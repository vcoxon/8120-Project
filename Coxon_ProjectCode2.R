library(foreign)
library(dplyr)
library(magrittr)

#### RUN THIS FIRST; THIS IS WHAT I WILL BE WORKING WITH.
# Variables IDCENSUS, NAME, CONUM, CSA, CBSA, and NCEID are alphanumeric character strings.
# All amounts are expressed in thousands of dollars.

district.data.13 = read.table(file = "http://www2.census.gov/govs/school/elsec13t.txt", header = TRUE, sep = ",")
#Need to include FEDROTHR because of GNETS funding flexibility.  
#See  http://www.rcboe.org/sandhills and https://www.gadoe.org/School-Improvement/Federal-Programs/Pages/REAP.aspx
my.district.data.13 <- district.data.13[c("NAME", "ENROLL", "TOTALREV", "TFEDREV", "FEDRSPEC", "STRSPEC", "STROTHR", "TLOCREV", "LOCROSCH", "LOCROTHR", "TOTALEXP", "TCURINST", "TCURSSVC", "TCURSPUP", "PCTTOTAL", "PCTFTOT", "PCTSTOT", "PCTLTOT", "PCTLOTHG", "PPCSTOT", "PPITOTAL", "PPSTOTAL", "PPSPUPIL")]
head(my.district.data.13)
# I need to find the population parameter for several spending variables...
summary(my.district.data.13$STRSPEC)
summary(my.district.data.13$FEDRSPEC)
summary(my.district.data.13$LOCROSCH)



# I need all 196 observations for Georgia.
GA.district.data.13 <- my.district.data.13 %>% slice(2199:2394)
head(GA.district.data.13)
tail(GA.district.data.13)
summary(GA.district.data.13$STRSPEC)
summary(GA.district.data.13$FEDRSPEC)
summary(GA.district.data.13$LOCROSCH)


RESA.data.13 <- GA.district.data.13 %>% filter(ENROLL=='0')
NoRESA.data.13 <- GA.district.data.13 %>% filter(ENROLL!='0')

# NOT SURE WHAT TO DO WITH THIS YET; MAY NOT NEED IT. KEEPING IT RIGHT NOW BECAUSE IT WAS PAINSTAKING.
Cedarwood.Bounds.First.Dist.RESA.13 <- GA.district.data.13[c(1, 17, 24, 63, 100, 160, 167, 168, 186),]
Coastal.Bounds.First.Dist.RESA.13 <- GA.district.data.13[c(16, 23, 77, 110, 112, 119),]
Heartland.Bounds.Heart.GA.RESA.13 <- GA.district.data.13[c(13,53,107,108,128,142,16,171,188,193),]
Futures.Bounds.Pioneer.RESA.13 <- GA.district.data.13[c(6,49,69,70,84,85,86,91,116,145,154,170,175,189),]
Burwell.Bounds.West.GA.RESA.13 <- GA.district.data.13[c(25,26,45,92,123,172),]
Harrell.Bounds.Okefenokee.RESA.13 <- GA.district.data.13[c(2,3,14,28,38,41,139,181),]
NMetro.Bounds.Metro.RESA.13 <- GA.district.data.13[c(71,72,82,83),]
Northstar.Bounds.North.GA.RESA <- GA.district.data.13[c(64,74,130,138,191,192),]
NW_GA_Ed_Program.Bounds.NW.GA.RESA.13 <- GA.district.data.13[c(8,9,27,31,32,48,66,67,78,79,88,89,135,141,177,178),] 
GNETS_Oconee.Oconee.RESA.13 <- GA.district.data.13[c(5,87,99,103,143,184,195),]
River_Quest.CENTRALSavannah.RESA.13 <- GA.district.data.13[c(19,62,76,98,102,150),] 
Rutland.Bounds.NE.GA.RESA.13 <- GA.district.data.13[c(7,34,61,81,96,97,98,121,129,133,134,179,180),]
####





