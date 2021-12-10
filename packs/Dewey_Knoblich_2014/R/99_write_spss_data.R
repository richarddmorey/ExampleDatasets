library(dplyr)
library(haven)
library(tidyr)
library(labelled)

source(here::here('R/00_read_data.R'))

## Write a nice wide version for SPSS
tb_data %>%
  pivot_wider(
    id_cols = c(subid,gender,order),
    names_from = c(condition, delay),
    values_from = estimated_interval
  )
  haven::write_sav(
    path = here::here('data/Dewey_Knoblich_2014_tb_wide.sav'))

## Write a nice long version for SPSS
tb_data %>%
  haven::write_sav(path = here::here('data/Dewey_Knoblich_2014_tb_long.sav'))

## Write a version of the correlation data with appropriate columns


#' There are several things to note here.
#' 
#' 1. I believe that in correlations_data.csv the tb_agency and
#'    sa_agency columns are reversed. The scores are reversed from 
#'    agency_data.csv. Below, I've swapped them.
#' 2. I cannot replicate the correlations for the two orders (Tables
#'    2 and 3) that involve the implicit temporal binding measures
#'    (see r/04_correlation_analysis.R)
#'
#' I contacted the first author J Dewey for comment on 21 Oct 2021, but haven't
#' heard back as of 14 Nov 2021.
#'
tb_data %>%
  pivot_wider(
    id_cols = c(subid,gender,order),
    names_from = c(condition, delay),
    values_from = estimated_interval
  ) %>%
  select(subid, gender, order) %>%
  left_join(
    correlation_data,
    by = 'subid'
    ) %>%
  rename(sa_agency0 = tb_agency,
         tb_agency = sa_agency) %>%
  rename(sa_agency = sa_agency0) %>%
  set_variable_labels(
      subid       = 'participant id',
      gender   = 'participant\'s gender',
      order    = 'Order of task presentation',
      sa       = 'Implicit agency measure from Sensory Attenuation task',
      tb_200    = 'Implicit agency measure from Temporal binding task, 200ms delay',
      tb_400 = 'Implicit agency measure from Temporal binding task, 400ms delay',
      tb_1200   = 'Implicit agency measure from Temporal binding task, 1200ms delay',
      MI  = 'Participant\'s score on Magical Ideation scale',
      LoC  = 'Participant\'s score on the Locus of Control scale',
      tb_agency    = 'Average response (1-9) to \'How confident do you feel that your key presses produced the tones?\' during temporal binding task',
      sa_agency  = 'Average response (1-9) to \'How confident do you feel that your key presses produced the first tone?\' during sensory attenuation task'
    ) %>%
  haven::write_sav(
    here::here('data/Dewey_Knoblich_2014_correlations.sav')
  )


