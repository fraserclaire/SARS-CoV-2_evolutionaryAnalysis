#!/bin/bash
#SBATCH --job-name=la_b117
#SBATCH --partition=sandbox
#SBATCH --time=00-04:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=120000

#SBATCH --core-spec=0 ## Uncommented to allow jobs to request all cores on a node
#SBATCH --constraint="ib_qdr"

#SBATCH --error=name=la_b117.err ## %A - filled with jobid
#SBATCH --output=name=la_b117 ## %A - filled with jobid
#SBATCH --mail-user=claire7@hawaii.edu
#SBATCH --mail-type=BEGIN,END,FAIL,REQUEUE,TIME_LIMIT_80

source ~/.bash_profile

module load bio/Beast/2.6.0-intel-2018.5.274
module load numlib/beagle-lib/3.0.2-intel-2018.5.274
beast -beagle_CPU la_b117.xml
