#!/bin/bash
#
# Configures enviroment variables required by the Slurm simulator and
# must be invoked at the sim_install folder.
#
# usage: source env.sh
#
# Produced at the Lawrence Berkeley National Lab
# Written by Gonzalo P. Rodrigo <gprodrigoalvarez@lbl.gov>
#
DIR=`pwd`
echo "Configuring dirs under $DIR"
export SIM_DAEMONS_PATH="$DIR/slurm_programs/sbin"
export SIM_MGR_PATH="$DIR/slurm_programs/bin"
export SIM_DIR="$DIR"
#export SIM_LIBRARY_PATH="$DIR/slurm/src/simulation_lib/.libs"

export PATH=$SIM_DAEMONS_PATH:$SIM_MGR_PATH:$PATH

#export LIBS=-lrt
#export CFLAGS="-D SLURM_SIMULATOR"

