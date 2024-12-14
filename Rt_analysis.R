require(bdskytools)
require(ggplot2)
require(stringr)
library(magrittr)
library(dplyr)
library(scales)

##
#Generate individual Rt plots and make Rt tables
#setwd("E:/SARS-CoV-2/REDO/repo/fixedmodel/hi_b117/run0")
#hawaii b117
fname <- "hi_b117_cleaned.log"   
lf    <- readLogfile(fname, burnin=0.2)

Re_sky    <- getSkylineSubset(lf, "reproductiveNumber")
Re_hpd    <- getMatrixHPD(Re_sky)
delta_hpd <- getHPD(lf$becomeUninfectiousRate)
plotSkyline(1:10, Re_hpd, type='step', ylab="R")

timegrid       <- seq(0,0.479,length.out=50)
Re_gridded     <- gridSkyline(Re_sky, lf$origin_BDSKY_Serial, timegrid)

Re_gridded_hpd1 <- getMatrixHPD(Re_gridded)
times1     <- 2021.625-timegrid
#plotSkyline(times1, Re_gridded_hpd1, type='smooth', xlab="Time", ylab="R")

pdf(file="../Re_hawaii_b117_run0t.pdf")
#, width = 20, height = 5)
plotSkyline(times1, Re_gridded_hpd1, type='smooth', xlab="Time", ylab="R", main="Hawaii B.1.1.7 Rt")
dev.off()

##
#setwd("E:/SARS-CoV-2/REDO/repo/fixedmodel/hi_b1243/run0")
#hawaii b1243
fname <- "hi_b1243_cleaned.log"   
lf    <- readLogfile(fname, burnin=0.2)

Re_sky    <- getSkylineSubset(lf, "reproductiveNumber")
Re_hpd    <- getMatrixHPD(Re_sky)
delta_hpd <- getHPD(lf$becomeUninfectiousRate)
plotSkyline(1:10, Re_hpd, type='step', ylab="R")

timegrid       <- seq(0,0.592,length.out=50)
Re_gridded     <- gridSkyline(Re_sky, lf$origin_BDSKY_Serial, timegrid)

Re_gridded_hpd2 <- getMatrixHPD(Re_gridded)
times2     <- 2021.107-timegrid
#plotSkyline(times, Re_gridded_hpd, type='smooth', xlab="Time", ylab="R")

pdf(file="../Re_hawaii_b1243_run0.pdf")
#, width = 20, height = 5)
plotSkyline(times2, Re_gridded_hpd2, type='smooth', xlab="Time", ylab="R", main="Hawaii B.1.243 Rt")
dev.off()

##
#setwd("E:/SARS-CoV-2/REDO/repo/fixedmodel/la_b117/run2")
#la b117
fname <- "la_b117_cleaned.log"   
lf    <- readLogfile(fname, burnin=0.2)

Re_sky    <- getSkylineSubset(lf, "reproductiveNumber")
Re_hpd    <- getMatrixHPD(Re_sky)
delta_hpd <- getHPD(lf$becomeUninfectiousRate)
plotSkyline(1:10, Re_hpd, type='step', ylab="R")

timegrid       <- seq(0,0.6,length.out=50)
Re_gridded     <- gridSkyline(Re_sky, lf$origin_BDSKY_Serial, timegrid)

Re_gridded_hpd3 <- getMatrixHPD(Re_gridded)
times3     <- 2021.667-timegrid
#plotSkyline(times, Re_gridded_hpd, type='smooth', xlab="Time", ylab="R")

pdf(file="../Re_la_b117_run2.pdf")
#, width = 20, height = 5)
plotSkyline(times3, Re_gridded_hpd3, type='smooth', xlab="Time", ylab="R", main="LA County B.1.1.7 Rt")
dev.off()

##
#setwd("E:/SARS-CoV-2/REDO/repo/fixedmodel/la_b1243/run1")
#la b1243
fname <- "la_b1243_cleaned.log"   
lf    <- readLogfile(fname, burnin=0.2)

Re_sky    <- getSkylineSubset(lf, "reproductiveNumber")
Re_hpd    <- getMatrixHPD(Re_sky)
delta_hpd <- getHPD(lf$becomeUninfectiousRate)
plotSkyline(1:10, Re_hpd, type='step', ylab="R")

