#!/bin/ash

DOLLAR='$'
PID=/var/spool/postfix/pid/master.pid

if [ "$EXT_RELAY_PORT" != "" ]; then
    EXT_RELAY_PORT=25
fi

if [ "$EXT_RELAY_HOST" != "" ]; then
    EXT_RELAY="$EXT_RELAY_HOST:$EXT_RELAY_PORT"
fi

export EXT_RELAY
export HOSTNAME=${HOSTNAME:-"relay.example.com"}
export NETWORKS=${NETWORKS:-"192.168.0.0/16 172.16.0.0/12 10.0.0.0/8"}
echo $HOSTNAME > /etc/mailname

/usr/bin/envsubst < /main.cf.stub > /etc/postfix/main.cf
rm /main/cf.stub
rm -f $PID

postfix start
sleep 2

while [ -f $PID ] && kill -0 $(cat $PID ) ; do
    sleep 0.5
done
