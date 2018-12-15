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
                   )
          )
          
        )
        
      ),
      
      body <- dashboardBody(
        tabItems(
          tabItem(tabName = "intro",
                  h2("Introduction")
          ),
          
        
          tabItem(tabName = "qqual",
                  h2("QQual analysis")
          ),
          
          
            tabItem(tabName = "freq",
                    h2("Frequency of use")
            ),
          
            tabItem(tabName = "usage",
                    h2("Usage of the vehicle")
            ),
          
            tabItem(tabName = "km",
                    h2("Kileometers of use of the vehicle")
            ),
          
            tabItem(tabName = "cc",
                    h2("CC of the Vehicle")
            ),
          
          tabItem(tabName = "deep",
                  h2("The Aprofondissiment data")
          ),
            tabItem(tabName = "semaine",
                    h2("The day of the week")
            )
            
        )
        
      ),
      
      dashboardPage(header, sidebar, body)
  )
))

