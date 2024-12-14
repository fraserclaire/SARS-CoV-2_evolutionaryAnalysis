require(ggplot2)

dat <- read.csv("beastrates.csv")
names(dat) <- c("Locality", "Variant", "Substitution Rate x 10-3")
x <- dat[,2]
y <- dat[,3]
z <- dat[,1]
pdf("subrates.pdf", height=5)
ggplot(dat, aes(x, y, fill=z)) +
geom_bar(stat="identity", position=position_dodge()) +
  xlab("") +
  ylab(bquote('Substitution Rate (s/s/y) x '~10^-3)) +
  theme(axis.text.x = element_text(size=15)) +
  theme(axis.text.y = element_text(size=13)) +
  theme(axis.title = element_text(size = 15))  +
  theme(legend.title = element_text(size = 15))   +
  theme(legend.text = element_text(size = 14)) +
  scale_fill_manual(name = "Locality", values=c("#56B4E9","#0072B2"))
dev.off()