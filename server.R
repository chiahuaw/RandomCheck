
library(shiny)
library(XML)
library(RCurl)

source("global.R")

shinyServer(function(input, output) {

  
  
    output$table <- renderDataTable({
      
      #隨機挑選案號
      Temp[c(sample(seq(1,nrow(Temp)),input$runcase)),]
      
      })

})
