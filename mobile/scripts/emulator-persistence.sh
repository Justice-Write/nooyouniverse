#!/usr/bin/env bash
# Debug-only, authorized-emulator-only: seed, force-stop, dump.
# Requires Android SDK + KVM. Never target an owner phone.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
export ANDROID_HOME="${ANDROID_HOME:-$HOME/android-sdk}"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH"
PKG="com.nooyouniverse.observationlog.debug"
ACTIVITY="com.nooyouniverse.observationlog.MainActivity"
AVD="${NOO_AVD_NAME:-noo_api34}"
SERIAL="${NOO_EMULATOR_SERIAL:-}"
EXPECTED_DEBUG_SHA256="${NOO_EXPECTED_DEBUG_SHA256:-}"
APK="$ROOT/mobile/android/app/build/outputs/apk/debug/app-debug.apk"
PROBE_HOST="/tmp/noo-probe.json"

if [[ "${NOO_EMULATOR_PROBE_ACK:-}" != "AUTHORIZED_EMULATOR_ONLY" ]]; then
  echo "REFUSE: set NOO_EMULATOR_PROBE_ACK=AUTHORIZED_EMULATOR_ONLY only in a separately authorized emulator session."
  exit 2
fi
if [[ ! "$SERIAL" =~ ^emulator-([0-9]+)$ ]]; then
  echo "REFUSE: NOO_EMULATOR_SERIAL must be an explicit emulator-* serial."
  exit 2
fi
if [[ ! "$EXPECTED_DEBUG_SHA256" =~ ^[0-9A-Fa-f]{64}$ ]]; then
  echo "REFUSE: NOO_EXPECTED_DEBUG_SHA256 must be the owner-authorized 64-hex debug APK hash."
  exit 2
fi
EMULATOR_PORT="${SERIAL#emulator-}"
if (( EMULATOR_PORT < 5554 || EMULATOR_PORT > 5682 || EMULATOR_PORT % 2 != 0 )); then
  echo "REFUSE: emulator serial port must be an even port from 5554 through 5682."
  exit 2
fi
adb_target() { adb -s "$SERIAL" "$@"; }

if [[ ! -x "$ANDROID_HOME/emulator/emulator" ]]; then
  echo "SKIP: emulator binary missing under $ANDROID_HOME"
  exit 0
fi
if [[ ! -f "$APK" ]]; then
  echo "REFUSE: exact prebuilt debug APK is missing; build and verify it before authorization."
  exit 2
fi
actual_debug_sha256="$(sha256sum "$APK" | awk '{print tolower($1)}')"
if [[ "$actual_debug_sha256" != "${EXPECTED_DEBUG_SHA256,,}" ]]; then
  echo "REFUSE: debug APK SHA-256 does not match the owner-authorized expected hash."
  exit 2
fi

if ! avdmanager list avd | grep -q "$AVD"; then
  echo "Creating AVD $AVD"
  echo "no" | avdmanager create avd -n "$AVD" -k "system-images;android-34;google_apis;x86_64" --force
fi

if ! adb_target get-state >/dev/null 2>&1; then
  echo "Starting emulator $AVD as $SERIAL"
  "$ANDROID_HOME/emulator/emulator" -avd "$AVD" -no-window -no-audio -no-boot-anim \
    -port "$EMULATOR_PORT" -gpu swiftshader_indirect -accel on -no-snapshot-load >/tmp/noo-emulator.log 2>&1 &
  echo $! > /tmp/noo-emulator.pid
fi

echo "Waiting for boot"
if ! adb_target wait-for-device; then
  echo "SKIP: adb never saw a device (KVM/emulator failed). Phone sideload remains owner-only."
  exit 0
fi
booted=0
for i in $(seq 1 90); do
  boot="$(adb_target shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')"
  if [[ "$boot" == "1" ]]; then
    booted=1
    break
  fi
  sleep 2
done
if [[ "$booted" != "1" ]]; then
  echo "SKIP: emulator did not reach boot_completed. See /tmp/noo-emulator.log"
  tail -n 40 /tmp/noo-emulator.log || true
  exit 0
fi
sleep 4

qemu="$(adb_target shell getprop ro.kernel.qemu 2>/dev/null | tr -d '\r')"
if [[ "$qemu" != "1" ]]; then
  echo "REFUSE: $SERIAL did not prove ro.kernel.qemu=1; no APK was installed."
  exit 2
fi

adb_target install -r "$APK"
adb_target shell am force-stop "$PKG" || true
rm -f "$PROBE_HOST"
adb_target shell rm -f "/sdcard/Android/data/$PKG/files/noo-probe.json" || true

adb_target shell am start -n "$PKG/$ACTIVITY" -e noo_debug_cmd seed
sleep 5
adb_target pull "/sdcard/Android/data/$PKG/files/noo-probe.json" "$PROBE_HOST" >/dev/null
echo "SEED $(cat "$PROBE_HOST")"
grep -q '"phase":"seed"' "$PROBE_HOST"
grep -q '"ok":true' "$PROBE_HOST"

adb_target shell am force-stop "$PKG"
sleep 2
adb_target shell am start -n "$PKG/$ACTIVITY" -e noo_debug_cmd dump
sleep 5
adb_target pull "/sdcard/Android/data/$PKG/files/noo-probe.json" "$PROBE_HOST" >/dev/null
echo "DUMP $(cat "$PROBE_HOST")"
grep -q '"phase":"dump"' "$PROBE_HOST"
grep -q '"ok":true' "$PROBE_HOST"
grep -q 'process-death probe' "$PROBE_HOST"
grep -q 'noo-private-observation-log' "$PROBE_HOST"
echo "EMULATOR_PERSISTENCE_OK"
