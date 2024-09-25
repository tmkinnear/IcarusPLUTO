#!/bin/bash
#Example job submission script
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=96
#SBATCH --cpus-per-task=1
#SBATCH --mem=120G
#SBATCH --time=20-00:00:00
#SBATCH --job-name=PlutoTask
#SBATCH --mail-type=END
#SBATCH --mail-user=${USER}@kent.ac.uk
#SBATCH --output=./%j.out
#SBATCH --error=./%j.err

echo "Starting..."

CONDAENV=PLUTOenv
export PLUTO_DIR="/home/${USER}/Pluto/PLUTO/"

##Initialisation Section
source /home/${USER}/.bashrc #to get conda
conda activate ${CONDAENV} #activate conda env providing MPI
export LD_LIBRARY_PATH=/home/${USER}/miniconda3/envs/${CONDAENV}/lib #MPI library path

mpirun -np 96 pluto > pluto.log

wait

echo "...Complete"
