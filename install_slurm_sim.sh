#!/bin/bash

work_dir=`pwd`
slurm_install_dir="${work_dir}/install"
slurm_source_dir="${work_dir}/slurm_simulator"

slurm_branch="bsc_simulator_v17"
if [ ! -d "$slurm_source_dir" ]; then
    echo "Downloading Slurm code from Github"
    git clone https://github.com/BSC-RM/slurm_simulator.git
    echo "Switching Slurm into tag $slurm_branch"
    cd $slurm_source_dir
    git checkout "${slurm_branch}"
    cd ..
fi

cd $slurm_source_dir
echo "Regenerating automake Makefiles in SLURM"
#./autogen.sh > ../autogen.output.txt

cd $work_dir

./compile_and_install_slurm.sh "${slurm_source_dir}" "${slurm_install_dir}"
