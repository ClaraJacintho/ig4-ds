library(shiny)
library(tidyverse)
library(RColorBrewer)
library(rpart)
library(rattle)
df <- read.csv("ap_tree.csv")
joined <- read.csv("prepared_data.csv", header = TRUE)
acidents  <- read.csv("accidents.csv", header = TRUE)
incidents <- read.csv("incidents.csv", header = TRUE)
respAprofInc <- read.csv("incidentsAp.csv", header = TRUE)
respAprofAc <- read.csv("accidentsAp.csv", header = TRUE)

acidents$FREQ1 <- as.factor(acidents$FREQ1)
incidents$FREQ1 <- as.factor(incidents$FREQ1)

incidents$USAGE1 <- as.factor(incidents$USAGE1)
acidents$USAGE1 <- as.factor(acidents$USAGE1)

incidents$CYLINDREE1 <-as.numeric(as.character(incidents$CYLINDREE1))
acidents$CYLINDREE1 <-as.numeric(as.character(acidents$CYLINDREE1))

respAprofInc$SEMAINE <- as.factor(respAprofInc$SEMAINE)
respAprofAc$SEMAINE <- as.factor(respAprofAc$SEMAINE)

respAprofInc$MOMENT_JOURNEE<- as.factor(respAprofInc$MOMENT_JOURNEE)
respAprofAc$MOMENTJOURNEE<- as.factor(respAprofAc$MOMENTJOURNEE)

respAprofInc$TEMPS <- as.factor(respAprofInc$TEMPS)
respAprofAc$TEMPS<- as.factor(respAprofAc$TEMPS)

respAprofInc$TRAJET<- as.factor(respAprofInc$TRAJET)
respAprofAc$TRAJET <- as.factor(respAprofAc$TRAJET)

df$semaine <- as.factor(df$semaine)
df$momentjourne <- as.factor(df$momentjourne)
df$temps <- as.factor(df$temps)
df$trajet <- as.factor(df$trajet)
df$typeroute <- as.factor(df$typeroute)
df$acident_incident<- as.factor(df$acident_incident)

