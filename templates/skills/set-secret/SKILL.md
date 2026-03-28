---
name: set-secret
description: Update or create an agent secret on the event handler. Use when you need to persist a new or rotated credential (e.g. OAuth refresh token, API key) so it's available to future agent jobs.
---

## Usage

```bash
# Plain string value
node skills/set-secret/set-secret.js MY_API_KEY "sk-abc123"

# JSON value inline (e.g. OAuth token response)
node skills/set-secret/set-secret.js MY_OAUTH_TOKEN '{"access_token":"...","refresh_token":"..."}'

# JSON value from file
node skills/set-secret/set-secret.js MY_OAUTH_TOKEN @/tmp/token.json
```

## OAuth Token Workflow

When an OAuth token refreshes and you receive a new JSON token object, store the entire JSON string as the secret value. Future agent jobs can read and parse it:

```bash
node -e "const t = JSON.parse(process.env.MY_OAUTH_TOKEN); console.log(t.access_token)"
```

## Requirements

One agent secret must be configured in Admin → Settings → Jobs:

- `THEPOPEBOT_API_KEY` — an API key created in Admin → Settings → API Keys

`APP_URL` is injected automatically from the event handler.

## Notes

- Values are encrypted at rest
- Future agent jobs receive the updated value immediately
- Use `get-secret` to verify the key appears after saving
