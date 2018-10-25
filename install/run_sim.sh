#!/bin/bash +xe
#
# Runs a Slurm simulation until simulated time reaches timestamp. Jobs submitted
# are listed at the trace_file. Simulation output is written in log_file.
# Simulation processes are run by the root user.
#
# usage: ./run_sim.sh timestamp trace_file log_file
# 
# Produced at the Lawrence Berkeley National Lab
# Written by Gonzalo P. Rodrigo <gprodrigoalvarez@lbl.gov>
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR
./run_sim_sudo.sh $1 $2  2>&1 > $3 &
