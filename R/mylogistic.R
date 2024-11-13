#' @title Logistic Regression
#'
#' @concept logistic
#'
#' @references JK Chapter 21
#'
#' @description This activates a JAGS script to analyze logistic data
#'
#' @param fname file name
#'
#' @param yname y name
#'
#' @param xname x name
#'
#'
#'
#' @return Jags output
#' @export
#' @examples
#' \dontrun{mylogistic()}
#'
mylogistic <- function(fname = "HtWtData110.csv",
                       yname = "male",
                       xname = "weight"){

  myData = utils::read.csv( file = system.file(paste0("jags/LS13/",fname), package = "DSALS11"))
  yName = yname ; xName = c(xname)
  fileNameRoot = "Logistic-"
  numSavedSteps=15000 ; thinSteps=2

  source(system.file("jags/LS13/Jags-Ydich-XmetMulti-Mlogistic-Example.R", package = "DSALS11"),local = TRUE)

}

