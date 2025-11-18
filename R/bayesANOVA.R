#' Bayesian GASTURBINE ANOVA
#'
#' @returns plots and MCMC diagnostics
#' @export
#'
#' @examples
#' \dontrun{bayesANOVA()}
bayesANOVA <- function(){
  source(system.file("jags/LS13ANOVA/Jags-Ymet-Xnom1fac-MrobustHet-Lab12-GASTURBINE.R", package = "DSALS11"),local = TRUE)
}
