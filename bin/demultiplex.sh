#!/bin/bash
#SBATCH -p keri
#SBATCH -n 5
#SBATCH --mem=30000
java -jar ./GBSX/releases/latest/GBSX_v1.3.jar --Demultiplexer -f1 ../../aguerra/Zmays/GBS-Heriberto/190717_BHL5NYDSXX/Zea-Mays_S16_L004_R1_001.fastq.gz -f2 ../../aguerra/Zmays/GBS-Heriberto/190717_BHL5NYDSXX/Zea-Mays_S16_L004_R2_001.fastq.gz -i ../meta/Zea-Mays_S16_L004_names_barcodes.txt -gzip true -o ../out/ -t 5
