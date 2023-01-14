SplitArray = function(x_CoordinateVoctor,Y_CoordinateVoctor, ClusterVector, axis) {
  
  if(axis == 'x'){
    saved_meadian = median(x_CoordinateVoctor)
    lowerBoundry = x_CoordinateVoctor < saved_meadian
    upperBoundry = x_CoordinateVoctor >= saved_meadian
  }
  
  if(axis == 'y'){
    saved_meadian = median(Y_CoordinateVoctor)
    lowerBoundry = Y_CoordinateVoctor < saved_meadian
    upperBoundry = Y_CoordinateVoctor >= saved_meadian
  }
  
  return(list(upperSlpit_X = x_CoordinateVoctor[upperBoundry], lowerSlpit_X = x_CoordinateVoctor[lowerBoundry],
              upperSlpit_Y = Y_CoordinateVoctor[upperBoundry], lowerSlpit_Y = Y_CoordinateVoctor[lowerBoundry],
              upperCluster = ClusterVector[upperBoundry], lowerCluster = ClusterVector[lowerBoundry],
              median = saved_meadian))
}


