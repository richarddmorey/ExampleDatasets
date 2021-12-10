#' ---
#' title: Analysis of James et al (2015), Experiment 2
#' author: Richard D. Morey (moreyr@cardiff.ac.uk)
#' date: 8 September 2021
#' output: 
#'   html_document:
#'     toc: true
#' ---
#' 

#' ## Load and format data

#' We load the `dplyr` library for its data science functions, which we
#' will use to load and manipulate the data.
library(dplyr)

#' We load the data using the `read_csv` function in the `readr` package.
#' This lets us specify all the column types (i: integer, d: numeric). 
#' We then
#'  
#' 1. specify helpful labels for the factors `Condition` and 
#' `Time_of_Day`,
#' 2. specify a row number column called `id`, and
#' 3. create the proper missing data in the Tetris variables when a 
#'    participant did not play Tetris.
#'
#' We put the neatened data set into a variable called `tetris`.
here::here('data/James_et_al_2015_Exp2.csv') %>%
  readr::read_csv(col_types = 'iiiiddddddddddddiiiiiiiididi') %>%
  mutate(
    Condition = factor(Condition, 
                       labels = c(
                         'No-Task Control',
                         'Reactivation+Tetris',
                         'Tetris Only',
                         'Reactivation Only'
                         )
                       ),
    Time_of_Day = factor(Time_of_Day,
                         levels = 1:3,
                         labels = c(
                           'morning',
                           'afternoon',
                           'evening'
                           )
                         ),
    id = factor(row_number()),
    Tetris_Total_Score = case_when(
      grepl(Condition, pattern = 'Tetris') ~ Tetris_Total_Score,
      TRUE ~ NA_integer_
    ),
    Self_Rated_Tetris_Performance = case_when(
      grepl(Condition, pattern = 'Tetris') ~ Self_Rated_Tetris_Performance,
      TRUE ~ NA_real_
    )
  ) -> tetris

#' ## Plots and analyses

#' We will conduct the three analyses corresponding to the three
#' panels in figure 4 of James et al (p. 1210):
#' 
#' 1. Figure 4a, memory intrusion counts after the disturbing video but *before* 
#'    random assignment to the experimental manipulation,
#' 2. Figure 4b, memory intrusions recorded in the participants' diaries from 
#'    day 1 to day 7 *after* the experimental manipulation,
#' 3. Figure 4c, memory intrusions during the Intrusion-provocation task on Day 7
#'    (see p. 1204 for details) 
#' 

#' We will use the `ggplot2` to create our plots. 
library(ggplot2)

#' ### Before the experimental manipulation

#' First, we create a standard bar plot: means with standard errors. We:
#' 
#' 1. group the observations by condition,
#' 2. summarise, computing the mean and standard error by condition, then
#' 3. pass the resulting summarised data to `ggplot` for a bar plot. 
tetris %>%
  group_by(Condition) %>%
  summarise(
    mean = mean(Day_Zero_Number_of_Intrusions),
    se = sd(Day_Zero_Number_of_Intrusions)/sqrt(n())
  ) %>%
  ggplot(aes(y = mean, x = Condition, color = Condition)) +
  geom_point(size = 4) +
  geom_errorbar(
    aes(ymin = mean - se, ymax = mean + se), 
    width = 0, size = 2
  ) +
  labs(
    y = 'Memory intrusions, Day 0',
    title = 'Intrusions before critical manipulation',
    subtitle = 'James et al (2015)',
    caption = 'c.f. James et al (2015), figure 4a (p. 1210)'
  ) +
  ylim(c(0, NA)) +
  theme(legend.position = 'none') -> ggplot_baseline_standard

#' We can print the plot.
ggplot_baseline_standard

#' We can also save the plot to a file.
ggplot_baseline_standard %>%
  ggsave(
    filename = here::here('figures/baseline_standard.png'),
    width = 7, height = 5, units = 'in', dpi = 300
    )
  

