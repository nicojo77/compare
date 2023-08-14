#!/usr/bin/bash
#script:		dns_ip_compare.sh
#author:		anon
#date:			07.05.2023
#modification:		07.05.2023
#purpose:		compare the final ip list with the dns queries reference list
#usage:			dns_ip_compare.sh <dns_iplist> <dns_query_reference_list> <output_file>

# Exit codes:
#	0	clean exit
#	1	usage error


usage(){
	if [ $# -ne 3 ]; then
		echo "Usage: $0 <dns_iplist> <dns_query_reference_list> <output_file>"
		exit 1
	fi
}

compare_lists(){
	debug "Comparing ip list with dns.log query list..."
	while read -r ip; do
	 	grep $ip $2 >> $3
	done < $1
}

debug(){
	if [[ $display_debug == true ]]; then
		echo "$1"
	else
		:
	fi
}

# Arg1: <tput_colour_n>, arg2: <message>, arg3: <bold> (optional)
# 1:red, 2:green, 3:yellow, 4:blue, 5:magenta, 6:cyan, 7:white
message(){
	if [[ $3 == "bold" ]]; then
		tput setaf $1; tput bold; echo -e "\n$2\n"; tput sgr 0
	else
		tput setaf $1; echo $2; tput sgr 0
	fi
}

display_debug=false
dns_iplist=$1
dns_query_reference_list=$2
output=$3

main(){
	usage $1 $2 $3
	message 4 "Comparing lists..."
	compare_lists $dns_iplist $dns_query_reference_list $output
	message 2 "Process over" bold
}

main $1 $2 $3

exit 0
