FROM alpine
MAINTAINER Huy Doan <huydq@ssgroup.com.vn>

EXPOSE 25

RUN apk add --update postfix gettext && rm -rf /var/cache/apk/*

ADD main.cf.stub /
ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
