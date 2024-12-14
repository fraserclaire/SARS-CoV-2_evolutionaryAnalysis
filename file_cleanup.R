setwd("E:/SARS-CoV-2/REDO/repo/fasta/la_b1243")
require(ape)
require(stringr)

#read in FASTA, get rid of those not in tree, and clean up names

tre <- read.tree("la_b1243.nwk")

#rename tip labels to exclude / and -
tre$tip.label <- str_replace_all(tre$tip.label, "-", "_")
tre$tip.label <- str_replace_all(tre$tip.label, "/", "_")
tre$tip.label <- str_replace_all(tre$tip.label, " ", "_")
tre$tip.label <- str_replace_all(tre$tip.label, "[|]", "_")

#write new tree
ape::write.tree(tre, file='la_b1243_updated.nwk')

#fix fasta names
dat <- read.FASTA("la_b1243.fasta")
id <- names(dat)
name <- str_replace_all(id, "/", "_")
name <- str_replace_all(name, "-", "_")
name <- str_replace_all(name, " ", "_")
name <- str_replace_all(name, "[|]", "_")
names(dat) <- name


#find tips to keep in fasta based on those in tree
keep <- grep("TRUE", names(dat) %in% tre$tip.label)
datt <- dat[keep]
write.FASTA(datt, "la_b1243_cleaned.fasta")


#read in metadata to make table with collection dates
met <- read.csv("la_b1243_allseq.csv")

all <- str_replace_all(met$Virus.name, "hCoV-19/", "")
all <- str_replace_all(all, "/", "_")
all <- str_replace_all(all, "-", "_")
all <- str_replace_all(all, " ", "_")
all <- str_replace_all(all, "[|]", "_")
met$Virus.name <- all

dates <- met$Collection.date
dates <- format(as.Date(dates, format = "%m/%d/%Y"), "%m/%d/%Y")
met$Collection.date <- dates

l <- grep("TRUE", met$Virus.name %in% tre$tip.label)
mett <- met[l,]
namedate <- cbind(mett$Virus.name, mett$Collection.date)
write.table(namedate, file="la_b1243.txt", sep = "\t", dec = ".", row.names = FALSE, col.names = TRUE, quote=F)
