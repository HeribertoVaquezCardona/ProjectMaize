#### README ####

IMPORTANT: Please note you can download correlation data tables,
supported by Ensembl, via the highly customisable BioMart and
EnsMart data mining tools. See http://www.ensembl.org/biomart/martview or
http://www.ebi.ac.uk/biomart/ for more information.

The genome assembly represented here corresponds to  
GCA_000005005.6

#######################
Fasta DNA dumps
#######################

-----------
FILE NAMES
------------
The files are consistently named following this pattern:
   <species>.<assembly>.<sequence type>.<id type>.<id>.fa.gz

<species>:   The systematic name of the species.
<assembly>:  The assembly build name.
<sequence type>:
 * 'dna' - unmasked genomic DNA sequences.
  * 'dna_rm' - masked genomic DNA.  Interspersed repeats and low
     complexity regions are detected with the RepeatMasker tool and masked
     by replacing repeats with 'N's.
  * 'dna_sm' - soft-masked genomic DNA. All repeats and low complexity regions
    have been replaced with lowercased versions of their nucleic base
<id type> One of the following:
  * 'chromosome'     - The top-level coordinate system in most species in Ensembl
  * 'nonchromosomal' - Contains DNA that has not been assigned a chromosome
  * 'seqlevel'       - This is usually sequence scaffolds, chunks or clones.
     -- 'scaffold'   - Larger sequence contigs from the assembly of shorter
        sequencing reads (often from whole genome shotgun, WGS) which could
        not yet be assembled into chromosomes. Often more genome sequencing
        is needed to narrow gaps and establish a tiling path.
     -- 'chunk' -  While contig sequences can be assembled into large entities,
        they sometimes have to be artificially broken down into smaller entities
        called 'chunks'. This is due to limitations in the annotation
        pipeline and the finite record size imposed by MySQL which stores the
        sequence and annotation information.
     -- 'clone' - In general this is the smallest sequence entity.  It is often
        identical to the sequence of one BAC clone, or sequence region
        of one BAC clone which forms the tiling path.
<id>:     The actual sequence identifier. Depending on the <id type> the <id>
          could represent the name of a chromosome, a scaffold, a contig, a clone ..
          Field is empty for seqlevel files
fa: All files in these directories represent FASTA database files
gz: All files are compacted with GNU Zip for storage efficiency.


EXAMPLES
   The genomic sequence of human chromosome 1:
     Homo_sapiens.GRCh37.dna.chromosome.1.fa.gz

   The masked version of the genome sequence on human chromosome 1
   (contains '_rm' or '_sm' in the name):
     Homo_sapiens.GRCh37.dna_rm.chromosome.1.fa.gz
     Homo_sapiens.GRCh37.dna_sm.chromosome.1.fa.gz

   Non-chromosomal assembly sequences:
   e.g. mitochondrial genome, sequence contigs not yet mapped on chromosomes
     Homo_sapiens.GRCh37.dna.nonchromosomal.fa.gz
     Homo_sapiens.GRCh37.dna_rm.nonchromosomal.fa.gz
     Homo_sapiens.GRCh37.dna_sm.nonchromosomal.fa.gz

---------
TOPLEVEL
---------
These files contains all sequence regions flagged as toplevel in an Ensembl
schema. This includes chromsomes, regions not assembled into chromosomes and
N padded haplotype/patch regions.

EXAMPLES

  Toplevel sequences unmasked:
    Homo_sapiens.GRCh37.dna.toplevel.fa.gz
  
  Toplevel soft/hard masked sequences:
    Homo_sapiens.GRCh37.dna_sm.toplevel.fa.gz
    Homo_sapiens.GRCh37.dna_rm.toplevel.fa.gz

-----------------
PRIMARY ASSEMBLY
-----------------
Primary assembly contains all toplevel sequence regions excluding haplotypes
and patches. This file is best used for performing sequence similarity searches
where patch and haplotype sequences would confuse analysis. If the primary
assembly file is not present, that indicates that there are no haplotype/patch
regions, and the 'toplevel' file is equivalent.

EXAMPLES

  Primary assembly sequences unmasked:
    Homo_sapiens.GRCh37.dna.primary_assembly.fa.gz
  
  Primary assembly soft/hard masked sequences:
    Homo_sapiens.GRCh37.dna_sm.primary_assembly.fa.gz
    Homo_sapiens.GRCh37.dna_rm.primary_assembly.fa.gz

--------------
SPECIAL CASES
--------------
Some chromosomes have alternate haplotypes which are presented in files with 
the haplotype sequence only:
   Homo_sapiens.GRCh37.dna_rm.chromosome.HSCHR6_MHC_QBL.fa.gz
   Homo_sapiens.GRCh37.dna_rm.chromosome.HSCHR17_1.fa.gz

All alternative assembly and patch regions have their sequence padded 
with N's to ensure alignment programs can report the correct index
regions

e.g. A patch region with a start position of 1,000,001 will have 1e6 N's added
its start so an alignment program will report coordinates with respect to the
whole chromosome.

Human has sequenced Y chromosomes and the pseudoautosomal region (PAR)
on the Y is annotated.  By definition the PAR region is identical on the 
X and Y chromosome.  The Y chromosome file contains the Y chromsome 
minus these repeated PAR regions i.e. the unique portion of Y.

