# 作者：张阳 2019-10-28
# ping禁止与启动，使用iptables实现。

usage() {
    echo "$0 <net interface> <stop|start>"
}

if [ $# -ne 2 ] || [ "-h" = $1 ]
then
    usage
    exit 1
fi

NET_INTERFACE=$1
SWITCH=$2

. commonFunction.sh

checkNetInterface $NET_INTERFACE

if [ "stop" = $SWITCH ]
then
    iptables -A INPUT -i $NET_INTERFACE -p icmp -j DROP
	ifErrReturn
elif [ "start" = $SWITCH ]
then
    iptables -D INPUT -i $NET_INTERFACE -p icmp -j DROP
	ifErrReturn
else
    usage
    exit 1
fi