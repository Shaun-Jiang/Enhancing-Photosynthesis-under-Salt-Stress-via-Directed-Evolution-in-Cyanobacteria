#!/bin/bash
#Execute this command under base environemnt!
for i in $(ls ../4-final-data/*.vcf)
do
	PREFIX=$(echo $i | cut -d '/' -f 3 | cut -d "." -f 1)
	java -Xmx8g -jar /home/the-exiled-duke/Toolkits/snpEff/snpEff.jar -c /home/the-exiled-duke/Toolkits/snpEff/snpEff.config -v PCC7942_NCBI ../4-final-data/${PREFIX}.vcf > ./${PREFIX}.ann.vcf
	mv ./snpEff_genes.txt ${PREFIX}_genes.txt
        mv ./snpEff_summary.html ${PREFIX}_summary.html	
done	

