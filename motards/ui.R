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
                   menuItem('Weather',
                            tabName = 'we',
                            icon = icon('line-chart')
                   ),
                   menuItem('Traffic',
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
                      box(title = "When people use their motorcycles", status = "primary", solidHeader = TRUE,
                          plotOutput("nbfreq")
                          ),
                      box("Remark")
                    ),
                    fluidRow(
                      box(title = "Frequency of use by number of incidents", status = "primary", solidHeader = TRUE,
                          plotOutput("freqxinc")
                      ),
                      box(title = "Frequency of use by number of accidents", status = "primary", solidHeader = TRUE,
                          plotOutput("freqxacc")
                      )
                    ),
                    fluidRow(
                      box("Analysis")
                    ),
                    fluidRow(
                      box(title = "Boxplot of the frequency of use by incidents", status = "primary", solidHeader = TRUE,
                          plotOutput("boxfreqxinc")
                      ),
                      box(title = "Boxplot of the frequency of use by accidents", status = "primary", solidHeader = TRUE,
                          plotOutput("boxfreqxacc")
                      )
                    ),
                    fluidRow(
                      box("ANOVA")
                    )
            ),
          
            tabItem(tabName = "usage",
                    h2("Usage of the vehicle"),
                    fluidRow(
                      box(title = "How people use their motorcycles", status = "primary", solidHeader = TRUE,
                          plotOutput("nbusage")
                      ),
                      box("Remark")
                    ),
                    fluidRow(
                      box(title = "Usage by number of incidents", status = "primary", solidHeader = TRUE,
                          plotOutput("usagexinc")
                      ),
                      box(title = "Usage by number of accidents", status = "primary", solidHeader = TRUE,
                          plotOutput("usagexacc")
                      )
                    ),
                    fluidRow(
                      box("Analysis")
                    ),
                    fluidRow(
                      box(title = "Boxplot of the usage by incidents", status = "primary", solidHeader = TRUE,
                          plotOutput("boxusagexinc")
                      ),
                      box(title = "Boxplot of the usage by accidents", status = "primary", solidHeader = TRUE,
                          plotOutput("boxusagexacc")
                      )
                    ),
                    fluidRow(
                      box("ANOVA")
                    )
            ),
          
            tabItem(tabName = "km",
                    h2("Kileometers of use of the vehicle"),
                    fluidRow(
                      box(title = "Number of kilometers by number of incidents", status = "primary", solidHeader = TRUE,
                          plotOutput("kmxinc")
                      ),
                      box(title = "Number of kilometers by number of accidents", status = "primary", solidHeader = TRUE,
                          plotOutput("kmxacc")
                      )
                    ),
                    fluidRow(
                      box("Analysis")
                    )
            ),
          
            tabItem(tabName = "cc",
                    h2("CC of the Vehicle"),
                    fluidRow(
                      box(title = "CC of the motorcycle by number of incidents", status = "primary", solidHeader = TRUE,
                          plotOutput("ccxinc")
                      ),
                      box(title = "CC of the motorcycle by number of accidents", status = "primary", solidHeader = TRUE,
                          plotOutput("ccxacc")
                      )
                    ),
                    fluidRow(
                      box("Analysis")
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
                      box(title = "Number of incidents by the time of the week", status = "primary", solidHeader = TRUE,
                          plotOutput("semxinc")
                      ),
                      box(title = "Number of accidents by the time of the week", status = "primary", solidHeader = TRUE,
                          plotOutput("semxac")
                      )
                    ),
                    fluidRow(
                      box("Analysis")
                    )
            ),
          tabItem(tabName = "mj",
                  h2("The time of the day'"),
                  fluidRow(
                    box(title = "Number of incidents by the time of the day", status = "primary", solidHeader = TRUE,
                        plotOutput("mjxinc")
                    ),
                    box(title = "Number of accidents by the time of the day", status = "primary", solidHeader = TRUE,
                        plotOutput("mjxac")
                    )
                  ),
                  fluidRow(
                    box("Analysis")
                  )
          ),
          tabItem(tabName = "we",
                  h2("The Weather"),
                  fluidRow(
                    box(title = "Number of incidents by the weather", status = "primary", solidHeader = TRUE,
                        plotOutput("wxinc")
                    ),
                    box(title = "Number of accidents by the weather", status = "primary", solidHeader = TRUE,
                        plotOutput("wxac")
                    )
                  ),
                  fluidRow(
                    box("Analysis")
                  )
        ),
          tabItem(tabName = "trajet",
                  h2("The journey"),
                  fluidRow(
                    box(title = "Number of incidents by the type of journey", status = "primary", solidHeader = TRUE,
                        plotOutput("tjxinc")
                    ),
                    box(title = "Number of accidents by the type of journey", status = "primary", solidHeader = TRUE,
                        plotOutput("tjxac")
                    )
                  ),
                  fluidRow(
                    box("Analysis")
                  )
          ),
          tabItem(tabName = "trafic",
                  h2("The conditions of traffic"),
                  fluidRow(
                    box(title = "Number of incidents by the traffic", status = "primary", solidHeader = TRUE,
                        plotOutput("trafficxinc")
                    ),
                    box(title = "Number of accidents by the traffic", status = "primary", solidHeader = TRUE,
                        plotOutput("trafficxac")
                    )
                  ),
                  fluidRow(
                    box("Analysis")
                  )
          ),
          tabItem(tabName = "tr",
                  h2("The type of road"),
                  fluidRow(
                    box(title = "Number of incidents by the type of road", status = "primary", solidHeader = TRUE,
                        plotOutput("trxinc")
                    ),
                    box(title = "Number of accidents by the type of road", status = "primary", solidHeader = TRUE,
                        plotOutput("trxac")
                    )
                  ),
                  fluidRow(
                    box("Analysis")
                  )
          ),
          tabItem(tabName = "speed",
                  h2("The speed"),
                  fluidRow(
                    box(title = "Number of incidents by speed", status = "primary", solidHeader = TRUE,
                        plotOutput("speedxinc")
                    ),
                    box(title = "Number of accidents by speed", status = "primary", solidHeader = TRUE,
                        plotOutput("speedxac")
                    )
                  ),
                  fluidRow(
                    box("Analysis")
                  )
          )
            
        )
        
        
      ),
      
      dashboardPage(header, sidebar, body)
  )
))

