MKV.RCP45<-list.files("MarkovWeatherFiles/Site_2/RCP45/Late/",include.dirs=T)
MKV.RCP85<-list.files("MarkovWeatherFiles/Site_2/RCP85/Late/",include.dirs=T)
MKV.CURRENT<-list.files("MarkovWeatherFiles/Site_2/Current/Current/",include.dirs=T)
Sites<-seq(1:40)
GCM<-c(MKV.CURRENT,MKV.RCP45,MKV.RCP85)
GCM<-gsub("idem.dall.RCP45.","",GCM)
GCM<-gsub("idem.dall.RCP85.","",GCM)
GCM.all<-unique(GCM)
GCM.unique<-GCM.all[-which(GCM.all=="Current")]


for ( i in 1:40){
  print (paste0('Site_',i))
  MKV.RCP45<-list.files(paste0("MarkovWeatherFiles/Site_",i,"/RCP45/Late/"),include.dirs=T)
  MKV.RCP85<-list.files(paste0("MarkovWeatherFiles/Site_",i,"/RCP85/Late/"),include.dirs=T)
  MKV.CURRENT<-list.files(paste0("MarkovWeatherFiles/Site_",i,"/Current/Current/"),include.dirs=T)
  GCM4.s<-gsub("idem.dall.RCP45.","",MKV.RCP45)
  GCM8.s<-gsub("idem.dall.RCP85.","",MKV.RCP85)
  if (all(GCM.unique %in% GCM4.s)==F) {
    print(GCM.unique[which(!(GCM.unique %in% GCM4.s))])
  }
  if (all(GCM.unique %in% GCM8.s)==F) {
    print(GCM.unique[which(!(GCM.unique %in% GCM8.s))])
  }
}


GCM.use<-GCM.unique[-which(GCM.unique %in% c("bcc-csm1-1-m","BNU-ESM"))]
GCM.use<-c("Current",GCM.use)

#####
MKV.RCP45<-list.files("MarkovWeatherFiles/Site_2/RCP45/Late/",include.dirs=T)
MKV.RCP85<-list.files("MarkovWeatherFiles/Site_2/RCP85/Late/",include.dirs=T)
MKV.CURRENT<-list.files("MarkovWeatherFiles/Site_2/Current/Current/",include.dirs=T)
Sites<-seq(1:40)
GCM<-c(MKV.CURRENT,MKV.RCP45,MKV.RCP85)

GCM.use<-GCM[-which(GCM %in% grep("bcc-csm1-1-m|BNU-ESM",GCM,value=T))]
paste(GCM.use,collapse="','")
GCM<-c('Current','idem.dall.RCP45.bcc-csm1-1','idem.dall.RCP45.CanESM2',
'idem.dall.RCP45.CCSM4','idem.dall.RCP45.CNRM-CM5','idem.dall.RCP45.CSIRO-Mk3-6-0',
'idem.dall.RCP45.GFDL-ESM2G','idem.dall.RCP45.GFDL-ESM2M',
'idem.dall.RCP45.HadGEM2-CC365','idem.dall.RCP45.HadGEM2-ES365',
'idem.dall.RCP45.inmcm4','idem.dall.RCP45.IPSL-CM5A-LR','idem.dall.RCP45.IPSL-CM5A-MR',
'idem.dall.RCP45.IPSL-CM5B-LR','idem.dall.RCP45.MIROC-ESM',
'idem.dall.RCP45.MIROC-ESM-CHEM','idem.dall.RCP45.MIROC5','idem.dall.RCP45.MRI-CGCM3',
'idem.dall.RCP45.NorESM1-M','idem.dall.RCP85.bcc-csm1-1','idem.dall.RCP85.CanESM2',
'idem.dall.RCP85.CCSM4','idem.dall.RCP85.CNRM-CM5','idem.dall.RCP85.CSIRO-Mk3-6-0',
'idem.dall.RCP85.GFDL-ESM2G','idem.dall.RCP85.GFDL-ESM2M',
'idem.dall.RCP85.HadGEM2-CC365','idem.dall.RCP85.HadGEM2-ES365',
'idem.dall.RCP85.inmcm4','idem.dall.RCP85.IPSL-CM5A-LR',
'idem.dall.RCP85.IPSL-CM5A-MR','idem.dall.RCP85.IPSL-CM5B-LR',
'idem.dall.RCP85.MIROC-ESM','idem.dall.RCP85.MIROC-ESM-CHEM',
'idem.dall.RCP85.MIROC5','idem.dall.RCP85.MRI-CGCM3','idem.dall.RCP85.NorESM1-M')
