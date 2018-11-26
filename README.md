To install the Simulator:
- Run: ./install_slurm_sim.sh

To prepare input:
- Modify swf2trace.c in slurm_simulator/contribs/simulator to read your trace format
- Use it to generate a trace for SLURM
- If you have your trace in SFW format you just need to change job's requested number of cores per node (this is fixed in swf2trace.c, but it can be changed if the information is available per job)

To run the simulation:
- In your laptop, run: ./run_simulation_local.sh [workload path] [param list]
- On a Slurm system, run: sbatch submit_simulation.sh [workload path] [param list]
- param list is the list of parameters that you change in slurm.conf, default parameters are numebr of cpus per node and number of tested jobs by backfill (this is a new parameter)

Analyze output:
- The simulator is configured to write output in: simulation_folder/TRACES
- The run script automatically convert this output to 3 formats:
	*list of: submit time, start time, end time per job
	*sfw format
	*csv format: more detailed, including metrics calculation and nodelist per job
