#!/usr/bin/env node
import { readFileSync } from 'fs';

const [key, rawValue] = process.argv.slice(2);

if (!key || rawValue === undefined) {
  console.error('Usage: node set-secret.js KEY_NAME value');
  console.error('       node set-secret.js KEY_NAME @path/to/file.json  (read value from file)');
  process.exit(1);
}

// Support @file syntax — reads file contents as the value
let value = rawValue;
if (rawValue.startsWith('@')) {
  value = readFileSync(rawValue.slice(1), 'utf8').trim();
}

const apiKey = process.env.THEPOPEBOT_API_KEY;
const appUrl = process.env.APP_URL;

if (!apiKey) {
  console.error('THEPOPEBOT_API_KEY not set — add it as an agent secret in Admin → Settings → Jobs');
  process.exit(1);
}
if (!appUrl) {
  console.error('APP_URL not available');
  process.exit(1);
}

const res = await fetch(`${appUrl}/api/set-agent-secret`, {
  method: 'POST',
  headers: { 'Content-Type': 'application/json', 'x-api-key': apiKey },
  body: JSON.stringify({ key, value }),
});

const json = await res.json();
if (!res.ok || json.error) {
  console.error('Failed:', json.error || res.status);
  process.exit(1);
}
console.log(`Secret "${key}" updated.`);
