#!/usr/bin/bash
#script:		sort_rir.sh
#author:		anon
#date:			11.05.2023
#modification:		11.05.2023
#purpose:		parse whois results and sort into separate folders according to RIR
#usage:			sort_rir.sh <reference_list>

# Exit codes:
#	0	clean exit
#	1	usage error


usage(){
	if [ $# -ne 1 ]; then
		echo "Usage: $0 <reference_list>"
		exit 1
	fi
}

parse_whois_get_rir(){
	debug "parsing whois for RIR..."
	while read -r ip; do
		result="$(grep -E -io -m1 $1 $ip\_whois.txt)"
		debug "ip: $ip result: $result"
		case $result in
			apnic|APNIC)
				cp $ip\_whois.txt $parent_folder_name/whois/rir_apnic
				;;
				
			arin|ARIN)
				cp $ip\_whois.txt $parent_folder_name/whois/rir_arin
				;;

			lacnic|LACNIC)
                                cp $ip\_whois.txt $parent_folder_name/whois/rir_lacnic
				;;

			ripe|RIPE)
                                cp $ip\_whois.txt $parent_folder_name/whois/rir_ripe
				;;

			afrinic|AFRINIC)
                                cp $ip\_whois.txt $parent_folder_name/whois/rir_afrinic
				;;

			*)
                                cp $ip\_whois.txt $parent_folder_name/whois/rir_undefined
				;;

		esac
	done < $ip_list
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
ip_list=$1
searched_rir='apnic|arin|lacnic|ripe|afrinic'

main(){
	usage $1
	message 4 "Parsing whois lookup for RIR..."
	parse_whois_get_rir $searched_rir
	message 2 "Process over" bold
}

main $1

exit 0
