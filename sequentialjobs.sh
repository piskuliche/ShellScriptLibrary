#!/bin/bash

#This script is used to create a job that runs at a walltime of less than 6 hours.
#It does this by requesting a walltime of 6 hours, but then kills the job after 5 hours.
#It then produces a new job script, and submits it.

#USAGE: ./run_back_to_back.sh jobpreface startid endid
#jobpreface is the name of your input files i.e. jobpreface.start jobpreface.restart
#startid is the number of the run you want to start i.e. for a new run choose 1.
#endid is the number of the run you want to end on i.e. to run 30 iterations choose endid as 30.

#User Interface: 
name=$1
sid=$2
lastid=$((sid-1))
rununtil=$3
#Creates a MSUB Script for the current run

if [ -e templates/template_submit.sh ]
then
    cat templates/template.sh > $sid.sh

    #Replace stuff in the template file.
    sed -i -e "s@AAA@$name@g" $sid.sh
    sed -i -e "s@BBB@$sid@g" $sid.sh


    #Determines whether to run again after the current run or not
    nextid=$((sid+1))
    if [ "$nextid" -lt "$rununtil" ]; then
        echo 'sequentialjobs.sh '$name' '$nextid' '$rununtil >> $sid.sh
    else
        MESSAGE="This run needs checking: "$1
        echo $MESSAGE | mail -s "completion terminated" "piskuliche@ku.edu"
    fi

    #submits the job.
    one=$(msub $sid.sh)
else
    echo "There was a problem - templates/template_submit.sh does not exist"
fi

