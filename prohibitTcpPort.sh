# 作者：张阳 2019-10-28
# ping禁止与启动，使用iptables实现。

usage() {
    echo "$0 <net interface> <tcp port> <stop|start>"
}

if [ $# -ne 3 ] || [ "-h" = $1 ]
then
    usage
    exit 1
fi

NET_INTERFACE=$1
TCP_PORT=$2
SWITCH=$3

. commonFunction.sh

checkNetInterface $NET_INTERFACE

if [ "stop" = $SWITCH ]
then
    iptables -A INPUT -i $NET_INTERFACE -p tcp --dport $TCP_PORT -j DROP
	ifErrReturn
elif [ "start" = $SWITCH ]
then
    iptables -D INPUT -i $NET_INTERFACE -p tcp --dport $TCP_PORT -j DROP
	ifErrReturn
else
    usage
    exit 1
fi