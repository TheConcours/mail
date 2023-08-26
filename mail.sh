#!/bin/sh

# Constants
User="DTS"
Mailbox=`eval echo ~$User/Mailbox`
Messages=`eval echo ~$User/messages`
DefaultThreshold=18 # in MB
DefaultMax=20 # in MB
Threshold=$DefaultThreshold
Max=$DefaultMax

# help message
usage() { echo "Usage: [-t ThresholdMB] [-m MaxMB]" 1>&2; exit 1; }
# Getting parameters if exit
while getopts t:m: option
do 
    case "${option}"
        in
        t)Threshold=${OPTARG};;
        m)Max=${OPTARG};;
	*)usage;;
    esac
done

shift $((OPTIND-1))

echo "Max MB: $Max"
echo "THreshold MB: $Threshold"
# Script body
cd $Mailbox
du -d 2 --block-size=1M . | grep "/maildir" | sed -e 's=\./==g' | sed -e 's=/.*==g' | \
awk -v th="$Threshold" -v max="$Max" -v mes="$Messages" '{
  if ($1 >= th)
    system("echo " $1 "/" max "MB > " mes "/" $2 ".txt")
}'
echo "There are `ls $Messages | wc -l` user accounts to be alerted"
