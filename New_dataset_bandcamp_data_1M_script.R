library(tidyverse)
data_raw<-read.csv(file.choose())
data_raw
glimpse(data_raw)
final_bandcamp_1M_data<- data_raw %>% distinct() %>%
  mutate(
    amount_paid = as.numeric(amount_paid),
    amount_paid_usd = as.numeric(amount_paid_usd)
  ) %>% filter(amount_paid > 0 & amount_paid_usd > 0 ) %>%
  group_by(item_description,artist_name,album_title) %>%
  summarise(
    Total_Amount_Paid = sum(amount_paid),
    Total_Amount_Paid_USD = sum(amount_paid_usd),
    Total_Albums = n(),
    .groups = 'drop'
  ) %>% arrange(desc(Total_Amount_Paid))
final_bandcamp_1M_data
write.csv(final_bandcamp_1M_data,
          'New_data_bandcamp_data.csv',
          row.names = FALSE)
getwd()
