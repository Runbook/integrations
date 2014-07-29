#!/usr/bin/env bash
##############################
#### cr-api.sh | CloudRoutes API Shell Script
#### This script provides the user with a basic shell interface to the CloudRoutes API
#### Use this script to integrate CloudRoutes with your own monitoring tools
##############################
#### Benjamin Cane | CloudRout.es
##############################

## Set necessary variables to None
check_key=$(echo None)
url=$(echo None)
action=$(echo None)

## Define the usage output as a function because we may call it often
usage()
{
  echo "usage: `basename $0` -k <check_key> -u <url> -a healthy|failed|status"
  exit 1
}

## Gather cmdline args with getops
while getopts ":k:u:a:" opt
do
  case $opt in
    k)
      check_key=$(echo $OPTARG)
    ;;
    u)
      url=$(echo $OPTARG)
    ;;
    a)
      if [ $OPTARG == "healthy" ]
      then
        action=$(echo $OPTARG)
      elif [ $OPTARG == "failed" ]
      then
        action=$(echo $OPTARG)
      elif [ $OPTARG == "status" ]
      then
        action=$(echo $OPTARG)
      else
        usage
      fi
    ;;
    ?)
      usage
    ;;
  esac
done

## Validate that we got a key
if [ $check_key == "None" ]
then
  usage
fi

## Validate that we got a url
if [ $url == "None" ]
then
  usage
fi

## Validate that we got an action
if [ $action == "None" ]
then
  usage
fi

## If all checks are good make the request
echo "Sending Request to: $url"
echo "-------------------------"

## Run and send output to OUTPUT variable
OUTPUT=$(curl -X POST -H "Content-type: application/json" -d "{\"check_key\" : \"$check_key\", \"action\" : \"$action\"}" -k $url 2> /dev/null )
echo "Results: $OUTPUT"

## Check the output and give an appropriate exit code
OUTCHK=$(echo $OUTPUT | grep -c "success")
if [ $OUTCHK -eq 1 ]
then
  exit 0
else
  exit 1
fi
