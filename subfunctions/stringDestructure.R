stringDestructure = function(completeJson, column) {
  
  list_X = list()
  list_Y = list()
  
  dimension=dim(completeJson)[1]
  
  for(i in 1:dimension){
    
    subjson = fromJSON(completeJson[i,column])
    
    even_odd_mask = seq_len(length(unlist(subjson[[2]][[1]][[1]]))) %% 2
    
    list_X[[toString(completeJson[i,1])]] = unlist(subjson[[2]][[1]][[1]])[even_odd_mask==1]
    list_Y[[toString(completeJson[i,1])]] = unlist(subjson[[2]][[1]][[1]])[even_odd_mask==0]
    
    if(i %% 1000 == 0){cat('\n',i, '/',dimension)}
    
  }
  
  return(list(list_X = list_X, list_Y = list_Y))
}