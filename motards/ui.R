library(shiny)
library(shinydashboard)



shinyUI(fluidPage(
    dashboardPage(
      
      header <- dashboardHeader(title = "IG4 DS Project"),
      
      sidebar <- dashboardSidebar(
        sidebarMenu(
          menuItem("The project", tabName = "pr", icon = icon("motorcycle"),
                   menuItem('Introduction',
                            tabName = 'intro',
                            icon = icon('chart-bar')
                   ),
                   menuItem('Preparation and initial analysis',
                            tabName = 'dp',
                            icon = icon('chart-bar')
                   )
                   ),
          
          menuItem("Qualification data", icon = icon("th"), tabName = "qual",
                   menuItem('QQual',
                            tabName = 'qqual',
                            icon = icon('motorcycle')
                   ),
                   menuItem('Frequency',
                            tabName = 'freq',
                            icon = icon('chart-bar')
                  ),    
                  
                  menuItem('Usage',
                           tabName = 'usage',
                           icon = icon('chart-bar')
                  ),
                  menuItem('Number of Kilometres',
                           tabName = 'km',
                           icon = icon('line-chart')
                  ),menuItem('CC',
                             tabName = 'cc',
                             icon = icon('line-chart')
                  )
          ),
          
          
          menuItem("The conditions data", icon = icon("th"), tabName = "qual",
                   menuItem('Aprofondissement',
                            tabName = 'deep',
                            icon = icon('motorcycle')
                   ),
                   menuItem('Time of the week',
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
          ),
          menuItem("Machine Learning", icon = icon("th"), tabName = "nl",
                   menuItem('Aprofondissement tree',
                            tabName = 'ap_tree',
                            icon = icon('tree')
                   )
          )
          
        )
        
      ),
      
      body <- dashboardBody(
        tabItems(
          tabItem(tabName = "intro",
                  h2("Introduction"),
                  fluidRow(
                     box(width=12, 
                        p("This project is a partnership between Polytech Montpellier and the Mutuelle des Motards with the objective of analyzing data collected by the 2RouesLab to gain insight into the profiles of bikers. 
                         Our group took a deeper look into the relationship between incidents and accidents (subject number 4)."),
                         p("We first analyzed the data from the 'QQual' questionnaire, to understand the profile of the drivers through data such as the frequency of use of the motorcycle, number of kilometers ridden and more."),
                         p("We then looked into the 'Aprofondissement' questionnaires, that went deeper into the causes of a particular accident or incident, to help us understand what differentiates the two.")
                     )
                  ),
                  h3("The Developers"),
                  fluidRow(
                            box(width = 4, status = "primary",
                                tags$img(src='clara.jpg',height=250, style="display: block; margin-left: auto; margin-right: auto;" ),
                                p(tags$b(h4("Maria Clara M. Jacintho"))), align = "center",
                                tags$b(a(href="https://github.com/SpaceCenturion/",  target="_blank", "Github"))),
                            
                             box(width = 4, status = "primary",
                               tags$img(src='delton.jpg',height=250,  style="display: block; margin-left: auto; margin-right: auto;"),
                                 p(tags$b(h4("Delton Vaz"))), align = "center",
                               tags$b(a(href="https://github.com/deltonvaz/",  target="_blank", "Github"))),
                            
                             box(width = 4,status = "primary",
                               tags$img(src='alex.jpg',height=250,  style="display: block; margin-left: auto; margin-right: auto;"),
                                 p(tags$b(h4("Alexandre Kueny"))), align = "center",
                               tags$b(a(href="https://github.com/AlexandreKueny",  target="_blank", "Github")))
                  ),
                      actionButton(inputId='ab1', label="See this project on Github", 
                                               icon = icon("github"), 
                                               onclick ="window.open('https://github.com/SpaceCenturion/ig4-ds', '_blank')")
          ),
          tabItem(tabName = "dp",
                  h2("Data preparation and initial analysis"),
                  fluidRow(
                    box(width=12, 
                        p("We first prepared the data in Dataiku. We created a variable called 'TOTAL_INC' for the incidents and 'TOTAL_AC' for the accidents.
                           This variable is the sum of all the times that person was in an incident/accident."),
                        p("For the initial analysis we wanted to see if there was a correlation between the total number of incidents and the total number of accidents a person has. For
                          this, we used Data Iku to 'join' the incident and accident tables, using the QQUAL response as the identifier. This gave us a table with only people that answer both
                          questionnaires, so we can compare  the numbers of an individual. "),
                        p("We then proceeded to measure the correlation of the two variables using ", code("cor(joined$TOTAL_AC, joined$TOTAL_INC)")),
                        p("The result measured was ", tags$b("0.04419411."), " This means the variables are positively but ",  tags$em("very"), " weakly correlated, so the number of incidents a person has 
                          cannot predict their number of accidents.")
                        
                    )
                  )
          ),
          
        
          tabItem(tabName = "qqual",
                  h2("The QQUAL data"),
                  fluidRow(
                    box(width=12,
                        p("For this part of the project, we chose some of the questions of the qualitative questionnaire that we thought would have the most impact in the number of accidents/incidents a person had. Those were:"),
                        tags$ul(
                          tags$li("Frequency of use - FREQ1"),
                          tags$li("How the motorcycle is used - USAGE1"),
                          tags$li("Number of kilometers of use of the main motorcycle - NBKM1"),
                          tags$li("Number of CCs of the main motorcycle - CYLINDREE1")
                        ),
                        p("We then created some graphs and conducted a correlation or ANOVA test to see if there was indeed any relationship between the variable and the quantity of incidents/accidents")
                        )
                  )
          ),
          
          
            tabItem(tabName = "freq",
                    h2("Frequency of use"),
                    fluidRow(
                      box(title = "How often people use their motorcycles", status = "primary", solidHeader = TRUE,
                          plotOutput("nbfreq")
                          ),
                      box(p("In this graph we can see the number of people who use their motorcycles once a week is roughly the same as the number of people that use it a couple of 
                            times a week, with these two groups being the majority of users.") )
                    ),
                    fluidRow(
                      box(title = "Number of incidents versus Frequency of use", status = "primary", solidHeader = TRUE,
                          plotOutput("freqxinc")
                      ),
                      box(title = "Number of accidents veersus Frequency of use", status = "primary", solidHeader = TRUE,
                          plotOutput("freqxacc")
                      )
                    ),
                    fluidRow(
                      box(width=12,
                        p("Here we can see that, even though the number of people that use their bikes daily and weekly is the same, those who use it daily have a greater number of incidents/accidents in general."),
                        p("That, of course, makes sense since they drive as much as 5 times more than their weekly counterparts"))
                    ),
                    fluidRow(
                      box(title = "Boxplot of the Incidents versus Frequency of use", status = "primary", solidHeader = TRUE,
                          plotOutput("boxfreqxinc")
                      ),
                      box(title = "Boxplot of the Accidents versus Frequency of use", status = "primary", solidHeader = TRUE,
                          plotOutput("boxfreqxacc")
                      )
                    ),
                    fluidRow(
                      box(width=12,
                        p("By conducting an ANOVA test, we find the p-value to be 6.56e-11 for the accidents and 1.37e-10 for the incidents, which shows  a significant relationship between the frequency of 
                          use of the motorcycle and the total number of incidents/accidents a person has."),
                        p("Looking at the boxplot we can see that relationship, specially in the accidents graph. What is also remarkable is the number of outliers, that is to say, 
                          the number of people with a lot more incidents/accidents then the average, particularly in the first factor.")
                      )
                    )
            ),
          
            tabItem(tabName = "usage",
                    h2("Usage of the vehicle"),
                    fluidRow(
                      box(title = "How people use their motorcycles", status = "primary", solidHeader = TRUE,
                          plotOutput("nbusage")
                      ),
                      box(p("The majority of people interviewed used their motorcycles mainly for leisure, with using it to go to work as a close second")
                          )
                    ),
                    fluidRow(
                      box(title = "Incidents versus Usage", status = "primary", solidHeader = TRUE,
                          plotOutput("usagexinc")
                      ),
                      box(title = "Accidents verusu Usage", status = "primary", solidHeader = TRUE,
                          plotOutput("usagexacc")
                      )
                    ),
                    fluidRow(
                      box(width = 12,
                          p("Here we see an inversion of the trend presented in the last graph, with a larger portion of the incidents and accidents happening to people that
                            use their motorcycles to go to work. That may be because they use their bikes more frequently than the ones that use it mainly for leisure."))
                    ),
                    fluidRow(
                      box(title = "Boxplot of Incidents versus Usage", status = "primary", solidHeader = TRUE,
                          plotOutput("boxusagexinc")
                      ),
                      box(title = "Boxplot of Accidents versus Usage", status = "primary", solidHeader = TRUE,
                          plotOutput("boxusagexacc")
                      )
                    ),
                    fluidRow(
                      box(width = 12,
                        p("Again with values of 3.55e-06 for the incidents and 1.35e-05 for the accidents, we can see a relationship between the usage of the motorcycle 
                          and the total number of incidents/accidents."),
                        p("The boxplot shows once again a great number of outliers that may have skewed the result."))
                    )
            ),
          
            tabItem(tabName = "km",
                    h2("Kileometers of use of the vehicle"),
                    fluidRow(
                      box(title = "Number of Incidents versus number of kilometers", status = "primary", solidHeader = TRUE,
                          plotOutput("kmxinc")
                      ),
                      box(title = "Number of Accidents versus number of kilometers", status = "primary", solidHeader = TRUE,
                          plotOutput("kmxacc")
                      )
                    ),
                    fluidRow(
                      box(width =12,
                        p("For this variable, plotted the total incidents/accidents by the number of kilometers of the main motorcycle. There is no noticeable trend"),
                        p("We then measured the correlation between the total number of incidents/accidents and the total number of kilometers. For the incidents the correlation 
                          was", tags$b("0.08422457"), ", and for the accidents",  tags$b("0.1371557. "),  "Both positive but weak.")
                        )
                    )
            ),
          
            tabItem(tabName = "cc",
                    h2("CC of the Vehicle"),
                    fluidRow(
                      box(title = "Number of incidents versus the CC of the vehicle", status = "primary", solidHeader = TRUE,
                          plotOutput("ccxinc")
                      ),
                      box(title = "Number of accidents versus the CC of the vehicle", status = "primary", solidHeader = TRUE,
                          plotOutput("ccxacc")
                      )
                    ),
                    fluidRow(
                      box(width =12,
                            p("For this analysis, we first created another column 'isScooter', to see if a determined vehicle was a", tags$em('Scooter'), "that is, 
                              under 125 CC, that requires a different driver's license than those above 125 cc, which are ", tags$em("Motorcycles")),
                          p("We once again measured the correlation an the results were", tags$b(" -0.06999536"), " for the incidents and ", tags$b("0.08871506"), " for
                            the accidents. The negative correlation with the incidents and positive with the accidents could indicate that lower cc vehicles are less prone to 
                            accidents than those with higher cc, where events that would be incidents become accidents, but the correlation is too weak to make any strong claims.")
                          )
                    )
            ),
          
          tabItem(tabName = "deep",
                  h2("The Approfondissement data"),
                  fluidRow(
                    box(width =12,
                      p("For the 'Approfondissement' questionnaire, we decided to look into the following variables:"),
                      tags$ul(
                        tags$li("Time of the week - SEMAINE"),
                        tags$li("Time of the day - MOMENT_JOURNEE"),
                        tags$li("The weather - TEMPS"),
                       # tags$li("The traffic conditions - TRAFIC"),
                        tags$li("How usual was the journey - TRAJET"),
                        tags$li("The type of road - TYPE_ROUTE"),
                        tags$li("The speed - VITESSE")
                      ),
                      p("These variables describe the conditions of one particular event. The will help us determine if there are any conditions of the road or of
                        how people drive that help incidents become accidents."),
                      p("We did not find it pertinent to try to establish a relationship between these values and the total number of incidents/accidents of a person,
                        since they describe only one particular event chosen by the interviewee.")
                      )
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
                      box(width = 12,
                          p("We can observe that a larger proportion of accidents happen on the weekend compared to incidents. That may be because more inexperienced riders
                            go out on the weekend as entertainment and do not have the knowledge to prevent the event from becoming an accident.")
                          )
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
                    box(width = 12,
                        p("This graph shows us that there is a larger number of accidents at night, 42 againt 19 incidents. This indicates that potential accidents
                          that happen at night tend to become more accidents than incidents.")
                    )
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
                    box(width = 12,
                        p("We can again see that a larger proportion of accidents happen during wet or severe (snow, strong winds, sleet) weather conditions. ")
                    )
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
                    box(width = 12,
                        p("A larger proportion of accidents happen on paths that are know but not habitual, compared to incidents. The fact that they are known may lower the guard
                          of many drivers, who are then surprised by things they did not know or forgot.")
                    )
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
                    box(width = 12,
                        p("We see a larger proportion of accidents happening in a city, compared to incidents.")
                    )
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
                    box(width = 12,
                        p("In this graph we can see that, contrary to what one would believe, most accidents happen at a slower speed than incidents. While the mean
                          speed for an accident was ", tags$b("47.26"), ", the mean speed for incidents was ", tags$b("64.37. "), "This may come from the fact that
                          when people are driving fast they pay more attention and drive more carefully.")
                    )
                  )
          ),
        
        tabItem(tabName = "ap_tree",
                h2("Decision tree Approfondissement data"),
                fluidRow(
                  box(title = "Decision Tree", status = "primary", solidHeader = TRUE,
                      plotOutput("aptree")
                  ),
                 
                  box(
                      p("We decided to apply the lesson we learned in the Machine Learning course by creating a decision tree with the data from the 'Approfondissement' questionnaire."),
                      p("To do so, we created a table with the 6 previously analysed characteristics:"),
                      tags$ul(
                        tags$li("Time of the week"),
                        tags$li("Time of the day"),
                        tags$li("The weather"),
                        tags$li("How usual was the journey"),
                        tags$li("The type of road"),
                        tags$li("The speed")
                      ),
                      p("And added a column acident_incident to indicate whether the event was an accident or an incident. This allows us to use the library 'rpart'
                        to easily create a decision tree."),
                      p("As we can see, the main characteristics that differentiates an incident from an accident is the speed, and the weather. A slower speed
                        and wet or severe weather indicates an accident!")
                  )
                )       
        )
            
        )
        
        
      ),
      
      dashboardPage(header, sidebar, body)
  )
))

