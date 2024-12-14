##Plot case incidence and variant counts on same graph
library(stringr)
library(plotrix) #for gap.plot()

#read in 7 day averages
#Hawaii
#case counts
swap <- read.csv("hi_alltime_cases_swap.csv", row.names=1)
names(swap) <- str_replace_all(names(swap), "X", "")
names(swap) <- str_replace_all(names(swap), "\\.", "/")
row.names(swap) <- c("Cases")
dates <- names(swap)
cases <- as.character(swap[1,1:372])
df1 <- as.data.frame(cbind(dates, cases))
df1$dates <- as.Date(df1$dates, format="%m/%d/%Y", origin="2020-07-08")
df1$cases <- as.numeric(df1$cases)
df1$cases[1:6] <- 0


#variant counts
dat <- read.csv("hi_alldates_var_swap.csv", row.names=1)
names(dat) <- str_replace_all(names(dat), "X", "")
names(dat) <- str_replace_all(names(dat), "\\.", "/")

datt <- rbind(dat[2,], dat[3,])
row.names(datt) <- c("B.1.1.7", "B.1.243")
dates <- names(datt)
b117 <- as.character(datt[1,1:372])
b1243 <- as.character(datt[2,1:372])

dff1 <- as.data.frame(cbind(dates, b117, b1243))
dff1$dates <- as.Date(dff1$dates, format="%m/%d/%Y")
dff1$b117 <- as.numeric(dff1$b117)
dff1$b1243 <- as.numeric(dff1$b1243)
#find range for y-axis that fits both variants
both <- rbind(dff1$b117, dff1$b1243)
maxx <- max(both)

#plot both total and variant counts on same plot, diff y-axes
pdf("hawaii_total_variant_counts.pdf", width=20, height=10)
#plot case counts
plot(df1$dates, df1$cases, col="gray48", type="l", xaxt="none", xlab="", ylab="Total Case Counts", ylim=c(0,300))
axis(1, dff1$dates, format(dff1$dates, "%Y-%m-%d"))
#plot more data on the same plot, different y-axis
par(new=TRUE)
#plot variant counts
plot(dff1$dates, dff1$b117, col="blue", type="l", ylim=c(0,100), xaxt="none", xlab="", ylab="", axes=FALSE, main="Hawaii")
lines(dff1$dates, dff1$b1243, col="red", type="l")
mtext("Variant Counts",side=4)
axis(1, dff1$dates, format(dff1$dates, "%Y-%m-%d"))
axis(side=4, at=pretty(c(0,100)))
legend("topright", c("Total Case Counts", "B.1.1.7", "B.1.243"), lwd=2, col=c("gray48", "blue", "red"))
dev.off()

#test making gaps in y-axis
#gap.plot(df$dates, df$cases, col="gray48", type="l", xaxt="none", xlab="", ylab="Total Case Counts", ylim=c(0,300), gap=c(100,200))
##function does not work, returning error is below
#Error in as.Date.numeric(e) : 'origin' must be supplied

#LA County
#case counts
swap <- read.csv("la_alltime_cases_swap.csv", row.names=1)
names(swap) <- str_replace_all(names(swap), "X", "")
names(swap) <- str_replace_all(names(swap), "\\.", "/")
row.names(swap) <- c("Cases")
dates1 <- names(swap)
cases <- as.character(swap[1,1:419])
df2 <- as.data.frame(cbind(dates, cases))
df2$dates <- as.Date(df2$dates, format="%m/%d/%Y")
df2$cases <- as.numeric(df2$cases)
df2$cases[1:6] <- 0


#variant counts
dat <- read.csv("la_alldates_var_swap.csv", row.names=1)
names(dat) <- str_replace_all(names(dat), "X", "")
names(dat) <- str_replace_all(names(dat), "\\.", "/")

datt <- rbind(dat[2,], dat[3,])
row.names(datt) <- c("B.1.1.7", "B.1.243")
dates <- names(datt)
b117 <- as.character(datt[1,1:419])
b1243 <- as.character(datt[2,1:419])

