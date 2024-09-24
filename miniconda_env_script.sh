#!/bin/bash
#quick script for setting up miniconda environment for PLUTO

envname=PLUTOenv

mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh

/home/${USER}/miniconda3/bin/conda init

source /home/${USER}/.bashrc

#make sure .bashrc is sourced automatically on login
if [ ! -f /home/${USER}/.profile ] ; then
        echo "source ~/.bashrc" > ~/.profile
fi

conda create --name ${envname} --file spec-file.txt

#fix missing .so.1 files
ln -s /home/${USER}/miniconda3/envs/${envname}/lib/libmpi_cxx.so.40.20.1  /home/${USER}/miniconda3/envs/${envname}/lib/libmpi_cxx.so.1
ln -s /home/${USER}/miniconda3/envs/${envname}/lib/libmpi.so.40.20.2  /home/${USER}/miniconda3/envs/${envname}/lib/libmpi.so.1

source /home/${USER}/.bashrc

mkdir ~/Pluto
cd ~/Pluto
PLUTOversion=pluto-4.4-patch3
wget --no-check-certificate https://plutocode.ph.unito.it/Downloads/${PLUTOversion}.tar.gz #must be updated to correct versions; REALLY should not use "--no-check-certificate"
tar -xzvf ${PLUTOversion}.tar.gz

PLUTOpath=/home/${USER}/Pluto/PLUTO
