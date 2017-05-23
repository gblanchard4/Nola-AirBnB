library(shiny)
library(leaflet)

# Define UI for application that draws a leaflet map
shinyUI(fluidPage(

  # Application title
  titlePanel("New Orleans Short Term Rentals"),

    # Show a plot of the generated distribution
    mainPanel(
      leafletOutput("map")
    )
  )
))
