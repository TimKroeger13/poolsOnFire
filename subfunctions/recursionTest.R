

createTree = function(lvl,leaf,depth) {
  
  lvl = lvl+1

  if (lvl <= depth){
    
    cat(paste("Level =",whitespace(lvl),lvl,"\n", sep=""))
    leaf = createTree(lvl,leaf,depth)
    leaf = createTree(lvl,leaf,depth)
    
    if (lvl == depth){
      
      leaf = leaf+1
      cat(paste(whitespace(depth),"       ","->Leaf = ",leaf,"\n", sep=""))
      
    }
  }
  
  invisible(leaf)

}

whitespace = function(spaces){
  
  sp = ""
  
  for (i in 1:spaces){
    
    sp = paste(sp," ", sep="")
    
  }
  
  return(sp)
  
}




leaf =  0
lvl = 0
depth = 5

createTree(lvl,leaf,depth)




































