library(shiny)
library(leaflet)

# Define UI for application that draws a leaflet map
shinyUI(fluidPage(

  # Application title
  titlePanel("New Orleans Short Term Rentals"),

  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
        inputId = "type",
        label =  "License Type",
        choices = c("Temporary STR", "Commercial STR", "Accessory STR"),
        selected = c("Temporary STR", "Commercial STR", "Accessory STR"))
    ),

    mainPanel(
      leafletOutput("map")
    )
  )
))
