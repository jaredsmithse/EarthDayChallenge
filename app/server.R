library(shiny) # Load shiny
library(ggplot2) # Fancy Plots
library(maps) # Map Data

poly.county <- map_data("county")

air.quality <- read.csv("data/air-quality-2010.csv")

air.quality$subregion <- gsub("\\.", "", air.quality$subregion)

joined <- merge(poly.county, air.quality, by = c("region", "subregion"), all.x = TRUE)

joined <- joined[order(joined$order), ] # Fix merge dicking around with ordering

shinyServer(function(input, output) {
  output[["map"]] <- renderPlot({
    p <- ggplot() + guides(fill=FALSE) +
      geom_polygon(
        data = joined,
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