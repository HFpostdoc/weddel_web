### Analysis of the Weddell Food Web

##

source('helpers.R')
library(enaR)

## Note: the database only provides the amounts of food consumed. 
## Also, information for the food web is provided in the doc folder.

## read in the data from U of Canberra's format
weddell <- read.web('../data/WEB342.csv')

## read in from EcoArchive
wed.ea <- readLines('../data/EcoArchive_weddell.csv')
wed.ea <- lapply(wed.ea,strsplit,split='\t')
wed.ea <- lapply(wed.ea,unlist)
head <- c('Food Web',head(wed.ea[[1]],length(wed.ea[[1]])-1))
wed.ea <- wed.ea[-1]
wed.ea <- do.call(rbind,wed.ea)
rown <- wed.ea[,1]
wed.ea <- wed.ea[,-1]
colnames(wed.ea) <- head
head(wed.ea)

wed.com <- unique(c(wed.ea[,'Taxonomy consumer'],wed.ea[,'Taxonomy resource']))
wed.net <- matrix(0,nrow=length(wed.com),ncol=length(wed.com))
rownames(wed.net) <- colnames(wed.net) <- wed.com

for (i in 1:nrow(wed.ea)){
    print(paste(i,'of',nrow(wed.ea),'records'))
    wed.net[rownames(wed.net) == wed.ea[i,'Taxonomy resource'],colnames(wed.net) == wed.ea[i,'Taxonomy consumer']] <- 1
    ## ## consumer body length as edges
    ## wed.net[rownames(wed.net) == wed.ea[i,'Taxonomy resource'],colnames(wed.net) == wed.ea[i,'Taxonomy consumer']] <- wed.ea[i,'Mean length (g) resource']
    ## ## consumer body mass as edges
    ## wed.net[rownames(wed.net) == wed.ea[i,'Taxonomy resource'],colnames(wed.net) == wed.ea[i,'Taxonomy consumer']] <- wed.ea[i,'Mean mass (g) resource']
}

## format as a network object
wed.jac <- pack(flow=wed.net) ## Jacob 2011
wed.hop <- pack(flow=weddell) ## Hopkins 1983

## conduct analyses
str.jac <- enaStructure(wed.jac)
str.hop <- enaStructure(wed.hop)

str.jac$ns
str.hop$ns

# Plot networks

plot(wed.jac)
plot(wed.hop)
