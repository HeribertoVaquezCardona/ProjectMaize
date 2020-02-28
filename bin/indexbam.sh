#!/bin/bash


ncores="6"
home="/srv/home/hvazquez"
bam="../bam"
javarules="-Djava.io.tmpdir=../speedy/tmp"


while read name 
do

{

samtools index -b $bam/$name.bam > $bam/$name.bam.bai

}

done < $home/meta/samplelist.txt
