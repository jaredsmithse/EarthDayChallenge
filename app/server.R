library(shiny) # Load shiny

shinyServer(function(input, output) {
  
  output[["demo"]] <- renderPlot(function() {
    plot(1:10, 10:1,
         main = paste("This is", input[["time"]]))
  })
})