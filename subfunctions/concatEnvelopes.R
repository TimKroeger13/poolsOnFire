concatEnvelopes = function(hoursingDestructured) {
  
  coordinates_X = NULL
  coordinates_Y = NULL
  clusterNumber = NULL
  
  dimension = length(hoursingDestructured[[1]])
  
  for(i in 1:dimension){
    
    x_cor = hoursingDestructured$list_X[i]
    y_cor = hoursingDestructured$list_Y[i]
    
    boundingBox = getBoundingBox(x_cor,y_cor)
    
    coordinates_X = c(coordinates_X,boundingBox[c(2:3)])
    coordinates_Y = c(coordinates_Y,boundingBox[c(4:5)])
    clusterNumber = c(clusterNumber,boundingBox[1],boundingBox[1])
    
    if(i %% 1000 == 0){cat('\n',i, '/',dimension)}
    
  }
  
  return(list(corX = coordinates_X, CorY = coordinates_Y, ClusN = clusterNumber))
  
}