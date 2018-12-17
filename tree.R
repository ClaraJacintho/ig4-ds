library(tidyverse)
library(RColorBrewer)
library(rpart)
library(rattle)
joined <- read.csv("prepared_data.csv", header = TRUE)
acidents  <- read.csv("accidents.csv", header = TRUE)
incidents <- read.csv("incidents.csv", header = TRUE)
respAprofInc <- read.csv("incidentsAp.csv", header = TRUE)
respAprofAc <- read.csv("accidentsAp.csv", header = TRUE)

respAprofInc$SEMAINE <- as.factor(respAprofInc$SEMAINE)
respAprofAc$SEMAINE <- as.factor(respAprofAc$SEMAINE)

respAprofInc$MOMENT_JOURNEE<- as.factor(respAprofInc$MOMENT_JOURNEE)
respAprofAc$MOMENTJOURNEE<- as.factor(respAprofAc$MOMENTJOURNEE)

respAprofInc$TEMPS <- as.factor(respAprofInc$TEMPS)
respAprofAc$TEMPS<- as.factor(respAprofAc$TEMPS)

respAprofInc$TRAJET<- as.factor(respAprofInc$TRAJET)
respAprofAc$TRAJET <- as.factor(respAprofAc$TRAJET)

r_inc <-nrow(respAprofInc)
r_ac <- nrow(respAprofAc)

df <- data.frame("semaine"=rep(NA,r_inc+r_ac), "momentjourne" =rep(NA,r_inc+r_ac), "temps" =rep(NA,r_inc+r_ac), "trajet"=rep(NA,r_inc+r_ac),
                 "typeroute"=rep(NA,r_inc+r_ac), "vitesse"=rep(NA,r_inc+r_ac), "acident_incident"=rep(NA,r_inc+r_ac))

for (row in 1:nrow(respAprofInc)) {
  df[row, "semaine"] <- respAprofInc[row, "SEMAINE"]
  df[row, "momentjourne"] <- respAprofInc[row, "MOMENT_JOURNEE"]
  df[row, "temps"] <- respAprofInc[row, "TEMPS"]
  df[row, "trajet"] <- respAprofInc[row, "TRAJET"]
  df[row, "typeroute"] <- respAprofInc[row, "TYPE_ROUTE"]
  df[row, "vitesse"] <- respAprofInc[row, "VITESSE"]
  df[row, "acident_incident"] <- "incident"
}

for (row in 1:nrow(respAprofAc)) {
  df[row+r_inc, "semaine"] <- respAprofAc[row, "SEMAINE"]
  df[row+r_inc, "momentjourne"] <- respAprofAc[row, "MOMENTJOURNEE"]
  df[row+r_inc, "temps"] <- respAprofAc[row, "TEMPS"]
  df[row+r_inc, "trajet"] <- respAprofAc[row, "TRAJET"]
  df[row+r_inc, "typeroute"] <- respAprofAc[row, "TYPEROUTE"]
  df[row+r_inc, "vitesse"] <- respAprofAc[row, "VITESSE"]
  df[row+r_inc, "acident_incident"] <- "accident"
}

df$semaine <- as.factor(df$semaine)
df$momentjourne <- as.factor(df$momentjourne)
df$temps <- as.factor(df$temps)
df$trajet <- as.factor(df$trajet)
df$typeroute <- as.factor(df$typeroute)
df$acident_incident<- as.factor(df$acident_incident)

summary(df)
write.csv(df, "ap_tree.csv")

ap_tree <- rpart(acident_incident ~ semaine+momentjourne+temps+trajet+typeroute+vitesse,
                 method="class", data=df)

printcp(ap_tree)
plot(ap_tree, uniform=TRUE, 
     main="Classification Tree for Aprofondissement")
text(ap_tree, use.n=TRUE, all=TRUE, cex=.8)

post(ap_tree, file = "tree.ps", 
     title ="Classification Tree for Aprofondissement")

rattle::fancyRpartPlot(ap_tree, sub="" ,palettes="YlGnBu")
