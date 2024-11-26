FROM alpine:3.20.3

RUN apk add --update-cache \
    rsync \
    cifs-utils \
    jq \
 && rm -rf /var/cache/apk/*

COPY ./startup.sh /startup.sh
RUN chmod +x startup.sh
ENTRYPOINT [ "./startup.sh" ]