#' ---
#' title: Analysis of Michail and Keil (2018)
#' author: Richard D. Morey (moreyr@cardiff.ac.uk)
#' date: 12 October 2021
#' output: 
#'   html_document:
#'     toc: true
#' ---
#' 

#' ## Load and format data

#' We load the `dplyr` library for its data science functions, which we
#' will use to load and manipulate the data.
library(dplyr)

#' We load the data for the critical A2V1 condition
#' from the raw_data folder. Then we:
#' 
#' 1. Create a participant ID column
#' 2. 'pivot' the data set from wide to long format
#' 3. Create a factor out of the new `n-back` column
#' 
here::here('raw_data/data_for_fig2A_condA2V1_2flashresponses.csv') %>%
  readr::read_csv(
    col_names = paste0(c('no', 0:2), '-back'),
    col_types = 'dddd'
    ) %>%
  mutate( 
    id = factor(row_number())
    ) %>%
  tidyr::pivot_longer(
    cols = matches('back'),
    names_to = 'condition',
    values_to = 'flashes_perc'
    ) %>%
  mutate(
    condition = factor(condition, levels = paste0(c('no', 0:2), '-back'),ordered = TRUE)
  ) -> A2V1_2flashes_resp

#' ## Create a graph
#' 
library(ggplot2)

#' Our first graph is a boxplot, to see the spread of
#' observations in each condition
A2V1_2flashes_resp %>%
  ggplot(aes(x = condition, y = flashes_perc,
             color = condition)) +
  geom_boxplot(alpha = .4) +
  geom_jitter(height = 0) +
  scale_y_continuous(name = 'Illusion rate (%)')

#' We can look at the relationship between participant's illusory responses across conditions 
#' using a pairs plot.
#' 
library(GGally)

A2V1_2flashes_resp %>%
  tidyr::pivot_wider(
    names_from = 'condition',
    values_from ='flashes_perc'
    ) %>%
  GGally::ggpairs(columns = 2:5)


#' ## Perform an repeated-measures ANOVA
#' 
options(contrasts = c("contr.sum", "contr.poly"))

A2V1_2flashes_resp %>%
  ez::ezANOVA(
    dv = .(flashes_perc),
    wid = .(id),
    within = .(condition),
    detailed = TRUE,
    return_aov = TRUE
    ) -> aov_obj

library(gt)

aov_obj$`Mauchly's Test for Sphericity` %>% 
  select(-`p<.05`) %>%
  gt() %>%
  tab_header(title = 'Mauchly\'s Test for Sphericity') %>%
  fmt_number(c('W','p'), decimals = 3)

aov_obj$`Sphericity Corrections` %>%
  select(-matches('<')) %>%
  tidyr::pivot_longer(cols = -matches('Effect')) %>%
  mutate(Type = case_when(
    grepl(name, pattern='GG') ~ 'Greenhouse-Geisser',
    grepl(name, pattern='HF') ~ 'Huynh-Feldt',
    TRUE ~ NA_character_
  ),
  epsilon = case_when(
    grepl(name, pattern='p\\[') ~ 'p',
    grepl(name, pattern='e$') ~ 'epsilon',
    TRUE ~ NA_character_
  )
  ) %>%
  select(-name) %>%
  tidyr::pivot_wider(names_from = 'epsilon', values_from = 'value') %>%
  gt() %>%
  tab_header(title = 'Sphericity corrections') %>%
  fmt_number(c('epsilon','p'), decimals = 3) %>%
  cols_label(Type = 'Correction type')

#' Compute the partial eta squared, and return
psychReport::aovEffectSize(aov_obj, effectSize = 'pes')$ANOVA %>%
  select(SSn, SSd, DFn, DFd, everything(), -`p<.05`) %>%
  gt() %>%
  tab_header(title = 'ANOVA table') %>%
  cols_label(
    pes = 'Partial eta-sq.'
  ) %>%
  fmt_number(c('SSn','SSd', 'F','p', 'pes'), decimals = 3) %>%
  cols_label(
    SSd = 'Sum Sq. denom.',
    SSn = 'Sum Sq. numer.',
    DFn = 'df numer.',
    DFd = 'df denom.',
  )


#' We can also create a bar plot with standard errors using the 
#' emprical marginal means.
#' 
aov_obj$aov %>%
  emmeans::emmeans(~ condition) %>%
  as.data.frame() -> mns

A2V1_2flashes_resp %>%
  ggplot(aes(x = condition, y = flashes_perc,
             color = condition)) +
  geom_jitter(height = 0, width = .2) +
  geom_point(
    data = mns,
    aes(
      x = condition,
      y = emmean,
      color = condition),
    shape = 18,
    inherit.aes = FALSE) +  
  geom_errorbar(
    data = mns,
    aes(
      x = condition,
      ymin = emmean - SE, ymax = emmean + SE,
      color = condition),
    width = .1,
    inherit.aes = FALSE) +
  scale_y_continuous(limits = c(0,100), breaks = seq(0,100,20)) +
  theme_bw()


