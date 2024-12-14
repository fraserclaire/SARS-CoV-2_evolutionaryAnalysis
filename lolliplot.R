###Make pos/neg lollipop plots
# Libraries
library(ggplot2)
library(ggpubr)
theme_set(theme_pubr())

###B117
#ORF1a
datorf <- read.csv("b117_orf1a_perlength.csv")
names(datorf) <- c("phase", "sites")
xorf <- datorf$phase
yorf <- datorf$sites

xposorf <- xorf[c(1,3,5,7)]
x1orf <- rep(xposorf, times=2)
xnegorf <- xorf[c(2,4,6,8)]
x2orf <- rep(xnegorf, times=2)

yposorf <- yorf[c(1,3,5,7)]
y1orf <- rep(yposorf, times=2)
ynegorf <- yorf[c(2,4,6,8)]
y2orf <- rep(ynegorf, times=2)

one <- ggplot(datorf, aes(x=xorf, y=yorf)) +
  geom_segment( aes(x=x1orf, xend=x1orf, y=0, yend=y1orf), color="blue") +
  geom_segment( aes(x=x2orf, xend=x2orf, y=0, yend=y2orf), color="red") +
  geom_point(inherit.aes = FALSE, aes(x1orf, y1orf), color="blue", size=2) +
  geom_point(inherit.aes = FALSE, aes(x2orf, y2orf), color="red", size=2) +
  ylim(-0.03,0.005) +
  theme_light() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.border = element_blank(),
    axis.ticks.x = element_blank()
  ) +
  xlab("") +
  ylab("n sites / AA length") +
  geom_hline(yintercept = 0) +
  ggtitle("B.1.1.7 ORF1a")

#spike
datspi <- read.csv("b117_spike_perlength.csv")
names(datspi) <- c("phase", "sites")
xspi <- datspi$phase
yspi <- datspi$sites

xposspi <- xspi[c(1,3,5,7)]
x1spi <- rep(xposspi, times=2)
xnegspi <- xspi[c(2,4,6,8)]
x2spi <- rep(xnegspi, times=2)

yposspi <- yspi[c(1,3,5,7)]
y1spi <- rep(yposspi, times=2)
ynegspi <- yspi[c(2,4,6,8)]
y2spi <- rep(ynegspi, times=2)

spi <- ggplot(datspi, aes(x=x, y=y)) +
  geom_segment( aes(x=x1spi, xend=x1spi, y=0, yend=y1spi), color="blue") +
  geom_segment( aes(x=x2spi, xend=x2spi, y=0, yend=y2spi), color="red") +
  geom_point(inherit.aes = FALSE, aes(x1spi, y1spi), color="blue", size=2) +
  geom_point(inherit.aes = FALSE, aes(x2spi, y2spi), color="red", size=2) +
  ylim(-0.03,0.005) +
  theme_light() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.border = element_blank(),
    axis.ticks.x = element_blank()
  ) +
  xlab("") +
  ylab("") +
  geom_hline(yintercept = 0) +
  ggtitle("B.1.1.7 Spike")

#ORF7a
datsev <- read.csv("b117_orf7a_perlength.csv")
names(datsev) <- c("phase", "sites")
xsev <- datsev$phase
ysev <- datsev$sites

xpossev <- xsev[c(1,3,5,7)]
x1sev <- rep(xpossev, times=2)
xnegsev <- xsev[c(2,4,6,8)]
x2sev <- rep(xnegsev, times=2)

ypossev <- ysev[c(1,3,5,7)]
y1sev <- rep(ypossev, times=2)
ynegsev <- ysev[c(2,4,6,8)]
y2sev <- rep(ynegsev, times=2)

sev <- ggplot(datsev, aes(x=xsev, y=ysev)) +
  geom_segment( aes(x=x1sev, xend=x1sev, y=0, yend=y1sev), color="blue") +
  geom_segment( aes(x=x2sev, xend=x2sev, y=0, yend=y2sev), color="red") +
  geom_point(inherit.aes = FALSE, aes(x1sev, y1sev), color="blue", size=2) +
  geom_point(inherit.aes = FALSE, aes(x2sev, y2sev), color="red", size=2) +
  ylim(-0.03,0.005) +
  theme_light() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.border = element_blank(),
    axis.ticks.x = element_blank()
  ) +
  xlab("") +
  ylab("") +
  geom_hline(yintercept = 0) +
  ggtitle("B.1.1.7 ORF7a")

