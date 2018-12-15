library(tidyverse)

joined <- read.csv("prepared_data.csv", header = TRUE)
acidents  <- read.csv("BDD_ACCIDENTO_SUM_ACC.csv", header = TRUE)
incidents <- read.csv("BDD_INCIDENTO_SUM_INC.csv", header = TRUE)

#Transforming the missing values of the column TOTAL_AC, 
#corresponding to the people who did not have accidents, into 0
joined$TOTAL_AC[is.na(joined$TOTAL_AC)] <- 0
acidents$TOTAL_AC[is.na(acidents$TOTAL_AC)] <- 0


ggplot(acidents, mapping = aes(x=acidents$TOTAL_AC)) + geom_bar() #nb of people x nb of accidents 
  #Most people have never had an accident. Most of those who did had only 1 or 2 accidents.

ggplot(incidents, mapping = aes(x=incidents$TOTAL_INC)) + geom_bar() #nb of people x nb of incidents 

mean(acidents$TOTAL_AC) #2.051085
mean(incidents$TOTAL_INC) #13.70571


median(acidents$TOTAL_AC) #1
median(incidents$TOTAL_INC) #8

cor(joined$TOTAL_AC, joined$TOTAL_INC) # 0.04419411
  # The two variavles are not very correlated! This means that the number of incidents a person
  # has cannot predict the number of acidents they have!

# _________________ ANOVA FREQUENCY __________________________________________________________

#There is a problem with the structure of the file: some data is missplaced! We'll filter those instances out
acidents <- filter(acidents, acidents$FREQ1 < 5)

#Now we will tell R that the data is, in fact, categorical, and not an int
acidents$FREQ1 <- as.factor(acidents$FREQ1)
str(acidents$FREQ1)

# First we start by seeing how often the people use their motorcycles
ggplot(acidents, mapping = aes(x=acidents$FREQ1)) + geom_bar()
  # "We can see that the number of people that use it everyday is roughly the same as the number of people that use it 
  #   a couple of times a week"

#The total nulber of accidents by 
ggplot(acidents, mapping = aes(x=acidents$FREQ1, y=acidents$TOTAL_AC)) + geom_bar(stat="identity")
  # "When we look at the sum of all accidents, on the other hand, we can see that people that daily users are responsable 
  # for more accidents then those who use it sa couple of times a week"

#Boxplot of the frequency of utilisation x nb accidents
ggplot(acidents, mapping = aes(x=acidents$FREQ1, y=acidents$TOTAL_AC)) + geom_boxplot()
  # "By looking at the boxplot we observe that, all categories have about the same mean amount of accidents,
  # but the daily users category has some outliers that drag their average and total numbers up"

res.anova.f1.ac <- aov(TOTAL_AC ~ FREQ1, data = acidents)
summary(res.anova.f1.ac)
  # "By doind the ANOVA we find a p-value of 0.000974, which shows that there is a statistically significant
  #  relationship between the frequency of use and the number of accidents" But how much is it due to the outliers?

# For the incidents, we prepare the data as above
incidents <- filter(incidents, incidents$FREQ1 < 5)
incidents$FREQ1 <- as.factor(incidents$FREQ1)
str(acidents$FREQ1)

ggplot(incidents, mapping = aes(x=incidents$FREQ1)) + geom_bar()
ggplot(incidents, mapping = aes(x=incidents$FREQ1, y=incidents$TOTAL_INC)) + geom_bar(stat="identity")
ggplot(incidents, mapping = aes(x=incidents$FREQ1, y=incidents$TOTAL_INC)) + geom_boxplot()
  #We can see the same trends in the incident side

res.anova.f1.inc <- aov(TOTAL_INC ~ FREQ1, data = incidents)
summary(res.anova.f1.inc)
  #And the anova confirms, with a p-value of 1.34e-10, that the frequency of use also shares a relationship 
  #with the number of incidents

# _________________ ANOVA USAGE __________________________________________________________

# Same import error, same fix
incidents <- filter(incidents, incidents$USAGE1 < 4)
incidents$USAGE1 <- as.factor(incidents$USAGE1)
str(incidents$USAGE1)

ggplot(incidents, mapping = aes(x=incidents$USAGE1)) + geom_bar()
  #The number of people that use their motorcycles for leisure is slightly larger than 
  #those that use it to go to work while few people use it TO work

ggplot(incidents, mapping = aes(x=incidents$USAGE1, y=incidents$TOTAL_INC)) + geom_bar(stat="identity")
  #There are more accidents by those that go to work on their bikes than use it for leisure, 
  #in opposition to the previous finding

ggplot(incidents, mapping = aes(x=incidents$USAGE1, y=incidents$TOTAL_INC)) + geom_boxplot()
  #This graph indicates a higher average of incidnts for those who use their motorcycles professionaly.

res.anova.u1.inc <- aov(TOTAL_INC ~ USAGE1, data = incidents)
summary(res.anova.u1.inc)

acidents <- filter(acidents, acidents$USAGE1 < 4)
acidents$USAGE1 <- as.factor(acidents$USAGE1)
str(acidents$USAGE1)

ggplot(acidents, mapping = aes(x=acidents$USAGE1, y=acidents$TOTAL_AC)) + geom_bar(stat="identity")
  #Again we see those who use it to get to work with a higher number of accidents
ggplot(acidents, mapping = aes(x=acidents$USAGE1, y=acidents$TOTAL_AC)) + geom_boxplot()
  #But on average they have the same number...

