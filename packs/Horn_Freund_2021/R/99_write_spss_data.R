library(dplyr)

here::here('raw_data/Analysis Files/Manuscript.Analysis.File.csv') %>%
  readr::read_delim(
    delim = ';',
    progress = FALSE,
    show_col_types = FALSE,
    col_types = 'ncifnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn',
    trim_ws = TRUE,
    locale=readr::locale(decimal_mark = ",")
  ) %>%
  select(
    -matches('^Z')
    ) %>%
  mutate(
    Age.Group = factor(
      Age.Group, 
      levels = c('Younger','Middle','Older'),
      ordered = TRUE),
    across(
      c(Education, Income, LifeSatisfaction, Health, GainOrientation, MaintenanceOrientation, LossOrientation),
      ~ case_when(. == -9 ~ NA_real_, TRUE ~ .)
      ),
    Income = case_when(Income == 9 ~ NA_real_, TRUE ~ Income),
    Sex = case_when(Sex == -9 ~ NA_integer_, TRUE ~ Sex),
    Sex = factor(Sex, labels = c('Male','Female','Other'))
  ) %>%
  select(-matches('^Z')) %>%
  select(-matches('\\.e.c$')) %>%
  haven::write_sav(
    path = here::here('data/Horn_Freund_2021.sav')
    )


  
