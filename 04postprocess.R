############### STE_wind_JU2003 ###############
### 04postprocess                           ###
### plot some comparison figures            ###
### Date: 2017-11-12                        ###
### By: xf                                  ###
###############################################

## header

## settings

## convert Ux.obs & Uy.obs into wspd.obs and wdir.obs
f.Ux.obs <- 'Ux_obs_PWIDS.csv'
f.Uy.obs <- 'Uy_obs_PWIDS.csv'
Ux.obs <- read.csv(f.Ux.obs, row.names = 1)
Uy.obs <- read.csv(f.Uy.obs, row.names = 1)
wspd.obs <- sqrt(Ux.obs^2 + Uy.obs^2)
wspd.obs.mean <- apply(wspd.obs, 2, mean, na.rm = TRUE)
wspd.obs.sd<- apply(wspd.obs, 2, sd, na.rm = TRUE)
wdir.obs <- atan(Ux.obs / Uy.obs) / pi * 180 + 180
wdir.obs.mean <- apply(wdir.obs, 2, mean, na.rm = TRUE)
wdir.obs.sd<- apply(wdir.obs, 2, sd, na.rm = TRUE)

## merge mcmc samples 
mcmc <- data.frame(wf.sim$BUGSoutput$sims.list)

## plot
# hists of dir 
hist( mcmc$wdir, 30, col=rgb(1,0,0,1/4), xlim=c(140,210), freq = FALSE)  # second
hist( wdir.obs[,14], 20, col=rgb(0,0,1,1/4), xlim=c(140,210), freq = FALSE, add=T, lty=2)  # first histogram

wdir.obs.downwind <- rnorm(12000, 176, 13.3/2) #GMT
# hist( wdir.obs.downwind, 20, col=rgb(0,1,0,1/4), xlim=c(130,220), freq = FALSE, add=T)
lines(density(wdir.obs[,14], adjust=2), col="blue", lwd=2, lty=2) 
 lines(density(wdir.obs.downwind, adjust=2), col="darkgreen", lwd=2,lty=4)
lines(density(mcmc$wdir, adjust=6),col="red", lwd=2)

# hists of speed

hist( wspd.obs[,14], 20, col=rgb(0,0,1,1/4), xlim=c(0, 12), ylim=c(0,0.6), freq = FALSE, lty=2)  # second
hist( mcmc$wspd, 20, col=rgb(1,0,0,1/4), xlim=c(0, 15), freq = FALSE,add=T)  # first histogram
lines(density(wspd.obs[,14], adjust=2), col="blue", lwd=2, lty=2) 
lines(density(mcmc$wspd, adjust=6),col="red", lwd=2)
 lines(c(6.925,6.925), c(-0.05,0.45), col='chartreuse4',lwd=3,lty=4) #GMT
