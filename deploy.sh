#!/usr/bin/env bash
# Deploy heymuster.com. Build → Bunny storage zone "heymuster" (id 1797602) → purge pull zone 6442869.
# Storage password + API key come from sops; nothing is hardcoded.
set -euo pipefail
SECRETS="$HOME/Fleet/Credentials/louie/secrets/wolfgang.yaml"
cd "$(dirname "$0")"
npm run build >/dev/null
cp public/tracker.json dist/tracker.json 2>/dev/null || true
SPW=$(sops -d --extract '["BUNNY_STORAGE_HEYMUSTER"]' "$SECRETS" 2>/dev/null || true)
if [ -z "${SPW:-}" ]; then
  APIKEY=$(sops -d --extract '["BUNNY_RUDDER_API_KEY"]' "$SECRETS")
  SPW=$(curl -sf -H "AccessKey: $APIKEY" https://api.bunny.net/storagezone \
        | python3 -c "import sys,json;print([z['Password'] for z in json.load(sys.stdin) if z['Name']=='heymuster'][0])")
fi
cd dist
# NOTE: curl must get </dev/null — inside a while-read loop it otherwise eats the file list
# and silently skips the tail of it. That is how tracker.json went unpublished on 2026-09-02.
while IFS= read -r f; do
  if curl -sf -X PUT --data-binary "@$f" -H "AccessKey: $SPW" \
       "https://storage.bunnycdn.com/heymuster/$f" </dev/null >/dev/null; then
    echo "  up $f"
  else
    echo "  FAILED $f" >&2; exit 1
  fi
done < <(find . -type f | sed 's|^\./||')
cd ..
APIKEY=${APIKEY:-$(sops -d --extract '["BUNNY_RUDDER_API_KEY"]' "$SECRETS")}
curl -sf -X POST -H "AccessKey: $APIKEY" "https://api.bunny.net/pullzone/6442869/purgeCache" >/dev/null
echo "deployed + purged"
