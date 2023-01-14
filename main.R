### reset
rm(list = ls())
cat("\014")
setwd("V:/Tu_Konto/Geodesy/3_st/Project/Code/poolsOnFire")
#beep(sound = 8, expr = NULL)

loadAndCutData = FALSE #<-- when false stored R data gets loaded

### Load Packages

#install.packages('RPostgreSQL')
#install.packages('RPostgres')
#install.packages('stringr')
#install.packages("rjson")
#install.packages("beepr")

library(stringr)
library(RPostgreSQL)
library(RPostgres)
library(DBI)
library(rjson)
library(beepr)

### Get Source functions

source(file = paste(getwd(),"/","subfunctions/","stringDestructure.R",sep = ""))
source(file = paste(getwd(),"/","subfunctions/","getBoundingBox.R",sep = ""))
source(file = paste(getwd(),"/","subfunctions/","concatEnvelopes.R",sep = ""))

if (loadAndCutData){
  
  ### Connect to Database
  
  db <- "postgres"  #provide the name of your db
  
  host_db <- "localhost" #i.e. # i.e. 'ec2-54-83-201-96.compute-1.amazonaws.com'  
  
  db_port <- 5432  # or any other port specified by the DBA
  
  db_user <- "postgres"
  
  db_password <- toString(read.table("password.txt", header = F))
  
  con <- dbConnect(RPostgres::Postgres(), dbname = db, host=host_db, port=db_port, user=db_user, password=db_password)
  rm(db_password)
  
  ### Display Tables
  
  dbListTables(con)
  
  ### Request for Area Data
  
  fetchRequest = dbSendQuery(con,"SELECT id,
ST_AsGeoJSON(ST_Transform(geom, 4326),15,0)::json As geom,
bezeich
FROM
(SELECT * FROM nutzung_flaechen
WHERE bezeich = 'AX_Wohnbauflaeche'
OR bezeich = 'AX_FlaecheGemischterNutzung'
OR bezfkt = 'Kleingarten') AS secondtable
")
  housingArea = dbFetch(fetchRequest)
  dbClearResult(fetchRequest)
  
  ### Request Land Plot data
  
  fetchRequest = dbSendQuery(con,"SELECT id,ST_AsGeoJSON(ST_Transform(geom, 4326),15,0)::json As geom FROM (SELECT * FROM flurstuecke_flaechen) AS secondtable")
  LandArea = dbFetch(fetchRequest)
  dbClearResult(fetchRequest)
  
  ### Load in the Json to R
  
  hoursingDestructured = stringDestructure(completeJson = housingArea, column = 2)
  LandAreaDestructured = stringDestructure(completeJson = LandArea, column = 2)
  
  ### Concatenate the boundary data for the R-Tree
  
  hoursingEnvelopArrays = concatEnvelopes(hoursingDestructured)
  LandAreaEnvelopArrays = concatEnvelopes(LandAreaDestructured)
  
}else{
  
  ### Load from R-file
  
  load(paste(getwd(),"/Saves/HardSaves/","hoursingDestructured.RData",sep = ""))
  load(paste(getwd(),"/Saves/HardSaves/","LandAreaDestructured.RData",sep = ""))
  load(paste(getwd(),"/Saves/HardSaves/","hoursingEnvelopArrays.RData",sep = ""))
  load(paste(getwd(),"/Saves/HardSaves/","LandAreaEnvelopArrays.RData",sep = ""))
  
}








#work in progress

axis = 'y'
x_CoordinateVoctor = coordinates_X
Y_CoordinateVoctor = coordinates_Y
ClusterVector = clusterNumber


a = SplitArray(coordinates_X,coordinates_Y,clusterNumber,'y')
print(a$median)

b = SplitArray(a$lowerSlpit_X,a$lowerSlpit_Y,a$lowerCluster,'x')
print(b$median)

c = SplitArray(b$lowerSlpit_X,b$lowerSlpit_Y,b$lowerCluster,'y')
print(c$median)

















#Save
#setwd("V:/Tu_Konto/Geodesy/3_st/Project/Code/cover/Saves")
'
setwd("V:/Tu_Konto/Geodesy/3_st/Project/Code/cover/Saves/HardSaves")

save(hoursingDestructured, file=paste("hoursingDestructured",".RData",sep = ""))
save(LandAreaDestructured, file=paste("LandAreaDestructured",".RData",sep = ""))

save(hoursingEnvelopArrays, file=paste("hoursingEnvelopArrays",".RData",sep = ""))
save(LandAreaEnvelopArrays, file=paste("LandAreaEnvelopArrays",".RData",sep = ""))
'









'
#Plotting

number = 12

housingArealist_X[[number]]
housingArealist_Y[[number]]

max(housingArealist_X[[number]])
min(housingArealist_X[[number]])
max(housingArealist_Y[[number]])
min(housingArealist_Y[[number]])
clusterNumber = "getFromCluster"


plot(housingArealist_X[[number]], housingArealist_Y[[number]])
plot(housingArealist_X[[number]], housingArealist_Y[[number]], type = "o")
par(new=T)
plot(c(min(housingArealist_X[[number]]),max(housingArealist_X[[number]])),
     c(min(housingArealist_Y[[number]]),max(housingArealist_Y[[number]])),
     type = "o")












setwd("V:/Tu_Konto/Geodesy/3_st/Project/Code/cover")

write.table(housingArea,file = paste(getwd(),"/","housingArea",".json",sep=""),
            append = FALSE,na = "", sep = ";", row.names = F, col.names = F,quote = F)
'


















