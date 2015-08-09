
library(shiny)
library(XML)
library(RCurl)

source("global.R")

shinyServer(function(input, output) {

  
  
    output$table <- renderDataTable({
      
      #隨機挑選案號
      temp2<-sample(unique(Temp[,1]),input$runcase)
      rcase<<-data.frame()
      for (i in 1:length(temp2)) {rcase<<-rbind(rcase,Temp[Temp$CaseNumber==temp2[i],])} 
      rcase<<-unique(rcase)
      })
    
    output$downloadData <- downloadHandler(
      filename = function() { paste('RandomCheck_',input$checkdate,'.csv',sep="")},
      content = function(file) {
        write.csv(rcase, file,row.names=FALSE,fileEncoding = "big5")
      }
    )

})
