#!/bin/bash 
 
display_usage() { 
	echo -e "Usage: $0 [Query_String] [Start_Date] [End_Date] [Output_File_Name] \n" 
	} 

# if less than two arguments supplied, display usage 
	if [  $# -ne 4 ] 
	then 
		display_usage
		exit 1
	fi 
 
# check whether user had supplied -h or --help . If yes display usage 
	if [[ ( $@ == "--help") ||  $@ == "-h" ]] 
	then 
		display_usage
		exit 0
	fi 

query_string="$1"
start_date="$2"
end_date="$3"
output_file="$4"

s_d=$start_date

while [[ $s_d != $(date -I -d "$end_date +1 day") ]]
do
	nice zgrep -E "$query_string" /[directory_path]]/$(date -d $d +%Y)/$(date -d $d +%m)/$(date -d $d +%d) | tee $output_file
	s_d=$(date -I -d "$s_d + 1 day")
done
