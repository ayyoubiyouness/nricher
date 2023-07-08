library(shiny)
library(shinydashboard)
library(highcharter)


vendName <- c("Autre vendeur", "Vendeur 1", "Vendeur 2", "Vendeur 3", "Vendeur 4", "Vendeur 5", "Vendeur 6")

ui <- dashboardPage(
  dashboardHeader(title = "Etude de cas Nricher",
                 titleWidth = 330
  ),
  dashboardSidebar(
    width = 280,
    sidebarMenu(
      menuItem("About", tabName = "about", icon = icon("th")),
      menuItem("Analyse globale des ventes", icon = icon("dashboard"),
               menuSubItem("Evolution temporelle", tabName = "subitem11"),
               menuSubItem("Analyse par univers & Nature", tabName = "subitem12"),
               menuSubItem("Analyse par vendeur", tabName = "subitem13")
               ),
      menuItem("Analse des ventes & prix matelas", icon = icon("dashboard"),
               menuSubItem("Analyse vente", tabName = "subitem21"),
               menuSubItem("Analyse prix", tabName = "subitem22")
               )
    )
  ),
      dashboardBody(
        tags$head(
          tags$link(
            rel = "stylesheet",
            href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
          )
        ),
        includeCSS("C:/Users/Youness/Desktop/R project/nricher/code/www/custom.css"),
        
        tabItems(
          tabItem("about",
                  box(width=12,height="80",
                     p(style="font-size:20px",strong("Youness AYYOUBI"),"élève ingénieur en 2A à ECM"),
                  )
          ),
          tabItem("subitem11",
                  box(width=12,height="80",
                      p(style="font-size:20px",strong("Youness "),"élève ingénieur en 2A à ECM"),
                  )
          ),
          tabItem("subitem12",
                  box(width=12,height="80",
                      p(style="font-size:20px",strong("Youness AYYOUBI"),"élève ingénieur en 2A à ECM"),
                  )
          ),
          tabItem("subitem13",
                  box(width=12,height="80",
                      p(style="font-size:20px",strong("Youness "),"élève ingénieur en 2A à ECM"),
                  ),
                  fluidRow(
                    
                    
                    column(12,
                           
                           box(selectInput("vendeur",label="Sélectionner le nom du vendeur",choices=vendName),width = 12) 
                           
                    ),
                    column(12,
                           
                           box(
                             
                             highchartOutput("hcontainer"),
                             
                             
                             
                             width="12")
                           
                    ), 
                    br(),
                    column(12,
                           
                           box(
                             highchartOutput("hc2"),width=12
                             
                           ) )
                    
                  ),
          
          ),
          tabItem("subitem21",
                  box(width=12,height="80",
                      p(style="font-size:20px",strong("Youness AYYOUBI"),"élève ingénieur en 2A à ECM"),
                  ),
                  fluidRow(
                    
                    
                    
                    column(12,
                           
                           box(
                             
                             plotlyOutput("vente"),
                             
                             
                             
                             width="12")
                           
                    ), 
                    br(),
                    column(12,
                           
                           box(
                             highchartOutput("prix"),width=12
                             
                           ) )
                    
                  ),
                  
                  
                  
          ),
          tabItem("subitem22",
                  box(width=12,height="80",
                      p(style="font-size:20px",strong("Youness "),"élève ingénieur en 2A à ECM"),
                  )
          )
        ),
      )
)


          
  
