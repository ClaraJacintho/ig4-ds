library(shiny)
joined <- read.csv("prepared_data.csv", header = TRUE)
acidents  <- read.csv("incidents.csv", header = TRUE)
incidents <- read.csv("acidents.csv", header = TRUE)
respAprofInc <- read.csv("incidentsAp.csv", header = TRUE)
respAprofAc <- read.csv("accidentsAp.csv", header = TRUE)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
   output$nbfreq <- renderPlot({
 
   })
  
})
