library(shiny) # Load shiny

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
      min = 0,
      max = 10,
      value = 2
    )
  ),
  
  mainPanel(
    plotOutput(outputId = "demo")
  )
))