#!/bin/sh
# title: making geneID and geneSymbol table from Drosophila gtf file 
# author: Tingting Zhao
# data: 03/04/2022
# usage: bash makeGeneAnnoTable.sh 

refdir="/data/bioinformatics/referenceGenome/Drosophila_Melanogaster/Ensembl/dm6/"
gtf_file="Drosophila_melanogaster.BDGP6.32.104.chr.filtered.gtf"
geneName_file="Drosophila_melanogaster.BDGP6.32.104.chr.filtered_geneAnnotationTable.txt"

cd $refdir

# extract Drosophila gene ID and gene symbols from gtf file
cat $gtf_file | awk 'BEGIN{FS="\t"}{split($9,a,";"); if ($3~"gene") print a[1]"\t"a[2]}' | sed 's/gene_id "//' | sed 's/ gene_name "//' | sed 's/"//g' > $geneName_file

# run R script to manipulate gene ID and gene symbols and generate an output file
echo $PWD
Rscript makeGeneAnnoTable.R $refdir $geneName_file