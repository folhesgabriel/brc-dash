###################
# server.R
# 
# For all your server needs 
###################

#https://rstudio.github.io/leaflet/articles/choropleths.html
#https://github.com/rstudio/leaflet/issues/877

server <- function(input, output, session) {
  
  
  #-- leaflet interactive map
  output$map_rural_credit <- renderLeaflet({
    
    leaflet() %>% 
      addTiles() %>%
      addProviderTiles("CartoDB.Positron", group = "CartoDB.Positron") %>%
      addProviderTiles("OpenStreetMap", group = "OpenStreetMap") %>%
      addProviderTiles("Esri.WorldImagery", group = "Esri.WorldImagery") %>%
      addPolygons(data= brazil_base_map,
                  weight = 3,
                  color = 'black',
                  fillOpacity = .1) %>% 
      addPolygons(data =df,
        fillColor = ~pal(sum_rural_credit_loans),
        fillOpacity = 0.8,
        color = 'black',
        weight = .1,
        highlight = highlightOptions(weight = 5, bringToFront = TRUE, color = 'red'),
        label = ~paste0("Municipality: ", name_muni),
        labelOptions = labelOptions(
          style = list("font-size" = "19px", "font-weight" = "bold"),
          direction = 'auto'
        ),
        popup = ~paste0(
          '<div style="font-size: 19px;">',
          "<b>Public Loans (R$): </b>", formatted_loans,"<br>",
          "<b>Municipality: <b>", name_muni,"<br>",
          "<b>State Acronym: </b>", abbrev_state 
        ),
        popupOptions  = labelOptions(
          style = list("font-size" = "19px"),
          direction = 'auto'
        )
      ) %>% 
      addLegend(pal = pal, 
                values = df$sum_rural_credit_loans, 
                title = "Rural Credit Classes (R$)",
                position = "bottomleft") %>% 
      addLayersControl(
        baseGroups = c("CartoDB.Positron", "OpenStreetMap", "Esri.WorldImagery"),
        options = layersControlOptions(collapsed = FALSE),
        position = "topright"
      ) %>% 
      addMiniMap()
  })

  #-- infomap_button
  output$infomap_button <- renderUI({
    actionButton('InfoMapButton', NULL, icon = icon('info'), style = 'border-radius: 50%;')
  })
  

    
  
}
    
          


  
  
  


