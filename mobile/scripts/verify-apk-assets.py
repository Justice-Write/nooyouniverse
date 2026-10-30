"""Compare the complete APK asset payload to freshly generated source assets."""
import hashlib
import json
from pathlib import Path
import sys
import zipfile

apk = Path(sys.argv[1]).resolve()
assets = Path(__file__).resolve().parents[1] / 'android/app/src/main/assets'
expected = {'assets/' + p.relative_to(assets).as_posix(): p.read_bytes()
            for p in assets.rglob('*') if p.is_file()}
with zipfile.ZipFile(apk) as archive:
    members = [n for n in archive.namelist() if n.startswith('assets/') and not n.endswith('/')]
    assert len(members) == len(set(members)), 'duplicate asset members'
    assert set(members) == set(expected), f'asset set mismatch: {set(members) ^ set(expected)}'
    for name, data in expected.items():
        assert archive.read(name) == data, f'asset bytes differ: {name}'
    forbidden = ('noo-probe.json', '.keystore', '.jks', 'observations.json', 'local.properties')
    assert not any(n.lower().endswith(forbidden) for n in archive.namelist()), 'private/build artifact in APK'
print(json.dumps({'apk': apk.name, 'sha256': hashlib.sha256(apk.read_bytes()).hexdigest(),
                  'assetCount': len(expected), 'exactAssetParity': True}, indent=2))
