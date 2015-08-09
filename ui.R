
library(shiny)

shinyUI(fluidPage(

 
  titlePanel("金門縣道路挖掘案件督導隨機抽選系統"),

  sidebarLayout(
    sidebarPanel(
      sliderInput("runcase",
                  "隨機抽選案件數",
                  min=1,
                  max=length(unique(Temp[,1])),
                  value=2,
                  step=1),
      dateInput("checkdate","預定督導日期：",value=Sys.Date()),
      print(paste("系統時間：",Sys.Date()))
    ),

    mainPanel(
      dataTableOutput("table"),
      downloadButton('downloadData', '下載抽選結果CSV檔')
    )
  )
))
