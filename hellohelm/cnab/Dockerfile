FROM alpine:latest

ENV HELM_LATEST_VERSION="v2.9.0"

RUN apk add --update ca-certificates \
 && apk add --update -t deps wget \
 && wget https://storage.googleapis.com/kubernetes-helm/helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz \
 && tar -xvf helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz \
 && mv linux-amd64/helm /usr/local/bin \
 && apk del --purge deps \
 && rm /var/cache/apk/* \
 && rm -f /helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz

COPY app/run /cnab/app/run
COPY bundle.json /cnab/bundle.json
COPY Dockerfile cnab/Dockerfile
COPY app/charts /cnab/app/charts

CMD [ "/cnab/app/run" ]