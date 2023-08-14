#!/usr/bin/bash
#script:		    compare.sh
#author:		    anon
#date:			    04.05.2023
#modification:	    08.08.2023
#purpose:		    compares two lists containing similar data with while read command
#usage:			    compare.sh <list1> <list2>

# Argument(s) verification (uncomment and modify if needed)
if [ $# -ne 2 ]; then
	echo "Usage: $0 <arg1> <arg2>"
	exit 1
fi

list1=$1
list2=$2
while read -r item; do
	if grep -Fxq $item $list2; then
		echo "match: $item"
	fi
done < $list1

exit 0
