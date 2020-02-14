library(dplyr)
raw_data<- read.csv("/Users/haijuanzhang/Documents/coronavirus-2020/time serires data/coronavirus.csv",stringsAsFactors = FALSE)
confirmed_df <- raw_data[(raw_data$type == 'confirmed')&(raw_data$date)=='2020-02-13',]
death_df <- raw_data[(raw_data$type == 'death')&(raw_data$date)=='2020-02-13',]
recoverd_df <- raw_data[(raw_data$type == 'recovered')&(raw_data$date)=='2020-02-13',]
merged_df <- merge(confirmed_df,death_df,by=c(c("Province.State", "Country.Region","Lat","Long","date"))) %>%
              merge(recoverd_df,by = c("Province.State", "Country.Region","Lat","Long","date"))
              
merged_df <- merged_df[,c(1,2,3,4,7,8,10,11,13,14)]
names(merged_df)[names(merged_df) == 'cases.x'] <- 'confirmed_number'
names(merged_df)[names(merged_df) == 'cases.y'] <- 'death_number'
names(merged_df)[names(merged_df) == 'cases'] <- 'recoved_number'
merged_df <- merged_df[,c(1,2,3,4,5,7,9)]
write.csv(merged_df,'/Users/haijuanzhang/Documents/coronavirus-2020/visulization data/total_numbers.csv')