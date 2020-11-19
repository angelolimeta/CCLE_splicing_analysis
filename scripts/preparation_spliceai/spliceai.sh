#!/usr/bin/env bash

#SBATCH -A C3SE2020-1-8
#SBATCH -p hebbe
#SBATCH -n 6 -t 0-1:30:00

module load Anaconda3
echo "Activating conda environment"
source activate /cephyr/NOBACKUP/groups/snic2020-8-84/conda/envs/spliceai

echo "running spliceai"

input="/cephyr/NOBACKUP/groups/snic2020-8-84/spliceai/dummy_out.vcf.gz"
output="/cephyr/NOBACKUP/groups/snic2020-8-84/spliceai/output/splice_dummy_out.vcf"
reference="/cephyr/NOBACKUP/groups/snic2020-8-84/spliceai/ref/hg19.fa"
ann="/cephyr/NOBACKUP/groups/snic2020-8-84/spliceai/annotations/grch37.txt"

spliceai -I $input -O $output -R $reference -A $ann
