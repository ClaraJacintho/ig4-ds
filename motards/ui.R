library(shiny)
library(shinydashboard)



shinyUI(fluidPage(
    dashboardPage(
      
      header <- dashboardHeader(title = "IG4 DS Project"),
      
      sidebar <- dashboardSidebar(
        sidebarMenu(
          menuItem("Introduction", tabName = "intro", icon = icon("dashboard")),
          
          menuItem("Qualitative data", icon = icon("th"), tabName = "qual",
                   menuItem('The QQual data',
                            tabName = 'qqual',
                            icon = icon('line-chart')
                   ),
                   menuItem('Frequency',
                            tabName = 'freq',
                            icon = icon('line-chart')
                  ),    
                  
                  menuItem('Usage',
                           tabName = 'usage',
                           icon = icon('line-chart')
                  ),
                  menuItem('Number of Kilometres',
                           tabName = 'km',
                           icon = icon('line-chart')
                  ),menuItem('CC',
                             tabName = 'cc',
                             icon = icon('line-chart')
                  )
          ),
          
          
          menuItem("DEEP", icon = icon("th"), tabName = "qual",
                   menuItem('Aprofondissement',
                            tabName = 'deep',
                            icon = icon('line-chart')
                   ),
                   menuItem('Day of the week',
                            tabName = 'semaine',
                            icon = icon('line-chart')
                   ),
                   menuItem('Time of the day',
                            tabName = 'mj',
                            icon = icon('line-chart')
                   ),
                   menuItem('Trafic',
                            tabName = 'trafic',
                            icon = icon('line-chart')
                   ),
                   menuItem('Journey',
                            tabName = 'trajet',
                            icon = icon('line-chart')
                   ),
                   menuItem('Type of road',
                            tabName = 'tr',
                            icon = icon('line-chart')
                   ),
                   menuItem('Speed',
                            tabName = 'speed',
                            icon = icon('line-chart')
                   )
          )
          
        )
        
      ),
      
      body <- dashboardBody(
        tabItems(
          tabItem(tabName = "intro",
                  h2("Introduction"),
                  fluidRow(
                    box("INTRO")
                  )
          ),
          
        
          tabItem(tabName = "qqual",
                  h2("QQual analysis"),
                  fluidRow(
                    box("INTRO")
                  )
          ),
          
          
            tabItem(tabName = "freq",
                    h2("Frequency of use"),
                    fluidRow(
                      box(title = "How people use their motorcycles", status = "primary", solidHeader = TRUE,
                          plotOutput("Nbfreq")
                          )
                    ),
                    fluidRow(
                      box("Content")
                    )
            ),
          
            tabItem(tabName = "usage",
                    h2("Usage of the vehicle"),
                    fluidRow(
                      box("INTRO")
                    )
            ),
          
            tabItem(tabName = "km",
                    h2("Kileometers of use of the vehicle"),
                    fluidRow(
                      box("INTRO")
                    )
            ),
          
            tabItem(tabName = "cc",
                    h2("CC of the Vehicle"),
                    fluidRow(
                      box("INTRO")
                    )
            ),
          
          tabItem(tabName = "deep",
                  h2("The Aprofondissiment data"),
                  fluidRow(
                    box("INTRO")
                  )
          ),
            tabItem(tabName = "semaine",
                    h2("The day of the week"),
                    fluidRow(
                      box("INTRO")
                    )
            ),
          tabItem(tabName = "mj",
                  h2("The time of the day'"),
                  fluidRow(
                    box("INTRO")
                  )
          ),
          tabItem(tabName = "trajet",
                  h2("The journey"),
                  fluidRow(
                    box("INTRO")
                  )
          ),
          tabItem(tabName = "trafic",
                  h2("The conditions of traffic"),
                  fluidRow(
                    box("INTRO")
                  )
          ),
          tabItem(tabName = "tr",
                  h2("The type of road"),
                  fluidRow(
                    box("INTRO")
                  )
          ),
          tabItem(tabName = "speed",
                  h2("The speed"),
                  fluidRow(
                    box("INTRO")
                  )
          )
            
        )
        
        
      ),
      
      dashboardPage(header, sidebar, body)
  )
))

