
### Read food webs from the Canberra Database format

read.web <- function(file,print.info=TRUE){
    x <- readLines(file)
    info <- x[1:2]
    x <- strsplit(x[-1:-2],split=',')
    flow <- do.call(rbind,x)
    rown <- flow[,1]
    flow <- flow[,-1]
    flow <- matrix(as.numeric(flow),nrow=length(rown))
    rownames(flow) <- colnames(flow) <- rown
    print(info)
    return(flow)
}

## ### enaPlot

## #' enaPlot  --- generate a network plot
## #' INPUT = network object
## #' OUTPUT = network plot
## #' M.K. Lau Jan 2016
## #' ---------------------------------------------------

## library(enaR)
## library(ggnet)
## library(ggplot2)
## library(enaR)
## library(igraph)
## library(Rgraphviz)
## library(intergraph)
## ## source("http://bioconductor.org/biocLite.R")
## ## biocLite("Rgraphviz")

## ## https://www.bioconductor.org/packages/3.3/bioc/vignettes/Rgraphviz/inst/doc/newRgraphvizInterface.pdf

## ### Rgraphviz

## enaPlot <- function(x){

##     ## node names

##     ## node scaling

##     ## flows 

##     ## inputs and outputs
##     y <- asIgraph(x);y <- as_graphnel(y)
##     ew <- as.character(round(unlist(edgeData(y,attr='flow')),2))
##     n.ew <- names(unlist(edgeData(y,attr='flow')))
##     n.ew <- sub('\\|','~',n.ew);names(ew) <- n.ew
##     eAttrs <- list();eAttrs$label <- ew
    
##     graph.par(list(edges=list(lty='solid',lwd=0.5,fontsize=10)))
##     y <- layoutGraph(y,edgeAttrs=eAttrs)
##     renderGraph(y,recipEdges='distinct')

## }

### convert 

edge2flow <- function(x){
    x[,1:2] <- apply(x[,1:2],2,as.character)
    x[,3] <- as.numeric(as.character(x[,3]))
    e.l <- unique(unlist(x[,1:2]))
    out <- matrix(0,nrow=length(e.l),ncol=length(e.l))
    rownames(out) <- colnames(out) <- e.l
    for (i in 1:nrow(x)){
        out[rownames(out) == x[i,1],colnames(out) == x[i,2]] <- x[i,3]
    }
    return(out)
}
