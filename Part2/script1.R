library(ggplot2)
library(dplyr)
library(tidyr)
library(zoo)
library(TTR)
library(xts)
library(scales)
library(candlesticks)
library(quantmod)



head(ndaq)


ndaq$date <- as.Date(ndaq$date, "%Y/%m/%d")

ndaqMav <- SMA(ndaq$close, n=200)

ndaqMav5 <- SMA(ndaq$close, n=50)



ggplot(ndaq) +
  geom_line(aes(date, close, group=1, colour="Price")) +
  geom_line(aes(ndaq$date,ndaqMav, colour="200 Moving Day Average")) + 
  scale_color_manual(values=c("red", "black")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_x_date(breaks = date_breaks("6 months"), date_labels = "%Y - %m") +
  theme(legend.position = c(0.1,0.9)) + 
  ylab("Price in $ USD ") + 
  xlab("Date Y-M") +
  ggtitle("Historical Closing Price") 



#wilR <- (high - Close)/(Highest High - Lowest Low) * -100
#williams


getSymbols("NDAQ")

candleChart(NDAQ, theme='white',up.col='green',dn.col='red' , TA=c(addBBands()), yrange=c(15,45), subset='20081001::20081201')


barChart(NDAQ, TA=c(addWPR(),addVo()), subset='20130801::20131201')


