library(shiny) # Load shiny
library(ggplot2)

# inputId

shinyUI(pageWithSidebar(
  headerPanel(
    title = "Climate Time Machine",
    windowTitle = "NASA Space Apps Challenge 2013"
  ),
  
  sidebarPanel(
    sliderInput(
      inputId = "time",
      label = "Year",
      min = 1990,
      max = 2012,
      value = 2008,
      step = 1/12 # 1-month increments -- bwahaha!
    )
  ),
  
  mainPanel(
    plotOutput(outputId = "map")
  )
))