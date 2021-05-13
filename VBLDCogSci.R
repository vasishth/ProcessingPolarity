##              Processing Polarity:
## How the grammatical intrudes on the ungrammatical
##      Vasishth, Bruessow, Lewis, Drenhaus
##   Code by Shravan Vasishth, with much advice and assistance from Reinhold Kliegl

## For questions, contact vasishth@acm.org Note: This is a *simplified* R
## file; the actual analyses involved a great of other analysis.  The
## full analysis file is available from the first author. The purpose
## of the present file is simply to allow readers to reproduce and
## understand the key analyses carried out in the paper. as background
## reading, Gelman and Hill's book is highly recommended: http://www.stat.columbia.edu/~gelman/arm/

# The article this code appears with:
## @Article{VBLD07,
##   author = 	 {Shravan Vasishth and Sven Bruessow and Richard L. Lewis and Heiner Drenhaus},
##   title = 	 {Processing Polarity: {H}ow the ungrammatical intrudes on the grammatical},
##   journal = 	 {Cognitive Science},
##   year = 	 {2007 (accepted)},
##   OPTkey = 	 {},
##   OPTvolume = 	 {},
##   OPTnumber = 	 {},
##   OPTpages = 	 {},
##   OPTmonth = 	 {},
##   OPTnote = 	 {},
##   OPTannote = 	 {}
## }

## function for computing 95% confidence intervals
ci <- function (scores){
m <- mean(scores)
stderr <- se(scores)
len <- length(scores)
upper <- m + qt(.975, df=len-1) * stderr 
lower <- m + qt(.025, df=len-1) * stderr 
return(data.frame(lower=lower,upper=upper))
}

# Load libraries:
library(reshape)
library(lme4)
library(car)
library(coda)
library(Hmisc)
library(gplots)
library(lattice)

# Load data
load("polaritydata.Rda")

## exercise 4:
exercise4<-subset(d.rs,condition%in%c("a","b","c") & times=="RRT")

exercise4<-exercise4[,c(1,2,9,11)]

write.table(exercise4,file="exercise4.txt")

## remove values less than 50ms
d.rs <- subset(d.rs,value>50)

## compute means and 95% CIs
means.sfd <- cast(d.rs, condition ~ ., function(x) c(M=round(mean(x)), ci=round(ci(x)) ), subset=times=="SFD")
means.ffd <- cast(d.rs, condition ~ ., function(x) c(M=round(mean(x)), ci=round(ci(x)) ), subset=times=="fpFFD")
means.fprt <- cast(d.rs, condition ~ ., function(x) c(M=round(mean(x)), ci=round(ci(x)) ), subset=times=="FPRT")
means.rbrt <- cast(d.rs, condition ~ ., function(x) c(M=round(mean(x)), ci=round(ci(x)) ), subset=times=="RBRT")
means.rrt <- cast(d.rs, condition ~ ., function(x) c(M=round(mean(x)), ci=round(ci(x)) ), subset=times=="RRT")

means.rrtold <- cast(subset(d.rs,value>50), condition ~ ., function(x) c(M=round(mean(x)), ci=round(ci(x)) ), subset=times=="RRT")

means.rpd <- cast(d.rs, condition ~ ., function(x) c(M=round(mean(x)), ci=round(ci(x)) ), subset=times=="RPD")
means.trt <- cast(d.rs, condition ~ ., function(x) c(M=round(mean(x)), ci=round(ci(x)) ), subset=times=="TFT")

## Basic analyses:
summary(sfd <- lmer(value ~ c1+c2+c3+c4+c5 + (1|subject) + (1|item),
                    data=d.rs,  subset=times=="SFD",
                    control=list(gradient=FALSE,
                      niterEM=0, maxIter=200,
                      msVerbose=F,
                      EMverbose=F ) ))

summary(rbrt <- lmer(value ~ c1+c2+c3+c4+c5 + (1|subject) + (1|item),
                   data=d.rs, subset=times=="RBRT",
                   control=list(gradient=TRUE, niterEM=0,
                   maxIter=200, msVerbose=F, EMverbose=F ) ))

