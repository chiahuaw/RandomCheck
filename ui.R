
library(shiny)

shinyUI(fluidPage(

 
  titlePanel("金門縣道路挖掘案件督導隨機抽選系統"),

  sidebarLayout(
    sidebarPanel(
      sliderInput("runcase",
                  "隨機抽選案件數",
                  min=1,
                  max=nrow(Temp),
                  value=2,
                  step=1)
    ),

    mainPanel(
      dataTableOutput("table")
    )
  )
))