res.anova.u1.ac <- aov(TOTAL_AC ~ USAGE1, data = acidents)
summary(res.anova.u1.ac)
  #The usage is also an important factor for accidents, with a p-value of 1.35e-05 ***


# _________________ NBKM1 Correlation __________________________________________________________

ggplot(incidents, mapping = aes(x=incidents$NBKM1, y=incidents$TOTAL_INC)) + geom_point()

ggplot(acidents, mapping = aes(x=acidents$NBKM1, y=acidents$TOTAL_AC)) + geom_point()

cor(incidents$NBKM1,incidents$TOTAL_INC) #0.08422457
cor(acidents$NBKM1,acidents$TOTAL_AC) #0.1371557
  #Both have weak positive correlations. 


# __________________ CYLINDRE1 Correlation ______________________________________________________

#R imported the variable as a factor - change it to numeric
incidents$CYLINDREE1 <-as.numeric(as.character(incidents$CYLINDREE1))
str(incidents$CYLINDREE1)
incidents$CYLINDREE1[is.na(incidents$CYLINDREE1)] <- 0

acidents$CYLINDREE1 <-as.numeric(as.character(acidents$CYLINDREE1))
str(acidents$CYLINDREE1)
incidents$CYLINDREE1[is.na(incidents$CYLINDREE1)] <- 0

#Nb of incidents x CC of the motorcycle
ggplot(incidents, mapping = aes(x=incidents$CYLINDREE1, y=incidents$TOTAL_INC)) + geom_point()

#Nb of accidents x CC of the motorcycle
ggplot(acidents, mapping = aes(x=acidents$CYLINDREE1, y=acidents$TOTAL_AC)) + geom_point()


cor(incidents$CYLINDREE1,incidents$TOTAL_INC) # -0.06999536
  #Very weak negative correlation!

cor(acidents$CYLINDREE1,acidents$TOTAL_AC) #0.08871506
  #Very weak positive correlation

# __________________ SEMAINE ____________________________________________________________

# Same import error, same fix
incidents$SEMAINE <- as.factor(incidents$SEMAINE)
str(incidents$SEMAINE)

respAprofInc <- filter(incidents, is.na(incidents$SEMAINE) == FALSE)
str(respAprofInc)

#Number of incidents by week/ weekend / holiday. Here each entry corresponds to a single incident
ggplot(respAprofInc, mapping = aes(x=respAprofInc$SEMAINE)) + geom_bar()
  #Most incidents happen on a weekday


acidents$SEMAINE <- as.factor(acidents$SEMAINE)
str(incidents$SEMAINE)

respAprofAc <- filter(acidents, is.na(acidents$SEMAINE) == FALSE)
#Number of acidents by week/ weekend / holiday. Here each entry corresponds to a single incident
ggplot(respAprofAc, mapping = aes(x=respAprofAc$SEMAINE)) + geom_bar()
  #Most incidents happen on a weekday => Very statistically likely i guess

#I does not make sense to do an ANOVA with these factors since they are specific to one event that  
#a person chose to tell us, it is not necessarily related to how many accidents that person had.

# __________________ MOMENT_JOURNE ____________________________________________________________ COOL!!!

respAprofInc$MOMENT_JOURNEE<- as.factor(respAprofInc$MOMENT_JOURNEE)
str(respAprofInc$MOMENT_JOURNEE)

#Number of incidents by time of the day. Here each entry corresponds to a single incident
ggplot(respAprofInc, mapping = aes(x=respAprofInc$MOMENT_JOURNEE)) + geom_bar()
  #Most incidents happen during the day

respAprofAc$MOMENTJOURNEE<- as.factor(respAprofAc$MOMENTJOURNEE)

#Number of acidents by time of the day. Here each entry corresponds to a single incident
ggplot(respAprofAc, mapping = aes(x=respAprofAc$SEMAINE)) + geom_bar()
  #More accidents by night than incidents. Events that happen at night are more likely to become accidents!!!!!

# __________________ TEMPS ____________________________________________________________

respAprofInc$TEMPS <- as.factor(respAprofInc$TEMPS)
str(respAprofInc$TEMPS)

#Number of incidents by the weather condition. Here each entry corresponds to a single incident
ggplot(respAprofInc, mapping = aes(x=respAprofInc$TEMPS)) + geom_bar()
  #Most incidents happen during dry weather

respAprofAc$TEMPS<- as.factor(respAprofAc$TEMPS)
str(respAprofAc$TEMPS)

#Number of acidents by the weather condition. Here each entry corresponds to a single incident
ggplot(respAprofAc, mapping = aes(x=respAprofAc$TEMPS)) + geom_bar()
  #More accidents with wet/ weather. Events that happen during these conditions are more likely to become accidents?

# __________________ TRAFIC ____________________________________________________________

respAprofInc$TRAFIC <- as.factor(respAprofInc$TRAFIC)
str(respAprofInc$TRAFIC)

#Number of incidents by the weather condition. Here each entry corresponds to a single incident
ggplot(respAprofInc, mapping = aes(x=respAprofInc$TEMPS)) + geom_bar()
#Most incidents happen during dry weather

respAprofAc$TEMPS<- as.factor(respAprofAc$TEMPS)
str(respAprofAc$TEMPS)

#Number of acidents by the weather condition. Here each entry corresponds to a single incident
ggplot(respAprofAc, mapping = aes(x=respAprofAc$TEMPS)) + geom_bar()
