
sqlite <- dbDriver("SQLite")
mydb<-dbConnect(sqlite,database)
## just some testing queries
# dbListTables(mydb)
# dbListFields(mydb, "Sites")
sites<-dbGetQuery(mydb, "SELECT DISTINCT Site_id FROM Sites")
scenarios<-GCM
dbscenarios<-dbGetQuery(mydb, "SELECT DISTINCT Scenario FROM Scenarios")
dbscenarios$ID<-rownames(dbscenarios)
dbscenarios2<-dbscenarios[which(dbscenarios$Scenario%in%scenarios),]
# dbListFields(mydb, "WeatherData")
# dbGetQuery(mydb, "SELECT * FROM Scenarios")
# dbGetQuery(mydb, "SELECT * FROM WeatherData ORDER BY wdid DESC LIMIT 10")
# dbGetQuery(mydb, "SELECT * FROM WeatherData LIMIT 10")

#Check that it worked
#dbW_IsValid()

#Get a table of your site labels
#sites <- dbW_getSiteTable()

#Get a table of your scenarios
#scenarios <- dbW_getScenariosTable()
period<-list()
period[["Current"]]<-c(1980,2010) # from what I pulled from DayMet (and in this database) these are the available years
period[["historical"]]<-c(1985,2005) # from what I pulled from MACA availalbe years ar 1950-2005
period[["Mid"]]<-c(2030,2060) # what years we want for mid century
period[["Late"]]<-c(2070,2099) # what years we want for late century
periods<-c("Current","Mid") # here identify which periods you want to make .mkv files for

#RCP<-c("RCP45","RCP85")

