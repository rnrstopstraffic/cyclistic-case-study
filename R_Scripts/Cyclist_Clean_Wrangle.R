Packages <- c("tidyverse", "tidyr", "dplyr", "ggplot2", "lubridate")

lapply(Packages, library, character.only = TRUE)

df <- read.csv(file = './ann_cyc_data.csv')

# Convert started_at and ended_at columns to date-time type
df$start_dt <- ymd_hms(df$started_at)
df$end_dt <-ymd_hms(df$ended_at)

# Find and eliminate duplicate entries; the only ones were some strange copies of rides from one day
# in November 2020 that received alternate start dates in December 2020
dups <-df %>% 
  group_by(ride_id) %>%
  filter(n()>1)

id_dups <-unique(dups[c("ride_id")])

df <- df[!(df$ride_id %in% id_dups$ride_id) | (month(df$start_dt) != 12),]

# Extract started_at and ended_at columns into separate time and date information and create duration column

df$start_time <- format(df$start_dt, format = "%H:%M:%S")

df$end_time <- format(df$end_dt, format = "%H:%M:%S")

df$day <- wday(df$start_dt)

df$day_name <- wday(df$start_dt, label = TRUE, abbr = FALSE)

df$dur <- difftime(df$end_dt, df$start_dt, units = 'secs')

df$month_name <- month(df$start_dt, label = TRUE, abbr = FALSE)

df$month <- month(df$start_dt)

df$year <- year(df$start_dt)

df$start_date <- date(df$start_dt)

# Remove any rides lasting 60 seconds or less (this includes some incorrect records which show a negative ride duration)

df <- df[df$dur > 60,]

# Remove rides which started at HQ QR (these were for testing purposes)

df <- df[df$start_station_name != 'HQ QR',]

# Save as RDS for analysis

saveRDS(df, file = 'Cyclist_Clean.RDS')
