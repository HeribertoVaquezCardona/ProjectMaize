#!/bin/bash
#SBATCH -p keri
#SBATCH -n 8
#SBATCH --mem=60000
home="/LUSTRE/Genetica/hvazquez/"
ngm="Cibiv-NextGenMap-33e92fb/bin/ngm-0.5.5/ngm"
ref="../data/B73_v4/Zea_mays.B73_RefGen_v4.dna_rm.toplevel.fa.gz"
bam="../out_bam"
fastq="/LUSTRE/Genetica/hvazquez/out"


ls  $fastq | grep fastq |  grep R | sed s/.R1.fastq.gz// |sed s/.R2.fastq.gz// | uniq > lele.txt

while read name
do
	echo "Aligning paired $name"

$ngm -r $ref -p -1 ../out/${name}.R1.fastq.gz -2 ../out/${name}.R2.fastq.gz -o $bam/$name.bam  -t 8

echo "Processing for $name"

samtools sort -@ 8 $bam/$name.bam > $bam/${name}.sort.bam
	samtools index $bam/${name}.sort.bam
	rm $bam/$name.bam
}>& $log/$name.alignment.log
fi

done < $home/meta/samplelist.txt
