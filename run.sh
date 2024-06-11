#! /bin/sh

set -e

if [ "${S3_S3V4}" = "yes" ]; then
    aws configure set default.s3.signature_version s3v4
fi

if [ "${SCHEDULE}" = "**None**" ]; then
  sh backup.sh
else
  sh backup.sh
  echo "$SCHEDULE sh /app/backup.sh" > /etc/crontabs/root
  exec crond -l 2 -f
fi
