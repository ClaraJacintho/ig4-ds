library(tidyverse)
joined <- read.csv("prepared_data.csv", header = TRUE)
acidents  <- read.csv("BDD_ACCIDENTO_SUM_ACC.csv", header = TRUE)
incidents <- read.csv("BDD_INCIDENTO_SUM_INC.csv", header = TRUE)

joined$TOTAL_AC[is.na(joined$TOTAL_AC)] <- 0
acidents$TOTAL_AC[is.na(acidents$TOTAL_AC)] <- 0

acidents <- filter(acidents, acidents$FREQ1 < 5)


incidents <- filter(incidents, incidents$FREQ1 < 5)


incidents <- filter(incidents, incidents$USAGE1 < 4)


acidents <- filter(acidents, acidents$USAGE1 < 4)

incidents$CYLINDREE1 <-as.numeric(as.character(incidents$CYLINDREE1))
str(incidents$CYLINDREE1)
incidents$CYLINDREE1[is.na(incidents$CYLINDREE1)] <- 0
acidents$CYLINDREE1 <-as.numeric(as.character(acidents$CYLINDREE1))
str(acidents$CYLINDREE1)
incidents$CYLINDREE1[is.na(incidents$CYLINDREE1)] <- 0

write.csv(incidents, file = "incidents.csv")
write.csv(acidents, file = "accidents.csv")

incidents <- read.csv("incidents.csv", header = TRUE)
ancidents <- read.csv("accidents.csv", header = TRUE)

respAprofInc <- filter(incidents, is.na(incidents$SEMAINE) == FALSE)
respAprofAc <- filter(acidents, is.na(acidents$SEMAINE) == FALSE)

respAprofInc  <- respAprofInc %>% filter(respAprofInc$TRAFIC %in% c(1,2,3,4)  ) %>% droplevels() 
respAprofAc  <- respAprofAc %>% filter(TRAFIC %in% c(1,2,3,4)  ) %>% droplevels() 
respAprofAc <- filter(respAprofAc, TRAJET %in% c(1,2,3))
respAprofInc <- respAprofInc %>% filter(as.integer(TYPE_ROUTE) < 7  ) %>% droplevels() 
respAprofAc<- respAprofAc %>% filter(as.integer(TYPEROUTE) < 7  ) %>% droplevels() 

write.csv(respAprofInc, file = "incidentsAp.csv")
write.csv(respAprofAc, file = "accidentsAp.csv")

