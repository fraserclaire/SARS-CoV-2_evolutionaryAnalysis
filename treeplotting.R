require(treeio)
require(ggtree)
require(ggplot2)
require(dplyr)

b117 <- read.tree("all_b117.newick")  # trees
b1243 <- read.tree("all_b1243.newick")
wulab <- grep("Wu", b117$tip.label, value=T)

d <- read.csv("sequenceids.csv")  # metadata
names(d) <- tolower(names(d))
#d$label <- gsub("/|-", "_", d$label)
d$col <- "blue"
d$col[d$locality=="LA"] <- "red"
names(d) <- c("label", "locality", "variant", "col")
## add locality info for Wuhan 
d <- rbind (d, data.frame(label=rep(wulab, 2), locality="Wuhan", variant=c("B117", "B1243"), col="grey"))

d117 <- d[d$variant=="B117",]
d1243 <- d[d$variant=="B1243",]

p <- ggtree(b117) %<+% d117   # attach tip dataframe to ggtree object

p2 <- p + #geom_tiplab(offset = .6, hjust = .5) +  # plot phylogeny with locality annotations on tips
    geom_tippoint(aes(color = locality), size=1) + 
    scale_color_manual(values=c("blue", "red", "green")) + 
    theme(legend.position = "right") +
    ggtitle("B.1.1.7 Phylogeny")
    
q <- ggtree(b1243) %<+% d1243   # attach tip dataframe to ggtree object
    
q2 <- q + #geom_tiplab(offset = .6, hjust = .5) +
    geom_tippoint(aes(color = locality), size=1) + 
    scale_color_manual(values=c("blue", "red", "green")) + 
    theme(legend.position = "right")  +   
    ggtitle("B.1.243 Phylogeny ")
    
    
pdf("treeplotting.pdf", width=6, height=9)
  print(p2)
  print(q2)
dev.off()
    
# There are some mismatches between tree and labels in B1243:

write.csv(merge(data.frame(label=b1243$tip.label), d1243, by="label", all=T), "mismatches.csv")

