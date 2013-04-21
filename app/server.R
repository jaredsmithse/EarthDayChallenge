library(shiny) # Load shiny
library(ggplot2) # Fancy Plots
library(maps) # Map Data

poly.county <- map_data("county")

air.quality <- read.csv("app/data/air-quality-2010.csv")

air.quality$subregion <- gsub("\\.", "", air.quality$subregion)

joined <- merge(poly.county, air.quality, by = c("region"), all.x = TRUE)

shinyServer(function(input, output) {
  output[["map"]] <- renderPlot({
    p <- ggplot() + guides(fill=FALSE) +
      geom_polygon(
        data = joined,
        aes(
          x = long,
          y = lat,
          group = group,
          fill = pm2.5.wtd.am.microg.by.m3), # Color is one-per-region
        colour = "white"  # Ouline color is white
      )
    
    print(p)
  })
})