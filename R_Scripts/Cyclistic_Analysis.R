Packages <- c("tidyverse", "tidyr", "dplyr", "ggplot2")

lapply(Packages, library, character.only = TRUE)

df <- readRDS('Cyclist_Clean.RDS')

dir.create('R_images', showWarnings = FALSE)


# Plot rides by month and user type 

count_type_month <- df %>% count(month_name, member_casual)

month_type_plot <- ggplot(count_type_month, aes(x=month_name, y=n, fill=member_casual)) +
  geom_bar(stat='identity', position='dodge') + 
  labs(title = 'Rides by Month and User Type', x = 'Month', y = 'Rides', fill = "Rider Type")
  
ggsave('./R_images/month_user.png')

# Plot proportion of rides each month by user type
prop_type_month <- group_by(count_type_month, month_name) %>% mutate(prop = n/sum(n))

month_type_prop_plot <- ggplot(prop_type_month, aes(x=month_name, y=prop, fill=member_casual)) +
  geom_bar(stat='identity', position='stack') + 
  labs(title = 'Proportion of Rides by Month and User Type', x = 'Month', y = 'Proportion of Rides', fill = "Rider Type")

ggsave('./R_images/prop_month_user.png')

# Plot mean ride times of member and casual riders by month

mean_dur_type_month <- aggregate(df$dur, list(month_name = df$month_name, member_casual = df$member_casual), mean)

dur_month_type_plot <- ggplot(mean_dur_type_month, aes(x=month_name, y=x, fill=member_casual)) +
  geom_bar(stat='identity', position='dodge') + 
  labs(title = 'Mean Duration by Month and User Type', x = 'Month', y = 'Mean Ride Length', fill = "Rider Type")

ggsave('./R_images/mean_dur_month_user.png')

# Plot total ride duration by month and user type

total_dur_type_month <- aggregate(df$dur, list(month_name = df$month_name, member_casual = df$member_casual), sum)

total_dur_type_month <-total_dur_type_month %>% mutate(x = x/3600000)

total_dur_month_type_plot <- ggplot(total_dur_type_month, aes(x=month_name, y=x, fill=member_casual)) +
  geom_bar(stat='identity', position='dodge') + 
  labs(title = 'Total Duration by Month and User Type', x = 'Month', y = 'Total Ride Duration (Thousands of Hours)', fill = "Rider Type")

ggsave('./R_images/total_dur_month_user.png')

# Plot rides by weekday and user type

count_type_day <- df %>% count(day_name, member_casual)

month_type_plot <- ggplot(count_type_day, aes(x=day_name, y=n, fill=member_casual)) +
  geom_bar(stat='identity', position='dodge') + 
  labs(title = 'Rides by Weekday and User Type', x = 'Day', y = 'Rides', fill = "Rider Type")

ggsave('./R_images/day_user.png')

# Plot proportion of rides each day by user type

prop_type_day <- group_by(count_type_day, day_name) %>% mutate(prop = n/sum(n))

day_type_prop_plot <- ggplot(prop_type_day, aes(x=day_name, y=prop, fill=member_casual)) +
  geom_bar(stat='identity', position='stack') + 
  labs(title = 'Proportion of Rides by day and User Type', x = 'Day', y = 'Proportion of Rides', fill = "Rider Type")

ggsave('./R_images/prop_day_user.png')

# Plot ride mean duration by day and user type

mean_dur_type_day <- aggregate(df$dur, list(day_name = df$day_name, member_casual = df$member_casual), mean)

dur_day_type_plot <- ggplot(mean_dur_type_day, aes(x=day_name, y=x, fill=member_casual)) +
  geom_bar(stat='identity', position='dodge') + 
  labs(title = 'Mean Duration by Day and User Type', x = 'Day', y = 'Mean Ride Length', fill = "Rider Type")

ggsave('./R_images/mean_dur_day_user.png')

# Plot total ride duration by day and user type

total_dur_type_day <- aggregate(df$dur, list(day_name = df$day_name, member_casual = df$member_casual), sum)

total_dur_type_day <-total_dur_type_day %>% mutate(x = x/3600000)

total_dur_day_type_plot <- ggplot(total_dur_type_day, aes(x=day_name, y=x, fill=member_casual)) +
  geom_bar(stat='identity', position='dodge') + 
  labs(title = 'Total Duration by day and User Type', x = 'day', y = 'Total Ride Duration (Thousands of Hours)', fill = "Rider Type")

ggsave('./R_images/total_dur_day_user.png')
