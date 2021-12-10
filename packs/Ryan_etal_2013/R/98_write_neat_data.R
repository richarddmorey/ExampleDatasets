#' This analysis script reads the data file
#' "pr2_all_1351_SS_1-15-07.sav", provided by 
#' B. Ryan (cogprofessor@gmail.com) in September 
#' of 2021, and outputs a cleaned-up SPSS data file 
#' with descriptions, etc. I have not included the 
#' original data file in this pack, because it contained \
#' potentially identifying information.

library(dplyr)
library(labelled)

here::here('data/pr2_all_1351_SS_1-15-07.sav') %>%
  haven::read_sav() %>%
  select(-hihi,-hilo,-lohi,-lolo,
         -experimen, -ref,
         -`filter_$`, -endline,
         -region2, -time, -date) %>%
  filter(rowSums(is.na(.[,c(2,14:21)]))==0) %>%
  distinct(.keep_all = TRUE) %>%
  select(-ip) %>%
  mutate(age = as.numeric(age)) %>%
  mutate(across(where(is.character), trimws)) %>%
  mutate(
    across(
      c(region,education,why_part,how_find,before,internet), 
      ~ case_when(
        . %in% c('---', '') ~ NA_character_,
        TRUE ~ .
      )
    )
  ) %>%
  mutate(
    gender = factor(
      gender, levels = 1:2,
      labels = c('male','female')
      )
    ) %>%
  mutate(
    region = recode(
      region,
      Austral = 'Australia'
    ),
    region = factor(
      region,
      levels = c("North","Europe","Other","Australia","South","Asia","Africa"),
      labels = c("North America","Europe",
                 "Other","Australia","South America",
                 "Asia","Africa"))
    ) %>%
  mutate(
    education = recode(
      education,
      advance = 'advanced'
    ),
    education = factor(
      education,
      levels = c('less','high','some','college','partial','advanced'),
      labels = c(
        "less than high school",
        "high school graduate",
        "some college",
        "college graduate",
        "partial advanced degree training",
        "advanced degree"
      ),
      ordered = FALSE
    )) %>%
  mutate(
    english = factor(
      english,
      levels = 0:1, 
      labels = c('non-native','native')
    )
  ) %>%
  mutate(
    why_part = recode(
      why_part,
      As = 'assign',
      Interes = 'psych',
      Interested = 'psych',
      Just = 'fun',
      Looking = 'bored',
      Other = 'other'
      ),
    why_part = factor(
      why_part,
      levels = c('assign','bored','fun','other','psych'),
      labels = c(
        "As an assignment for school",
        "Looking for something to do",
        "Just for fun",
        "Other",
        "Interested in psychology"
      )
    )
  ) %>%
  mutate(
    how_find = recode(
      how_find,
      Heard = 'heard',
      Just = 'browsing',
      Read = 'other_website',
      Was = 'psych'
    ),
    how_find = factor(
      how_find,
      levels = c('heard','browsing','other_website','psych'),
      labels = c(
        "Heard about it from someone",
        "Just browsing the web",
        "Read about it on another web site",
        "Was looking for a psychology experiment"
      )
    )
  ) %>%
  mutate(
    before = factor(
      before,
      levels = c('Never','One','Several','Many'),
      labels = c(
        "Never",
        "One before this one",
        "Several before this one",
        "Many before this one"
      ),
      ordered = TRUE
    )
  ) %>%
  mutate(
    internet = factor(
      internet,
      levels = c('Seldom','Occasionally','Fairly','Every'),
      labels = c(
        "Seldom",
        "Occasionally",
        "Fairly often",
        "Every day"
      ),
      ordered = TRUE
    )
  ) %>%
  mutate(
    expect = factor(
      expect,
      levels = 0:2, 
      labels = c('No','Yes','We\'ll see')
    )
  ) %>%
  set_variable_labels(
    sub       = 'subject id',
    gender    = 'Your gender?',
    age       = 'How old are you?',
    region    = 'Where are you from?',
    education = 'What is your level of education?',
    english   = 'Is English your native language?',
    why_part  = 'Why are you participating in this experiment?',
    how_find  = 'How did you find out about this experiment?',
    before    = 'Have you done psychology experiments on the web before?',
    internet  = 'How much do you use the internet?',
    expect    = 'Do you think you will enjoy this experiment?',
    order     = 'Order of presentation of the stimuli',
    lolo1     = 'loF,loD 1: Assassinbug.jpg',
    lolo2     = 'loF,loD 2: JuneBeetle.jpg',
    lohi1     = 'loF,hiD 1: divingBeetle.jpg',
    lohi2     = 'loF,hiD 2: cockroach2.JPG',
    hilo1     = 'hiF,loD 1: cicada_killer1.jpg',
    hilo2     = 'hiF,loD 2: wasp_1.jpg',
    hihi1     = 'hiF,hiD 1: scorpion2.jpg',
    hihi2     = 'hiF,hiD 2: antlion.jpg'
  ) %>%
  haven::write_sav(
    here::here('data/Ryan_etal_2013_Study2_wide.sav')
  )

    