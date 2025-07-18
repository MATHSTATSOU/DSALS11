# Jags-ExampleScript.R
# Accompanies the book:
#   Kruschke, J. K. (2014). Doing Bayesian Data Analysis:
#   A Tutorial with R, JAGS, and Stan. 2nd Edition. Academic Press / Elsevier.

# Optional generic preliminaries:
#graphics.off() # This closes all of R's graphics windows.
#rm(list=ls())  # Careful! This clears all of R's memory!

# Load the functions used below:
#source("DBDA2E-utilities.R", local = TRUE) # Must be in R's current working directory.
require(rjags)               # Must have previously installed package rjags.

fileNameRoot="Jags-Paired-2sampleMV-Script" # For output file names.



# Define the model:
modelString = "
model {

for(i in 1:Ntotal){
  y[i,1:2]  ~  dmnorm(mu[],Omega[,]) # Multivariate Normal
}
  mu[1] ~ dnorm(0, pow(10,-3)) # independence priors low impact
  mu[2] ~ dnorm(0, pow(10,-3))

  mudiff <- mu[1] - mu[2] # What we are interested in

  Omega[1:2, 1:2] ~ dwish(R[,],3) # Wishart distribution

  R[1,1] <- 0.001
  R[1,2] <- 0
  R[2,1] <- 0
  R[2,2] <- 0.001

  Sigma2[1:2,1:2] <- inverse(Omega[,])
  rho <- Sigma2[1,2]/sqrt(Sigma2[1,1]*Sigma2[2,2])
}
" # close quote for modelString

#system.file("jags/LS11/Jags-PairedSampleScriptMV-wayne.R", package = "DSALS11")
writeLines( modelString , con="TEMPmodel.txt" )

#writeLines( modelString , con="TEMPmodel.txt" )

initsList <- list(mu = c(0,0),
                  Omega = structure(.Data = c(2,0,0,2),
                                    .Dim = c(2,2)))
# initsList <- function(){
#   resampleY <- sample(ydif, replace = TRUE)
#   muinit <- mean(resampleY)
#   sigmainit <- sd(resampleY)
#   return(list(mu = muinit, sigma = sigmainit))
# }
#
# # Run the chains:
jagsModel = jags.model( file="TEMPmodel.txt" ,
                        data=dataList ,
                        inits=initsList ,
                        n.chains=3 ,
                        n.adapt=500 )

update( jagsModel , n.iter=5000 )
codaSamples = coda.samples( jagsModel ,
                            variable.names=c("mu", "Omega", "Sigma2", "mudiff","rho") ,
                            n.iter=3334 )

save( codaSamples , file=paste0(fileNameRoot,"Mcmc.Rdata") )

# Examine the chains:
# Convergence diagnostics:
diagMCMC( codaObject=codaSamples , parName="mudiff" )

saveGraph( file=paste0(fileNameRoot,"PairedDiagmudiff") , type="bmp" )

diagMCMC( codaObject=codaSamples , parName="Sigma2[1,2]" )

saveGraph( file=paste0(fileNameRoot,"PairedDiagcov") , type="bmp" )
# Posterior descriptives:
openGraph(height=3,width=4)
par( mar = c(3.5,0.5,2.5,0.5) , mgp = c(2.25,0.7,0) )
plotPost( codaSamples[,"Sigma2[1,2]"] ,
          main= bquote(Sigma[12]) ,
          xlab=bquote(sigma[12]),
          credMass = 0.95, xlim = c(0,0.06) )

saveGraph( file=paste0(fileNameRoot,"PairedPostcov") , type="bmp" )
# # Re-plot with different annotations:
openGraph(height = 3, width = 5)
plotPost( codaSamples[,"mudiff"] ,
          main="Difference in means by Wayne" ,
          xlab=bquote(mu[S] - mu[H]) ,
          cenTend="mean" , compVal=0 ,
          ROPE=NULL ,
          credMass=0.95,
          col = rgb(0.5, 0.4,0, 0.5))

saveGraph( file=paste0(fileNameRoot,"PairedPost2") , type="bmp" )


openGraph(height = 3, width = 5)
plotPost( codaSamples[,"rho"] ,
          main="coefficient of correlation" ,
          xlab=bquote(rho) ,
          cenTend="mean" , compVal= 0 ,
          ROPE=NULL ,
          credMass=0.95 )

saveGraph( file=paste0(fileNameRoot,"PairedPostMVrho") , type="bmp" )


