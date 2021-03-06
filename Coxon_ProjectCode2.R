library(foreign)
library(dplyr)
library(magrittr)

#### RUN THIS FIRST; THIS IS WHAT I WILL BE WORKING WITH.
# Variables IDCENSUS, NAME, CONUM, CSA, CBSA, and NCEID are alphanumeric character strings.
# All amounts are expressed in thousands of dollars.

district.data.13 = read.table(file = "http://www2.census.gov/govs/school/elsec13t.txt", header = TRUE, sep = ",")
#Need to include FEDROTHR because of GNETS funding flexibility.  
#See  http://www.rcboe.org/sandhills and https://www.gadoe.org/School-Improvement/Federal-Programs/Pages/REAP.aspx
my.district.data.13 <- district.data.13[c("NAME", "ENROLL", "TOTALREV", "TFEDREV", "FEDRSPEC", "FEDROTHR",  "TSTREV", "STRFORM",  "STRSPEC", "STROTHR", "TLOCREV", "LOCRPROP", "LOCROSCH", "LOCROTHR", "TOTALEXP", "TCURINST", "TCURSSVC", "TCURSPUP", "PCTTOTAL", "PCTFTOT", "PCTSTOT", "PCTLTOT", "PCTLOTHG", "PPCSTOT", "PPITOTAL", "PPSTOTAL", "PPSPUPIL")]
head(my.district.data.13)

# I need all 196 observations for Georgia.
GA.district.data.13 <- my.district.data.13 %>% slice(2199:2394)
head(GA.district.data.13)
tail(GA.district.data.13)
# The correct observations are included...

# I need to find the population parameters for several spending variables...
library(ggplot2)
library(pastecs)

#Univariate Descriptive Statistics: GA.district.data.13
attach(GA.district.data.13)
GAstats <- cbind(TOTALREV, TFEDREV, FEDRSPEC, FEDROTHR, TSTREV, STRFORM, STRSPEC, STROTHR, LOCRPROP, LOCROSCH, PCTFTOT, PCTSTOT, PCTLTOT, PCTLOTHG)
options(scipen=100)
options(digits = 3)
stat.desc(GAstats, basic = F)

GNETS <- GA.district.data.13[c(172,1,17,167,23,77,110,29,52,12,94,47,85,181,39,128,11,114,166,93,152,71,72,83,138,67,56,5,103,42,50,164,19,34,147,117,37,131),]
##Defined as having a center-based or school-based GNETS  program
attach(GNETS)
GNETSstats <- cbind(TOTALREV, TFEDREV, FEDRSPEC, FEDROTHR, TSTREV, STRFORM, STRSPEC, STROTHR, LOCRPROP, LOCROSCH, PCTFTOT, PCTSTOT, PCTLTOT, PCTLOTHG)
options(scipen=100)
options(digits = 3)
stat.desc(GNETSstats, basic = F)

NoGNETS <-GA.district.data.13[c(2,3,4,6,7,8,9,10,13,14,15,16,20,21,24,25,26,27,28,30,31,32,33,36,38,40,41,43,44,45,46,48,51,53,55,57,58,59,60,61,62,63,64,65,66,70,74,76,78,79,80,81,82,86,87,88,89,90,91,92,95,96,97,98,99,100,101,102,104,105,106,107,108,109,111,112,113,116,119,120,121,122,123,124,125,126,127,129,130,132,133,134,135,136,139,140,141,142,143,144,145,146,148,149,150,151,155,156,158,159,160,161,162,163,165,168,170,171,173,174,176,177,178,179,180,183,184,186,187,188,191,192,193,194,195,196),]
##Defined as NOT having a center-based or school-based GNETS program
attach(NoGNETS)
NoGNETSstats <- cbind(TOTALREV, TFEDREV, FEDRSPEC, FEDROTHR, TSTREV, STRFORM, STRSPEC, STROTHR, LOCRPROP, LOCROSCH, PCTFTOT, PCTSTOT, PCTLTOT, PCTLOTHG)
options(scipen=100)
options(digits = 3)
stat.desc(NoGNETSstats, basic = F)

GA.district.data.13$GNETS <- c(1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0 ,0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)
summary(GA.district.data.13$GNETS=="1")

# Test for Normality
ggplot(data = GA.district.data.13,aes(x = PCTFTOT)) + geom_histogram(aes(group=GNETS,fill=as.factor(GNETS)),position='dodge')+
  ylab('Frequency') + xlab('Percent Federal Revenue - Total Revenue From Federal Sources') +
  scale_fill_discrete('',labels=c('Non-GNETS','GNETS')) + 
  scale_x_continuous(expand=c(0,0)) + 
  scale_y_continuous(expand=c(0,0)) + 
  theme_bw() + theme(legend.position=c(.8,.40))

