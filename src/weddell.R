### Analysis of the Weddell Food Web

##

source('helpers.R')
library(enaR)

## Note: the database only provides the amounts of food consumed. 
## Also, information for the food web is provided in the doc folder.

## read in the data from U of Canberra's format
weddell <- read.web('../data/WEB342.csv')

## format as a network object

wed.web <- pack(weddell)

## conduct analyses

enaStructure(wed.web)


