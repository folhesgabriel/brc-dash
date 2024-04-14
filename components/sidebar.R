###################
# sidebar.R
# 
# Create the sidebar menu options for the ui.
##################
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(HTML("Brazil Rural Credit"), tabName = "page_1", icon = icon("map"))
  )
)
