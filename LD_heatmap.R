install.packages("synbreed")
install.packages("BLR", repos="http://R-Forge.R-project.org")
install.packages("synbreed", repos="http://R-Forge.R-project.org")
library(synbreed)
library(grid)
data(maize)

geno <- read.table("/run/user/1000/gvfs/sftp:host=128.253.192.28/home/DB/M.esculenta/Chr8/2014_markers/2014.geno", header=TRUE, quote="\"")
geno <- read.table("/home/DB/M.esculenta/Chr8/2014_markers/2014.geno", header=TRUE, quote="\"")

geno <- geno[,-1]
rownames(geno) <- geno[,1]
geno <- geno[,-1:-5]
geno <- as.matrix(geno)

map <- read.delim("/run/user/1000/gvfs/sftp:host=128.253.192.28/home/DB/M.esculenta/Chr8/2014_markers/2014_markers.map", header=FALSE)
map <- read.delim("/home/DB/M.esculenta/Chr8/2014_markers/2014_markers.map", header=FALSE)
map <- map[,-3]
rownames(map) <- map[,2]
map <- map[,-2]
map <- as.data.frame(map)
colnames(map) <- c("chr", "pos")

write.table(geno, "/home/roberto/Desktop/table")
table1 <- read.table("~/Desktop/table1", header=TRUE, quote="\"")
geno_for <- table1
colnames(geno_for) <- colnames(geno)
rownames(geno_for) <- rownames(geno)

#getting things short
short <- geno_for[,(-1:-1600)]
short <- short[,(-350:-414)]
geno_for <- short

gp2 <- create.gpData(pheno = NULL, geno = geno_for, map = map, pedigree = NULL,
              family = NULL, covar = NULL, reorderMap = TRUE,
              map.unit = "bp", repeated = NULL, modCovar = NULL)

gp.coded <- codeGeno(gp2)

cassavaLD <- pairwiseLD(gp.coded, type="matrix")
LDMap(cassavaLD,gp.coded)

# LD for chr 1
cassavaLD <- pairwiseLD(gp.coded,chr=8, type="data.frame")
# scatterplot
LDDist(cassavaLD,type="p",pch=19,colD=hsv(alpha=0.1,v=0))

