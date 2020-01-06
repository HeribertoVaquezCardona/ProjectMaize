# Filters and Flags
This file explains some filters and flags that we used by each script. 

**demultiplex.sh**
--Demultiplexer: Call the demultiplexer program.
-f1: refers to fasqc file numer 1.
-f2: refers to fastqc file number 2.
-i: refers to barcode list. 

**p_alignment.sh**
-1: refers to fasqc file numer 1.
-2: refers to fastqc file number 2.
-r: reference genome.

**variant_discovery_v4.sh**
HaplotypeCaller: calls the discovery program.
-R: reference genome.
-I: input bam.
-O: outuput vcf files.
-ERC GVCF: emitting reference confidence score, vcf format.

**merge_gvcf.sh**
CombinesGVCFs: calls the combined program.
-R: reference genome.
--read-filter MappingQualityReadFilter: cares quality.
--read-filter NotDuplicateReadFilter: avoids duplicates.

**make_beagleinput.sh**
-GL 2: use GATK.
-doGlf 2: file.beagle.gz.
-doMajorMinor 1: input bam.
-doMaf 1: knows Major and Minor.  
-uniqueOnly 1: mapped reads in one position. Avoids duplicates.
-minInd 87: refers to 90% of the individuals.

**run_admixture.sh**
-K: number of clusters.
-likes inputBeagleFile.gz: I goy this file with make_beagleunput.sh.
-P: number of threads.
-o: prefix of output file names.
-minMaf 0.05: because we have small reads (150) and a few popultaion.

