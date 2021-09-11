date.time.append <- function(str, sep = '_', date.format ="%Y_%m_%d_%H_%M_%S") {
  stopifnot(is.character(str))
  return(paste(str, format(Sys.time(), date.format), sep = sep))  
}