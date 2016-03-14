library(ggplot2)
library(dplyr)
library(tidyr)
library(bitops)
library(igraph)
library(ips)
library(colorRamps)
library(plotrix)
library(gtable)
library(lattice)
library(verisr)


#source("http://bioconductor.org/biocLite.R")
#biocLite("Rgraphviz")

ggplot(fullExport, aes(fullExport$Source,fullExport$Protocol)) +
  geom_jitter()


p <- ggplot(pings, aes(pings$Source,pings$Destination))
p + geom_bin2d()


pingsGrouped <- group_by(pings, grepl("* request *",pings$Info))


pingsSet <- subset(pingsGrouped, pingsGrouped[ ,8] == TRUE, drop = TRUE)



ggplot(pingsSet, aes(pingsSet$Source,pingsSet$Destination)) +
  geom_bin2d() + 
  ylab("Destination IP's") + 
  xlab("IP Sending Request") +
  ggtitle("Ping Requests") 


p <- ggplot(rpc_filtered, aes(rpc_filtered$Destination, rpc_filtered$Protocol))
p + geom_jitter()




#########################


rpcLess <- read.csv('rpcLess.csv', header = TRUE)
rpc_filtered <- read.csv('rpc_filtered.csv', header = TRUE)


rpc_less <- select(rpcLess, Source, Destination, Length)
rpcScan <- subset(rpcLess, (Length < 1400))

newRpc <- select(rpc_filtered, Source, Destination, Length)


parallelplot(~newRpc[1:3] | Protocol, rpcScan, )




########################


summary(rcp_tn)


ggplot(attSrc, aes(Protocol, Source)) +
  geom_jitter() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


#########################

########################
#!dns && (ip.dst ==  172.16.115.20 || ip.dst ==  172.16.112.50 || ip.dst ==  172.16.112.10)
# rsh || telnet && (ip.addr ==  172.16.115.20 || ip.addr ==  172.16.112.50 || ip.addr ==  172.16.112.10) rsh || telnet && (ip.addr ==  172.16.115.20 || ip.addr ==  172.16.112.50 || ip.addr ==  172.16.112.10
# rsh || 513 && (ip.addr ==  172.16.115.20 || ip.addr ==  172.16.112.50 || ip.addr ==  172.16.112.10)
# tcp.port eq 514 || tcp.port eq 513 || rsh || telnet && (ip.addr ==  172.16.115.20 || ip.addr ==  172.16.112.50 || ip.addr ==  172.16.112.10)

summary(ripDns)


ggplot(tcp_trsh, aes(Source, Protocol)) +
  geom_jitter() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


#########################

attack <- getenum(packets, 'Protocol', add.n=TRUE, add.freq=TRUE)


ggplot(attack, aes(enum, x, group = 1, colour = x)) +
  geom_line(size=2.5) +
  geom_point(size=8) +
  stat_smooth(level=0.5) +
  scale_colour_gradient(high="red", low="blue") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

##########################

install.packages('quantreg')
install.packages('stat_quantile')













