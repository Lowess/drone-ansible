# Dockerfile for building Ansible image for Alpine, with as few additional software as possible.

# pull base image
FROM alpine:latest

MAINTAINER Florian Dambrine <android.florian@gmail.com>

ARG ANSIBLE_VERSION=2.4.3.0

RUN apk --update add sudo \
    && apk --update add python py-pip openssl ca-certificates \
    && apk --update add --virtual build-dependencies \
        python-dev libffi-dev openssl-dev build-base \
    && pip install --upgrade pip cffi \
    && pip install ansible==${ANSIBLE_VERSION} \
    && pip install  boto \
    && apk del build-dependencies \
    && rm -rf /var/cache/apk/* \
    && mkdir -p /etc/ansible \
    &&echo 'localhost' > /etc/ansible/hosts

ADD entrypoint.sh /bin/
RUN chmod +x /bin/entrypoint.sh

ENTRYPOINT /bin/entrypoint.sh
