#' ---
#' title: Analysis of Ryan et al (2013), Experiment 2 
#' author: Richard D. Morey (moreyr@cardiff.ac.uk)
#' date: 29 September 2021
#' output: 
#'   html_document:
#'     toc: true
#' ---
#' 

#' ## Load and format data

#' We load the `dplyr` library for its data science functions, which we
#' will use to load and manipulate the data.
library(dplyr)

#' We load the data using the `read_sav` function in the `haven` package.
#' This lets us read in SPSS files. 
#' 
#' We then put everything in a variable called `bugs_wide`, named 
#' because the SPSS file is in wide format.
#' 
here::here('data/Ryan_etal_2013_Study2_wide.sav') %>%
  haven::read_sav() -> bugs_wide

#' We now write pivot so that we have the data in long format.

library(tidyr)

bugs_wide %>%
  mutate(across(where(haven::is.labelled), haven::as_factor)) %>%
  pivot_longer(cols = matches('hi[1-2]$|lo[1-2]$'), 
               names_to = 'condition',
               values_to = 'hostility') %>%
  mutate(
    frig = factor(
      substr(condition, 1, 2),
      levels = c('lo', 'hi'), ordered = TRUE
    ),
    disg = factor(
      substr(condition, 3, 4),
      levels = c('lo', 'hi'), ordered = TRUE
    ),
    stimnum = substr(condition, 5, 5)
  ) -> bugs_long

#' We can write a long version of the file for convenience in SPSS.

bugs_long %>%
  haven::write_sav(here::here('data/Ryan_etal_2013_Study2_long.sav'))

library(gtsummary)

#' Create a summary table. Remember the data frame is in LONG format,
#' so there are four observations per participant. First, we'll summarise
#' to remove the extra rows.
bugs_long %>%
  group_by(sub) %>%
  summarise(
    gender = first(gender),
    education = first(education),
    region = first(region),
    `Missing rating` = any(is.na(hostility))
    ) %>%
  tbl_summary(
    by = gender, # split table by group
    include = c('education','region', 'Missing rating'),
    missing = 'ifany',
    missing_text = 'Missing',
  ) %>%
  add_n() %>%
  bold_labels()
  

#' As Ryan et al did, we'll collapse the data by taking the mean of
#' the two bugs in each condition. This will yield four observations, instead
#' of eight, per participant. We'll get rid of all columns except the ones we
#' need for the basic analysis.

bugs_long %>%
  group_by(sub, frig, disg) %>%
  summarise(
    gender = first(gender),
    hostility = mean(hostility)
  ) -> bugs_long_collapsed


# We now want to remove any participants who have missing data
# on either the DV or gender
bugs_long_collapsed %>%
  group_by(sub) %>%
  filter(
    !any(is.na(hostility)),
    !is.na(gender)
  ) %>%
  ungroup() -> bugs_no_na


#' We can use ggplot to create a jitter/boxplot to see all the data.

library(ggplot2)

bugs_no_na %>%
  ggplot(aes(x = frig, y = hostility, shape = disg, color = disg)) +
  geom_boxplot(alpha = .3) +
  geom_jitter(position = position_jitterdodge(), alpha = .3) +
  scale_color_discrete(name = 'Disgustingness', labels = c('Low', 'High')) +
  scale_shape_discrete(name = 'Disgustingness', labels = c('Low', 'High')) +
  scale_x_discrete(name = 'Frighteningness', labels = c('Low', 'High')) +
  scale_y_continuous(name = 'Mean hostility rating (0-10)') +
  facet_wrap(~ gender)


#' Create a pairs plot. First we select only the columns we 
#' want, then pivot so that the data is in wide format.

library(GGally)


#+ pairs_plot, fig.width = 7, fig.height = 7 
bugs_no_na %>%
  select(sub, gender, hostility, disg, frig) %>%
  tidyr::pivot_wider(
    id_cols = c('sub','gender'),
    names_from = c('disg', 'frig'),
    values_from = 'hostility') %>%
  select(-sub) %>%
  GGally::ggpairs(
    mapping = aes(color = gender),
    lower = list(continuous = wrap("points", alpha = 0.3)),
    diag = list(continuous = wrap("densityDiag", alpha = 0.3))
  ) +
  theme(
    axis.text.x = element_text(angle = 90, hjust = 1)
    )

#' We can perform Levene's test on each condition, broken out
#' by gender (the between-subjects variable)
#' 
#' 1. Create a condition variable
#' 2. Split by condition
#' 3. Use purrr::map_df to call Levene's test on each data frame
#'    from the split
#'    
#' Note that by default, rstatix::levene_test will use the median.
bugs_no_na %>%
  mutate(
    condition = glue::glue("{frig} frig, {disg} disg")
    ) %>%
  split(.$condition) %>%
  purrr::map_df(function(tbl){
    bind_cols(
      condition = first(tbl$condition),
      rstatix::levene_test(data = tbl, hostility ~ gender)
    )
  }) -> levenes_tab


#' We can use the `gt` package to print the results in a nice table.
library(gt)

levenes_tab %>%
  gt() %>%
  cols_label(
    statistic = 'Levene\'s statistic',
    p = 'p value'
  ) %>%
  fmt_number(c(statistic, p), decimals = 3) %>%
  tab_footnote(
    'Based on the median',
    locations = cells_column_labels(columns = statistic)
  )

#' ## Mixed ANOVA
options(contrasts = c("contr.sum", "contr.poly"))

bugs_no_na %>%
  ez::ezANOVA(
    dv = .(hostility),
    between = .(gender),
    within = .(disg, frig),
    wid = .(sub),
    type = 3,
    return_aov = TRUE,
    detailed = TRUE
  ) -> aov_obj



psychReport::aovEffectSize(aov_obj, effectSize = "pes")$ANOVA %>%
  select(Effect, DFn, SSn, DFd, SSd, `F`, p, pes) %>%
  gt(rowname_col = 'Effect') %>%
  fmt_number(c('SSn','SSd','F','p','pes'), decimals = 3) %>%
  cols_label(
    DFn = 'df',
    DFd = 'df',
    SSn = 'Sum. Sq.',
    SSd = 'Sum. Sq.',
    pes = 'Partial \\(\\eta^2\\)'
  ) %>%
  tab_spanner(label = 'Num.', columns = c('DFn','SSn')) %>%
  tab_spanner(label = 'Denom.', columns = c('DFd','SSd'))

#' ## Figure of the means

# Dodge the points so that the standard errors don't overlap
dodge = position_dodge(width=0.2)

aov_obj$aov %>%
  emmeans::emmeans(specs = ~gender:disg:frig) %>%
  as.data.frame() %>% 
  ggplot(aes(x = frig, y = emmean, 
             color = disg, group = disg,
             shape = disg)) +
  geom_line(position = dodge) +
  scale_color_discrete(name = 'Disgustingness', labels = c('Low', 'High')) +
  scale_shape_discrete(name = 'Disgustingness', labels = c('Low', 'High')) +
  scale_x_discrete(name = 'Frighteningness', labels = c('Low', 'High')) +
  scale_y_continuous(name = 'Mean hostility rating (0-10)', limits = c(4, 10)) +
  geom_point(size = 3, position = dodge) +
  geom_errorbar(
    aes(ymin = emmean - SE, ymax = emmean + SE),
    position = dodge,
    width = 0
    ) +
  facet_wrap(~gender)
  
