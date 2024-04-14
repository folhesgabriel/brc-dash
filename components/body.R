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
                   HTML('<h2 style="margin-bottom: 24px;">Brazil Rural Credit Dashboard</h2>
    <p style="font-size: 20px;">This dashboard, a culmination of the Data Engineering 2024 courses final project, illustrates the total nominal value of rural public credit loans allocated to Brazilian municipalities throughout the 2022/2023 agricultural year, utilizing datasets from the Brazilian Central Bank.</p>
    <p style="font-size: 20px;">For insight into the development process or to contribute, visit the repositories:</p>
    <ul style="font-size: 20px;">
      <li>The Shiny apps source code is available <a href="https://github.com/folhesgabriel/brc-dash" target="_blank">here</a>.</li>
      <li>The data pipelines source code is accessible <a href="https://github.com/folhesgabriel/brazil-rural-credit" target="_blank">here</a>.</li>
    </ul>
    <p style="font-size: 18px;"><strong>Author:</strong> Gabriel P. Folhes</p>'),
      br()
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

