library(shiny)
library(RSocrata)
library(leaflet)

# data.nola.gov
data <- read.socrata("https://data.nola.gov/resource/9u8f-np3i.json")
data$lng <- do.call("rbind", lapply(data$location.coordinates, "[[",1))
data$lat <- do.call("rbind", lapply(data$location.coordinates, "[[",2))

# Define server logic required to draw a leaflet map
shinyServer(function(input, output, session) {

  # Data reacts to input
  filteredData <- reactive({
    subset(data, license_type %in% input$type)
  })

  output$map <- renderLeaflet({
    leaflet() %>%
    addTiles(
      urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
      attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
    ) %>%
    setView(
      lng = -90.08385663199994,
      lat = 29.980464294000058,
      zoom = 11
    )
  })


  observe({
    observeData <- filteredData()
    leafletProxy("map") %>%
    clearMarkers() %>%
    addMarkers(
      data = observeData,
      lng = ~lng,
      lat = ~lat,
      popup = ~address)
  })
})
