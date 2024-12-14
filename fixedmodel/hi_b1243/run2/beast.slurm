#!/bin/bash
#SBATCH --job-name=hi_b1243
#SBATCH --partition=shared
#SBATCH --time=03-00:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=120000

#SBATCH --core-spec=0 ## Uncommented to allow jobs to request all cores on a node
#SBATCH --constraint="ib_qdr"

#SBATCH --error=name=hi_b1243.err ## %A - filled with jobid
#SBATCH --output=name=hi_b1243 ## %A - filled with jobid
#SBATCH --mail-user=claire7@hawaii.edu
#SBATCH --mail-type=BEGIN,END,FAIL,REQUEUE,TIME_LIMIT_80

source ~/.bash_profile

module load bio/Beast/2.6.0-intel-2018.5.274
module load numlib/beagle-lib/3.0.2-intel-2018.5.274
beast -beagle_CPU hi_b1243.xml
