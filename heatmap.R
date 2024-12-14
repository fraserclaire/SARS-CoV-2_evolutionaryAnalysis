##Make a heatmap to show overlapping sites with selection
library(stringr)
library(tidyverse)
library(ggpubr)
theme_set(theme_pubr())

#allsites
#b117
dat <- read.csv("b117_heatmap_allsites_swap.csv")
names(dat) <- c("X", "Y", "Selection")
dat$Selection <- str_replace_all(dat$Selection, "-1", "negative")
dat$Selection <- str_replace_all(dat$Selection, "0", "none")
dat$Selection <- str_replace_all(dat$Selection, "1", "positive")
pdf("b117_heatmap_allsites.pdf", height=5, width=20)
ggplot(dat, aes(fct_inorder(X), fct_inorder(Y), fill= Selection)) + 
    geom_tile(color = "white",
              lwd = 0.5,
              linetype = 1)+
    scale_fill_manual(values = c('red', 'white', 'yellow')) +
	theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1), axis.text.y=element_text(size=18), legend.title=element_text(size=18), legend.text=element_text(size=16), plot.title=element_text(size=27)) +
	ggtitle("B.1.1.7") +
	theme(axis.title.x=element_blank(), axis.title.y=element_blank()) 
dev.off()

#b1243
dat <- read.csv("b1243_heatmap_allsites.csv")
names(dat) <- c("X", "Y", "Selection")
dat$Selection <- str_replace_all(dat$Selection, "-1", "negative")
dat$Selection <- str_replace_all(dat$Selection, "0", "none")
dat$Selection <- str_replace_all(dat$Selection, "1", "positive")
pdf("b1243_heatmap_allsites.pdf", height=5, width=20)
ggplot(dat, aes(fct_inorder(X), fct_inorder(Y), fill= Selection)) + 
    geom_tile(color = "white",
              lwd = 0.5,
              linetype = 1)+
    scale_fill_manual(values = c('red', 'white', 'yellow')) +
	theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1), axis.text.y=element_text(size=18), legend.title=element_text(size=18), legend.text=element_text(size=16), plot.title=element_text(size=27)) +
	ggtitle("B.1.243") +
	theme(axis.title.x=element_blank(), axis.title.y=element_blank()) 
dev.off()

##################
###code to plot each region independently
##ggplot
#ORF1a
dat <- read.csv("b117_heatmap_ggplot_orf1a.csv")
names(dat) <- c("X", "Y", "Selection")
dat$Selection <- str_replace_all(dat$Selection, "-1", "negative")
dat$Selection <- str_replace_all(dat$Selection, "0", "none")
dat$Selection <- str_replace_all(dat$Selection, "1", "positive")
#pdf("heatmap_b117_orf1a.pdf", height=10, width=20)
orf1a <- ggplot(dat, aes(fct_inorder(X), fct_inorder(Y), fill= Selection)) + 
    geom_tile(color = "white",
              lwd = 0.5,
              linetype = 1)+
    scale_fill_manual(values = c('red', 'white', 'yellow')) +
	theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1), axis.text.y=element_text(size=18), legend.title=element_text(size=15), legend.text=element_text(size=13), plot.title=element_text(size=24)) +
	ggtitle("B.1.1.7") +
	xlab("ORF1a") + theme(axis.title.y=element_blank())
#dev.off()

#spike
dat <- read.csv("b117_heatmap_ggplot_spike.csv")
names(dat) <- c("X", "Y", "Selection")
dat$Selection <- str_replace_all(dat$Selection, "-1", "negative")
dat$Selection <- str_replace_all(dat$Selection, "0", "none")
dat$Selection <- str_replace_all(dat$Selection, "1", "positive")
#pdf("heatmap_b117_spike.pdf", height=10, width=20)
spi <- ggplot(dat, aes(fct_inorder(X), fct_inorder(Y), fill= Selection)) + 
    geom_tile(color = "white",
              lwd = 0.5,
              linetype = 1)+
    scale_fill_manual(values = c('red', 'white', 'yellow')) +
	theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1), axis.text.y=element_text(size=18), legend.title=element_text(size=15), legend.text=element_text(size=13), plot.title=element_text(size=24)) +
	ggtitle("B.1.1.7") +
	xlab("Spike") + theme(axis.title.y=element_blank())
#dev.off()

figure <- ggarrange(orf1a, spi,
                    ncol = 2, nrow = 1)
					
#Allsites
dat <- read.csv("b117_heatmap_allsites_v2.csv")
names(dat) <- c("X", "Y", "Selection")
dat$Selection <- str_replace_all(dat$Selection, "-1", "negative")
dat$Selection <- str_replace_all(dat$Selection, "0", "none")
dat$Selection <- str_replace_all(dat$Selection, "1", "positive")
pdf("b117_allsites_v2.pdf", height=5, width=20)
ggplot(dat, aes(fct_inorder(X), fct_inorder(Y), fill= Selection)) + 
    geom_tile(color = "white",
              lwd = 0.5,
              linetype = 1)+
    scale_fill_manual(values = c('red', 'white', 'yellow')) +
	theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1), axis.text.y=element_text(size=18), legend.title=element_text(size=18), legend.text=element_text(size=16), plot.title=element_text(size=27)) +
	ggtitle("B.1.1.7") +
	theme(axis.title.x=element_blank(), axis.title.y=element_blank()) 
dev.off()

######
##B.1.243
#ORF1a
dat <- read.csv("b1243_heatmap_ggplot_orf1a.csv")
names(dat) <- c("X", "Y", "Selection")
dat$Selection <- str_replace_all(dat$Selection, "-1", "negative")
dat$Selection <- str_replace_all(dat$Selection, "0", "none")
dat$Selection <- str_replace_all(dat$Selection, "1", "positive")
pdf("heatmap_b1243_orf1a.pdf", height=10, width=20)
ggplot(dat, aes(fct_inorder(X), fct_inorder(Y), fill= Selection)) + 
    geom_tile(color = "white",
              lwd = 0.5,
              linetype = 1)+
    scale_fill_manual(values = c('red', 'white', 'yellow')) +
	theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1), axis.text.y=element_text(size=18), legend.title=element_text(size=15), legend.text=element_text(size=13), plot.title=element_text(size=24)) +
	ggtitle("B.1.243") +
	xlab("ORF1a") + theme(axis.title.y=element_blank())
dev.off()

#Spike
dat <- read.csv("b1243_heatmap_ggplot_spike.csv")
names(dat) <- c("X", "Y", "Selection")
dat$Selection <- str_replace_all(dat$Selection, "-1", "negative")
dat$Selection <- str_replace_all(dat$Selection, "0", "none")
dat$Selection <- str_replace_all(dat$Selection, "1", "positive")
pdf("heatmap_b1243_spike.pdf", height=10, width=20)
ggplot(dat, aes(fct_inorder(X), fct_inorder(Y), fill= Selection)) + 
    geom_tile(color = "white",
              lwd = 0.5,
              linetype = 1)+
    scale_fill_manual(values = c('red', 'white', 'yellow')) +
	theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
	ggtitle("B.1.243") +
	xlab("Spike") + theme(axis.title.y=element_blank())
dev.off()
