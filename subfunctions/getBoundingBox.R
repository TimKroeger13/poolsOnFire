getBoundingBox = function(x_cor,y_cor) {
  
  return(c(as.numeric(names(x_cor[1])),
           min(x_cor[[1]]),
           max(x_cor[[1]]),
           min(y_cor[[1]]),
           max(y_cor[[1]])))
}