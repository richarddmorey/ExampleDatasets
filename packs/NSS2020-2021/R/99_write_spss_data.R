source(here::here('R/00_read_data.R'))

all_qs_with_scale %>%
  haven::write_sav(here::here('data/NSS_taught_psych_avg.sav'))
