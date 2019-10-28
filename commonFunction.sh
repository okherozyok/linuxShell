# 作者：张阳 2019-10-28
# 公共函数。

checkNetInterface() {
    _NET_IF=`ifconfig -s | grep -v -E '^(Iface|lo)' | awk '{print $1}'`
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

ifErrReturn() {
    if [ $? -ne 0 ]
    then
	    exit 1
    fi
}
