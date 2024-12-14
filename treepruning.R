setwd("E:/SARS-CoV-2/REDO/repo/trees")
require(ape)
require(phylotools)
require(stringr)
require(seqinr)

#put tree into object
tree <- read.tree(file="la_b117.nwk")

#make list of taxa to include 
#lists do not include wuhan sequences
#included list will drop those sequences and keep the others
#ex: read in exponential ID list, drop to obtain waning tree
s <- read.table("la_b117_waning.txt")

#index list to find sequences to exclude-not in tree due to nextstrain filtering
todrop <- grep("FALSE", s$V1 %in% tree$tip.label)

#generate pruned tree using drop.tip()
if(length(todrop) > 0){
	ss <- s[-c(todrop),]
}else{
	ss <- s}
expo <- drop.tip(tree, ss)
#If above line fails, change ss$V1 to ss, or viceversa

#rename tip labels to exclude / and -
expo$tip.label <- str_replace_all(expo$tip.label, "-", "_")
expo$tip.label <- str_replace_all(expo$tip.label, "/", "_")

#write new tree
#ape::write.tree(waning, file='./prunedtrees/la_b117_expo.nwk')

#######
#generate new fasta removing dropped tips
#drop filtered out seq in phase of interest
fdrop <- s$V1[s$V1!=ss]
#include list of OTHER phase to remove from fasta
otherphase <- read.table("la_b117_waning.txt")
#find out dimensions of list
dim(otherphase)
#change the "1:___" value to reflect proper length
otherphase[1:579,] <- str_replace_all(otherphase[1:579,], "-", "_")
otherphase[1:579,] <- str_replace_all(otherphase[1:579,], "/", "_")
toremove <- c(fdrop, otherphase$V1)
rm.sequence.fasta(infile = "la_b117_cleaned.fasta", outfile = "../updatedfasta/la_b117_expo_updated.fasta", to.rm = toremove)

#####################
#Prune IQTREE of all seq from each variant from both localities
setwd("E:/SARS-CoV-2/REDO/repo/iqtree")

#put tree into object
tree <- read.tree(file="all_b1243_old.newick")

#make list of taxa to include 
#lists do not include wuhan sequences
#included list will drop those sequences and keep the others
#ex: read in exponential ID list, drop to obtain waning tree
s <- read.csv("b1243_labels_updated.csv", row.names=NULL)
s <- s[,2]

s <- str_replace_all(s, "-", "_")
s <- str_replace_all(s, "/", "_")


#index list to find sequences to exclude-not in tree due to nextstrain filtering
todrop <- grep("FALSE", s %in% tree$tip.label)

#generate pruned tree using drop.tip()
if(length(todrop) > 0){
	ss <- s[-c(todrop)]
}else{
	ss <- s}
expo <- drop.tip(tree, ss)
#If above line fails, change ss$V1 to ss, or viceversa

#write new tree
ape::write.tree(expo, file='./all_b1243.newick')
