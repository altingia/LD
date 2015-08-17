library(ggplot2)

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
sum(as.numeric(levels(y[,5]))[y[,5]])

#histogram of haplotypes bigger than 50kb

a <- which(as.numeric(levels(y[,4]))[y[,4]]> 100)
b <-(y[a,4])
hist(as.numeric(levels(b))[b], xlab = "size (kb)", main ="HB size Distribution (higher than 100kb)", col="orange")

hist(as.numeric(levels(y[,4]))[y[,4]], xlab = "size (kb)", main ="HB size Distribution", col= "orange")

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

#extract a single chromsome

setwd("/home/DB/M.esculenta/VCF_V6/HB/")

for (i in 1:20){  

  num <- i
  selection <- which(y$CHR==num)
  subset <- y[selection,]

  g <- ggplot(subset, aes(x=as.numeric(levels(BP1))[BP1], y=as.numeric(levels(KB))[KB])) 
  
  chr <- g + geom_point(aes(size = as.numeric(levels(NSNPS))[NSNPS]), color= "chartreuse4")  +
      #scale_colour_gradient(low = "blue", limits = c(10,80)) +
      labs(title = paste("Haplotype Blocks Chromosome ",num)) +
      theme(plot.title = element_text(size=20, face="bold", vjust=2)) +
      xlab("Position in chromosomes") +
      ylab("HB size in Kb") +
      labs(size = "NSNPS")
  
  namef <- paste("chr",num,".pdf")
  ggsave(chr, file=namef)
 
                         
}    

