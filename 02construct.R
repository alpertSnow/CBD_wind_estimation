############### STE_wind_JU2003 ###############
### 02construct                             ###
### construct wind finder BUGS/JAGS model   ###
### Date: 2017-11-11                        ###
### By: xf                                  ###
###############################################

library(R2WinBUGS)
windfinder <- function(){
        # likelihood
        for(i in 1:n.valid.U){
                wspd.x[i] <- Ux.map[i.wdir, i] * rel.wspd
                wspd.y[i] <- Uy.map[i.wdir, i] * rel.wspd
                wspd.var[i] <- 2/3 * k.map[i.wdir, i] * rel.wspd^2
                # (2,13) ~ (2,13), (2,2,13)
                U.cov.array[1, 2, i] <- U.cov.obs.array[1,2,i]
                U.cov.array[2, 1, i] <- U.cov.obs.array[2,1,i]
                U.cov.array[1, 1, i] <- U.cov.obs.array[1,1,i] + wspd.var[i]
                U.cov.array[2, 2, i] <- U.cov.obs.array[2,2,i] + wspd.var[i]
                U.T.array[1:2,1:2,i] <- inverse(U.cov.array[,,i])
                U.mu[, i] ~ dmnorm(c(wspd.x[i], wspd.y[i]), U.T.array[,,i]/2) # 3 for 6:00 GMT
        }
        wspd <- rel.wspd * U.ref
        wdir <- wdirs[i.wdir]
        # prior
        # wind direction
        Mwdir ~ dcat(p.wdir)
        i.wdir <- wdir.Cat[Mwdir]
        # wind speed
        log.rel.wspd ~ dunif(logWspdLower, logWspdUpper)
        rel.wspd <- 10^log.rel.wspd
        # rel.wspd ~ dunif(0,10)
        
        # concentration prediction
        C <- C.pre[i.wdir,] / rel.wspd * 0.5
}
wf.path <- file.path(getwd(), 'windfinder.bug')
write.model(windfinder, wf.path)