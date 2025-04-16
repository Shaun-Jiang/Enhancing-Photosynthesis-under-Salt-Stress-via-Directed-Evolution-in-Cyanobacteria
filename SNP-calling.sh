#!/bin/bash

#for i in $(ls ../2-mapping/*.sam)
#do
#	prefix=$(echo $i | cut -d '/' -f 3 | cut -d '.' -f 1)
#	printf '[samtools view]: %s\n' "$prefix"
#	samtools view -S -b ../2-mapping/${prefix}.sam > ./${prefix}.bam
#done

#for i in $(ls ./*.bam)
#do
#	prefix=$(echo $i | cut -d '/' -f 2 | cut -d '.' -f 1)
#	printf '[samtools sort]: %s\n' "$prefix"
#	samtools sort ./${prefix}.bam -o ./${prefix}-sorted.bam 
#done

for i in $(ls ./*-sorted.bam)
do
	prefix=$(echo $i | cut -d '/' -f 2 | cut -d '-' -f 1)
	printf '[bcftools mpileup]: %s\n' "$prefix"
	bcftools mpileup -A --threads 8 --min-BQ 0 --min-MQ 0 --annotate FORMAT/AD,FORMAT/ADF,FORMAT/ADR,FORMAT/DP,FORMAT/SP,INFO/AD,INFO/ADF,INFO/ADR -f ../0-refseq/SelongatusPCC7942.fna -o ${prefix}.vcf -Oz ./${prefix}-sorted.bam
done

for i in $(ls ./*.vcf)
do
	prefix=$(echo $i | cut -d '/' -f 2 | cut -d '.' -f 1)
	printf '[bcftools call]: %s\n' "$prefix"
	bcftools call --threads 8 -A -o ../4-final-data/${prefix}.vcf -O v ${prefix}.vcf -m -v -f GQ
done
