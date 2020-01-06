#!/bin/bash
#SBATCH -p keri
#SBATCH -n 10
#SBATCH --mem=60000

combinedGVCFs="/LUSTRE/Genetica/hvazquez/gvcf_1/gvcf"
tmp=""
ref="/LUSTRE/Genetica/hvazquez/data/B73_v4/Zea_mays.B73_RefGen_v4.dna_rm.toplevel.fa"
home="/LUSTRE/Genetica/hvazquez"

ls $combinedGVCFs | grep "vcf" | grep -v ".idx"   > $home/meta/GVCFs_1.samplelist.txt

while read prefix
do
        tmp="$tmp --variant $combinedGVCFs/$prefix"
done < $home/meta/GVCFs_1.samplelist.txt

./gatk-4.1.4.1/gatk --java-options "-Xmx60g" CombineGVCFs \
        -R /LUSTRE/Genetica/hvazquez/data/B73_v4/Zea_mays.B73_RefGen_v4.dna_rm.toplevel.fa \
        $tmp \
        -O /LUSTRE/Genetica/hvazquez/gvcf_1/gvcf/Zea_mays.GPv4.vcf \
        --read-filter MappingQualityReadFilter \
        --read-filter NotDuplicateReadFilter
