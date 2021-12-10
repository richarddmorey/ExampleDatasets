library(dplyr)

here::here('raw_data/Video_Summary_Data.xlsx') %>%
  readxl::read_xlsx() %>%
  janitor::clean_names() %>%
  rename(newscaster_shown = newcaster_shown) %>%
  mutate(
    newscaster_gender = stringr::str_to_title(newscaster_gender),
    number_people_talking = case_when(
      number_people_talking == 'Mulitple' ~ 'Multiple',
      TRUE ~ number_people_talking
    )
  ) -> video_summaries

