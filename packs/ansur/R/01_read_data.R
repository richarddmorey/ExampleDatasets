library(dplyr)
library(readr)

dir(here::here('raw_data/'), pattern = '*.csv', full.names = TRUE) %>%
  purrr::map_df(
    read_csv, 
    locale = locale(encoding = 'windows-1252'),
    col_types = paste(collapse = '', c(
      'f',
      rep('n', 93),
      'f',
      'c',
      rep('c', 5),
      rep('f', 3),
      rep('n', 3),
      'f'
    ))) %>%
  mutate(
    Date = lubridate::as_date(Date),
    weightkg = weightkg / 10 # For some reason weights were in hectograms (?) 
  ) -> ansur2
