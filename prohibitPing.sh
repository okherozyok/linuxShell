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

checkNetInterface() {
    _NET_IF=`ifconfig -s | grep -v -E 'Iface|lo' | awk '{print $1}'`
	for _netIf in $_NET_IF
	do
	    if [ $_netIf = $1 ]
		then
		    return
		fi
	done
	
	echo "Wrong net interface."
	exit 1
}
checkNetInterface $NET_INTERFACE

ifErrReturn() {
    if [ $? -ne 0 ]
    then
	    exit 1
    fi
}

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