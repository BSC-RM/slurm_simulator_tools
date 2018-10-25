#!/bin/bash -xe
#SBATCH -J slurm-simulator-into-slurm
#SBATCH -o OUTPUTS/test1_%j.out
#SBATCH -e OUTPUTS/test1_%j.err
#SBATCH -c 4
##SBATCH -p interactive
#SBATCH -t 2:00:00
#SBATCH --qos debug

unset OMP_NUM_THREADS
source enableenv_mn4
workload_name=$(basename $1)
sim_path="/gpfs/scratch/bsc15/bsc15800/simulation_"$SLURM_JOBID$workload_name"serialq"$2
rm -rf $sim_path

mkdir -p $sim_path
cp -r install/* $sim_path
workload="/home/bsc15/bsc15800/phd/slurm-git/slurm-simulator/"$1
workload_swf=$workload".swf"
control_host="$SLURM_NODELIST"

slave_nnodes=49

slurm_conf_template="$sim_path/slurm_conf/slurm.conf.template"

slurmctld_port=$((($SLURM_JOBID%65535))) #12 is the max number of jobs that can enter mn4 node
range=$((($slurmctld_port%12)))
slurmctld_port=$(((($slurmctld_port*$range)%65535)))

if [ $slurmctld_port -le 10000 ] ; then
        slurmctld_port=$((($slurmctld_port+10000)))
fi
slurmctld_f_port=$((($slurmctld_port+12)))

slurmd_port=$((($slurmctld_port+144)))

openssl genrsa -out $sim_path/slurm_conf/slurm.key 1024
openssl rsa -in $sim_path/slurm_conf/slurm.key -pubout -out $sim_path/slurm_conf/slurm.cert

cd $sim_path

sed -e s/{ID_JOB}/$SLURM_JOBID/ \
    -e s:{DIR_WORK}:$sim_path: slurm_varios/trace.sh.template > slurm_varios/trace.sh;

chmod +x slurm_varios/trace.sh

sed -e s:TOKEN_SLURM_USER_PATH:$sim_path: \
    -e s:TOKEN_BF_QUEUE:$2: \
    -e s:TOKEN_CONTROL_MACHINE:$control_host: \
    -e s:TOKEN_NNODES:$slave_nnodes: \
    -e s:TOKEN_SLURMCTLD_PORT:$slurmctld_port-$slurmctld_f_port: \
    -e s:TOKEN_SLURMD_PORT:$slurmd_port: \
    -e s:TOKEN_CORES:$3: \
    $slurm_conf_template > $sim_path/slurm_conf/slurm.conf

source env.sh
#slurmdbd
export SLURM_CONF=$sim_path/slurm_conf/slurm.conf
export SLURM_SIM_ID=$SLURM_JOBID
sim_mgr -f -w $workload

#generate output
cat TRACES/trace.test.$SLURM_JOBID | sed -e 's!JobId=!!' | sort -n | awk '{print $8,$9,$10,$15}' | awk -F'[=/ /]' '{split($0,a); print a[2], a[4], a[6], a[8] }' > "out_static_"$workload_name"_q"$2

cat TRACES/trace.test.$SLURM_JOBID | sed -e 's!JobId=!!' | sort -n | awk '{ print $1,$7,$8,$9,$10,$13 }' | awk -F'[=/ /]' '{split($0,a); printf("%s\t%s\t%s\t%s\t%s\t-1\t-1\t%s\t%s\t-1\t1\t-1\t-1\t-1\t-1\t-1\t-1\t-1\n",a[1]-1,a[5],a[7]-a[5],a[9]-a[7],a[11],a[11],a[3])}' > "out_static_"$workload_name"_q"$2.swf
