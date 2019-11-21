FROM alpine:3.10
LABEL maintainer="Wazo Authors <dev@wazo.community>"
ENV VERSION 1.0.0

RUN apk add --update \
    bash \
    sngrep \
    curl \
    netcat-openbsd \
    kamailio \
    kamailio-db \
    kamailio-dbtext \
    kamailio-jansson \
    kamailio-json \
    kamailio-utils \
    kamailio-extras \
    kamailio-outbound \
    kamailio-http_async \
    kamailio-dbtext \
    kamailio-ev

COPY ./scripts/wait-for /usr/bin/wait-for
RUN chmod +x /usr/bin/wait-for

RUN mkdir -p /etc/kamailio
COPY kamailio/kamailio-local.cfg.example /etc/kamailio/kamailio-local.cfg.example
COPY kamailio/kamailio.cfg /etc/kamailio/kamailio.cfg
COPY kamailio/routing.cfg /etc/kamailio/routing.cfg
COPY kamailio/cdrs.cfg /etc/kamailio/cdrs.cfg
COPY kamailio/xhttp.cfg /etc/kamailio/xhttp.cfg
COPY kamailio/dbtext/domain /etc/kamailio/dbtext/domain
COPY kamailio/dbtext/domain_attrs /etc/kamailio/dbtext/domain_attrs
COPY kamailio/dbtext/uacreg /etc/kamailio/dbtext/uacreg
COPY kamailio/dbtext/version /etc/kamailio/dbtext/version

ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
CMD ["/docker-entrypoint.sh"]
