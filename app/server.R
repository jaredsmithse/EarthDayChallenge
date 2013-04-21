library(shiny) # Load shiny
library(ggplot2) # Fancy Plots
library(maps) # Map Data


poly.county <- map_data("county")

climate.change <- read.csv("./data/subbed_climate_data.csv")
climate.change <- with(climate.change, climate.change[order(region, subregion, DATE), ])
# climate.change <- ddply(climate.change, .(DATE, region, subregion),
#               summarize,
#               TSNW = mean(TSNW, na.rm = TRUE),
#               TPCP = mean(TPCP, na.rm = TRUE),
#               MNTM = mean(MNTM, na.rm = TRUE))

climate.change$subregion <- gsub("\\.", "", climate.change$subregion)

joined <- merge(poly.county, climate.change, by = c("region", "subregion"), all = TRUE)

print("de kalb" %in% joined$subregion)

joined <- with(joined, joined[order(order), ]) # Fix merge dicking around with ordering

# joined <- subset(joined, region != NA)

joined <- joined[joined$DATE == "201112", ]

leftover <- setdiff(with(poly.county, paste(region, subregion, sep=",")),
                    with(climate.change, paste(region, subregion, sep=",")))

setdiff(unique(with(joined, paste(region, subregion, sep=","))), leftover)
print(intersect(leftover, with(joined, paste(region, subregion, sep = ","))))


# joined <-
ddply(joined, .(region, subregion, DATE), function(df) {
  normalized.location <- with(df[1, ], paste(region, subregion, sep = ","))
  
  if (normalized.location %in% leftover)
    stop(normalized.location)
  
#   df$TSNW <- 0
#   df$TPCP <- 0
#   df$MNTM <- 0 # fuck everything
  
  return(df)
})

p <- ggplot() + guides(fill=FALSE) +
  geom_polygon(
    data = subset(poly.county, region == "alabama" & subregion == "de kalb"),
    aes(
      x = long,
      y = lat,
      group = group,
      fill = TSNW),
    colour = TRUE) # + scale_fill_gradient(low="#000060", high="yellow")

print(p)














#County data for air quality plotting
poly.county <- map_data("county")

air.quality <- read.csv("./data/air-quality-2010.csv")

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
          fill = subregion), # Color is one-per-region
        colour = "white"  # Ouline color is white
      )
    
    print(p)
  })
})