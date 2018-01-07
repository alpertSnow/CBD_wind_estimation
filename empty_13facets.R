############### STE_wind_JU2003 ###############
### empty-facets                            ###
### 13 empty facets made by lattice         ###
### Date: 2018-01-07                        ###
### By: xf                                  ###
###############################################

## header
library(lattice)

## settings

data <- as.data.frame(cbind(x=rep(0,13),y=rep(0,13),z=c('01','02','03','04','05','06','07','08','09','10','11','12','13')))
xyplot( x~y| z, data=data, xlim=c(-6,6),ylim=c(-6,6), aspect = 1, xlab = 'Ux (m/s)', ylab = 'Uy (m/s)',
        scales=list(x=list(at=seq(-6,6,3)),y=list(at=seq(-6,6,3))))
 