library(ggplot2)

for(i in 1:2) {
  infile <- paste("/home/DB/M.esculenta/VCF_V6/HB/block",i,".blocks.det", sep="")
  
  block <- read.csv(infile, sep="")
  
  y <- block[which(block[,4]>1),4]
  x <- block[which(block[,4]>1),2]
  z <- rep(i, length(y))
  
  data <- as.data.frame(x)
  data[,2] <- y
  data[,3] <- z
  colnames(data) <- c("position", "size", "chrom")
  
  a <- ggplot(data, aes(x=position, y=size, color=chrom)) + geom_point(shape=9)
  a
  
}


################################################################################################################################################

all <- read.table("/home/DB/M.esculenta/VCF_V6/HB/all.blocks", header=TRUE, quote="\"")

y<- all
y <- y[-(which(y[,1] == "CHR")),]

size <- y[,4]
num <- as.numeric(levels(size))[size]
cho <- which(num>1)
y <- y[cho,]

#how much of the genome does the haplotype blocks cover

sum(as.numeric(levels(y[,4]))[y[,4]])



#GRAPH ALL

p <- ggplot(y, aes(x=as.numeric(levels(BP1))[BP1], y=as.numeric(levels(KB))[KB])) 

p + geom_point(aes(color = factor(CHR))) +
  labs(title = "Haplotype Blocks") +
  theme(plot.title = element_text(size=20, face="bold", vjust=2)) +
  xlab("Position in chromosomes") +
  ylab("HB size in Kb") +
  labs(color = "CHR")

#GRAPH FOCU

p + geom_point(color="chartreuse4") +  ylim(0, 200) +
  labs(title = "Haplotype Blocks") +
  theme(plot.title = element_text(size=20, face="bold", vjust=2)) +
  xlab("Position in chromosomes") +
  ylab("HB size in Kb") +
  labs(color = "CHR")
                       
                       