qq.plot(resid(rbrt))

## Note that c3 is no longer significant; but the sign of the coefficient does not change
summary(rbrt.log <- lmer(log(value) ~ c1+c2+c3+c4+c5 + (1|subject) + (1|item),
                   data=d.rs, subset=times=="RBRT",
                   control=list(gradient=TRUE, niterEM=0,
                   maxIter=200, msVerbose=F, EMverbose=F ) ))

qq.plot(resid(rbrt.log))


## compute HPD intervals:
rbrt.mc <- mcmcsamp(rbrt,50000)
HPDinterval(rbrt.mc)

summary(rpd<- lmer(value ~ c1+c2+c3+c4+c5 + (1|subject) + (1|item),
                   data=d.rs,  subset=times=="RPD",
                   control=list(gradient=FALSE, niterEM=0, maxIter=200, msVerbose=F, EMverbose=F ) ))

qq.plot(resid(rpd))

summary(rpd.log <- lmer(log(value) ~ c1+c2+c3+c4+c5 + (1|subject) + (1|item),
                   data=d.rs,  subset=times=="RPD",
                   control=list(gradient=FALSE, niterEM=0, maxIter=200, msVerbose=F, EMverbose=F ) ))

qq.plot(resid(rpd.log))

mc.rpd <- mcmcsamp(rpd,50000)
HPDinterval(mc.rpd)

summary(rrt<- lmer(value ~ c1+c2+c3+c4+c5 + (1|subject) + (1|item),  data=d.rs,  subset=times=="RRT",
                   control=list(gradient=FALSE, niterEM=0, maxIter=200, msVerbose=F, EMverbose=F ) ))

qq.plot(resid(rrt))

summary(rrt.log <- lmer(log(value) ~ c1+c2+c3+c4+c5 + (1|subject) + (1|item),  data=d.rs,  subset=times=="RRT",
                   method="ML",
                   control=list(gradient=FALSE, niterEM=0, maxIter=200, msVerbose=F, EMverbose=F ) ))

qq.plot(resid(rrt.log))

mc.rrt <- mcmcsamp(rrt,50000)

HPDinterval(mc.rrt)

## Not used in paper since RRT measures pretty much give us all information that TRT does:
summary(tft<- lmer(value ~ c1+c2+c3+c4+c5 + (1|subject) + (1|item),  data=d.rs,  subset=times=="TFT",
                   control=list(gradient=FALSE, niterEM=0, maxIter=200, msVerbose=F, EMverbose=F ) ))

## graphs

# Data
load("alldatapos9.Rda") ## means

# Model
# Naming convention: model-latencyfactor-noise
model4615 <- c(420, 644,688,636,424,421)
model4630 <- c(463, 620, 699, 630, 469, 430)
model4645 <- c(482, 602,679, 580,491,441)

model1415 <- c(181, 235, 250, 234, 182, 181)
model1430 <- c(185, 232, 250, 228, 152,182)
model1445 <- c(192, 224,260,228,197,187)

allmodel <- rbind(model4615,model4630,model4645,model1415,model1430,model1445)

# fits, Latency factor 0.46:
rownum <- 1
fitted.rbrt.n15 <- fitted(rbrt.lm.n15 <- lm(alldatapos9[1,]~allmodel[rownum,]))
fitted.rpd.n15 <- fitted(rpd.lm.n15 <- lm(alldatapos9[2,]~allmodel[rownum,]))
fitted.rrt.n15 <- fitted(rrt.lm.n15 <- lm(alldatapos9[3,]~allmodel[rownum,]))

summary(rbrt.lm.n15)
summary(rpd.lm.n15)
summary(rrt.lm.n15)

rownum <- 2
fitted.rbrt.n30 <- fitted(rbrt.lm.n30 <- lm(alldatapos9[1,]~allmodel[rownum,]))
fitted.rpd.n30 <- fitted(rpd.lm.n30 <- lm(alldatapos9[2,]~allmodel[rownum,]))
fitted.rrt.n30 <- fitted(rrt.lm.n30 <- lm(alldatapos9[3,]~allmodel[rownum,]))

