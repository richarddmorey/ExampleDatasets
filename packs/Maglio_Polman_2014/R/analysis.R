#' ---
#' title: Analysis of Maglio and Polman (2014) data (Study 1)
#' author: Richard D. Morey (moreyr@cardiff.ac.uk)
#' date: 18 October 2021
#' output: 
#'   html_document:
#'     toc: true
#' ---
#' 

library(dplyr)

#' ## Load and format data

readr::read_csv(
  file = here::here('data/Maglio_Polman_2014.csv'),
  col_types = 'ciic'
  ) %>%
  mutate(
    STN_NAME = factor(STN_NAME, 
                      levels = c('SPAD', 'STG', 'B-Y', 'SHER'),
                      labels = c('Spadina', 'St George', 'Bloor-Yonge', 'Sherbourne'),
                      ordered = TRUE
                      ),
    DIRECTION = factor(case_when(
      DIRECTION == "WEST" ~ "West",
      DIRECTION == "EAST" ~ "East"
    ))
  ) -> subway


#' ## Create a table of descriptive statistics
#'

library(gt)

subway %>%
  group_by(DIRECTION, STN_NAME) %>%
  mutate(N = n(),
         M = mean(DISTANCE),
         SD = sd(DISTANCE)) %>%
  group_by(DIRECTION, STN_NAME, DISTANCE) %>%
  summarise(freq = n(),
            N = first(N),
            M = first(M),
            SD = first(SD)) %>%
  mutate(freq = freq/N) %>%
  tidyr::pivot_wider(names_from = DISTANCE,
                     values_from = freq) %>%
  group_by(STN_NAME) %>%
  gt() %>%
  tab_options(
    table.font.size = "80%"
  ) %>%
  fmt_missing(6:11, missing_text = "") %>%
  fmt_percent(6:11, decimals = 1) %>%
  fmt_number(c(M,SD), decimals = 3) %>%
  cols_label(
    DIRECTION = "Station / Direction"
  ) %>%
  tab_spanner(
    label = "Response",
    columns = 6:11
  ) %>%
  tab_style(
    style = cell_borders(sides = "left", color = "#dddddd", style = "solid", weight = px(2)),
    locations = cells_body(columns = c(N,`1`))
  ) %>%
  tab_header(
    title = "Summaries and response proportions",
    subtitle = "Maglio & Polman (2014), Experiment 1"
    ) %>%
  tab_footnote(
    footnote = "Empty cells denote no responses. Response category 7 is omitted because no participant used it.", 
    locations = cells_column_spanners("Response")
    )

#' ## Create graphs
#' 
library(ggplot2)

#' First we create a graph where size represents the proportion of
#' respondents in a category. This respects the discreteness and ordinality
#' of the data.

subway %>%
  group_by(DIRECTION, STN_NAME, DISTANCE) %>%
  summarise(
    n = n()
  ) %>%
  mutate(
    total = sum(n),
    percent = 100 * n / total
    ) -> summaries_n

dodge0 = position_dodge(.5)

summaries_n %>%
  ggplot(aes(x = STN_NAME, y = DISTANCE, size = percent, group = DIRECTION, color = DIRECTION)) +
  geom_point(position = dodge0, shape = 15) +
  scale_size_area(name = '% of responses', max_size = 10) +
  scale_y_continuous(limits = c(1,7), name = 'Rated distance', breaks = 1:7, minor_breaks = 1:7) +
  xlab('Station') +
  scale_color_discrete(name = 'Direction')


#' We now create a typical bar plot with standard errors. Compare to Figure 1 of Maglio and Polman 
#' (note that their standard errors are twice as large as they should be).

subway %>%
  group_by(DIRECTION, STN_NAME) %>%
  summarise(
    n = n(),
    mn = mean(DISTANCE),
    stderr = sd(DISTANCE) / sqrt(n())
  ) -> summaries


dodge0 = position_dodge(.1)

summaries %>% 
  ggplot(aes(x = STN_NAME, y = mn, group = DIRECTION, color = DIRECTION)) +
  geom_point(position = dodge0) +
  geom_line(position = dodge0) +
  geom_errorbar(
    aes(ymin = mn - stderr, ymax = mn + stderr),
    width = 0, position = dodge0
    ) +
  ylab('Subjective distance to station (mean)') +
  xlab('Station') +
  scale_color_discrete(name = 'Direction')


#' ## Typical ANOVA analysis
#' 

subway %>%
  mutate(id = factor(row_number())) %>%
  ez::ezANOVA(
    dv = DISTANCE,
    wid = id,
    between = .(DIRECTION, STN_NAME),
    detailed = TRUE,
    type = 3 # to match SPSS
  ) -> ez_obj

ez_obj$ANOVA %>%
  select(-`p<.05`) %>%
  gt() %>%
  fmt_number(columns = c('SSn', 'SSd', 'F', 'p', 'ges'), decimals = 3) %>%
  cols_label(ges = htmltools::HTML('\\(\\eta^2_{p}\\)')) %>%
  tab_header(title = 'ANOVA')


ez_obj$`Levene's Test for Homogeneity of Variance` %>%
  select(-`p<.05`) %>%
  gt() %>%
  fmt_number(columns = c('SSn', 'SSd', 'F', 'p'), decimals = 3) %>%
  tab_header(title = "Levene's Test for Homogeneity of Variance",
             subtitle = 'Based on median')
  

#' ## Advanced ordinal analysis
#' 

subway %>%
  mutate(DISTANCE = factor(DISTANCE, ordered = TRUE),
         DIRECTION = factor(DIRECTION,
                            levels=c("East","West"),
                            ordered=FALSE)
  ) -> for_clm0

#' We perform a series of model fits, which we'll then compare.
intercept_only   = ordinal::clm(DISTANCE ~ 1, data = for_clm0)
station          = ordinal::clm(DISTANCE ~ STN_NAME, data = for_clm0)
main_effects     = ordinal::clm(DISTANCE ~ STN_NAME + DIRECTION, data = for_clm0)
full_interaction = ordinal::clm(DISTANCE ~ STN_NAME * DIRECTION, data = for_clm0)

#' We can compare all models together against one another...
anova(intercept_only, station, main_effects, full_interaction)

#' The summaries of the parameters of the `full_interaction` model can be obtained
#' by using the `summary` function.
summary(full_interaction)

#' We can also get a more "ANOVA-like" table using the `anova` function, which you'll notice corresponds to the 
#' model comparisons above (essentially, comparing each model with the one just-simpler than it).
anova(full_interaction)