ggplot(data = GA.district.data.13,aes(x = PCTSTOT)) + geom_histogram(aes(group=GNETS,fill=as.factor(GNETS)),position='dodge')+
  ylab('Frequency') + xlab('Percent State Revenue - Total Revenue From State Sources') +
  scale_fill_discrete('',labels=c('Non-GNETS','GNETS')) + 
  scale_x_continuous(expand=c(0,0)) + 
  scale_y_continuous(expand=c(0,0)) + 
  theme_bw() + theme(legend.position=c(.8,.40))

ggplot(data = GA.district.data.13,aes(x = TFEDREV)) + geom_histogram(aes(group=GNETS,fill=as.factor(GNETS)),position='dodge')+
  ylab('Frequency') + xlab('Percent Federal Revenue - Total Revenue From Federal Sources') +
  scale_fill_discrete('',labels=c('Non-GNETS','GNETS')) + 
  scale_x_continuous(expand=c(0,0)) + 
  scale_y_continuous(expand=c(0,0)) + 
  theme_bw() + theme(legend.position=c(.8,.40))

ggplot(data = GA.district.data.13,aes(x = TSTREV)) + geom_histogram(aes(group=GNETS,fill=as.factor(GNETS)),position='dodge')+
  ylab('Frequency') + xlab('Percent State Revenue - Total Revenue From State Sources') +
  scale_fill_discrete('',labels=c('Non-GNETS','GNETS')) + 
  scale_x_continuous(expand=c(0,0)) + 
  scale_y_continuous(expand=c(0,0)) + 
  theme_bw() + theme(legend.position=c(.8,.40))

ggplot(GA.district.data.13, aes(x = PCTFTOT, group = GNETS)) + geom_density(aes(colour = as.factor(GNETS))) + theme_bw() + theme(legend.position = c(0.8,0.3))
ggplot(GA.district.data.13, aes(x = PCTSTOT, group = GNETS)) + geom_density(aes(colour = as.factor(GNETS))) + theme_bw() + theme(legend.position = c(0.8,0.3))
ggplot(GA.district.data.13, aes(x = TFEDREV, group = GNETS)) + geom_density(aes(colour = as.factor(GNETS))) + theme_bw() + theme(legend.position = c(0.8,0.3))
ggplot(GA.district.data.13, aes(x = TSTREV, group = GNETS)) + geom_density(aes(colour = as.factor(GNETS))) + theme_bw() + theme(legend.position = c(0.8,0.3))


#Hypothesis testing
t.test(GA.district.data.13$TFEDREV[GA.district.data.13$GNETS==0],GA.district.data.13$TFEDREV[GA.district.data.13$GNETS==1])
t.test(GA.district.data.13$FEDRSPEC[GA.district.data.13$GNETS==0],GA.district.data.13$FEDRSPEC[GA.district.data.13$GNETS==1])
t.test(GA.district.data.13$FEDROTHR[GA.district.data.13$GNETS==0],GA.district.data.13$FEDROTHR[GA.district.data.13$GNETS==1])
t.test(GA.district.data.13$STRFORM[GA.district.data.13$GNETS==0],GA.district.data.13$STRFORM[GA.district.data.13$GNETS==1])
t.test(GA.district.data.13$STRSPEC[GA.district.data.13$GNETS==0],GA.district.data.13$STRSPEC[GA.district.data.13$GNETS==1])
t.test(GA.district.data.13$STROTHR[GA.district.data.13$GNETS==0],GA.district.data.13$STROTHR[GA.district.data.13$GNETS==1])
t.test(GA.district.data.13$LOCRPROP[GA.district.data.13$GNETS==0],GA.district.data.13$LOCRPROP[GA.district.data.13$GNETS==1])
t.test(GA.district.data.13$LOCROSCH[GA.district.data.13$GNETS==0],GA.district.data.13$LOCROSCH[GA.district.data.13$GNETS==1])
t.test(GA.district.data.13$LOCROTHR[GA.district.data.13$GNETS==0],GA.district.data.13$LOCROTHR[GA.district.data.13$GNETS==1])
t.test(GA.district.data.13$PCTFTOT[GA.district.data.13$GNETS==0],GA.district.data.13$PCTFTOT[GA.district.data.13$GNETS==1])
t.test(GA.district.data.13$PCTSTOT[GA.district.data.13$GNETS==0],GA.district.data.13$PCTSTOT[GA.district.data.13$GNETS==1])
t.test(GA.district.data.13$PCTLTOT[GA.district.data.13$GNETS==0],GA.district.data.13$PCTLTOT[GA.district.data.13$GNETS==1])
t.test(GA.district.data.13$PCTLOTHG[GA.district.data.13$GNETS==0],GA.district.data.13$PCTLOTHG[GA.district.data.13$GNETS==1])


