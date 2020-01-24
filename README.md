To install the Simulator:
- Run: ./install_slurm_sim.sh

To prepare input:
- Modify swf2trace.c in slurm_simulator/contribs/simulator to read your trace format
- Use it to generate a trace for SLURM
- If you have your trace in SFW format you just need to change job's requested number of cores per node (this is fixed in swf2trace.c, but it can be changed if the information is available per job)

To run the simulation:
- In your laptop, run: ./run_simulation_local.sh [workload path] [param list]
- On a Slurm system, run: sbatch submit_simulation.sh [workload path] [param list]
- param list is the list of parameters that you can dynamically edit at each run. This is implemented by using sed and TOKENS in the slurm.conf template. Please take a look at run_simulation_local.sh. Default script has TOKEN_CORES and TOKEN_BF_QUEUE, but they are currently set to a fixed number.
- Run a first example by: ./run_simulation_local.sh $COMPLETE_PATH/workloads/cirne_workload

Analyze output:
- The simulator is configured to write output in: simulation_folder/TRACES
- The run script automatically convert this output to 3 formats:
	*list of: submit time, start time, end time per job
	*sfw format
	*csv format: more detailed, including metrics calculation and nodelist per job
	
Citing the BSC Slurm Simulator:
"Evaluating SLURM Simulator with Real-Machine SLURM and Vice Versa", Ana Jokanovic, Marco D'Amico, Julita Corbalan, Performance Modeling, Benchmarking and Simulation of High Performance Computer Systems (PMBS18)At: ACM/IEEE Supercomputing 2018 (SC18), Dallas, TX, USA
