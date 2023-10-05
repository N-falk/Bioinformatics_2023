#!/bin/bash

#SBATCH --job-name=kraken
#SBATCH --output=%x-%j.out.txt
#SBATCH --error=%x-%j.err.txt
#SBATCH --time=1-0
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=200G
#SBATCH --partition=high-capacity
#SBATCH --qos=hc-concurrent-jobs

export KRAKEN_DB=/scratch/user/doan0033/database/kraken2db

for f in `cat ./sample-names.txt`; do

kraken2 --db $KRAKEN_DB ./"$f".fastq \
        --threads 16 --use-names \
        --report "$f"_kraken.report --output "$f"_kraken_.out
done
