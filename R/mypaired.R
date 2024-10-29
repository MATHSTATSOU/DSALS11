#' My Paired 2 Sample Problem
#'
#' @return Jags output
#' @export
#'
#' @examples
#' \dontrun{mypaired(Data)}
mypaired <- function(Data){


  ys = Data$STANDARD        # The y values are in the column named ys.
  yn = Data$HUFFMAN

  Ntotal = length(yn)  # Only using the differences in y values (paired)
  y <- structure(c(ys,yn), .Dim=c(Ntotal,2))


  dataList = list(y = y, Ntotal = Ntotal)

  source(system.file("jags/LS11/Jags-PairedSampleScriptMV-wayne.R", package = "DSALS11"),local = TRUE)
}

