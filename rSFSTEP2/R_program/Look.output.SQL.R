sqlite <- dbDriver("SQLite")
database<-"/Users/tem52/rSFSTEP2_ROB_setup/rSFSTEP2/R_program_1/Output_site_1.sqlite"
mydb<-dbConnect(sqlite,database)
## just some testing queries
dbListTables(mydb)
dbListFields(mydb, "Biomass")
dbGetQuery(mydb,"SELECT DISTINCT GCM FROM Biomass")
dbGetQuery(mydb,"SELECT sagebrush FROM Biomass WHERE GCM = Current")

# sites<-dbGetQuery(mydb, "SELECT DISTINCT Site_id FROM Sites")
# scenarios<-GCM
# dbscenarios<-dbGetQuery(mydb, "SELECT DISTINCT Scenario FROM Scenarios")
# dbscenarios$ID<-rownames(dbscenarios)
# dbscenarios2<-dbscenarios[which(dbscenarios$Scenario%in%scenarios),]
# dbListFields(mydb, "WeatherData")
# dbGetQuery(mydb, "SELECT * FROM Scenarios")
# dbGetQuery(mydb, "SELECT * FROM WeatherData ORDER BY wdid DESC LIMIT 10")
# dbGetQuery(mydb, "SELECT * FROM WeatherData LIMIT 10")