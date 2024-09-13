# Dockerfile for phantun based alpine
FROM alpine:latest
LABEL maintainer="xyzvps"

WORKDIR /root

RUN apk add iptables \
&& wget -q -O /root/phantun.zip "https://github.com/dndx/phantun/releases/latest/download/phantun_aarch64-unknown-linux-musl.zip" \
&& unzip -o /root/phantun.zip -d /usr/local/bin/ \
&& rm -f /root/phantun.zip

COPY ./phantun_init.sh /

ENV LOCAL_PORT=12345
ENV REMOTE_ADDR=127.0.0.1
ENV REMOTE_PORT=54321

CMD /phantun_init.sh \$LOCAL_PORT \$REMOTE_ADDR \$REMOTE_PORT
EOF
