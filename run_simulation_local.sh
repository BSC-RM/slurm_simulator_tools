#!/bin/bash -xe
workload_name=$(basename $1)
sim_path=$PWD"/simulation_"$$$workload_name
rm -rf $sim_path

mkdir -p $sim_path
cp -r install/* $sim_path
workload=$1
#control_host=$(hostname)
control_host=localhost
slave_nnodes=1024 #EDIT: number of computing nodes
user=`(whoami)`
uid=`id -u`
slurm_conf_template="$sim_path/slurm_conf/slurm.conf.template"

slurmctld_port=$((($$%65535))) #12 is the max number of jobs that can enter mn4 node
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

sed -e s/{ID_JOB}/$$/ \
    -e s:{DIR_WORK}:$sim_path: slurm_varios/trace.sh.template > slurm_varios/trace.sh;

chmod +x slurm_varios/trace.sh

sed -e s:TOKEN_USER:$user: \
    -e s:TOKEN_SLURM_USER_PATH:$sim_path: \
    -e s:TOKEN_BF_QUEUE:1000: \
    -e s:TOKEN_CONTROL_MACHINE:$control_host: \
    -e s:TOKEN_NNODES:$slave_nnodes: \
    -e s:TOKEN_SLURMCTLD_PORT:$slurmctld_port-$slurmctld_f_port: \
    -e s:TOKEN_SLURMD_PORT:$slurmd_port: \
    -e s:TOKEN_CORES:8: \
    $slurm_conf_template > $sim_path/slurm_conf/slurm.conf

if ! grep -q $user:$uid $sim_path/slurm_conf/users.sim ; then
    echo $user:$uid >> $sim_path/slurm_conf/users.sim
fi

source env.sh
#slurmdbd
export SLURM_CONF=$sim_path/slurm_conf/slurm.conf
export SLURM_SIM_ID=$$
sim_mgr -f -w $workload

#generate output
printf 'JobId;Nodes;NodeList;Submit time;Start time;End time;Wait time;Run time;Response time;Slowdown;Backfilled\n' > "o_"$workload_name".csv"
cat TRACES/trace.test.$$ | sed -e 's!JobId=!!' | sort -n | awk '{print "JobId="$1,$12,$11,$8,$9,$10,$15}' | awk '-F[=/ /]' '{split($0,a); printf("%d;%d;%s;%d;%d;%d;%d;%d;%d;%f;%d\n",a[2],a[4],a[6],a[8],a[10],a[12],a[10]-a[8],a[12]-a[10],a[12]-a[8],(a[12]-a[8])/(a[12]-a[10]),a[14]) }' >> "o_"$workload_name".csv"

cat TRACES/trace.test.$$ | sed -e 's!JobId=!!' | sort -n | awk '{print $8,$9,$10,$15}' | awk -F'[=/ /]' '{split($0,a); print a[2], a[4], a[6], a[8] }' > "o_"$workload_name

cat TRACES/trace.test.$$ | sed -e 's!JobId=!!' | sort -n | awk '{ print $1,$7,$8,$9,$10,$13 }' | awk -F'[=/ /]' '{split($0,a); printf("%s\t%s\t%s\t%s\t%s\t-1\t-1\t%s\t%s\t-1\t1\t-1\t-1\t-1\t-1\t-1\t-1\t-1\n",a[1]-1,a[5],a[7]-a[5],a[9]-a[7],a[11],a[11],a[3])}' > "o_"$workload_name".swf"
