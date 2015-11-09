library(foreign)
library(dplyr)
library(magrittr)

IDEA_childcount.dta.13 = read.table(file = "http://www2.ed.gov/programs/osepidea/618-data/state-level-data-files/part-b-data/child-count-and-educational-environments/bchildcountandedenvironments2013.csv", header = TRUE, sep = ",")
head(IDEA_childcount.dta.13)
GA.IDEA_childcount.dta.13 <- IDEA_childcount.dta.13[3463:3729,] 
str(GA.IDEA_childcount.dta.13$X.1)
GA.EBD.dta.13 <- GA.IDEA_childcount.dta.13 %>% filter(X.1=='Emotional disturbance')
##########
IDEA_childcount.dta.12 = read.table(file = "http://www2.ed.gov/programs/osepidea/618-data/state-level-data-files/part-b-data/child-count-and-educational-environments/bchildcountandedenvironments2012.csv", header = TRUE, sep = ",")
head(IDEA_childcount.dta.12)
GA.IDEA_childcount.dta.12 <- IDEA_childcount.dta.12[3463:3729,]
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
##########
IDEA_childcount.dta.11 = read.table(file = "http://www2.ed.gov/programs/osepidea/618-data/state-level-data-files/part-b-data/educational-environments/benvironment2011.csv", header = TRUE, sep = ",")
head(IDEA_childcount.dta.11)
GA.IDEA_childcount.dta.11 <- IDEA_childcount.dta.11[3729:3994,]
# GUIDE:  mtcars[c(3, 24),] from http://www.r-tutor.com/r-introduction/data-frame/data-frame-row-slice
ages.GA.EBD.dta.11 <- GA.IDEA_childcount.dta.11[c(3733,3747,3761,3775,3789,3803,3817,3831,3845,3859,3873,3887,3901,3915,3929,3943,3957,3971,3985),]


district.data.13 = read.table(file = "http://www2.census.gov/govs/school/elsec13t.txt", header = TRUE, sep = ",")
head(district.data.13)
# I need all 196 observations for Georgia.
# GUIDE: newdata <- mydata[1:5,]
GA.district.data.13 <- district.data.13[2199:2394,]
head(GA.district.data.13)
tail(GA.district.data.13)
RESA.data.13 <- GA.district.data.13 %>% filter(ENROLL=='0')
print(RESA.data.13)

district.data.12 = read.table(file = "http://www2.census.gov/govs/school/elsec12t.txt", header = TRUE, sep = ",")
head(district.data.12)
GA.district.data.12 <- district.data.12[2201:2396,]
head(GA.district.data.12)
tail(GA.district.data.12)
RESA.data.12 <- GA.district.data.12 %>% filter(ENROLL=='0')
print(RESA.data.12)

district.data.11 = read.table(file = "http://www2.census.gov/govs/school/elsec11t.txt", header = TRUE, sep = ",")
head(district.data.11)
GA.district.data.11 <- district.data.11[2199:2394,]
head(GA.district.data.11)
tail(GA.district.data.11)
RESA.data.11 <- GA.district.data.11 %>% filter(ENROLL=='0')
print(RESA.data.11)

