# 作者：张阳 2019-10-28
# ping禁止与启动，使用iptables实现。

CMD_HELPER="$0 <net interface> <stop|start>"

errReturn() {
    if [ $? -ne 0 ]
    then
	    exit 1
    fi
}

if [ -z $1 ]
then
    echo $CMD_HELPER
    exit 1
fi

if [ "-h" = $1 ]
then
    echo $CMD_HELPER
    exit 0
fi

if [ "stop" = $2 ]
then
    iptables -A INPUT -i $1 -p icmp -j DROP
	errReturn
elif [ "start" = $2 ]
then
    iptables -D INPUT -i $1 -p icmp -j DROP
	errReturn
else
    echo $CMD_HELPER
    exit 1
fi