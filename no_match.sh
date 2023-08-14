#!/usr/bin/bash
#script:		    no_match.sh
#author:		    anon
#date:			    07.08.2023
#modification:		07.08.2023
#purpose:		compares two lists to find no match
#usage:			no_match.sh <list1> <list2>

# Argument(s) verification (uncomment and modify if needed)
usage(){
    if [ $# -ne 2 ]; then
        tput setaf 1; echo "Usage: $0 <list 1> <list 2>"; tput sgr 0
    	exit 1
    fi
}

find_longest_list(){
    len_list1=$(wc -l $1 | awk '{print $1}')
    len_list2=$(wc -l $2 | awk '{print $1}')

    [[ $len_list1 -gt $len_list2 ]] && longest=$1 shortest=$2\
        || longest=$2 shortest=$1
    
    echo -e "The longest list is: $longest\n"
}

compare_lists(){
    echo "The next item(s) is not in $shortest:"
    while read -r i; do
    	if ! grep -Fxq $i $shortest; then
            echo -e "$(tput setaf 1)No match:$(tput sgr 0)\t$i"
    	fi
    done < $longest
    echo
}

main(){
    usage $1 $2
    find_longest_list $1 $2
    compare_lists
}

main $1 $2

exit 0
