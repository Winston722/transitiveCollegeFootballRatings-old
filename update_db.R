library(RMySQL)

db_user <- 'winston722'
db_password <- readRDS("db_password.rds")
db_host <- "database-1.cluster-ro-cltluml8ryll.us-east-2.rds.amazonaws.com"
db_port <- 3306

con <-  dbConnect(MySQL(), user = db_user, password = db_password
                   , host = db_host, port = db_port)
dbSendQuery(con,"use transitive_ratings") %>% dbFetch()

ratings_error <- readRDS("ratings_error.rds")

##for creating the power_ratings table 
# dbWriteTable(con, "power_ratings", ratings_error, overwrite = TRUE, row.names = FALSE
#              , field.types = c(
#                team = "VARCHAR(255)"
#                , power_margin_rating = "double"
#                , fbs = "tinyint(1)"
#                , as_of_week = "integer"
#                , games_played = "integer"
#                , weighted_error = "double"))

dbWriteTable(con, "power_ratings", ratings_error
             , append = TRUE, overwrite = FALSE, row.names = FALSE)

