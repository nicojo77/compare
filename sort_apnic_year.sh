#!/usr/bin/bash
#script:		sort_apnic_year.sh
#author:		anon
#date:			06.05.2023
#modification:		06.05.2023
#purpose:		sort apnic whois based on creation date
#usage:			

# Argument(s) verification (uncomment and modify if needed)
#usage(){
#	if [ $# -ne 1 ]; then
#		echo "Usage: $0 <arg>"
#		exit 1
#	fi
#}

create_ips_list_reference(){
	find . -type f -name "*whois.txt" | awk -F"/|_" '{print $2}' > reference_list.txt
}

mkdircp_cp(){
	if [ ! -d $1 ]; then
		mkdir $1
		cp $ip\_whois.txt $1
	else
		cp $ip\_whois.txt $1
	fi
}

# As awk use $4, args 2 and 3 needs to be given as NULL when calling function
parse_whois_result(){
	debug "parsing whois for creation date..."
	while read -r ip; do
		result=$(grep -i -m1 $1 $ip\_whois.txt | awk -F '[ -]' '{print $4}')

		debug "ip: $ip result: $result"
		case $result in
			20[2-9][0-9])
				mkdircp_cp "ge2020"
				;;
				
			*)
				mkdircp_cp "lt2020"
				;;

		esac
	done < $reference_list
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

remove_unuseful_stuff(){
	rm $reference_list
}

reference_list=reference_list.txt
searched_item='last-modified'
display_debug=false

main(){
#	usage $1
	create_ips_list_reference
	message 4 "Parsing whois lookup for creation date..."
	parse_whois_result $searched_item NULL NULL $4
	remove_unuseful_stuff
	message 2 "Process over" bold
}

main 

exit 0

