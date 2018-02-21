FROM alpine:3.7

MAINTAINER Alexey Kioller <avkioller@gmail.com>

RUN apk add --update --no-cache bash jq curl

COPY ./resource/* /opt/resource/
RUN chmod +x /opt/resource/*
