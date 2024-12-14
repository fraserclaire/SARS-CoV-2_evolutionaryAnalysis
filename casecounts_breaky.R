#plot just case incidence with break in y-axis for LA
library(stringr)
library(zoo)
library(plotrix) #for gap.plot()
library(ggplot2)
library(ggbreak) 
library(patchwork)
require(gridExtra)
library(ggpubr)

#read in 7 day averages
#Hawaii
#total case counts
dat <- read.csv("hi_allcases.csv")
roll <- rollmean(dat[,2], 7, fill = list(NA, NULL, NA))
rolling <- cbind(dat, roll)
datt <- cbind(dat[,1], roll)
write.csv(datt, file="hi_alltime_freq_int.csv")
##open csv and transpose the data
swap <- read.csv("hi_alltime_freq_swap.csv", row.names=1)
names(swap) <- str_replace_all(names(swap), "X", "")
names(swap) <- str_replace_all(names(swap), "\\.", "/")
row.names(swap) <- c("Cases")
dates <- names(swap)
cases <- as.character(swap[1,1:372])
df1 <- as.data.frame(cbind(dates, cases))
df1$dates <- as.Date(df1$dates, format="%m/%d/%Y", origin="2020-07-08")
df1$cases <- as.numeric(df1$cases)

pdf("hi_casecounts.pdf", width=10, height=10)
ggplot(df1, aes(dates, cases)) + 
	geom_line() +
	ylim(c(0,1300)) + 
	labs(x="", y="7-Day Average Case Counts") +
	theme(axis.text.x=element_text(size=18), axis.text.y=element_text(size=18), axis.title.y=element_text(size=20))
dev.off()
	

#LA County
#total case counts
dat <- read.csv("la_allcases.csv")
roll <- rollmean(dat[,2], 7, fill = list(NA, NULL, NA))
rolling <- cbind(dat, roll)
datt <- cbind(dat[,1], roll)
write.csv(datt, file="la_alltime_freq_int.csv")
##open csv and transpose the data
swap <- read.csv("la_alltime_freq_swap.csv", row.names=1)
names(swap) <- str_replace_all(names(swap), "X", "")
names(swap) <- str_replace_all(names(swap), "\\.", "/")
row.names(swap) <- c("Cases")
dates1 <- names(swap)
cases <- as.character(swap[1,1:419])
df2 <- as.data.frame(cbind(dates1, cases))
df2$dates1 <- as.Date(df2$dates1, format="%m/%d/%Y")
df2$cases <- as.numeric(df2$cases)
#have to save plots separately because of line break in y-axis
#does not allow saving 2 plots on 1 PDF
ggplot(df2, aes(dates1, cases)) +
	geom_line() +
	scale_y_break(c(1000,2000), scales=0.25) +
	labs(x="", y="7-Day Average Case Counts") 
ggsave("la_casecounts.pdf")	
	
	
