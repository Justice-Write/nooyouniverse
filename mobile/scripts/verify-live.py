"""Read public release bytes and compare with a committed Git reference."""
from concurrent.futures import ThreadPoolExecutor
import hashlib
import json
from pathlib import Path
import subprocess
import sys

root = Path(__file__).resolve().parents[2]
ref = sys.argv[1] if len(sys.argv) > 1 else 'HEAD'
files = json.loads((root / 'mobile/scripts/public-assets.json').read_text())
commit = subprocess.check_output(['git', 'rev-parse', ref], cwd=root, text=True).strip()
def check(name):
    path = '/' if name == 'index.html' else '/' + (name[:-5] if name.endswith('.html') and name not in ('404.html', 'offline.html') else name)
    expected = subprocess.check_output(['git', 'show', f'{commit}:public/{name}'], cwd=root)
    # curl uses the host's functioning network route; Python's proxy route can
    # return an environment-generated 403 for every asset on this workstation.
    result = subprocess.check_output(['curl.exe' if sys.platform == 'win32' else 'curl',
        '--silent', '--show-error', '--location', '--max-time', '30',
        '-H', 'Accept-Encoding: identity', '-w', '\n%{http_code}',
        'https://nooyouniverse.com' + path + '?verify=' + commit[:12]])
    data, code = result.rsplit(b'\n', 1)
    status = int(code)
    return {'file': name, 'status': status, 'match': data == expected,
            'expectedSha256': hashlib.sha256(expected).hexdigest(), 'actualSha256': hashlib.sha256(data).hexdigest()}
with ThreadPoolExecutor(max_workers=5) as pool:
    results = list(pool.map(check, [f for f in files if f != '_headers']))
report = {'commit': commit, 'matched': sum(x['match'] for x in results), 'total': len(results), 'files': results}
print(json.dumps(report, indent=2))
sys.exit(0 if report['matched'] == report['total'] else 1)
