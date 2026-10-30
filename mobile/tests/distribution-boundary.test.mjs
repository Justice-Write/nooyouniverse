import { test } from 'node:test';
import assert from 'node:assert/strict';
import { mkdtempSync, mkdirSync, writeFileSync, rmSync, symlinkSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { dirname, join } from 'node:path';
import { publicAssets, validatePublicDirectory } from '../scripts/distribution-boundary.mjs';

test('distribution rejects private backup contamination and missing assets', () => {
  const root = mkdtempSync(join(tmpdir(), 'noo-distribution-'));
  try {
    for (const name of publicAssets) {
      mkdirSync(dirname(join(root, name)), { recursive: true });
      writeFileSync(join(root, name), 'synthetic asset');
    }
    assert.equal(validatePublicDirectory(root).length, publicAssets.length);
    writeFileSync(join(root, 'personal-observation-backup.json'), '{}');
    assert.throws(() => validatePublicDirectory(root), /unexpected: personal-observation-backup.json/);
    rmSync(join(root, 'personal-observation-backup.json'));
    rmSync(join(root, publicAssets[0]));
    assert.throws(() => validatePublicDirectory(root), /missing:/);
  } finally { rmSync(root, { recursive: true, force: true }); }
});

test('distribution rejects directory junctions before following private data', () => {
  const root = mkdtempSync(join(tmpdir(), 'noo-link-'));
  const outside = mkdtempSync(join(tmpdir(), 'noo-outside-'));
  try {
    symlinkSync(outside, join(root, 'private'), process.platform === 'win32' ? 'junction' : 'dir');
    assert.throws(() => validatePublicDirectory(root), /symlink rejected/);
  } finally { rmSync(root, { recursive: true, force: true }); rmSync(outside, { recursive: true, force: true }); }
});
