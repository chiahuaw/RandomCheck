
library(shiny)
library(XML)
library(RCurl)

source("global.R")

shinyServer(function(input, output) {

  
  
    output$table <- renderDataTable({
      
      #隨機挑選案號
      rcase<<-Temp[sample(seq(1,nrow(Temp),1),input$runcase),]

      })
    
    output$downloadData <- downloadHandler(
      filename = function() { paste('RandomCheck_',input$checkdate,'.csv',sep="")},
      content = function(file) {
        write.csv(rcase, file,row.names=FALSE,fileEncoding = "big5")
      }
    )

})
