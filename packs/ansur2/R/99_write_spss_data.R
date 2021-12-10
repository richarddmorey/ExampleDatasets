library(haven)

source(here::here('R/01_read_data.R'))

ansur2 %>%
  haven::write_sav(here::here('data/ansur2.sav'))