#' We now create a much better descriptive plot, showing both each data point and
#' a smoothed histogram of each condition. This allows us to see outliers and 
#' deviations from our assumptions (such as normality and homogeneity of variance).
#' This code is adapted from https://www.cedricscherer.com/2021/06/06/visualizing-distributions-with-raincloud-plots-and-how-to-create-them-with-ggplot2/.
tetris %>%
  ggplot(aes(
    x = Condition,
    y = Day_Zero_Number_of_Intrusions,
    fill = Condition)
  ) + 
  ggdist::stat_halfeye(
    adjust = .5,
    width = .6, 
    ## set slab interval to show IQR and 95% data range
    .width = c(.5, .95)
  ) + 
  ggdist::stat_dots(
    aes(color = Condition),
    side = "left", 
    dotsize = .8, 
    justification = 1.05, 
    binwidth = .3
  ) +
  labs(
    y = 'Memory intrusions, Day 0',
    title = 'Intrusions before critical manipulation',
    subtitle = 'James et al (2015)',
    caption = 'c.f. James et al (2015), figure 4a (p. 1210)'
  ) +
  theme(legend.position = 'none') -> ggplot_baseline_nice

ggplot_baseline_nice

ggplot_baseline_nice %>%
  ggsave(
    filename = here::here('figures/baseline_nice.png'),
    width = 7, height = 5, units = 'in', dpi = 300
  )

#' As another way of assessing the normality assumption, we
#' can perform a Shapiro-Wilks test on each condition. We
#' 
#' 1. split the data by condition using `split`, then
#' 2. use `map` to compute the test for each condition separately. 
tetris %>%
  split(.$Condition) %>%
  purrr::map(
    ~ .$Day_Zero_Number_of_Intrusions %>% 
      shapiro.test(.)
  )

#' We now perform a one-way ANOVA using the `ez` package and put the result
#' into a variable called `ez_obj_baseline` (baseline because this ANOVA is
#' before randomization to experimental condition).
tetris %>%
  ez::ezANOVA(dv = Day_Zero_Number_of_Intrusions, 
              wid = id,
              between = Condition,
              detailed = TRUE
  ) -> ez_obj_baseline

#' We print the ANOVA, which will also (helpfully) contain a Levene's test
#' for homogeneity of variance.
ez_obj_baseline

#' ### After the experimental manipulation (Days 1-7)

#' We now perform all the above steps, but on the memory intrusions recorded in
#' participants' diaries from Days 1-7. I now omit most comments; see above for
#' details.

# Standard plot
tetris %>%
  group_by(Condition) %>%
  summarise(
    mean = mean(Days_One_to_Seven_Number_of_Intrusions),
    se = sd(Days_One_to_Seven_Number_of_Intrusions)/sqrt(n())
  ) %>%
  ggplot(aes(y = mean, x = Condition, color = Condition)) +
  geom_point(size = 4) +
  geom_errorbar(
    aes(ymin = mean - se, ymax = mean + se), 
    width = 0, size = 2
    ) +
  labs(
    y = 'Memory intrusions, Days 1-7',
    title = 'Memory intrusions by condition, Days 1-7',
    subtitle = 'James et al (2015)',
    caption = 'c.f. James et al (2015), figure 4b (p. 1210)'
  ) +
  ylim(c(0, NA)) +
  theme(legend.position = 'none') -> ggplot_expt_standard

ggplot_expt_standard

ggplot_expt_standard %>%
  ggsave(
    filename = here::here('figures/expt_standard.png'),
    width = 7, height = 5, units = 'in', dpi = 300
  )


# Good descriptive plot
tetris %>%
  ggplot(aes(
    x = Condition,
    y = Days_One_to_Seven_Number_of_Intrusions,
    fill = Condition)
    ) + 
  ggdist::stat_halfeye(
    adjust = .5,
    width = .6, 
    ## set slab interval to show IQR and 95% data range
    .width = c(.5, .95)
  ) + 
  ggdist::stat_dots(
    aes(color = Condition),
    side = "left", 
    dotsize = .8, 
    justification = 1.05, 
    binwidth = .3
  ) +
  labs(
    y = 'Memory intrusions, Days 1-7',
    title = 'Memory intrusions by condition, Days 1-7',
    subtitle = 'James et al (2015)',
    caption = 'c.f. James et al (2015), figure 4b (p. 1210)'
       ) +
  theme(legend.position = 'none') -> ggplot_expt_nice

