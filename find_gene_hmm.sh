GeneName="SGR"
genome="Urhy.protein.fasta"

inFastaSeq="STR_good.fasta"

clustalw -INFILE=$inFastaSeq -OUTFILE=$inFastaSeq.aln

input=$inFastaSeq.aln #bait gene  aligment from previous pep.fasta


## Build the HMM Profile: hmmer version HMMER 3.4 (Aug 2023); http://hmmer.org/
hmmbuild profile.hmm $input

hmmsearch -E 1e-5 --tblout ${GeneName}_all_genes_in_genome.n.txt profile.hmm $genome

#filter on evalue and hit score
python $scriptdir/get_covered_hit_fromHmm.py -i ${GeneName}_all_genes_in_genome.n.txt -o ${GeneName}_all_genes_in_genome.hmm.filtered.tsv -e 1e-10 -s 100
