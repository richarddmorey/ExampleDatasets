library(dplyr)
library(tidyr)
library(stringi)
library(ggplot2)

russell = readLines(here::here('raw_data/russell_group.txt'))

dir(
  here::here('raw_data/'), 
  pattern = 'NSS_taught_all*',
  full.names = TRUE
) %>%
  purrr::map_df(
    function(fn){
      readxl::read_xlsx(
        fn, 
        sheet = 'NSS3',
        skip = 3) %>%
        mutate(
          fn = stringr::str_remove_all(
            basename(fn), '[^0-9]'),
          Year = glue::glue('20{fn}')
        ) %>% select(-fn)
    }) %>%
  filter(
    Subject == "Psychology (non-specific)"
  ) %>%
  mutate() -> nss_psych

nss_psych %>%
  mutate(
    across(
      matches("Answered [12345]", 
              function(x){
                as.numeric(stringr::str_remove(x, "%"))/100
              }
      )
    ),
    avg = -2*`Answered 1` + -1*`Answered 2` + 0*`Answered 3` + 1*`Answered 4` + 2*`Answered 5`
  ) %>%
  filter(
    Level == "First degree"
  ) %>%
  mutate(response_rate = Response / `Sample Size`) %>%
  group_by(Provider, Year) %>%
  mutate(Avg_rate = mean(response_rate)) %>% 
  ungroup() %>%
  rename(Sample_size = `Sample Size`) %>%
  pivot_wider(id_cols = c('Provider','Year','Sample_size','Avg_rate'),
              names_from = "Question Number",
              values_from = avg) %>%
  mutate(Russell_group = Provider %in% russell) %>%
  relocate(Russell_group, .after = Provider) %>%
  relocate(
    matches("Scale"), .after = everything()
  ) -> all_qs_with_scale 
