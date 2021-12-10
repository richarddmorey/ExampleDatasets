library(dplyr)
library(tidyr)
library(stringr)

here::here('raw_data') %>%
  dir(pattern = '*.csv', full.names = TRUE) %>%
  purrr::map_df(function(fn){
    readr::read_csv(
      file = fn, 
      col_names = c('no_back','0_back','1_back','2_back'),
      col_types = 'dddd'
      ) %>%
      mutate(
        file = basename(fn),
        id = factor(row_number()),
        cond = stringr::str_match(file, 'cond(.{4,})_')[,2],
        dv = stringr::str_match(file, '_[0-9]{0,1}([a-z0-9]{2,})\\.csv')[,2],
        fig = stringr::str_match(file, 'fig(.{2})_')[,2],
        ) %>%
      select(-file) %>%
      pivot_longer(names_to = 'n_back', values_to = 'dv_value', cols = matches('back'))
  }) %>%
  pivot_wider(id_cols = c('id', 'cond', 'n_back'), names_from = 'dv', values_from = 'dv_value') %>%
  rename(flash_err_rate = flashresponses) %>%
  mutate(
    flash_err_rate = flash_err_rate / 100, 
    cond = factor(cond),
    n_back = factor(n_back, levels = c('no_back','0_back','1_back','2_back'), ordered = TRUE)
         ) -> long_data

long_data %>%
  readr::write_csv(file = here::here('data/Michail_Keil_2018.csv'))


