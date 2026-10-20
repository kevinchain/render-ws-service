FROM alpine:latest

RUN apk add --no-cache curl unzip ca-certificates tzdata \
 && curl -L -o /tmp/xray.zip "https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip" \
 && mkdir -p /usr/local/bin /usr/local/share/xray \
 && unzip -o /tmp/xray.zip -d /tmp/xray \
 && mv /tmp/xray/xray /usr/local/bin/xray \
 && mv /tmp/xray/geoip.dat /tmp/xray/geosite.dat /usr/local/share/xray/ \
 && chmod +x /usr/local/bin/xray \
 && rm -rf /tmp/xray /tmp/xray.zip

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
