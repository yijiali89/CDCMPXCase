library(tidyverse)
library(MetBrewer)
library(zoo)

link<-'https://www.cdc.gov/wcms/vizdata/poxvirus/monkeypox/data/mpx_count_by_date.csv'
data<-read_csv(link)%>%
  mutate(epi_date=as.Date(epi_date, '%m/%d/%Y'))%>%
  mutate(Day=as.integer(epi_date-as.Date('2022-05-15')))%>%
  mutate(Avg=zoo::rollmean(Cases, k=7, fill = NA))

data%>%
  ggplot(aes(x=epi_date, y=Avg, color=Cases))+
  geom_point()+
  theme_classic()+
  geom_col(aes(y=Cases, fill=Cases), alpha=0.5, color='grey90')+
  geom_line() +
  scale_colour_met_c('Hiroshige', direction = -1)+
  scale_fill_met_c('Hiroshige', direction = -1)+
  xlab('Date')+ylab('7-Day Average Cases in US')+
  labs(color='Reported Daily\n Cases Number')+
  guides(fill='none')