Cedarwood.Bounds.First.Dist.RESA.13 <- GA.district.data.13[c("APPLING CO SCH DIST", "BULLOCH CO SCH DIST", "CANDLER CO SCH DIST", "EVANS CO SCH DIST", "JEFF  DAVIS CO SCH DIST", "TATTNALL CO SCH DIST", "TOOMBS CO SCH DIST", "WAYNE CO SCH DIST", "VIDALIA IND SCH DIST"),]
Coastal.Bounds.First.Dist.RESA.13 <- GA.district.data.13[c("BRYAN CO SCH DIST", "CAMDEN CO SCH DIST", "GLYNN CO SCH DIST", "LIBERTY CO SCH DIST", "LONG CO SCH DIST", "MCINTOSH CO SCH DIST"),]
Heartland.Bounds.Heart.GA.RESA.13 <- GA.district.data.13[c("BLECKLEY CO SCH DIST", "DODGE CO SCH DIST", "LAURENS CO SCH DIST", "MONTGOMERY CO SCH DIST", "PULASKI CO SCH DIST", "TELFAIR CO SCH DIST", "TREUTLAN CO SCH DIST", "WHEELER CO SCH DIST", "WILCOX CO SCH DIST", "DUBLIN IND SCH DIST"),]
Futures.Bounds.Pioneer.RESA.13 <- GA.district.data.13[c("BANKS CO SCH DIST", "DAWSON CO SCH DIST", "FRANKLIN CO SCH DIST", "FORSYTH CO SCH DIST", "HABERSHAM CO SCH DIST", "HALL CO SCH DIST", "HART CO SCH DIST", "LUMPKIN CO SCH DIST", "RABUN CO SCH DIST", "STEPHANS CO SCH DIST", "TOWNS CO SCH DIST", "UNION CO SCH DIST", "WHIIE CO SCH DIST", "GAINESVILLE IND SCH  DIST"),]
Burwell.Bounds.West.GA.RESA.13 <- GA.district.data.13[c("CARROLL CO SCH DIST", "COWETA CO SCH DIST", "HEARD CO SCH DIST", "MERIWETHER CO SCH DIST", "TROUP CO SCH DIST", "CARROLLTON IND SCH DIST"),]
Harrell.Bounds.Okefenokee.RESA.13 <- GA.district.data.13[c("ATKINSON CO SCH DIST", "BACON CO SCH DIST", "BRANTLEY CO SCH DIST", "CHARLTON CO SCH DIST", "CLINCH CO SCH DIST", "COFFEE CO SCH DIST", "PIERCE CO SCH DIST", "WARE CO SCH DIST"),]
NMetro.Bounds.Metro.RESA.13 <- GA.district.data.13[c("FULTON CO SCH DIST", "ATLANTA PUBLIC SCHOOLS", "GWINNETT CO SCH DIST", "BUFORD IND SCH DIST"),]
Northstar.Bounds.North.GA.RESA <- GA.district.data.13[c("FANNIN CO SCH DIST", "GILMER CO SCH DIST", "MURRAY CO SCH DIST", "PICKENS COO SCH DIST", "WHITFIELD CO SCH DIST", "DALTON IND SCH DIST"),]
NW_GA_Ed_Program.Bounds.NW.GA.RESA.13 <- GA.district.data.13[c("BARTOW CO SCH DIST", "CATOOSA CO SCH DIST", "CHATTOOGA CO SCH DIST", "DADE CO SCH DIST", "FLOYD CO SCH DIST", "GORDON CO SCH DIST", "HARALSON CO SCH DIST", "PAULDING CO SCH DIST", "POLK CO SCH DIST", "WALKER CO SCH DIST", "BREMAN IND CSH DIST", "CALHOUN IND SCH DIST", "CARTERSVILLE IND SCH DIST", "CHICKAMAUGA IND SCH DIST", "ROME IND SCH DIST", "TRION  IND SCH DIST"),] 
GNETS_Oconee.Oconee.RESA.13 <- GA.district.data.13[c("BALDWIN CO SCH DIST", "HANCOCK CO SCH  DIST", "JASPER CO SCH DIST", "JOHNSON CO SCH DIST", "PUTNAM CO SCH DIST", "WASHINGTON CO SCH DIST", "WILKINSON CO SCH DIST"),]
River_Quest.CENTRALSavannah.RESA.13 <- GA.district.data.13[c("BURKE CO SCH DIST", "EMANUEL CO SCH DIST", "GLASCOCK CO SCH DIST", "JEFFERSON CO SCH DIST", "JENKINS CO SCH DIST", "SCREVEN CO SCH DIST"),] 
Rutland.Bounds.NE.GA.RESA.13 <- GA.district.data.13[c("BARROW CO SCH DIST", "CLARKE CO SCH  DIST", "ELBERT  CO SCH DIST", "GREENE CO SCH DIST", "JACKSON CO SCH DIST", "MADISON CO SCH DIST", "MORGAN CO SCH DIST", "OCONEE CO SCH DIST", "OGLETHORPE CO SCH DIST", "WALTON CO SCH DIST", "COMMERCE IND SCH DIST", "JEFFERSON IND SCH DIST", "SOCIAL CIRCLE IND  SCH DIST"),]
