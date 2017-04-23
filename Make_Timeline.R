
library('RCurl') 
library('data.table') 
library('XML') 

for(i in 2007:2017)
{fileURL <- paste('https://www.bing.com/search?q=евровидение+к+',i,'&qs=n&form=QBLH&sp=-1&pq=евровидение+к+2&sc=0-15&sk=&cvid=DD67510EBA2E466290895C8D028089D1')
  fileURL  
  html <- getURL(fileURL)
  doc <- htmlTreeParse(html, useInternalNodes = T)}
doc
#установка пакетов
install.packages("RCurl")
install.packages("XML")
library("RCurl")
library("XML")

#не работает Source, закомментирован в векторах, цикле и фрейме

#вектора для данных
years <- vector(mode = "numeric", length = 0)         
headers <- vector(mode = "character", length = 0)     
urls <- vector(mode = "character", length = 0)
#sources <- vector(mode = "character", length = 0)

#вектор для запроса
request <- c('к', 'в', 'с')
n=0

#циклы для получения данных из html страниц
#во внешнем цикле менятся предлог - в, до, после
#во внутреннем цикле меняется год

for (j in request){
  for (i in 2002:2017){
    
    Sys.sleep(20)
    file_url=paste('http://www.bing.com/search?q=евровидение+в+России+',j,'+',i, sep = '')
    html <- getURL(file_url)
    doc <- htmlTreeParse(html, useInternalNodes = T)
    rootNode <- xmlRoot(doc)
    
    headers <- c (headers, xpathSApply(rootNode, '//h2[@class="r"]/a', xmlValue))
    m <- length(headers)-n
    years <- c (years, rep(i,m))
    n <- length(headers)
    urls <- c (urls, xpathSApply(rootNode, '//h2[@class="r"]/a', xmlGetAttr,'href'))
    #sources <- xpathSApply(rootNode, '//div[@class="f kv _SWb"]/cite[@class="_Rm"]', xmlValue)
    
  }
}

#запись во фрейм
data <- data.frame(Year=years, Header = headers,  URL = urls
                   #, Sources = sources
)
data
#запись в файл .csv
write.csv(data, file = './TimelineEuro.csv', append = T, row.names = F)

print('Запись файла TimelineEuro.csv завершена')
