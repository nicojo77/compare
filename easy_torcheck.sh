#!/bin/bash
#script:		easy_torcheck.sh
#author:		anon
#date:			16.05.2023
#modification:		22.05.2023
#purpose:		compare a list of IPs with tor exit nodes
#usage:			./easy_torcheck.sh <ip_list> <compare_list> <output_file>

# Argument(s) verification (uncomment and modify if needed)
usage(){
	if [ $# -ne 3 ]; then
		tput setaf 3
		echo "Usage: $0 <ip_list> <compare_list> <output_file>"
        echo "<ip_list>:         /results/concatenated_ip.list"
        echo "<compare_list>:    /tmp/tor/..."
        echo -e "<output_file>:     /tmp/tor/...\n"
		tput sgr 0
		exit 1
	fi
}

compare_ip_list_to_tor_exit_nodes(){
	while read -r ip; do
		if grep -F $ip $2; then
			echo "match: $ip" >> $3
		fi
	done < $1
}

display_results(){
	if [[ -f $1 ]]; then
		tput setaf 1; echo "Match found!"; tput sgr 0
		cat $1
	else
		tput dim; echo "No match found."; tput sgr 0
	fi
}

ip_list=$1
compare_list=$2
output_file=$3

main(){
	usage $1 $2 $3
	compare_ip_list_to_tor_exit_nodes $ip_list $compare_list $output_file
	display_results $output_file
}

main $1 $2 $3

exit 0
