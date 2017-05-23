library(shiny)
library(RSocrata)
library(leaflet)

# data.nola.gov
data <- read.socrata("https://data.nola.gov/resource/9u8f-np3i.json")
data$lat <- do.call("rbind", lapply(data$location.coordinates, "[[",1))
data$lng <- do.call("rbind", lapply(data$location.coordinates, "[[",2))

# Define server logic required to draw a leaflet map
shinyServer(function(input, output) {

  output$map <- renderLeaflet({
    leaflet() %>%
    addProviderTiles(providers$Stamen.TonerLite,
      options = providerTileOptions(noWrap = TRUE)
    ) %>%
    addMarkers(data = data, lng = ~lng, lat = ~lat )
  })
})
