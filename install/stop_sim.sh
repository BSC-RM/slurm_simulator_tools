#!/bin/bash
#
# Stops Slurm simulation without cleaning the simulation state.
#
# usage: ./stop_sim.sh
# 
# Produced at the Lawrence Berkeley National Lab
# Written by Gonzalo P. Rodrigo <gprodrigoalvarez@lbl.gov>
#
killall sim_mgr
killall slurmd
killall slurmctld

sleep 3

killall -9 slurmd
killall -9 slurmctld

mv slurm_varios/log/slurmctld_stats last_run_stats
