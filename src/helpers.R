
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
