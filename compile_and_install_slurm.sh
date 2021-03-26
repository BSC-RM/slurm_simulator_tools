#!/bin/bash
if [ $# -ne 2 ];
then
        echo "Script needs to be invoked with two arguments."
    echo "./compile_and_install_slurm.sh  /slurm_source /target_install_dir"
fi

slurm_source_dir="$1"
install_dir="$2"

echo "Compiling and installing Slurm from ${slurm_source_dir} to "\
"${install_dir}"

mkdir -p "${install_dir}"
mkdir -p "${install_dir}/slurm_varios/var/state"
mkdir -p "${install_dir}/slurm_varios/var/spool"
mkdir -p "${install_dir}/slurm_varios/log"

export LIBS=-lrt

export CFLAGS="-D SLURM_SIMULATOR -g0 -O3 -D NDEBUG=1 -fno-omit-frame-pointer -fcommon"

cd "${slurm_source_dir}"

echo "Running Configure"

./configure --exec-prefix=$install_dir/slurm_programs \
--localstatedir=$install_dir/slurm_varios \
--sharedstatedir=$install_dir/slurm_varios \
--mandir=$install_dir/slurm_varios/man \
--prefix=$install_dir/slurm_programs \
--sysconfdir=$install_dir/slurm_conf \
--enable-front-end --disable-debug 2> slurm_configure.log

echo "Compiling"
make -j4

echo "Installing"
make -j install

echo "Compiling simulator binaries"
cd $slurm_source_dir/contribs/simulator
make

echo "Installing simulator binaries"
make -j install
