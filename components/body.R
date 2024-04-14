###################
# body.R
# 
# Create the body for the ui. 
# If you had multiple tabs, you could split those into their own
# components as well.
###################
body <- dashboardBody(
  tags$head(
    tags$style(HTML(
      "
      .custom-margin {
        margin-top: 22px; 
      }
      .title-text {
        font-size: 20px;
      }
    
      .leaflet-control-layers label {
      font-size: 14px !important; 
      }
      "
    ))
  ),
  tabItems(######
    tabItem(
      tabName = "page_1",
      tabPanel(
        "Map Panel",
        fluidPage(
          fluidRow(
            column(width = 12,
                   HTML('<h2>Brazil Rural Credit   </h2>
                      <h3> This dashboard is part of the Data Engineering 2024 course final project. </h3>
                      <h3> It shows a map with the total nominal value of rural public credit loans per Brazilian municipallity
                      during the 2022/2023 agricultural year built with data extracted from Brazilian Central Bank </h3>
                     <br> </br>'),
            ),
            br(),
          ),
            mainPanel(
              fluidRow(
                column(width = 12,
                       style = 'border: 1px solid lightgrey; border-radius: 25px',
                       br(),
                       # ntitle and info button
                       div(HTML('<b style="font-size: 24px;"> Brazilian Public Rural Credit Interactive Map </b>'), style = 'display: inline-block;'),
                       uiOutput('infomap_button', style = 'display: inline-block;'),
                       bsTooltip(id = "infomap_button", 
                                 title = "The polygons represents Brazilian municipalities. Click on them to see the absolute rural loans values."),
                       br(), br(),
                       # map plot
                       leafletOutput("map_rural_credit", width = "750px", height = "730px"),
                       br(), br(), br()
                )
              )
            )
          )
        )
      )
    )
  )

