#!/bin/sh
date

HOSTNAME=$(hostname)
IP_ADDRESS=$(hostname -i)
export PATH_KAMAILIO_CFG=/etc/kamailio/kamailio.cfg
export KAMAILIO=$(which kamailio)

mkdir -p /etc/kamailio/ /etc/kamailio/dbtext

echo '#!define RTPENGINE_LIST "'$RTPENGINE_LIST'"' > /etc/kamailio/kamailio-local.cfg
echo '#!define HTTP_API_ROUTING_ENDPOINT "'$HTTP_API_ROUTING_ENDPOINT'"' >> /etc/kamailio/kamailio-local.cfg
echo '#!define HTTP_API_CDR_ENDPOINT "'$HTTP_API_CDR_ENDPOINT'"' >> /etc/kamailio/kamailio-local.cfg
echo '#!define HTTP_API_DBTEXT_UACREG_ENDPOINT "'$HTTP_API_DBTEXT_UACREG_ENDPOINT'"' >> /etc/kamailio/kamailio-local.cfg
echo '#!define HTTP_API_TIMEOUT '$HTTP_API_TIMEOUT >> /etc/kamailio/kamailio-local.cfg
echo '#!define LISTEN '$LISTEN >> /etc/kamailio/kamailio-local.cfg
if ! [ -z "$TESTING" ]; then
    echo '#!define TESTING 1' >> /etc/kamailio/kamailio-local.cfg
fi
if ! [ -z "$LISTEN_ADVERTISE" ]; then
    echo '#!define LISTEN_ADVERTISE '$LISTEN_ADVERTISE >> /etc/kamailio/kamailio-local.cfg
fi
if ! [ -z "$ALIAS" ]; then
    echo '#!define ALIAS '$ALIAS >> /etc/kamailio/kamailio-local.cfg
fi
if ! [ -z "$WITH_DMQ" ]; then
    echo '#!define WITH_DMQ 1' >> /etc/kamailio/kamailio-local.cfg
    echo '#!define DMQ_PORT "'$DMQ_PORT'"' >> /etc/kamailio/kamailio-local.cfg
    echo '#!define DMQ_LISTEN '$DMQ_LISTEN >> /etc/kamailio/kamailio-local.cfg
    echo '#!define DMQ_SERVER_ADDRESS "sip:'$IP_ADDRESS':'$DMQ_PORT'"' >> /etc/kamailio/kamailio-local.cfg
    echo '#!define DMQ_NOTIFICATION_ADDRESS "'$DMQ_NOTIFICATION_ADDRESS'"' >> /etc/kamailio/kamailio-local.cfg
fi
if ! [ -z "$ROUTER_AUTH_SECRET" ]; then
    echo '#!define ROUTER_AUTH_SECRET "'$ROUTER_AUTH_SECRET'"' >> /etc/kamailio/kamailio-local.cfg
fi

# Test the config syntax
$KAMAILIO -f $PATH_KAMAILIO_CFG -c

curl -X PUT \
    -d '{"ID": "'$HOSTNAME'", "Name": "router", "Tags": [ "router", "kamailio" ], "Address": "'$IP_ADDRESS'", "Port": '$SIP_PORT'}' \
    http://consul:8500/v1/agent/service/register

# Run
supervisord=$(which supervisord)
$supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
