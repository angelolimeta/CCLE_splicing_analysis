#!/usr/bin/env bash

#create vcf input file for spliceai containing the mutations for each chromosome separately

# Makes the bash script to print out every command before it is executed except echo
#trap '[[ $BASH_COMMAND != echo* ]] && echo $BASH_COMMAND' DEBUG

declare -a chr_list

chr_list=(4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21)

for i in "${chr_list[@]}"
do
#echo "$i"
mkdir chr${i} #create a directory for each output
grep "^#" CCLE_sort.vcf > chr${i}/CCLE_chr${i}.vcf
grep -w "^${i}" CCLE_sort.vcf >> chr${i}/CCLE_chr${i}.vcf

awk 'BEGIN{FS=OFS="\t"} {gsub(/\-/, ".", $4)} 1' chr${i}/CCLE_chr${i}.vcf  > chr${i}/temp.vcf && mv chr${i}/temp.vcf chr${i}/CCLE_chr${i}.vcf
#awk '{ if($4 == "-") { print }}' CCLE_chr1.vcf >> CCLE_chr1_ins.vcf #to filter only the ones containing "-"

bgzip chr${i}/CCLE_chr${i}.vcf #compress file
tabix chr${i}/CCLE_chr${i}.vcf.gz #index file
done
