LDs <- read.delim("~/Desktop/Scripts/LD/LDs")

library(ggplot2)

p <- ggplot(LDs, aes(x=Mb, y=R2))
p + stat_smooth(aes(colour = factor(Chr), group = Chr), size =1.5, fill="grey70") + 
  geom_point(aes(colour = factor(Chr))) +
  ggtitle("LD bins in 4 chromosomes") +
  theme(plot.title= element_text(size=26, colour = "dodgerblue4", vjust=2, face ="bold")) +
  labs(x="Distance in Mb", y="Average pairwise r^2 of markers within each bin") +
  theme(axis.text=element_text(size=15, colour = "black"), axis.title=element_text(size=20, colour = "dodgerblue4", vjust=0.5)) 
 
  
  



