import { lstatSync, readdirSync, readFileSync } from 'node:fs';
import { join, relative } from 'node:path';
import { fileURLToPath } from 'node:url';

export const publicAssets = JSON.parse(readFileSync(new URL('./public-assets.json', import.meta.url), 'utf8'));

export function validatePublicDirectory(root) {
  const files = [];
  function walk(dir) {
    for (const name of readdirSync(dir)) {
      const full = join(dir, name);
      const stat = lstatSync(full);
      if (stat.isSymbolicLink()) throw new Error(`Distribution symlink rejected: ${name}`);
      if (stat.isDirectory()) walk(full);
      else if (stat.isFile()) files.push(relative(root, full).replaceAll('\\', '/'));
      else throw new Error(`Unsupported distribution entry: ${name}`);
    }
  }
  walk(root);
  const extra = files.filter(f => !publicAssets.includes(f));
  const missing = publicAssets.filter(f => !files.includes(f));
  if (extra.length || missing.length) throw new Error(`Public distribution mismatch; unexpected: ${extra.join(', ')}; missing: ${missing.join(', ')}`);
  return files.sort();
}

if (process.argv[1] && fileURLToPath(import.meta.url) === process.argv[1]) {
  console.log(`Public distribution verified: ${validatePublicDirectory(fileURLToPath(new URL('../../public/', import.meta.url))).length} approved assets`);
}