####NOT SURE IF I NEED THIS...WANTED TO HAVE IT JUST IN CASE I CAN'T FIND ACTUAL NUMBER OF STUDENTS IN THE DISTRICTS...
IDEA_childcount.dta.13 = read.table(file = "http://www2.ed.gov/programs/osepidea/618-data/state-level-data-files/part-b-data/child-count-and-educational-environments/bchildcountandedenvironments2013.csv", header = TRUE, sep = ",")
GA.IDEA_childcount.dta.13 <- IDEA_childcount.dta.13 %>% slice(3463:3729) 
names(GA.IDEA_childcount.dta.13) <- c("Year",	"State Name",	"SEA Education Environment",	"SEA Disability Category",	"Age 3",	"Age 4",	"Age 5",	"American Indian or Alaska Native Age 3 to 5", 	"Asian Age 3-5", 	"Black or African American Age 3-5", 	"Hispanic/Latino Age 3-5", 	"Native Hawaiian or Other Pacific Islander Age 3-5", 	"Two or More Races Age 3-5", 	"White Age 3-5", 	"Female Age 3 to 5",	"Male Age 3 to 5",	"LEP Yes Age 3 to 5",	"LEP No Age 3 to 5",	"Age 3 to 5",	"Age 6",	"Age 7",	"Age 8",	"Age 9",	"Age 10",	"Age 11",	"Age 12",	"Age 13",	"Age 14",	"Age 15",	"Age 16",	"Age 17",	"Age 18",	"Age 19",	"Age 20",	"Age 21",	"Age 6-11",	"Age 12-17",	"Age 18-21",	"Ages 6-21",	"LEP Yes Age 6 to 21",	"LEP No Age 6 to 21",	"Female Age 6 to 21",	"Male Age 6 to 21",	"American Indian or Alaska Native Age 6 to21",	"Asian Age 6 to21",	"Black or African American Age 6 to21",	"Hispanic/Latino Age 6 to21",	"Native Hawaiian or Other Pacific Islander Age 6 to21",	"Two or more races Age 6 to21",	"White Age 6 to21")
GA.EBD.dta.13 <- GA.IDEA_childcount.dta.13 %>% filter(`SEA Disability Category`=='Emotional disturbance') %>% select(`Age 6-11`, `Age 12-17`, `Age 18-21`, `Ages 6-21`)
####

##########NOT SURE IF I NEED THESE EITHER...
IDEA_childcount.dta.12 = read.table(file = "http://www2.ed.gov/programs/osepidea/618-data/state-level-data-files/part-b-data/child-count-and-educational-environments/bchildcountandedenvironments2012.csv", header = TRUE, sep = ",")
head(IDEA_childcount.dta.12)
GA.IDEA_childcount.dta.12 <- IDEA_childcount.dta.12%>% slice(3463:3729)
str(GA.IDEA_childcount.dta.12$x.1)
GA.EBD.dta.12 <- GA.IDEA_childcount.dta.12 %>% filter(X.1=='Emotional disturbance')
names(GA.EBD.dta.12)
#GUIDE: (hsb4 <- hsb2.small[, 1:4]) to get columns 14:17
GA.EBD.dta.12 <- GA.EBD.dta.12[, 14:17]

six.sepsch.GA.EBD.dta.12 <- 410
twelve.sepsch.GA.EBD.dta.12 = 916
eighteen.sepsch.GA.EBD.dta.12 = 113
total.sepsch.GA.EBD.dta.12 = 1439

TOTsix.GA.EBD.dta.12 = 3796
TOTtwleve.GA.EBD.dta.12 = 8787
TOTeighteen.GA.EBD.dta.12 = 1046
TOTAL.GA.EBD.dta.12 = 13629

district.data.12 = read.table(file = "http://www2.census.gov/govs/school/elsec12t.txt", header = TRUE, sep = ",")
head(district.data.12)
GA.district.data.12 <- district.data.12[2201:2396,]
head(GA.district.data.12)
tail(GA.district.data.12)
RESA.data.12 <- GA.district.data.12 %>% filter(ENROLL=='0')
print(RESA.data.12)
##########
##########
IDEA_childcount.dta.11 = read.table(file = "http://www2.ed.gov/programs/osepidea/618-data/state-level-data-files/part-b-data/educational-environments/benvironment2011.csv", header = TRUE, sep = ",")
head(IDEA_childcount.dta.11)
GA.IDEA_childcount.dta.11 <- IDEA_childcount.dta.11[3729:3994,]
# GUIDE:  mtcars[c(3, 24),] from http://www.r-tutor.com/r-introduction/data-frame/data-frame-row-slice
ages.GA.EBD.dta.11 <- GA.IDEA_childcount.dta.11[c(3733,3747,3761,3775,3789,3803,3817,3831,3845,3859,3873,3887,3901,3915,3929,3943,3957,3971,3985),]

district.data.11 = read.table(file = "http://www2.census.gov/govs/school/elsec11t.txt", header = TRUE, sep = ",")
head(district.data.11)
GA.district.data.11 <- district.data.11[2199:2394,]
head(GA.district.data.11)
tail(GA.district.data.11)
RESA.data.11 <- GA.district.data.11 %>% filter(ENROLL=='0')
print(RESA.data.11)
##########