ggplot_expt_nice

ggplot_expt_nice %>%
  ggsave(
    filename = here::here('figures/expt_nice.png'),
    width = 7, height = 5, units = 'in', dpi = 300
  )

tetris %>%
  split(.$Condition) %>%
  purrr::map(
    ~ .$Days_One_to_Seven_Number_of_Intrusions %>% 
      shapiro.test(.)
  )

tetris %>%
  ez::ezANOVA(dv = Days_One_to_Seven_Number_of_Intrusions, 
              wid = id,
              between = Condition,
              return_aov = TRUE,
              detailed = TRUE
  ) -> ez_obj_expt

#' We print the object, which now contains three (rather than two) list elements:
#' 
#' * `ANOVA`: the ANOVA we expect,
#' * `Levene's Test for Homogeneity of Variance`: Levene's test, and
#' * `aov`: another analysis of variance object. We requested this above 
#'   with `return_aov=TRUE`. We'll need the extra information in it to
#'   compute *post hoc* analyses.
ez_obj_expt

#' Of course, we also probably want to look at a *post hoc* analysis. We can 
#' use the `TukeyHSD` function to compute Tukey *post hoc* intervals and 
#' *p* values for the differences between all conditions.
TukeyHSD(ez_obj_expt$aov)

#' ### Day 7 Provocation Task Intrusions

#' We now perform all the above steps, but on the memory intrusions recorded in
#' intrusion provocation task in the lab on day 7. I now omit most comments; see above for
#' details.

# Standard plot
tetris %>%
  group_by(Condition) %>%
  summarise(
    mean = mean(Number_of_Provocation_Task_Intrusions),
    se = sd(Number_of_Provocation_Task_Intrusions)/sqrt(n())
  ) %>%
  ggplot(aes(y = mean, x = Condition, color = Condition)) +
  geom_point(size = 4) +
  geom_errorbar(
    aes(ymin = mean - se, ymax = mean + se), 
    width = 0, size = 2
  ) +
  labs(
    y = 'Provocation Task Intrusions, day 7',
    title = 'Provocation Task Intrusions, day 7',
    subtitle = 'James et al (2015)',
    caption = 'c.f. James et al (2015), figure 4c (p. 1210)'
  ) +
  ylim(c(0, NA)) +
  theme(legend.position = 'none') -> ggplot_ipt7_standard

ggplot_ipt7_standard

ggplot_ipt7_standard %>%
  ggsave(
    filename = here::here('figures/ipt7_standard.png'),
    width = 7, height = 5, units = 'in', dpi = 300
  )


# Good descriptive plot
tetris %>%
  ggplot(aes(
    x = Condition,
    y = Number_of_Provocation_Task_Intrusions,
    fill = Condition)
  ) + 
  ggdist::stat_halfeye(
    adjust = .5,
    width = .6, 
    ## set slab interval to show IQR and 95% data range
    .width = c(.5, .95)
  ) + 
  ggdist::stat_dots(
    aes(color = Condition),
    side = "left", 
    dotsize = .8, 
    justification = 1.05, 
    binwidth = .3
  ) +
  labs(
    y = 'Provocation Task Intrusions, day 7',
    title = 'Provocation Task Intrusions, day 7',
    subtitle = 'James et al (2015)',
    caption = 'c.f. James et al (2015), figure 4c (p. 1210)'
  ) +
  theme(legend.position = 'none') -> ggplot_ipt7_nice

ggplot_ipt7_nice

ggplot_ipt7_nice %>%
  ggsave(
    filename = here::here('figures/ipt7_nice.png'),
    width = 7, height = 5, units = 'in', dpi = 300
  )

tetris %>%
  split(.$Condition) %>%
  purrr::map(
    ~ .$Number_of_Provocation_Task_Intrusions %>% 
      shapiro.test(.)
  )

tetris %>%
  ez::ezANOVA(dv = Number_of_Provocation_Task_Intrusions, 
              wid = id,
              between = Condition,
              return_aov = TRUE,
              detailed = TRUE
  ) -> ez_obj_ipt7

ez_obj_ipt7

TukeyHSD(ez_obj_ipt7$aov)
