#!/bin/bash

#SBATCH --job-name=superfocus_test
#SBATCH --output=%x-%j.out.txt
#SBATCH --error=%x-%j.err.txt
#SBATCH --partition=high-capacity
#SBATCH --qos=hc-concurrent-jobs
#SBATCH --time=4-0
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=200G

export SUPERFOCUS_DB=/scratch/user/doan0033/database/superfocus_mmseqsDB/mmseqs2
for f in `cat ./sample-names.txt`; do

superfocus -q ./ -dir superfocus_results -a mmseqs2 -t 16 -n 0

done