timegrid       <- seq(0,0.296,length.out=50)
Re_gridded     <- gridSkyline(Re_sky, lf$origin_BDSKY_Serial, timegrid)

Re_gridded_hpd4 <- getMatrixHPD(Re_gridded)
times4     <- 2021.26-timegrid
#plotSkyline(times, Re_gridded_hpd, type='smooth', xlab="Time", ylab="R")

pdf(file="../Re_la_b1243_run1.pdf")
#, width = 20, height = 5)
plotSkyline(times4, Re_gridded_hpd4, type='smooth', xlab="Time", ylab="R", main="LA County B.1.243 Rt")
dev.off()

#make spreadsheets with Rt for each variant in each locality
write.csv(Re_gridded_hpd1, "../hi_b117_RN.csv")
write.csv(Re_gridded_hpd2, "../hi_b1243_RN.csv")
write.csv(Re_gridded_hpd3, "../la_b117_RN.csv")
write.csv(Re_gridded_hpd4, "../la_b1243_RN.csv")

###########################
###########################
####
#before moving on, need to combine the Rt values in one spreadsheet
#include the first and last collection dates, fill in the dates in between
#and finally make sure the dates line up between localities
#####
###########################

###########################
#########
#plot individual variants with no CI
#b117
dat <- read.csv("b117_rt.csv")
names(dat) <- str_replace_all(names(dat), "X", "")
names(dat) <- as.Date(names(dat), format="%m.%d.%Y")
x <- names(dat[,2:61])
y1 <- as.numeric(dat[1,2:61])
y2 <- as.numeric(dat[2,2:61])
dat1 <- cbind(x, y1)
datt <- cbind(dat1, y2)
datt <- as.data.frame(datt)
datt[,1] <- as.Date(datt[,1])
datt[,2] <- as.numeric(datt[,2])
datt[,3] <- as.numeric(datt[,3])
names(datt) <- c("date", "HI", "LA")
b117 <- ggplot(datt, aes(x=date)) +
scale_x_date(limits=as.Date(c("2021-01-04", "2021-08-12"))) +
geom_line(aes(y=LA, color="LA County")) +
geom_line(aes(y=HI, color="Hawai'i")) +
labs(x="", y="Rt", color="Locality") + 
scale_color_manual(values = c("Hawai'i"="orange", "LA County"="blue")) +
ggtitle("B.1.1.7") +
scale_y_continuous(limits=c(0,2.5), breaks=seq(0,3, by=0.5)) +
theme(axis.text.x = element_text(size=27), axis.text.y=element_text(size=27), legend.title=element_text(size=27), legend.text=element_text(size=25), plot.title=element_text(size=30), axis.title.y=element_text(size=27))

pdf("b117_both.pdf", width=12,  height=10)
b117
dev.off()

#b1243
dat <- read.csv("b1243_rt.csv")
names(dat) <- str_replace_all(names(dat), "X", "")
names(dat) <- as.Date(names(dat), format="%m.%d.%Y")
x <- names(dat[,2:66])
y1 <- as.numeric(dat[1,2:66])
y2 <- as.numeric(dat[2,2:66])
dat1 <- cbind(x, y1)
datt <- cbind(dat1, y2)
datt <- as.data.frame(datt)
datt[,1] <- as.Date(datt[,1])
datt[,2] <- as.numeric(datt[,2])
datt[,3] <- as.numeric(datt[,3])
names(datt) <- c("date", "HI", "LA")
b1243 <- ggplot(datt, aes(x=date)) +
scale_x_date(limits=as.Date(c("2020-06-20", "2021-04-06"))) +
geom_line(aes(y=LA, color="LA County")) +
geom_line(aes(y=HI, color="Hawai'i")) +
labs(x="", y="Rt", color="Locality") + 
scale_color_manual(values = c("LA County"="blue","Hawai'i"="orange")) +
ggtitle("B.1.243") +
scale_y_continuous(limits=c(0,2.5), breaks=seq(0,3, by=0.5)) +
theme(axis.text.x = element_text(size=27), axis.text.y=element_text(size=27), legend.title=element_text(size=27), legend.text=element_text(size=25), plot.title=element_text(size=30), axis.title.y=element_text(size=27))

pdf("b1243_both.pdf", width=12,  height=10)
b1243
dev.off()