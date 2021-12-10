#' This analysis is not complete. 
#' I've just started to read in the data.
#'   -RDM, 5 Dec 2021

library(dplyr)

here::here('raw_data/Raw Data and Log/') %>%
  dir(pattern = '*.csv', full.names = TRUE) %>%
  purrr::map(function(fn){
    condition = stringr::str_match(basename(fn), 'PMLab([A-Z]{2})_')[2]
    readr::read_delim(fn, delim = ';', progress = FALSE,
      show_col_types = FALSE,
      trim_ws = TRUE,
      ) %>% 
      select(-matches('session.PercentageKeep.sessionCode')) %>%
      mutate(
        session.condition = condition,
        session.Remember.sessionCode = as.character(session.Remember.sessionCode)
        )
  }) %>%
  bind_rows() -> PMtask


here::here('raw_data/Raw Data and Log/Exclusions/') %>%
  dir(pattern = '*.csv', full.names = TRUE) %>%
  purrr::map(function(fn){
    condition = stringr::str_match(basename(fn), 'PMLab([A-Z]{2})_')[2]
    readr::read_delim(fn, delim = ';', progress = FALSE,
                      show_col_types = FALSE,
                      trim_ws = TRUE,
    ) %>% 
      select(-matches('session.PercentageKeep.sessionCode')) %>%
      mutate(
        session.condition = condition,
        session.Remember.sessionCode = as.character(session.Remember.sessionCode)
      )
  }) %>%
  bind_rows() -> PMtask_exclusions


PMtask %>%
  filter(executableId == 'TargetTrial') %>%
  group_by(userCode) %>%
  summarise(
    score = mean(score),
    birth = first(session.Birthyear.sessionCode),
    condition = first(session.condition)
    ) %>%
  group_by(condition) %>%
  summarise(score = mean(score))

# Parse logbook
library(tabulizer)
library(lubridate)

here::here('raw_data/Raw Data and Log/LaboratoryLog.pdf') %>%
  extract_tables() %>%
  do.call(what = rbind, args = .) -> pdf_tab

pdf_tab[-(1:2),] %>%
  data.frame() %>%
  tibble() -> logbook

colnames(logbook) = c(
  'userCode',
  'Birthyear',
  'Sex',
  'ExptDate',
  'ExptTime',
  'RoomNumber',
  'ComputerNumber',
  'Experimenter',
  'PaymentType',
  'DataFile',
  'ParticipantSource',
  'Notes'
)

logbook %>%
  mutate(
    userCode = as.integer(userCode),
    Birthyear = as.integer(Birthyear),
    Sex = as.factor(Sex),
    ExptTime = dmy_hm(
      glue::glue('{ExptDate} {ExptTime}'),
      tz = 'Europe/Zurich'
      )
  ) %>%
  select(-ExptDate) -> logbook

## Reasons for exclusions
logbook %>%
  filter(userCode %in% unique(PMtask_exclusions$userCode)) %>%
  select(userCode, Notes)


## Read in compiled data for comparison
here::here('raw_data/Analysis Files/Manuscript.Analysis.File.csv') %>%
  readr::read_delim(
    delim = ';',
    progress = FALSE,
    show_col_types = FALSE,
    trim_ws = TRUE,
    locale=readr::locale(decimal_mark = ",")
    ) -> PMtask_compiled

PMtask %>%
  filter(executableId == 'TargetTrial') %>%
  group_by(userCode) %>%
  summarise(score = mean(score)) -> mean_scores
  
mean_scores %>%
  left_join(PMtask_compiled, by = userCode)

## The compiled data set does not have user IDs in them,
## so we have to look at the distribution of scores until
## we can find a way to identify them uniquely.
qqplot(mean_scores$score, PMtask_compiled$Accuracy.PM.Task)
abline(0,1)
# Seems to check out
