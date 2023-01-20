rm(list=ls())
#libraries
library(DBI)
library(RSQLite)
library(rSOILWAT2)
library(plyr)
library(dplyr)
library(doParallel)
library(synchronicity)

# set up loop 
sqlite <- dbDriver("SQLite")
Period<-c("Late","Mid")
Site<-seq(1:40)

p<-"Mid"
  for (s in Site){
    print(s)
    database<-paste0("Output/Output_site_",s,".sqlite")
    mydb<-dbConnect(sqlite,database)
    biomass.out<-dbGetQuery(mydb,"SELECT * FROM Biomass")
    biomass.out$RCP<-ifelse(grepl("RCP85",biomass.out$GCM),"RCP85",
                            ifelse(grepl("RCP45",biomass.out$GCM),
                                   "RCP45","CURRENT"))
    biomass.out$GCM2<-ifelse(grepl("RCP85",biomass.out$GCM),gsub("RCP85.","",biomass.out$GCM),
                             ifelse(grepl("RCP45",biomass.out$GCM),
                                    gsub("RCP45.","",biomass.out$GCM),"CURRENT"))
    biomass.out$years<-p
    dbDisconnect(mydb)
    if ("biomass.all" %in% ls()){
      biomass.all<-rbind(biomass.all,biomass.out)
    } else {biomass.all<-biomass.out}
    
  }
#}

write.csv(biomass.all,paste0("collate.biomass.output.csv"))
#rm(biomass.all)

# 
# library(tidyverse)
# ggplot(biomass.all,aes(x=Year,y=sagebrush,col=RCP))+
#   geom_point(alpha=0.2)+
#   facet_grid(Functional~years)
# # ggplot(biomass.all,aes(x=Year,y=a.cool.grass,col=GCM2))+
# #   geom_point()+
# #   facet_grid(RCP~years,scales="free")
# ggplot(biomass.all,aes(x=Year,y=p.cool.grass,col=GCM2))+
#   geom_point()+
#   facet_grid(RCP~years)
# ggplot(biomass.all,aes(x=Year,y=p.warm.grass,col=GCM2))+
#   geom_point()+
#   facet_grid(RCP~years)
# ggplot(biomass.all,aes(x=Year,y=p.warm.grass,col=RCP))+
#   geom_point()+
#   facet_grid(Functional~years)
# ggplot(biomass.all,aes(x=Year,y=p.cool.grass,col=RCP))+
#   geom_point()+
#   facet_grid(Functional~years)
# ggplot(biomass.all,aes(x=Year,y=shrub,col=RCP))+
#   geom_point()+
#   facet_grid(Functional~years)
