library(XML)
library(RCurl)
# from:http://shiny.rstudio.com/gallery/unicode-characters.html
# Cairo包的PNG设备似乎无法显示中文字符，强制使用R自身的png()设备
options(shiny.usecairo = FALSE)

# 请忽略以下代码，它只是为了解决ShinyApps上没有中文字体的问题
font_home <- function(path = '') file.path('~', '.fonts', path)
if (Sys.info()[['sysname']] == 'Linux' &&
      system('locate wqy-zenhei.ttc') != 0 &&
      !file.exists(font_home('wqy-zenhei.ttc'))) {
  if (!file.exists('wqy-zenhei.ttc'))
    shiny:::download(
      'https://github.com/rstudio/shiny-examples/releases/download/v0.10.1/wqy-zenhei.ttc',
      'wqy-zenhei.ttc'
    )
  dir.create(font_home())
  file.copy('wqy-zenhei.ttc', font_home())
  system2('fc-cache', paste('-f', font_home()))
}
rm(font_home)

####抓取資料####
url <-'http://pipe.kinmen.gov.tw/kinmen/Civilian/LocationQuery.aspx'
url_list <- unlist(url) #去格式化

##Get the table online
#核心程式
myTemp <- function(url){
  #抓取url
  get_url = getURL(url,encoding = "UTF-8")
  #將url解析
  get_url_parse = htmlParse(get_url, encoding = "UTF-8")
  #抓取關鍵的變項，我們需要的變項夾在一個div的class=tqtongji2，裡面<ul>中的<li>標籤裡面
  #標籤裡面還有一些沒有用到的東西沒關係，事後再一併移除
  tablehead <- xpathSApply(get_url_parse, "//table[@class='TurnInTable']/tr/td", xmlValue)
  #將擷取到的關鍵字轉成容易閱讀的矩陣格式
  table <- matrix(tablehead, ncol = 12, byrow = TRUE)
  #回傳值
  return(table)
}

Temp_Total <- lapply(url_list, myTemp)

#清理資料

df<-as.data.frame(Temp_Total,stringsAsFactors = F)
df2<-list()

for (i in 1:nrow(df)) {
  for ( t in 1:ncol(df)) {
    df[i,t]<-gsub("\r\n","",df[i,t])
    df[i,t]<-gsub("\\s","",df[i,t])
    df2<-rbind(df2,df[i,t])
  }
}
df2<-unlist(df2)
Temp <- matrix(ncol =8,nrow=length(df2)/8)
Temp<-matrix(df2,ncol=8,byrow=T)
Temp<-as.data.frame(Temp,stringsAsFactors = F)

colnames(Temp)<-c("CaseNumber","Date","Time","Applicant","Contract","Township","Roads","Note")
