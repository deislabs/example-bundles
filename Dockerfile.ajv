FROM node:8-alpine

ARG json_schema_file
ARG json_schema_uri

RUN npm install -g ajv-cli

RUN wget -q \
  --header 'Accept: application/vnd.github.v3.raw' \
  -O ${json_schema_file} \
  ${json_schema_uri}
