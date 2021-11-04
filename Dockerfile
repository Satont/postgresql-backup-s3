FROM alpine:edge
LABEL maintainer="Satont"

RUN apk update
RUN apk add \
	coreutils \
	postgresql-client \
	python3 \
  py3-pip \
	openssl 

RUN pip3 install --upgrade pip && pip3 install awscli
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

WORKDIR /app

ADD run.sh backup ./

CMD ["sh", "run.sh"]
