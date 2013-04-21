library(shiny) # Load shiny
library(ggplot2) # Fancy Plots
library(maps) # Map Data


# poly.county <- map_data("county")
# 
# # Create Rdata file that contains climate data by month/year
# climate.change <- read.csv("app/data/version4.csv")
# climate <- dlply(climate.change, .(DATE), function(df) {
#   if (!str_detect(df[1, ]$DATE, "^(2|199)"))
#     return(subset(df, DATE == 0))
#   
#   print(df[1, ]$DATE)
#   
#   df <- with(df, df[order(region, subregion), ])
#   
#   # Average out data
#   df <- ddply(df, .(region, subregion), summarize,
#               snow = mean(snow, na.rm = TRUE),
#               rain = mean(rain, na.rm = TRUE),
#               temp = mean(temp, na.rm = TRUE))
#   
#   df$subregion <- gsub("\\.", "", df$subregion)
#   
#   df <- merge(poly.county, df, by = c("region", "subregion"), all = TRUE)
#   
#   df <- df[order(df$order), ]
#   
#   return(df)
# })

# # climate.change <- with(climate.change, climate.change[order(region, subregion, DATE), ])
# # climate.change <- ddply(climate.change, .(DATE, region, subregion),
# #               summarize,
# #               TSNW = mean(TSNW, na.rm = TRUE),
# #               TPCP = mean(TPCP, na.rm = TRUE),
# #               MNTM = mean(MNTM, na.rm = TRUE))
# # 
# # climate.change$subregion <- gsub("\\.", "", climate.change$subregion)
# 
# joined <- merge(poly.county, climate.change, by = c("region", "subregion"), all = TRUE)
# 
# joined <- with(joined, joined[order(region, subregion, order), ]) # Fix merge dicking around with ordering
# 
# # joined <- subset(joined, region != NA)
# 
# joined <- joined[joined$DATE == "201112", ]
# 
# leftover <- setdiff(with(poly.county, paste(region, subregion, sep=",")),
#                     with(climate.change, paste(region, subregion, sep=",")))
# normalized.leftover <- gsub("\\s", "", leftover)
# 
# joined <-ddply(joined, .(region, subregion, DATE), function(df) {
#   normalized.location <- with(df[1, ], paste(region, subregion, sep = ","))
#   normalized.location <- gsub("\\s", "", normalized.location)
#   
#   if (!(normalized.location %in% normalized.leftover))
#     return(df)
#   
#   df$TSNW <- NA
#   df$TPCP <- NA
#   df$MNTM <- NA # fuck everything
#   
#   return(df)
# })
# 
# ggplot() + guides(fill=FALSE) +
#   geom_polygon(
#     data = climate[["201201"]],
#     aes(
#       x = long,
#       y = lat,
#       group = group,
#       fill = snow),
#     colour = TRUE) # + scale_fill_gradient(low="#000060", high="yellow")

load("climate.Rdata")







#County data for air quality plotting
# poly.county <- map_data("county")
# 
# air.quality <- read.csv("./data/air-quality-2010.csv")
# 
# air.quality$subregion <- gsub("\\.", "", air.quality$subregion)
# 
# joined <- merge(poly.county, air.quality, by = c("region", "subregion"), all.x = TRUE)
# 
# joined <- joined[order(joined$order), ] # Fix merge dicking around with ordering

shinyServer(function(input, output) {
  output[["map"]] <- renderPlot({
    target <- paste(input[["time"]], (input[["time"]] %% 1) * 12, sep="")
    
    p <- ggplot() + guides(fill=FALSE) +
      geom_polygon(
        data = climate[[target]],
        aes(
          x = long,
          y = lat,
          group = group,
          fill = snow),
        colour = TRUE) # + scale_fill_gradient(low="#000060", high="yellow")
    
    print(p)
  })
})