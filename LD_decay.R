out.hap <- read.delim("/run/user/1000/gvfs/sftp:host=128.253.192.28/home/DB/M.esculenta/Chr8/2014_markers/out.hap.ld", header=FALSE)
#out.hap <- read.delim("/home/DB/M.esculenta/Chr8/2014_markers/out.hap.ld", header=FALSE)
out.hap <- out.hap[-1,]

ldmatrix <-matrix(1, nrow= 2027091, ncol = 4)
ldmatrix[,1] <- as.character(out.hap[,2])
ldmatrix[,2] <- as.character(out.hap[,3])
ldmatrix[,3] <- as.character(out.hap[,5])
ldmatrix[,4] <- as.character(out.hap[,7])


distance <- (as.numeric(ldmatrix[,2]) -as.numeric(ldmatrix[,1]))/1000000
distance
LD.data <- as.numeric(ldmatrix[,3])
#For dprime
LD.data <- as.numeric(ldmatrix[,4])
n <- 1446


#R2
HW.st<-c(C=0.1)
HW.nonlinear<-nls(LD.data~((10+C*distance)/((2+C*distance)*(11+C*distance)))*(1+((3+C*distance)*(12+12*C*distance+(C*distance)^2))/(n*(2+C*distance)*(11+C*distance))),start=HW.st,control=nls.control(maxiter=100))
tt<-summary(HW.nonlinear)
new.rho<-tt$parameters[1]
fpoints<-((10+new.rho*distance)/((2+new.rho*distance)*(11+new.rho*distance)))*(1+((3+new.rho*distance)*(12+12*new.rho*distance+(new.rho*distance)^2))/(n*(2+new.rho*distance)*(11+new.rho*distance)))

#Di
LD.st<-c(b0=12.9)
distance.mb<-distance/1000000
LD.nonlinear<-nls(LD.data~(1-distance.mb)^b0,start=LD.st,control=nls.control(minFactor=1/1000000000,maxiter=100,warnOnly=T))
summ<-summary(LD.nonlinear)
param<-summ$parameters
beta0<-param["b0","Estimate"]
fpoints<-(1-distance.mb)^beta0

df<-data.frame(distance,fpoints)
maxld<-max(LD.data)
#You could eleucubrate if it's better to use the maximum ESTIMATED value of LD
#In that case you just set: maxld<-max(fpoints)
h.decay<-maxld/2
half.decay.distance<-df$distance[which.min(abs(df$fpoints-h.decay))]

ld.df<-data.frame(distance,fpoints)
ld.df<-ld.df[order(ld.df$distance),]
plot(distance,LD.data,pch=".",cex=0.9,col="black", xlim=c(0,0.002))
plot(distance,LD.data,pch=".",cex=0.9,col="black")
lines(ld.df$distance,ld.df$fpoints,lwd=3, col="blue")
?lines

