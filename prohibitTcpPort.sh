# 作者：张阳 2019-10-28
# tcp 端口禁止与启动，使用iptables实现。

usage() {
    echo "`basename $0` <-I net_interface | -O> -p <tcp port> -s <stop|start>"
	exit 1
}

if [ $# -eq 0 ]
then
    usage    
fi

INPUT=INPUT
DIRECTION=
NET_INTERFACE=
TCP_PORT=
SWITCH=

while getopts :I:Op:s: OPTION
do
    case $OPTION in
	I) NET_INTERFACE=$OPTARG
	   DIRECTION=$INPUT
	;;
	O) DIRECTION=OUTPUT
	;;
	p) TCP_PORT=$OPTARG
	;;
	s) SWITCH=$OPTARG
	;;
	\?) usage
	;;
	esac
done

. ./commonFunction.sh

if [ $INPUT = $DIRECTION ]
then
    checkNetInterface $NET_INTERFACE
fi

case $SWITCH in
    stop) if [ $INPUT = $DIRECTION ]
	    then
		    iptables -A INPUT -i $NET_INTERFACE -p tcp --dport $TCP_PORT -j DROP
	        ifErrReturn
		else
		    iptables -A OUTPUT -p tcp --dport $TCP_PORT -j DROP
	        ifErrReturn
		fi
    ;;
	start) if [ $INPUT = $DIRECTION ]
	    then
		    iptables -D INPUT -i $NET_INTERFACE -p tcp --dport $TCP_PORT -j DROP
	        ifErrReturn
		else
		    iptables -D OUTPUT -p tcp --dport $TCP_PORT -j DROP
	        ifErrReturn
		fi
    ;;
	*) usage
esac
