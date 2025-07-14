#' @title My Paired 2 Sample Problem
#'
#' @description
#' This is a sample package to help in the making of functions using JAGS scripts
#' @param Data Data frame
#'
#'
#' @return Jags output
#' @export
#' @examples
#' \dontrun{mypaired(Data = ccts)}
#'
mypaired <- function(Data, var1 = "STANDARD",var2 = "HUFFMAN"){


  ys = Data[[var1]]  # The y values are in the column named ys.
  yn = Data[[var2]]

  Ntotal = length(yn)  # Only using the differences in y values (paired)
  y <- structure(c(ys,yn), .Dim=c(Ntotal,2))
  dataList = list(y = y, Ntotal = Ntotal)
  source(system.file("jags/JAGSUTILITIES/DBDA2E-utilities.R", package = "DSALS11"),local = TRUE)
  source(system.file("jags/LS11/Jags-PairedSampleScriptMV-wayne.R", package = "DSALS11"),local = TRUE)
}

