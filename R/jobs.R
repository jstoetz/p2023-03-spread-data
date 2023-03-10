library(tidyverse)

# set the url for the csv file
p_tpt_address <- 'https://www.thepredictiontracker.com/ncaapredictions.csv'

# create a file path and name with the timestamp for the csv file
p_csv_file <- paste(Sys.Date(), "ncaa-predictions.csv", sep="-")

# download the file and save it to the raw-data directory
#download.file(p_tpt_address, paste("raw-data", p_csv_file, sep="/"))

# read the file
df_tpt_file <- read_csv(p_tpt_address)

# create the data table
df_avg <-
  df_tpt_file %>%
  select(road,home,lineopen, lineavg, line, linemedian, phcover, phwin) %>%
  mutate(diff = lineavg-line) %>%
  arrange(desc(diff))

df_avg <-
  df_avg %>%
  mutate(
    my_pred = ifelse(lineavg > line, home, road),
    my_pred_id = ifelse(lineavg > line, "home", "road"),
    my_abs_diff = abs(diff)) %>%
  arrange(desc(my_abs_diff))

# save the original data (downloaded from url)
#write.csv(df_tpt_file, paste0("raw-data/", paste(Sys.Date(),"raw-ncaa-predictions.csv", sep="-")))

# save the data table
#write.csv(df_avg, paste("data", paste(Sys.Date(),"ncaa-predictions.csv", sep="-"), sep = "/"))

write_csv(df_avg, file = paste("data", paste(Sys.Date(),"ncaa-predictions.csv", sep="-"), sep = "/"))