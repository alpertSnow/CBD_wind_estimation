############### STE_wind_JU2003 ###############
### 07cCompare                              ###
### stats comaprisons of C.obs & C.pre      ###
### Date: 2018-05-06                        ###
### By: xf                                  ###
###############################################

mu.obs <- C.obs[,1]
mu.est <- wf.sim$BUGSoutput$mean$C
mu.pre <- t(C.pre[13,])[,1] # 172 degree

plot(mu.obs, type= 'l')
lines(mu.est, lty = 2, col = 'red')
lines(mu.pre, lty =2, col = 'blue')

thres <- 10 # detector limit
#n0 <- which(mu.obs < thres & mu.pre < thres) 
n.over <- which(mu.obs > thres | mu.pre > thres | mu.est > thres)
co <- mu.obs[n.over]
cp <- mu.est[n.over]
co <- pmax(co, thres)
cp <- pmax(cp, thres)

num <- length(co)
FB <- (mean(co-cp))/0.5/(mean(co)+mean(cp))
MG <- exp(mean(log(co))-mean(log(cp)))
NMSE <- mean((co-cp)^2)/mean(co)/mean(cp)
VG <- exp(mean((log(co)-log(cp))^2))
COR <- mean((co-mean(co))*(cp-mean(cp)))/sd(cp)/sd(co)
FAC2 <- sum(cp/co>=0.5 & cp/co<=2)/num
NAD <- (mean(abs(co-cp)))/(mean(co)+mean(cp))
IA <- 1 - sum( (co - cp)^2) / sum( ( abs(cp - mean(co)) + abs(co - mean(co)) )^2 )
print(data.frame(FB=FB,NMSE=NMSE,MG=MG,VG=VG,R=COR,FAC2=FAC2,NAD=NAD, IA=IA))
