import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import { test } from "node:test";
import { fileURLToPath } from "node:url";
import path from "node:path";

const mobileRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");

async function read(relativePath) {
  return readFile(path.join(mobileRoot, relativePath), "utf8");
}

function occurrences(text, value) {
  return text.split(value).length - 1;
}

test("release Android resources use the release application identity", async () => {
  const [manifest, strings, shortcuts] = await Promise.all([
    read("android/app/src/main/AndroidManifest.xml"),
    read("android/app/src/main/res/values/strings.xml"),
    read("android/app/src/main/res/xml/shortcuts.xml"),
  ]);

  assert.match(strings, /<string name="app_name">Noo Check Hub<\/string>/);
  assert.doesNotMatch(strings, /\(debug\)/i);
  assert.equal(
    occurrences(shortcuts, 'android:targetPackage="com.nooyouniverse.observationlog"'),
    3,
  );
  assert.doesNotMatch(shortcuts, /observationlog\.debug/);
  assert.equal(occurrences(manifest, 'android:taskAffinity="${applicationId}.'), 3);
  assert.doesNotMatch(manifest, /android:taskAffinity="[^"]*\.debug/);
});

test("debug Android overlays preserve the debug application identity", async () => {
  const [strings, shortcuts] = await Promise.all([
    read("android/app/src/debug/res/values/strings.xml"),
    read("android/app/src/debug/res/xml/shortcuts.xml"),
  ]);

  assert.match(strings, /<string name="app_name">Noo Check Hub \(debug\)<\/string>/);
  assert.equal(
    occurrences(shortcuts, 'android:targetPackage="com.nooyouniverse.observationlog.debug"'),
    3,
  );
});
