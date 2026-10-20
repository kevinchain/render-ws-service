#!/bin/sh
set -e

PORT="${PORT:-10000}"
UUID="${UUID:?UUID env var is required}"
WS_PATH="${WS_PATH:-/}"

cat > /usr/local/etc-xray.json <<EOF
{
  "log": { "loglevel": "warning" },
  "inbounds": [
    {
      "listen": "0.0.0.0",
      "port": ${PORT},
      "protocol": "vless",
      "settings": {
        "clients": [ { "id": "${UUID}" } ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": { "path": "${WS_PATH}" }
      }
    }
  ],
  "outbounds": [
    { "protocol": "freedom", "tag": "direct" }
  ]
}
EOF

echo "starting xray on port ${PORT}, ws path ${WS_PATH}"
exec /usr/local/bin/xray run -config /usr/local/etc-xray.json