#dir.create("Markov_Files")
sw_weatherLista<-list()
#sw_weatherList[[1]] <- NaN*seq(40)
#sw_weatherList[[i]]
# for each site
s<-site
#for ( s in sort(sites$Site_id)) {
print(s)
sw_weatherLista[[1]]<-paste0('Site_',s)
#for each scenario
#dir.create(paste0("Markov_Files/Site_",s))
#dir.create(paste0("Markov_Files/Site_",s,"/RCP45"))
#dir.create(paste0("Markov_Files/Site_",s,"/RCP85"))
#dir.create(paste0("Markov_Files/Site_",s,"/RCP45/Mid"))
#dir.create(paste0("Markov_Files/Site_",s,"/RCP45/Late"))
#dir.create(paste0("Markov_Files/Site_",s,"/RCP85/Mid"))
#dir.create(paste0("Markov_Files/Site_",s,"/RCP85/Late"))
#site_scenarios<-dbGetQuery(mydb, paste0("SELECT DISTINCT Scenario FROM WeatherData WHERE Site_id =",s))
site_scenarios<-dbGetQuery(mydb, paste0("SELECT DISTINCT Scenario FROM WeatherData WHERE Site_id =",s))
#site_scenarios<-temp
for ( c in dbscenarios2$ID) {
  
  for (p in periods){
    
    scen<-dbscenarios2$Scenario[which(dbscenarios2$ID==c)]
    # if "Current" is not in the periods we want to run, next
    if (scen=="Current" & !(scen %in% periods)) {next}
    # if "historical" is not in the periods we want to run, next
    if (grepl("historical",scen)) {
      if(!("historical" %in% periods)){next}
    }
    
    if(scen=="Current" & p=="Mid"){ next}
    if(scen=="Current" & p=="Late"){ next}
    if(grepl("historical",scen)&p=="Mid"){next}
    if(grepl("historical",scen)&p=="Late"){next}
    
    # 
    # if(scen=="Current"){
    #   dir.create(paste0("Markov_Files/Site_",s,"/Current"))
    #   dir.create(paste0("Markov_Files/Site_",s,"/Current/Current"))
    #   #dir.create(paste0("Markov_Files/Site_",s,"/Current/Current/Current"))
    # }
    # if(grepl("historical",scen)){
    #   dir.create(paste0("Markov_Files/Site_",s,"/historical",))
    #   dir.create(paste0("Markov_Files/Site_",s,"/historical/historical",))
    #   #dir.create(paste0("Markov_Files/Site_",s,"/historical/historical/historical",))
    # }
    # 
    
    # we cannot have both RCP and Current/historical
    if(grepl("RCP45",scen)&p=="Current") {next}
    if(grepl("RCP85",scen)&p=="Current") {next}
    if(grepl("RCP45",scen)&p=="historical") {next}
    if(grepl("RCP85",scen)&p=="historical") {next}
    
    # query the database
    #if (sc %in% site_scenarios$Scenario) {
    
    query<-paste0("SELECT data FROM WeatherData WHERE Site_id =",s,"  AND Scenario = ",c)
    myblob<-dbGetQuery(mydb,query)
    mysite<-unserialize(memDecompress(myblob$data[[1]], type = "gzip"))
    
    # identify the years I want
    years<-period[[p]]
    year.seq<-seq(years[1],years[2])
    
    # extrct the weather data for just the years I want 
    years.want<-mysite[match(year.seq,names(mysite))]
    print(paste0("Site_",s,"Scenario_",c))
    
    sw_weatherLista[[1]][paste0(scen)]<-NA
    sw_weatherLista[[1]][paste0(scen)]<-years.want
    sw_weatherLista[[1]][[paste0(scen)]]<-years.want
    
    
    # mfs <- dbW_estimate_WGen_coefs(years.want, imputation_type = "mean", imputation_span = 5)
    # 
    # # clean names for the Markov files
    # names(mfs[[1]])[1] <- paste0("#", names(mfs[[1]])[1])
    # names(mfs[[2]])[1] <- paste0("#", names(mfs[[2]])[1])
    # 
    # if(grepl("RCP45",scen)){
    #   direct<-"RCP45"
    #   #per<-p
    #   #dir.create(paste0("Markov_Files/Site_",s,"/RCP45/Mid/",scen))
    #   #dir.create(paste0("Markov_Files/Site_",s,"/RCP45/Late/",scen))
    #   dir.create(paste0("Markov_Files/Site_",s,"/RCP45/",p,"/",scen))
    # }
    # if(grepl("RCP85",scen)){
    #   dir.create(paste0("Markov_Files/Site_",s,"/RCP85/",p,"/",scen))
    #   #dir.create(paste0("Markov_Files/Site_",s,"/RCP85/Late/",scen))
    #   direct<-"RCP85"
    #   #per<-p
    # }
    # if(grepl("historical",scen)){
    #   direct<-"historical"
    #   dir.create(paste0("Markov_Files/Site_",s,"/historical/",p,"/",scen))
    #   #per<-"historical"
    # }
    # if(grepl("Current",scen)){
    #   direct<-"Current"
    #   dir.create(paste0("Markov_Files/Site_",s,"/Current/",p,"/",scen))
    #   #per<-"Current"
    # }
    # #Write tables for each markov file
    # 
    # #dir.create(paste0("Markov_Files/Site_",s,"/RCP45/Mid/",scen))
    # #dir.create(paste0("Markov_Files/Site_",s,"/RCP45/Late/",scen))
    # #dir.create(paste0("Markov_Files/Site_",s,"/RCP85/Mid/",scen))
    # #dir.create(paste0("Markov_Files/Site_",s,"/RCP85/Late/",scen))
    # 
    # markov_covar_file<-paste0("Markov_Files/Site_",s,"/",direct,"/",p,"/",scen,"/mkv_covar.in")
    # markov_prob_file<-paste0("Markov_Files/Site_",s,"/",direct,"/",p,"/",scen,"/mkv_prob.in")
    # write.table(format(mfs[[1]], digits = 6), markov_covar_file, quote = FALSE, row.names = FALSE)
    # write.table(format(mfs[[2]], digits = 6), markov_prob_file, quote = FALSE, row.names = FALSE)
    # 
    # 
    
    #     } else {next} # end check for scenario in scenarios list for the site
  }  # end for each period
}# end for each scenario
#}# end for each site

sw_weatherList2<-sw_weatherLista
sw_weatherList<-sw_weatherList2
