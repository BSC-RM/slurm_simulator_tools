#!/bin/bash
#
# Cleans files and database entries representing the state of a Slurm
# simulation. Also, it kills all Slurm simulation processes.
# If simulation is run by the root use, it must be called with sudo.
#
# usage: ./reset_user.sh
# 
# Produced at the Lawrence Berkeley National Lab
# Written by Gonzalo P. Rodrigo <gprodrigoalvarez@lbl.gov>
#

rm -rf slurm_varios/acct/*
rm -rf slurm_varios/log/*
rm -rf slurm_varios/var/state/*
rm -rf slurm_varios/var/spool/*

#mysql -u slurm --password=ihatelsf < delete_slurm_tables_info
killall slurmd
killall slurmctld
killall slurmdbd
killall sim_mgr
#rm /var/run/slurmd.pid

