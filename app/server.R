library(shiny) # Load shiny
library(ggplot2) # Fancy Plots
library(maps) # Map Data


poly.state <- map_data("state")

shinyServer(function(input, output) {
  output[["map"]] <- renderPlot({
    p <- ggplot() +
      geom_polygon(
        data = poly.state,
        aes(
          x = long,
          y = lat,
          group = group,
          fill = region), # Color is one-per-region
        colour = "white"  # Ouline color is white
      )
    
    print(p)
  })
})