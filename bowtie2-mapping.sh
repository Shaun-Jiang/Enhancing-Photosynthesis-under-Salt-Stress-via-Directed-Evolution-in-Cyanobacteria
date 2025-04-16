#!/bin/bash

for i in $(ls ../*_1.fq.gz)
do
	prefix=$(echo $i | sed 's/_1.fq.gz//' | cut -d '/' -f 2)
	bowtie2 -x ../0-refseq/SelongatusPCC7942.fna -p 8 -1 ../${prefix}_1.fq.gz -2 ../${prefix}_2.fq.gz -S ./${prefix}\.sam 
done
