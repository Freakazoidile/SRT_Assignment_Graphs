library(bitops)
library(ggplot2)
library(igraph)
library(tidyr)
library(dplyr)
library(ips)
library(igraph)



ip2long <- function(ip){
  # convert string into vector of characters
  ips <- unlist(strsplit(ip, '.', fixed=TRUE))
  # set up a function to bit-shift, then "OR" the octets
  octet <- function(x,y) bitOr(bitShiftL(x, 8), y)
  # Reduce applys a function cumulatively left to right
  Reduce(octet, as.integer(ips))
}


long2ip <- function(longip) {
  # set up reversing bit manipulation
  octet <- function(nbits) bitAnd(bitShiftR(longip, nbits), 0xFF)
  # Map applys a function to each element of the argument
  # paste converts arguments to character and concatenates them
  paste(Map(octet, c(24,16,8,0)), sep="", collapse=".")
}


long2ip(ip2long("192.168.0.0"))


# Listing 4-2
# requires packages: bitops
# requires all objects from 4-1
# Define function to test for IP CIDR membership
# take an IP address (string) and a CIDR (string) and
# return whether the given IP address is in the CIDR range
ip.is.in.cidr <- function(ip, cidr) {
  long.ip <- ip2long(ip)
  cidr.parts <- unlist(strsplit(cidr, "/"))
  cidr.range <- ip2long(cidr.parts[1])
  cidr.mask <- bitShiftL(bitFlip(0),
                         (32-as.integer(cidr.parts[2])))
  return(bitAnd(long.ip, cidr.mask) == bitAnd(cidr.range,
                                              cidr.mask))
}


ip.is.in.cidr(pings$Destination, "172.16.113.0/24")

ip.is.in.cidr("10.0.1.15","10.0.2.255/24")




boxplot(pings)

??boxplots


######################


## PART 1. the scan. try and create a tree graph connection IP that scanned to IP that replied up and down and link nodes


p <- ggplot(packets, aes(Destination, Protocol))
p + geom_point()



summary(pings)
ips <- gather(pings, ips, Source, Destination)

uniqueIps <- unique(ips)
summary(ips)
summary(uniqueIps)


setwd("E:/Documents/School/Winter2016/srt411/assignment1/pt3/")
load("termDocMatrix.rdata")
termDocMatrix[termDocMatrix>=1] <- 1
termMatrix <- termDocMatrix %*% t(termDocMatrix)


g <- graph.adjacency(termMatrix, weighted=T, mode="undirected")
g <- simplify(g)
V(g)$label <- V(g)$name
V(g)$degree <- degree(g)
set.seed(3952)
layout1 <- layout.fruchterman.reingold(g)
plot(g, layout=layout1)


ipOnly <- select(pings, Source, Destination)

ipMatrix <- data.matrix(ipOnly)


g <- graph.adjacency(ipMatrix, weighted=T, mode="undirected")
g <- simplify(g)
V(g)$label <- V(g)$name
V(g)$degree <- degree(g)
set.seed(3952)
layout1 <- layout.fruchterman.reingold(g)
plot(g, layout=layout1)




################################################################

























