#!/bin/bash

for i in $(ls ./*.ann.vcf)
do
	prefix=$(echo $i | cut -d '/' -f 2 | cut -d '.' -f 1)
	snippy-vcf_to_tab --ref ../0-refseq/SelongatusPCC7942.fna --gff ../0-refseq/SelongatusPCC7942.gff --vcf ./${prefix}.ann.vcf > ${prefix}.tab
done
