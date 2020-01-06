#!/bin/bash
#SBATCH -p keri
#SBATCH -n 6
#SBATCH --mem=60000

bam="/LUSTRE/Genetica/hvazquez/meta/bam.filelist"


./angsd/angsd -GL 2 -out genolikebeagle -nThreads 5 -doGlf 2 -doMajorMInor 1 -SNP_pval 1e-6 -doMaf 1 -uniqueOnly 1 -minMapQ 30 -minQ 20 -minInd 87 -bam $bam
