library(dplyr)


here::here('raw_data/sa_data.csv') %>%
  readr::read_csv(col_types = 'ffffd') %>%
  mutate(
    condition = factor(condition, levels = 1:2, labels = c('Operant','Observational')),
    gender = factor(gender, levels = 0:1, labels = c('female','male')),
    order = factor(order, levels = 1:2, labels = c('SenAtt-TemBin', 'TemBin-SenAtt'))    
  ) -> sa_data


here::here('raw_data/tb_data.csv') %>%
  readr::read_csv(col_types = 'fffffd') %>%
  mutate(
    delay = factor(delay, labels = c('200ms','400ms','1200ms'), ordered = TRUE),
    condition = factor(condition, labels = c('Operant','Observational')),
    gender = factor(gender, levels = 0:1, labels = c('female','male')),
    order = factor(order, levels = 1:2, labels = c('SenAtt-TemBin', 'TemBin-SenAtt')),
    estimated_interval = estimated_interval * 1000 # convert to ms
  ) -> tb_data

here::here('raw_data/agency_data.csv') %>%
  readr::read_csv(col_types = 'ffffd') %>%
  mutate(
    task = factor(task, levels = 1:2, labels = c('SensAtt','TemBin')),
    gender = factor(gender, levels = 0:1, labels = c('female','male')),
    order = factor(order, levels = 1:2, labels = c('SenAtt-TemBin', 'TemBin-SenAtt'))
  ) -> agency_data


here::here('raw_data/correlation_data.csv') %>%
  readr::read_csv(col_types = 'fdddddddd') -> correlation_data