library(tidyr)
par(mfrow = c(2,2))
boxplot(GNETS$TOTALREV,NoGNETS$TOTALREV, horizontal=TRUE,
        names=c("GNETS","Non-GNETS"),
        col=c("turquoise","tomato"),
        xlab="Total Revenues",
        main="Comparison of Total Revenues")

boxplot(GNETS$TFEDREV,NoGNETS$TFEDREV, horizontal=TRUE,
        names=c("GNETS","Non-GNETS"),
        col=c("turquoise","tomato"),
        xlab="Federal Revenue-Total",
        main="Comparison of Total Federal Revenue")

boxplot(GNETS$FEDRSPEC,NoGNETS$FEDRSPEC, horizontal=TRUE,
        names=c("GNETS","Non-GNETS"),
        col=c("turquoise","tomato"),
        xlab="Federal Revenue-Children wth Disabilities",
        main="Comparison of Federal Special Education Revenue")

boxplot(GNETS$FEDROTHR,NoGNETS$FEDROTHR, horizontal=TRUE,
        names=c("GNETS","Non-GNETS"),
        col=c("turquoise","tomato"),
        xlab="Federal Revenue-Other",
        main="Comparison of Federal Other Revenue")

boxplot(GNETS$TSTREV,NoGNETS$TSTREV, horizontal=TRUE,
        names=c("GNETS","Non-GNETS"),
        col=c("turquoise","tomato"),
        xlab="State Revenue-Total",
        main="Comparison of State Total Revenue")

boxplot(GNETS$STRSPEC,NoGNETS$STRSPEC, horizontal=TRUE,
        names=c("GNETS","Non-GNETS"),
        col=c("turquoise","tomato"),
        xlab="State Revenue-Special Education Programs",
        main="Comparison of State Special Education Programs Revenue")

boxplot(GNETS$STROTHR,NoGNETS$STROTHR, horizontal=TRUE,
        names=c("GNETS","Non-GNETS"),
        col=c("turquoise","tomato"),
        xlab="State Revenue-Other",
        main="Comparison of State Other Revenue")

boxplot(GNETS$LOCROSCH,NoGNETS$LOCROSCH, horizontal=TRUE,
        names=c("GNETS","Non-GNETS"),
        col=c("turquoise","tomato"),
        xlab="Local Revenue-Revenue from Other School Systems",
        main="Comparison of Local Revenue from Other School Systems")

boxplot(GNETS$LOCROTHR,NoGNETS$LOCROTHR, horizontal=TRUE,
        names=c("GNETS","Non-GNETS"),
        col=c("turquoise","tomato"),
        xlab="Local Revenue-Other Local Revenues",
        main="Comparison of Other Local Revenues")

boxplot(GNETS$PCTFTOT,NoGNETS$PCTFTOT, horizontal=TRUE,
        names=c("GNETS","Non-GNETS"),
        col=c("turquoise","tomato"),
        xlab="Percent Total Federal Revenues",
        main="Comparison of Percent Total Federal Revenues")

boxplot(GNETS$PCTSTOT,NoGNETS$PCTSTOT, horizontal=TRUE,
        names=c("GNETS","Non-GNETS"),
        col=c("turquoise","tomato"),
        xlab="Percent Total State Revenues",
        main="Comparison of Percent Total State Revenues")

boxplot(GNETS$PCTLTOT,NoGNETS$PCTLTOT, horizontal=TRUE,
        names=c("GNETS","Non-GNETS"),
        col=c("turquoise","tomato"),
        xlab="Percent Total Local Revenues",
        main="Comparison of Percent Total Local Revenues")

boxplot(GNETS$PCTLOTHG,NoGNETS$PCTLOTHG, horizontal=TRUE,
        names=c("GNETS","Non-GNETS"),
        col=c("turquoise","tomato"),
        xlab="Percent Revenue  from Other Local Governments",
        main="Comparison of Percent Revenues from Other Local Governments")




