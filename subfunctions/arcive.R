
#

install.packages("beepr")
library(beepr)
beep(sound = 8, expr = NULL)






DestructureStrings = function(completeJson) {
  
  list_X = list()
  list_Y = list()
  
  dimension=dim(completeJson)[1]
  
  for(i in 1:dimension){
    
    fullGeomjson = str_replace(str_replace(str_extract(housingArea[i,2], '\\[\\[\\[\\[.*]]]]'),'\\[\\[\\[',''),']]]','')
    
    x = as.numeric(str_replace(str_extract_all(fullGeomjson, '\\[[0-9]+\\.[0-9]+',simplify = T),'\\[',''))
    
    y = as.numeric(str_replace(str_extract_all(fullGeomjson, '[0-9]+\\.[0-9]+]',simplify = T),'\\]',''))
    
    list_X[[toString(housingArea[i,1])]] = x
    list_Y[[toString(housingArea[i,1])]] = y
    
    if(i %% 1000 == 0){cat('\n',i, '/',dimension)}
    
  }
  
  return(list_X = list_X, list_Y = list_Y)
}





#coordinates chain

coordinates_X = NULL
coordinates_Y = NULL
clusterNumber = NULL

for(i in 1:dim(housingArea)[1]){
  
  x_cor = housingArealist_X[i]
  y_cor = housingArealist_Y[i]
  
  boundingBox = getBoundingBox(x_cor,y_cor)
  
  coordinates_X = c(coordinates_X,boundingBox[c(2:3)])
  coordinates_Y = c(coordinates_Y,boundingBox[c(4:5)])
  
  clusterNumber = c(clusterNumber,boundingBox[1],boundingBox[1])
  
  
  
}






##pablo test data

PabloTestArea = cbind(
  hoursingDestructured$list_X[[24]],
  hoursingDestructured$list_Y[[24]]
)

colnames(PabloTestArea) = c("X","Y")

PabloTestBoundingBoxArea = cbind(
  envelopArrays$corX[47:48],
  envelopArrays$CorY[47:48],
  envelopArrays$ClusN[47:48]
)

colnames(PabloTestBoundingBoxArea) = c("X","Y","clusterNumber")

save(PabloTestArea, file=paste("PabloTestArea",".RData",sep = ""))
save(PabloTestBoundingBoxArea, file=paste("PabloTestBoundingBoxArea",".RData",sep = ""))


load("c:/Pablo/.../Pablos_cool_sub_directory/.../data.RData")
load("c:/Pablo/.../Pablos_cool_sub_directory/.../data.RData")
plot(PabloTestArea,type = "l")

#test
setwd("V:/Tu_Konto/Geodesy/3_st/Project/Code/cover/Saves")
save(housingArea, file=paste("housingArea",".RData",sep = ""))
save(LandArea, file=paste("LandArea",".RData",sep = ""))







stringDestructure = function(completeJson, column) {
  
  list_X = list()
  list_Y = list()
  
  dimension=dim(completeJson)[1]
  
  for(i in 1:dimension){
    
    subjson = fromJSON(completeJson[i,column])
    
    XY_matrix = matrix(NA,ncol = 2,nrow = length(subjson[[2]][[1]][[1]]))
    
    for(k in 1:length(subjson[[2]][[1]][[1]])){
      
      XY_matrix[k,] = subjson[[2]][[1]][[1]][[k]]
      
    }
    
    list_X[[toString(completeJson[i,1])]] = XY_matrix[,1]
    list_Y[[toString(completeJson[i,1])]] = XY_matrix[,2]
    
    if(i %% 1000 == 0){cat('\n',i, '/',dimension)}
    
  }
  
  return(list(list_X = list_X, list_Y = list_Y))
}













