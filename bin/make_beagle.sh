#!/bin/bash


ref="/srv/home/hvazquez/data/RefGenome/Zea_mays.B73_RefGen_v4.dna_rm.toplevel.fa"
bam="/srv/home/hvazquez/meta/bam.filelist"

./angsd/angsd -bam $bam -doMaf 1 -doMajorMinor 4 -uniqueOnly 1 -minMapQ 30 -minQ 20 -minInd 87 -ref $ref -GL 2 -doGlf 2 -SNP_pval 1e-6 -P 8 -out genolike

