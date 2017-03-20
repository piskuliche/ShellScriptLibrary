#MSUB -S /bin/bash
#MSUB -N AAA.runBBB
#MSUB -q sixhour
#MSUB -l nodes=1:ppn=6:intel
#MSUB -l walltime=00:06:00:00
#MSUB -j oe
#MSUB -o AAA-BBB.joblog
#MSUB -d ./

# Save job specific info for troubleshooting
echo "This is a sequential job created by sequentialjob.sh"
echo "The following processors are allocated to this job:"
echo $(cat $PBS_NODEFILE)

module load legacy
module load intel_compiler
export OMP_NUM_THREADS=6

echo "Start: $(date +%F_%T)"

if [ "BBB" .eq. "1" ]; then
    #timeout 5h time Cassandra_1.2.4.exe 
    echo "Hello start"
else
    #timeout 5h time Cassandra_1.2.4.exe
    echo "Hello in progress"
fi

echo "End: $(date +%F_%T)"

# Clean Up Scripts
mkdir run-BBB
gzip *xyz *log
mv *gz *xyz *prp *H *log *sh run-BBB/
cp *chk run-BBB/



