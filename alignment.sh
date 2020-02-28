#!/bin/bash


home="/srv/home/hvazquez/"
ngm="Cibiv-NextGenMap-33e92fb/bin/ngm-0.5.5/ngm"
ref="../data/RefGenome/Zea_mays.B73_RefGen_v4.dna_rm.toplevel.fa.gz"
bam="../bam"
fastq="../out"
log="../out_log"
project="Zmays_v4_2019"
picard="picard-2.21.3"
ncores="8"



ls  $fastq  |grep -v "nobar" | grep fastq |  grep R | sed s/.R1.fastq.gz// | sed s/.R2.fastq.gz// | uniq > $home/meta/samplelist.txt

while read name
do
        if [  ! -f $bam/$name.bam ]; then

{
        echo "Aligning paired $name"

        $ngm -r $ref -p -1 $fastq/${name}.R1.fastq.gz -2 $fastq/${name}.R2.fastq.gz -o $bam/$name.paired.bam  -t 8 -b --rg-id $name --rg-sm $name
 --rg-pl illumina --rg-pu $project --rg-lb Zea-Mays_S16_L004


        echo "Aligning unpaired $name"

        $ngm -r $ref -q $fastq/${name}.R1.fastq.gz  -o $bam/$name.R1_unpaired.bam -t $ncores -b --rg-id $name --rg-sm $name --rg-pl illumina --rg-pu $project --rg-lb Zea-Mays_S16_L004
        $ngm -r $ref -q $fastq/${name}.R2.fastq.gz  -o $bam/$name.R2_unpaired.bam -t $ncores -b --rg-id $name --rg-sm $name --rg-pl illumina --rg-pu $project --rg-lb Zea-Mays_S16_L004


         echo "Processing for $name"

 java -jar $picard/picard.jar MergeSamFiles I=$bam/$name.paired.bam I=$bam/$name.R1_unpaired.bam I=$bam/$name.R2_unpaired.bam O=$bam/$name.merged.bam VALIDATION_STRINGENCY=LENIENT COMPRESSION_LEVEL=0
 samtools view -h $bam/$name.merged.bam > $bam/$name.merged.sam
 samtools view -hSb $bam/$name.merged.sam > $bam/$name.merged.bam
 java -jar $picard/picard.jar SortSam I=$bam/$name.merged.bam O=$bam/$name.merged.v1.bam SORT_ORDER=coordinate VALIDATION_STRINGENCY=LENIENT COMPRESSION_LEVEL=0
 java -jar $picard/picard.jar AddOrReplaceReadGroups I=$bam/$name.merged.v1.bam O=$bam/$name.merged.v2.bam RGID=$name RGLB=$project RGPL=ILLUMINA RGPU=$project RGSM=$name SORT_ORDER=coordinate VALIDATION_STRINGENCY=LENIENT COMPRESSION_LEVEL=0
 java -jar $picard/picard.jar CleanSam I=$bam/$name.merged.v2.bam O=$bam/$name.bam VALIDATION_STRINGENCY=LENIENT
 java -jar $picard/picard.jar MarkDuplicates I=$bam/$name.bam O=marked_duplicates.bam M=marked_dup_metrics.txt ASSUME_SORTED=true VALIDATION_STRINGENCY=LENIENT

         rm $bam/$name.merged*
         rm $bam/$name.paired.bam*
         rm $bam/$name.R?_unpaired.bam*

 }>& $log/$name.alignment.log
 fi
 done < $home/meta/samplelist.txt