#combine all onto 1 pdf
pdf(file="b117_lolli.pdf", width=10, height=3)
ggarrange(one, spi, sev, ncol=3, nrow=1)
dev.off()

#########
###B1243
#ORF1a
datorf <- read.csv("b1243_orf1a_perlength.csv")
names(datorf) <- c("phase", "sites")
xorf <- datorf$phase
yorf <- datorf$sites

xposorf <- xorf[c(1,3,5,7)]
x1orf <- rep(xposorf, times=2)
xnegorf <- xorf[c(2,4,6,8)]
x2orf <- rep(xnegorf, times=2)

yposorf <- yorf[c(1,3,5,7)]
y1orf <- rep(yposorf, times=2)
ynegorf <- yorf[c(2,4,6,8)]
y2orf <- rep(ynegorf, times=2)

one <- ggplot(datorf, aes(x=xorf, y=yorf)) +
  geom_segment( aes(x=x1orf, xend=x1orf, y=0, yend=y1orf), color="blue") +
  geom_segment( aes(x=x2orf, xend=x2orf, y=0, yend=y2orf), color="red") +
  geom_point(inherit.aes = FALSE, aes(x1orf, y1orf), color="blue", size=2) +
  geom_point(inherit.aes = FALSE, aes(x2orf, y2orf), color="red", size=2) +
  ylim(-0.03,0.005) +
  theme_light() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.border = element_blank(),
    axis.ticks.x = element_blank()
  ) +
  xlab("") +
  ylab("n sites / AA length") +
  geom_hline(yintercept = 0) +
  ggtitle("B.1.243 ORF1a")

#spike
datspi <- read.csv("b1243_spike_perlength.csv")
names(datspi) <- c("phase", "sites")
xspi <- datspi$phase
yspi <- datspi$sites

xposspi <- xspi[c(1,3,5,7)]
x1spi <- rep(xposspi, times=2)
xnegspi <- xspi[c(2,4,6,8)]
x2spi <- rep(xnegspi, times=2)

yposspi <- yspi[c(1,3,5,7)]
y1spi <- rep(yposspi, times=2)
ynegspi <- yspi[c(2,4,6,8)]
y2spi <- rep(ynegspi, times=2)

spi <- ggplot(datspi, aes(x=x, y=y)) +
  geom_segment( aes(x=x1spi, xend=x1spi, y=0, yend=y1spi), color="blue") +
  geom_segment( aes(x=x2spi, xend=x2spi, y=0, yend=y2spi), color="red") +
  geom_point(inherit.aes = FALSE, aes(x1spi, y1spi), color="blue", size=2) +
  geom_point(inherit.aes = FALSE, aes(x2spi, y2spi), color="red", size=2) +
  ylim(-0.03,0.005) +
  theme_light() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.border = element_blank(),
    axis.ticks.x = element_blank()
  ) +
  xlab("") +
  ylab("") +
  geom_hline(yintercept = 0) +
  ggtitle("B.1.243 Spike")

#combine all onto 1 pdf
pdf(file="b1243_lolli.pdf", width=10, height=3)
ggarrange(one, spi, sev, ncol=3, nrow=1)
dev.off()

  
#####
##old plotting code
#dat <- read.csv("b117_orf1a.csv")
#names(dat) <- c("phase", "sites")
#x1 <- dat$phase
#y1 <- dat$sites
#
#one <- ggplot(dat, aes(x=x1, y=y1)) +
#  geom_segment( aes(x=x1, xend=x1, y=0, yend=y1), color="grey") +
#  geom_point( color="orange", size=2) +
#  ylim(-40,10) +
#  theme_light() +
#  theme(
#    panel.grid.major.x = element_blank(),
#    panel.border = element_blank(),
#    axis.ticks.x = element_blank()
#  ) +
#  xlab("") +
#  ylab("Sites with Selection") +
#  geom_hline(yintercept = 0) +
#  ggtitle("B.1.1.7 ORF1a")