shinyServer(function(input, output) {
   
   output$nbfreq <- renderPlot({
     ggplot(acidents, mapping = aes(x=acidents$FREQ1,fill=FREQ1)) + geom_bar()+
      xlab("Frequency of use") +
      ylab("Number of people")+ 
       scale_x_discrete(labels =  c("Everyday", "Weekly", "Monthly", "Yearly"))+
      scale_fill_brewer(palette = "YlGnBu", name = "Frequency", labels = c("Everyday", "A couple of times a week", "A couple of times a month", "A couple of times a year"))+
      theme_bw()
   })
   
   output$freqxinc <- renderPlot({
     
     ggplot(incidents, mapping = aes(x=incidents$FREQ1, y=incidents$TOTAL_INC,fill=FREQ1)) + geom_bar(stat="identity")+ 
       xlab("Frequency of use") +
       ylab("Total number of incidents")+ 
       scale_x_discrete(labels =  c("Everyday", "Weekly", "Monthly", "Yearly"))+
       scale_fill_brewer(palette = "YlGnBu", name = "Frequency", labels = c("Everyday", "A couple of times a week", "A couple of times a month", "A couple of times a year"))+
       theme_bw()
   })
   
   output$freqxacc <- renderPlot({
     ggplot(acidents, mapping = aes(x=acidents$FREQ1, y=acidents$TOTAL_AC,fill=FREQ1)) + geom_bar(stat="identity")+
       xlab("Frequency of use") +
       ylab("Total number of accidents")+ 
       scale_x_discrete(labels =  c("Everyday", "Weekly", "Monthly", "Yearly"))+
       scale_fill_brewer(palette = "YlGnBu", name = "Frequency", labels = c("Everyday", "A couple of times a week", "A couple of times a month", "A couple of times a year"))+
       theme_bw()
    })
   
   output$boxfreqxinc <- renderPlot({
     ggplot(incidents, mapping = aes(x=incidents$FREQ1, y=incidents$TOTAL_INC,fill=FREQ1)) + geom_boxplot()+ 
       xlab("Frequency of use") +
       ylab("Total number of incidents")+ 
       scale_x_discrete(labels =  c("Everyday", "Weekly", "Monthly", "Yearly"))+
       scale_fill_brewer(palette = "YlGnBu", name = "Frequency", labels = c("Everyday", "A couple of times a week", "A couple of times a month", "A couple of times a year"))+
       theme_bw()
    })
   
   output$boxfreqxacc <- renderPlot({
     ggplot(acidents, mapping = aes(x=acidents$FREQ1, y=acidents$TOTAL_AC,fill=FREQ1)) + geom_boxplot()+
     xlab("Frequency of use") +
       ylab("Total number of accidents")+ 
       scale_x_discrete(labels =  c("Everyday", "Weekly", "Monthly", "Yearly"))+
       scale_fill_brewer(palette = "YlGnBu", name = "Frequency", labels = c("Everyday", "A couple of times a week", "A couple of times a month", "A couple of times a year"))+
       theme_bw()
    })
   
#___________________________ USAGE ____________________________________________________________________________   
  
    output$nbusage <- renderPlot({
      ggplot(incidents, mapping = aes(x=incidents$USAGE1, fill=USAGE1)) + geom_bar()+
       ylab("Number of people")+ 
       xlab("Usage") +
       scale_x_discrete(labels =  c("Leisure", "Going to work", "Work"))+
       scale_fill_brewer(palette = "YlGnBu", name = "Usage", labels = c("Leisure", "Going to work", "Work"))+
       theme_bw()
   })
   
   output$usagexinc <- renderPlot({
     ggplot(incidents, mapping = aes(x=incidents$USAGE1, y=incidents$TOTAL_INC, fill=USAGE1)) + geom_bar(stat="identity")+ 
       ylab("Total number of incidents")+ 
       xlab("Usage") +
       scale_x_discrete(labels =  c("Leisure", "Going to work", "Work"))+
       scale_fill_brewer(palette = "YlGnBu", name = "Usage", labels = c("Leisure", "Going to work", "Work"))+
       theme_bw()
   })
   
   output$usagexacc <- renderPlot({
     ggplot(acidents, mapping = aes(x=acidents$USAGE1, y=acidents$TOTAL_AC, fill=USAGE1)) + geom_bar(stat="identity")+
       ylab("Total number of accidents")+ 
       xlab("Usage") +
       scale_x_discrete(labels =  c("Leisure", "Going to work", "Work"))+
       scale_fill_brewer(palette = "YlGnBu", name = "Usage", labels = c("Leisure", "Going to work", "Work"))+
       theme_bw()
   })
   
   output$boxusagexinc <- renderPlot({
     ggplot(incidents, mapping = aes(x=incidents$USAGE1, y=incidents$TOTAL_INC, fill=USAGE1)) + geom_boxplot()+ 
       ylab("Total number of incidents")+ 
       xlab("Usage") +
       scale_x_discrete(labels =  c("Leisure", "Going to work", "Work"))+
       scale_fill_brewer(palette = "YlGnBu", name = "Usage", labels = c("Leisure", "Going to work", "Work"))+
       theme_bw()
   })
   
   output$boxusagexacc <- renderPlot({
     ggplot(acidents, mapping = aes(x=acidents$USAGE1, y=acidents$TOTAL_AC, fill=USAGE1)) + geom_boxplot()+
       ylab("Total number of accidents")+ 
       xlab("Usage") +
       scale_x_discrete(labels =  c("Leisure", "Going to work", "Work"))+
       scale_fill_brewer(palette = "YlGnBu", name = "Usage", labels = c("Leisure", "Going to work", "Work"))+
       theme_bw()
   })
   
#___________________________ NBKM1 ____________________________________________________________________________   
   output$kmxinc <- renderPlot({
     ggplot(incidents, mapping = aes(x=incidents$NBKM1, y=incidents$TOTAL_INC, color=NBKM1)) + geom_point()+ 
       ylab("Total number of incidents")+ 
       xlab("Usage")+
       scale_color_gradient(low="steelblue3", high="springgreen2")+
       theme_bw()
   })
   
   output$kmxacc <- renderPlot({
     ggplot(acidents, mapping = aes(x=acidents$NBKM1, y=acidents$TOTAL_AC,color=NBKM1)) + geom_point()+
       ylab("Total number of accidents")+ 
       xlab("Usage")+
       scale_color_gradient(low="steelblue3", high="springgreen2")+
       theme_bw()
   })
#___________________________ CC ____________________________________________________________________________   
   output$ccxinc <- renderPlot({
     ggplot(incidents, mapping = aes(x=incidents$CYLINDREE1, y=incidents$TOTAL_INC, color=isScooter)) + geom_point()+ 
       ylab("Total number of incidents")+ 
       xlab("CC")+
       scale_color_brewer(palette = "YlGnBu", name = "Type")+
       theme_bw()
   })
   
   output$ccxacc <- renderPlot({
     ggplot(acidents, mapping = aes(x=acidents$CYLINDREE1, y=acidents$TOTAL_AC, color=isScooter)) + geom_point()+
       ylab("Total number of accidents")+ 
       xlab("CC")+
       scale_color_brewer(palette = "YlGnBu", name = "Type")+
       theme_bw()
   })

#___________________________ SEMAINE ____________________________________________________________________________   
   output$semxinc <- renderPlot({
     ggplot(respAprofInc, mapping = aes(x=respAprofInc$SEMAINE, fill=SEMAINE)) + geom_bar()+ 
       ylab("Number of incidents")+ 
       xlab("Time of the week")+
       scale_x_discrete(labels =  c("Weekday", "Weekend", "Holiday"))+
       scale_fill_brewer(palette = "YlGnBu", name = "Time of the week", labels =  c("Weekday", "Weekend", "Holiday"))+
       theme_bw()
   })
   
   output$semxac <- renderPlot({
     ggplot(respAprofAc, mapping = aes(x=respAprofAc$SEMAINE,fill=SEMAINE)) + geom_bar()+ 
       ylab("Number of accidents")+ 
       xlab("Time of the week")+
       scale_x_discrete(labels =  c("Weekday", "Weekend", "Holiday"))+
       scale_fill_brewer(palette = "YlGnBu", name = "Time of the week", labels =  c("Weekday", "Weekend", "Holiday"))+
       theme_bw()
   })
#___________________________ mj ____________________________________________________________________________
   output$mjxinc <- renderPlot({
     ggplot(respAprofInc, mapping = aes(x=respAprofInc$MOMENT_JOURNEE, fill=MOMENT_JOURNEE)) + geom_bar()+ 
       ylab("Number of incidents")+ 
       xlab("Time of the day")+
       scale_x_discrete(labels =  c("Day", "Night", "Dusk/Dawn"))+
       scale_fill_brewer(palette = "YlGnBu", name = "Time of the day", labels =   c("Day", "Night", "Dusk/Dawn"))+
       theme_bw()
   })
   
   output$mjxac <- renderPlot({
     ggplot(respAprofAc, mapping = aes(x=respAprofAc$MOMENTJOURNEE, fill=MOMENTJOURNEE)) + geom_bar()+
       ylab("Number of accidents")+ 
       xlab("Time of the day")+
       scale_x_discrete(labels =  c("Day", "Night", "Dusk/Dawn"))+
       scale_fill_brewer(palette = "YlGnBu", name = "Time of the day", labels =   c("Day", "Night", "Dusk/Dawn"))+
       theme_bw()
   })
#___________________________ weather ____________________________________________________________________________
   output$wxinc <- renderPlot({
     ggplot(respAprofInc, mapping = aes(x=respAprofInc$TEMPS, fill=TEMPS)) + geom_bar()+ 
       ylab("Number of incidents")+ 
       xlab("Weather")+
       scale_x_discrete(labels =  c("Dry", "Wet","Severe"))+
       scale_fill_brewer(palette = "YlGnBu", name = "Weather", labels =   c("Dry", "Wet","Severe"))+
       theme_bw()
   })
   
   output$wxac <- renderPlot({
     ggplot(respAprofAc, mapping = aes(x=respAprofAc$TEMPS, fill=TEMPS)) + geom_bar()+
       ylab("Number of accidents")+ 
       xlab("Weather")+
       scale_x_discrete(labels =  c("Dry", "Wet","Severe"))+
       scale_fill_brewer(palette = "YlGnBu", name = "Weather", labels =   c("Dry", "Wet","Severe"))+
       theme_bw()
   })
#___________________________ tj ____________________________________________________________________________
   output$tjxinc <- renderPlot({
     ggplot(respAprofInc, mapping = aes(x=respAprofInc$TRAJET, fill=TRAJET)) + geom_bar()+ 
       ylab("Number of incidents")+ 
       xlab("Type of journey")+
       scale_x_discrete(labels =  c("Habitual", "Known", "New"))+
       scale_fill_brewer(palette = "YlGnBu", name = "Journey", labels =    c("Habitual", "Known but not frequent", "New"))+
       theme_bw()
   })
   
   output$tjxac <- renderPlot({
     ggplot(respAprofAc, mapping = aes(x=respAprofAc$TRAJET, fill=TRAJET)) + geom_bar()+
       ylab("Number of accidents")+ 
       xlab("Type of journey")+
       scale_x_discrete(labels =  c("Habitual", "Known", "New"))+
       scale_fill_brewer(palette = "YlGnBu", name = "Journey", labels =    c("Habitual", "Known but not frequent", "New"))+
       theme_bw()
   })
#___________________________ traffic ____________________________________________________________________________
   output$trafficxinc <- renderPlot({
     ggplot(respAprofInc, mapping = aes(x=respAprofInc$TRAFIC, fill=TRAFIC)) + geom_bar()+ 
       ylab("Number of incidents")+ 
       xlab("Traffic")+
       scale_x_discrete(labels =  c("Very fluid", "Fluid", "Dense", "Blocked"))+
       scale_fill_brewer(palette = "YlGnBu", name = "Traffic", labels = c("Very fluid", "Fluid", "Dense", "Blocked"))+
       theme_bw()
   })
   
   output$trafficxac <- renderPlot({
     ggplot(respAprofAc, mapping = aes(x=respAprofAc$TRAFIC, fill=TRAFIC)) + geom_bar()+
       ylab("Number of accidents")+ 
       xlab("Traffic")+
       scale_x_discrete(labels =  c("Very fluid", "Fluid", "Dense", "Blocked"))+
       scale_fill_brewer(palette = "YlGnBu", name = "Traffic", labels = c("Very fluid", "Fluid", "Dense", "Blocked"))+
       theme_bw()
   })
#___________________________ tr ____________________________________________________________________________
   output$trxinc <- renderPlot({
     ggplot(respAprofInc, mapping = aes(x=respAprofInc$TYPE_ROUTE, fill=TYPE_ROUTE)) + geom_bar()+ 
       ylab("Number of incidents")+ 
       xlab("Type of Road")+
       scale_x_discrete(labels =  c("City", "Road", "Highway", "Ring road", "Private", "Path"))+
       scale_fill_brewer(palette = "YlGnBu", name = "Type", labels = c("City", "Road", "Highway", "Ring road", "Private", "Path"))+
       theme_bw()
   })
   
   output$trxac <- renderPlot({
     ggplot(respAprofAc, mapping = aes(x=respAprofAc$TYPEROUTE, fill=TYPEROUTE)) + geom_bar()+
       ylab("Number of accidents")+ 
       xlab("Type of Road")+
       scale_x_discrete(labels =  c("City", "Road", "Highway", "Ring road", "Private", "Path"))+
       scale_fill_brewer(palette = "YlGnBu", name = "Type", labels = c("City", "Road", "Highway", "Ring road", "Private", "Path"))+
       theme_bw()
   })
#___________________________ SPEED ____________________________________________________________________________
   output$speedxinc <- renderPlot({
     ggplot(respAprofInc, mapping = aes(x=VITESSE)) + geom_area(stat = "bin", fill="deepskyblue4")+ 
       geom_vline(xintercept =mean(respAprofInc$VITESSE) ) +
       ylab("Number of incidents")+ 
       xlab("Speed")+
       theme_bw()
   })
   
   output$speedxac <- renderPlot({
     ggplot(respAprofAc, mapping = aes(x=VITESSE)) +  geom_area(stat = "bin", fill="deepskyblue4")+
       geom_vline(xintercept =mean(respAprofAc$VITESSE) ) +
       ylab("Number of accidents")+ 
       xlab("Type of Road")+
       theme_bw()
   })
#___________________________ TREE ____________________________________________________________________________
   output$aptree <- renderPlot({
     ap_tree <- rpart(acident_incident ~ semaine+momentjourne+temps+trajet+typeroute+vitesse,
                      method="class", data=df)
     rattle::fancyRpartPlot(ap_tree, sub="" ,palettes="YlGnBu")
     
   })
})
