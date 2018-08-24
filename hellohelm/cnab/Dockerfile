FROM lachlanevenson/k8s-helm:v2.10.0

COPY app/run /cnab/app/run
COPY bundle.json /cnab/bundle.json
COPY Dockerfile cnab/Dockerfile
COPY app/charts /cnab/app/charts

CMD [ "/cnab/app/run" ]