dff2 <- as.data.frame(cbind(dates, b117, b1243))
dff2$dates <- as.Date(dff2$dates, format="%m/%d/%Y")
dff2$b117 <- as.numeric(dff2$b117)
dff2$b1243 <- as.numeric(dff2$b1243)
#find range for y-axis that fits both variants
both <- rbind(dff2$b117, dff2$b1243)
maxx <- max(both)

#plot both total and variant counts on same plot, diff y-axes
pdf("la_total_variant_counts.pdf", width=20, height=10)
#plot case counts
plot(df2$dates, df2$cases, col="gray48", type="l", xaxt="none", xlab="", ylab="Total Case Counts")
#ylim=c(0,300)
axis(1, dff2$dates, format(dff2$dates, "%Y-%m-%d"))
#plot more data on the same plot, different y-axis
par(new=TRUE)
#plot variant counts
plot(dff2$dates, dff2$b117, col="blue", type="l", ylim=c(0,100), xaxt="none", xlab="", ylab="", axes=FALSE, main="LA County")
lines(dff2$dates, dff2$b1243, col="red", type="l")
mtext("Variant Counts",side=4)
axis(1, dff2$dates, format(dff2$dates, "%Y-%m-%d"))
axis(side=4, at=pretty(c(0,100)))
legend("topright", c("Total Case Counts", "B.1.1.7", "B.1.243"), lwd=2, col=c("gray48", "blue", "red"))
dev.off()

#plot just variant counts
library(stringr)
library(plotrix) #for gap.plot()
library(ggplot2)
library(ggbreak) 
library(patchwork)
require(gridExtra)
library(ggpubr)

#read in 7 day averages
#Hawaii
#case counts
swap <- read.csv("hi_alldates_var_swap.csv", row.names=1)
names(swap) <- str_replace_all(names(swap), "X", "")
names(swap) <- str_replace_all(names(swap), "\\.", "/")
row.names(swap) <- c("Cases", "B.1.1.7", "B.1.243")
dates <- names(swap)
b117 <- as.character(swap[2,1:372])
b1243 <- as.character(swap[3,1:372])
df1 <- as.data.frame(cbind(dates, b117, b1243))
df1$dates <- as.Date(df1$dates, format="%m/%d/%Y", origin="2020-07-08")
df1$b117 <- as.numeric(df1$b117)
df1$b1243 <- as.numeric(df1$b1243)
A <- data.frame(x = df1$dates, y = df1$b117)
B <- data.frame(x = df1$dates, y = df1$b1243)
hi <- ggplot(A, aes(x,y)) +
	ylim(0,15) +
	geom_line(color='blue') +
	geom_line(data=B, color='red') +
	labs(x="", y="7-Day Average Variant Counts") +
	theme(axis.title=element_text(size=15))

#LA County
#case counts
swap <- read.csv("la_alldates_var_swap.csv", row.names=1)
names(swap) <- str_replace_all(names(swap), "X", "")
names(swap) <- str_replace_all(names(swap), "\\.", "/")
row.names(swap) <- c("Cases", "B.1.1.7", "B.1.243")
dates1 <- names(swap)
b117 <- as.character(swap[2,1:419])
b1243 <- as.character(swap[3,1:419])
df2 <- as.data.frame(cbind(dates1, b117, b1243))
df2$dates1 <- as.Date(df2$dates1, format="%m/%d/%Y", origin="2020-06-20")
df2$b117 <- as.numeric(df2$b117)
df2$b1243 <- as.numeric(df2$b1243)
A2 <- data.frame(x = df2$dates, y = df2$b117)
B2 <- data.frame(x = df2$dates, y = df2$b1243)
la <- ggplot(data=A2, aes(x,y)) +
	ylim(0,15) +
	geom_line(color='blue') +
	geom_line(data=B2, color='red') +
	labs(x="", y="7-Day Average Variant Counts") 

pdf("both_onlyvar_v3.pdf", width=20, height=4)
grid.arrange(hi, la, nrow=1, ncol=2)
dev.off()