par(mfrow = c(2,2))
ggplot(data = GA.district.data.13,aes(x = FEDRSPEC)) + geom_histogram(aes(group=GNETS,fill=as.factor(GNETS)),position='dodge')+
  ylab('Frequency') + xlab('Federal Funding - Children with Disabilities') +
  scale_fill_discrete('',labels=c('Non-GNETS','GNETS')) + 
  scale_x_continuous(expand=c(0,0)) + 
  scale_y_continuous(expand=c(0,0)) + 
  theme_bw() + theme(legend.position=c(.8,.40))

ggplot(data = GA.district.data.13,aes(x = FEDROTHR)) + geom_histogram(aes(group=GNETS,fill=as.factor(GNETS)),position='dodge')+
  ylab('Frequency') + xlab('Federal Funding - All Other Federal Funding') +
  scale_fill_discrete('',labels=c('Non-GNETS','GNETS')) + 
  scale_x_continuous(expand=c(0,0)) + 
  scale_y_continuous(expand=c(0,0)) + 
  theme_bw() + theme(legend.position=c(.8,.40))

ggplot(data = GA.district.data.13,aes(x = STRFORM)) + geom_histogram(aes(group=GNETS,fill=as.factor(GNETS)),position='dodge')+
  ylab('Frequency') + xlab('State Funding - Special Education Programs') +
  scale_fill_discrete('',labels=c('Non-GNETS','GNETS')) + 
  scale_x_continuous(expand=c(0,0)) + 
  scale_y_continuous(expand=c(0,0)) + 
  theme_bw() + theme(legend.position=c(.8,.40))

ggplot(data = GA.district.data.13,aes(x = STRSPEC)) + geom_histogram(aes(group=GNETS,fill=as.factor(GNETS)),position='dodge')+
  ylab('Frequency') + xlab('State Funding - Special Education Programs') +
  scale_fill_discrete('',labels=c('Non-GNETS','GNETS')) + 
  scale_x_continuous(expand=c(0,0)) + 
  scale_y_continuous(expand=c(0,0)) + 
  theme_bw() + theme(legend.position=c(.8,.40))

ggplot(data = GA.district.data.13,aes(x = STROTHR)) + geom_histogram(aes(group=GNETS,fill=as.factor(GNETS)),position='dodge')+
  ylab('Frequency') + xlab('State Funding - All Other State Revenue') +
  scale_fill_discrete('',labels=c('Non-GNETS','GNETS')) + 
  scale_x_continuous(expand=c(0,0)) + 
  scale_y_continuous(expand=c(0,0)) + 
  theme_bw() + theme(legend.position=c(.8,.40))

ggplot(data = GA.district.data.13,aes(x = LOCROSCH)) + geom_histogram(aes(group=GNETS,fill=as.factor(GNETS)),position='dodge')+
  ylab('Frequency') + xlab('Local Funding - Revenue From Other School Systems') +
  scale_fill_discrete('',labels=c('Non-GNETS','GNETS')) + 
  scale_x_continuous(expand=c(0,0)) + 
  scale_y_continuous(expand=c(0,0)) + 
  theme_bw() + theme(legend.position=c(.8,.40))

ggplot(data = GA.district.data.13,aes(x = LOCROTHR)) + geom_histogram(aes(group=GNETS,fill=as.factor(GNETS)),position='dodge')+
  ylab('Frequency') + xlab('Local Funding - Other Local Revenues') +
  scale_fill_discrete('',labels=c('Non-GNETS','GNETS')) + 
  scale_x_continuous(expand=c(0,0)) + 
  scale_y_continuous(expand=c(0,0)) + 
  theme_bw() + theme(legend.position=c(.8,.40))



ggplot(data = GA.district.data.13,aes(x = PCTLTOT)) + geom_histogram(aes(group=GNETS,fill=as.factor(GNETS)),position='dodge')+
  ylab('Frequency') + xlab('Percent Local Revenue - Total Revenue From Local Sources') +
  scale_fill_discrete('',labels=c('Non-GNETS','GNETS')) + 
  scale_x_continuous(expand=c(0,0)) + 
  scale_y_continuous(expand=c(0,0)) + 
  theme_bw() + theme(legend.position=c(.8,.40))

ggplot(data = GA.district.data.13,aes(x = PCTLOTHG)) + geom_histogram(aes(group=GNETS,fill=as.factor(GNETS)),position='dodge')+
  ylab('Frequency') + xlab('Percent Local Other Government Revenue - Total Revenue From Other Local Governments') +
  scale_fill_discrete('',labels=c('Non-GNETS','GNETS')) + 
  scale_x_continuous(expand=c(0,0)) + 
  scale_y_continuous(expand=c(0,0)) + 
  theme_bw() + theme(legend.position=c(.8,.40))




 