## These are the values used in the paper:
rownum <- 3
fitted.rbrt <- fitted.rbrt.n45 <- fitted(rbrt.lm.n45 <- lm(alldatapos9[1,]~allmodel[rownum,]))
fitted.rpd <- fitted.rpd.n45 <- fitted(rpd.lm.n45 <- lm(alldatapos9[2,]~allmodel[rownum,]))
fitted.rrt <- fitted.rrt.n45 <- fitted(rrt.lm.n45 <- lm(alldatapos9[3,]~allmodel[rownum,]))

summary(rrt.lm.n45)
summary(rbrt.lm.n45)
summary(rpd.lm.n45)

## function for printing PostScript graph
createPS <- function(filename){
postscript(file=filename,
           paper="a4",
           horizontal= TRUE,
           family="Times",
           pointsize=10)     
}

createPS("rrtmodeldata.ps")

createPS("modeldata.ps")

multiplot(3,1)

matplot(alldatapos9[3,],type="l",lwd=3,lty=c(1),col="black",
        ylim=range(300,800),xaxt="n",cex.axis=2,ylab="",
        main="Re-reading time",
        xlab="Conditions",cex.main=3,cex.lab=2.5)
points(alldatapos9[3,],pch=20,cex=2)
lines(fitted.rrt,lwd=2,lty=2)
points(fitted.rrt,pch=7,cex=2)  #7,8,9,10,11,13

margintext("RTs/Retrieval latencies [ms]")
mtext(letters[1:6],side=1,at=1:6,line=1,cex=2.5)

legend(list(x=6,y=750),
        legend = c("Data","Model"),
       lty=c(1,2),
       pch=c(20,7),
       lwd=2,
        cex=1.6,     #magnification of legend
        xjust=1,
        yjust=1,
        merge=TRUE,horiz=FALSE)

dev.off()

createPS("rbrtmodeldata.ps")

matplot(alldatapos9[1,],type="l",lwd=3,lty=c(1),col="black",
        ylim=range(250,450),xaxt="n",cex.axis=2,ylab="",
        main="Right-bounded reading time",
        xlab="Conditions",cex.main=3,cex.lab=2)
points(alldatapos9[1,],pch=20,cex=2)
lines(fitted.rbrt,lwd=2,lty=2)
points(fitted.rbrt,pch=7,cex=2)  #7,8,9,10,11,13

margintext("RTs/Retrieval latencies [ms]")
mtext(letters[1:6],side=1,at=1:6,line=1,cex=2.5)

legend(list(x=6,y=400),
        legend = c("Data","Model"),
       lty=c(1,2),
       pch=c(20,7),
       lwd=2,
        cex=1.6,     #magnification of legend
        xjust=1,
        yjust=1,
        merge=TRUE,horiz=FALSE)#, trace=TRUE)

dev.off()

createPS("rpdmodeldata.ps")

matplot(alldatapos9[2,],type="l",lwd=3,lty=c(1),col="black",
        ylim=range(300,900),xaxt="n",cex.axis=2,ylab="",
        main="Regression path duration",
        xlab="Conditions",cex.main=3,cex.lab=2)
points(alldatapos9[2,],pch=21,cex=2,bg="black")
lines(fitted.rpd,lwd=2,lty=2)
points(fitted.rpd,pch=7,cex=2)  #7,8,9,10,11,13
#mtext(letters[1:6],side=1,at=1:6,line=1,cex=2)
close.screen(all = TRUE)    # exit split-screen mode

margintext("RTs/Retrieval latencies [ms]")
mtext(letters[1:6],side=1,at=1:6,line=1,cex=2.5)

legend(list(x=6,y=800),
        legend = c("Data","Model"),
       lty=c(1,2),
       pch=c(20,7),
       lwd=2,
        cex=1.6,     #magnification of legend
        xjust=1,
        yjust=1,
        merge=TRUE,horiz=FALSE)#, trace=TRUE)

dev.off()
