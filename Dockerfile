FROM golang:1.17-alpine as gobuild
RUN apk add --no-cache git
RUN git clone https://github.com/odise/go-cron /go-cron && cd /go-cron && go mod init go-cron && go get github.com/robfig/cron && go get github.com/odise/go-cron && go build -o ./out/go-cron bin/go-cron.go

FROM alpine:edge
LABEL maintainer="Satont"

RUN apk update
RUN apk add \
	coreutils \
	postgresql-client \
	python3 \
  py3-pip \
	openssl \
	curl

RUN pip3 install --upgrade pip && pip3 install awscli
#RUN curl -L --insecure https://github.com/odise/go-cron/releases/download/v0.0.6/go-cron-linux.gz | zcat > /usr/local/bin/go-cron && chmod u+x /usr/local/bin/go-cron 
RUN apk del curl 
RUN rm -rf /var/cache/apk/*

ENV POSTGRES_DATABASE **None**
ENV POSTGRES_HOST **None**
ENV POSTGRES_PORT 5432
ENV POSTGRES_USER **None**
ENV POSTGRES_PASSWORD **None**
ENV POSTGRES_EXTRA_OPTS ''
ENV S3_ACCESS_KEY_ID **None**
ENV S3_SECRET_ACCESS_KEY **None**
ENV S3_BUCKET **None**
ENV S3_REGION us-west-1
ENV S3_PREFIX 'backup'
ENV S3_ENDPOINT **None**
ENV S3_S3V4 no
ENV SCHEDULE **None**
ENV ENCRYPTION_PASSWORD **None**
ENV DELETE_OLDER_THAN **None**

ADD run.sh run.sh
ADD backup.sh backup.sh
COPY --from=gobuild /go-cron/out/go-cron go-cron

CMD ["sh", "run.sh"]
