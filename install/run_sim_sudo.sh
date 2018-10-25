#!/bin/bash +xe
#
# Runs a Slurm simulation until simulated time reaches timestamp. Jobs submitted
# are listed at the trace_file.
#
# usage: ./run_sim_sudo.sh timestamp trace_file
# 
# Produced at the Lawrence Berkeley National Lab
# Written by Gonzalo P. Rodrigo <gprodrigoalvarez@lbl.gov>
#
#[ -z "$CLEANED" ] && exec /bin/env -i CLEANED=1 /bin/sh "$0" "$@"
#source enableenv_mn4
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR
source env.sh
./reset_user.sh
#slurmdbd
export SLURM_CONF=$(pwd)/slurm_conf/slurm.conf
sim_mgr $1 -w $2 --fork
#2>&1
