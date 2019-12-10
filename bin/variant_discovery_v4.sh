#!/bin/bash
#SBATCH -p keri
#SBATCH -n 10
#SBATCH --mem=60000


java -jar picard.jar CreateSequenceDictionary R=../data/B73_v4/Zea_mays.B73_RefGen_v4.dna_rm.toplevel.fa
O=../data/B73_v4/Zea_mays.B73_RefGen_v4.dna_rm.toplevel.fa.dict

samtools faidx /LUSTRE/Genetica/hvazquez/data/B73_v4/Zea_mays.B73_RefGen_v4.dna_rm.toplevel.fa

for library in Zea-Mays_S16_L004; do

javarules="-Djava.io.tmpdir=../speedy/tmp"
ncores="10"
home="/LUSTRE/Genetica/hvazquez"
ref="/LUSTRE/Genetica/hvazquez/data/B73_v4/Zea_mays.B73_RefGen_v4.dna_rm.toplevel.fa"
bam="../$library/out_bam/"
gvcf="../gvcf"

while read prefix
do
 if [ ! -f $gvcf/$prefix.gvcf.vcf.idx ]
then

#Call GATK HaplotypeCaller
./gatk-4.1.4.1/gatk --java-options "-Xmx60g" HaplotypeCaller  \
	-R /LUSTRE/Genetica/hvazquez/data/B73_v4/Zea_mays.B73_RefGen_v4.dna_rm.toplevel.fa \
	-I /LUSTRE/Genetica/hvazquez/out_bam/$prefix.sort.bam \
	-O $gvcf/$prefix.gvcf.vcf \
	--native-pair-hmm-threads $ncores \
	-ERC GVCF ; #Emmitting reference confidence scores, gvcf format

fi
done < $home/meta/samplelist.txt

done
