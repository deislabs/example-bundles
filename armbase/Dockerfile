FROM alpine:3.7

RUN apk add --update ca-certificates \
# && apk del --purge deps \
 && rm /var/cache/apk/*

COPY bundle.json /cnab/bundle.json
COPY cnab/app/run /cnab/app/run
COPY Dockerfile /cnab/Dockerfile
COPY cnab/app/armup /cnab/app/armup
COPY cnab/app/arm /cnab/app/arm

RUN chmod 755 /cnab/app/run /cnab/app/armup

CMD ["/cnab/app/run"]