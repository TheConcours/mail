#!/bin/bash

# Constants
User="DTS"
Mailbox=`eval ~$User/Mailbox`

# Initialize
rm -rf $Mailbox

# Create User maildir by generating random names
for j in {1..50}
do
  i=`echo $RANDOM | base64 | tr -d '=+/.'`
  mkdir -p $Mailbox/$i/maildir
done
echo "Created `ls $Mailbox | wc -l` dummy users"

# Create dummy data
cd $Mailbox
for d in *; do
  fallocate -l $(($RANDOM*1000)) $d/maildir/dummy.data
done

