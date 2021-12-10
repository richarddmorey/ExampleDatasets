#' ---
#' title: "Analysis of Müller & Rothermund (2014)"
#' author: "Richard D. Morey"
#' date: "8 September 2021"
#' output: 
#'   html_document:
#'     toc: true
#' ---
#'

#' ### Data source
#' 
#' Müller, F., & Rothermund, K. (2014). What Does It Take to 
#'    Activate Stereotypes? Simple Primes Don’t Seem Enough. 
#'    *Social Psychology*, *45(3)*, 187–193. 
#'    https://doi.org/10.1027/1864-9335/a000183
#'    

#' ## Data preparation
#' 

#' Run the cleaning code to get the cleaned data set.
#+ message=FALSE 
source( here::here('R/01_clean_data.R') )

#' Aggregate to get average RT for each subject, in each condition:
#' 
#' 1. Group the data by participant and condition (our 2x2x2 design)
#' 2. Summarise the mean RT
#' 
#' then, 
#' 
#' 3. ungroup the data, and
#' 4. and convert character columns to factors.
#' 
priming_clean %>%
  group_by(id, PrimeGender, TargetGender, type) %>%
  summarise(RT = mean(RT)) %>%
  ungroup() %>%
  mutate(
    across(where(is.character), factor)
    ) -> priming_clean_aggregated

#'
#' ## Assumption tests
#' 
#' ### Correlations and normality
#' 
#' First we convert to wide format for convenience, to
#' look at each condition separately. Then we remove the 
#' redundant `id` column and save the result in the 
#' variable `priming_clean_aggregated_wide`.
#' 
priming_clean_aggregated %>%
  pivot_wider(id_cols = 'id',
              names_from = c('PrimeGender','TargetGender','type'),
              values_from = 'RT'
  ) %>%
  select(-id) -> priming_clean_aggregated_wide
 
#' The `GGally` package has the function `ggpairs` which produces
#' a nice pairs plot. The smoothed histograms on the diagonal
#' help us assess the distributions of observations.
#' 
library(GGally)

priming_clean_aggregated_wide %>%
  ggpairs() +
  theme( # rotate x axis labels for legibility
    axis.text.x = element_text(angle = 90, hjust = 1)
    ) -> pairs_obj

#' We need to make the figure a little bigger for printing. This
#' will not have any effect when you simply run the code.
#+ fig.width=9,fig.height=8
pairs_obj

#' Save the figure to a PNG file.
pairs_obj %>%
  ggsave(
    filename = here::here('figure/Mueller_Rothermund_pairs.png'),
    width = 9, height = 8, units = 'in', dpi = 300
  )

#' We can perform a Shapiro-Wilk normality test on each condition. 
#' The `map` function performs the `shapiro.test` on each column (condition). 
priming_clean_aggregated_wide %>%
  purrr::map(shapiro.test)

#' ## Omnibus analysis
#' 
#' ### Omnibus ANOVA
#' 
#' This option sets the kind of contrasts to use
#' for the ANOVA. These are good defaults (sum to zero 
#' for unordered factors and polynomial for ordered 
#' factors. 
options(contrasts = c('contr.sum', 'contr.poly'))

#' Perform a three-way within ANOVA as in SPSS
#' (SPSS uses Type III sums of squares), and put the
#' result in a variable called `ez_obj_omnibus` so we
#' can use it.
priming_clean_aggregated %>%
  ez::ezANOVA(data = ., dv = RT, wid = id, 
            within = .(PrimeGender, TargetGender, type),
            detailed = TRUE,
            return_aov = TRUE,
            type = 3) %>%
  psychReport::aovEffectSize() -> ez_obj_omnibus

#' `gt()` makes nice tables.
library(gt)

#' Define a function to make a nice table using gt;
#' we define a function because we'll use the code more than 
#' once.
make_nice_anova_table = function(df, title, subtitle){
  df %>%
    gt(rowname_col = "Effect") %>%
    cols_hide('p<.05') %>%
    fmt_number(
      c('SSn','SSd','F','pes'),
      decimals = 3) %>%
    fmt_scientific('p') %>%
    cols_label(pes='Partal eta-sq') %>%
    tab_header(
      title = title,
      subtitle = subtitle
    )
}

make_nice_anova_table(
  df = ez_obj_omnibus$ANOVA,
  title = 'Omnibus repeated measures ANOVA',
  subtitle = 'DV: RT'
  )

#' ### Marginal means

#' Compute the Estimated Marginal Means and standard errors and
#' put the result in a variable called `em_obj` so we can
#' use it for a table and a graph.
emmeans::emmeans(
  ez_obj_omnibus$aov,
  specs = ~ PrimeGender*TargetGender*type
) %>%
  as.data.frame() -> em_obj

#' Create a nice table.
em_obj %>%
  gt() %>%
  cols_hide('df') %>%
  fmt_number(
    c('emmean','SE','df','lower.CL','upper.CL'),
    decimals = 3)

#' ### Omnibus graph

#' We will create a graph with standard errors using `ggplot2`.
library(ggplot2)

#' We need to dodge so standard errors don't visually overlap
#' and obscure one another.
dodge = position_dodge(width=0.15)

#' Now we create the plot itself, with all its elements.
em_obj %>%
  ggplot(
    aes(x = PrimeGender, y = emmean,
        group = TargetGender, color = TargetGender,
        linetype = TargetGender,
        shape = TargetGender)
  ) + 
  geom_point(position = dodge, size = 2) + 
  geom_line(position = dodge) +
  geom_errorbar(aes(ymin = emmean - SE,
                    ymax = emmean + SE), 
                width = 0,
                position = dodge,
                linetype = 1) +
  labs(
    title = 'Average response time by condition',
    subtitle = 'Müller & Rothermund (2014)',
    caption = 'c.f. Müller & Rothermund (2014), Figure 1, p. 191',
    x = 'Prime gender',
    y = 'Average response time (ms)', 
    color = 'Target gender',
    linetype = 'Target gender',
    shape = 'Target gender'
  ) +
  facet_wrap(~ type) -> ggplot_obj

#' Print the plot, so we can see it before we save it.
ggplot_obj

#' Save the graph as a PNG file.
ggplot_obj %>%
  ggsave(
    filename = here::here('figure/Mueller_Rothermund_Fig1.png'),
    width = 7, height = 5, units = 'in', dpi = 300
  )

#' ## Follow-ups

#' Now test within each type:
#' 
#' 1. `split()` splits the data frame into two, based on type,
#'       and puts the results in a list, then
#' 2. `map()` performs a function to EACH element of a list, so
#'       in our case, to the separate data frames defined by
#'       the split on the variable `type`.
#'       
#' We'll put the result in a variable called `ez_obj_type`,
#' which will be a list with two elements:
#' 
#' * `$response` for the *response priming* condition, and
#' * `$semantic` for the *semantic priming* condition.
priming_clean_aggregated %>%
  split(.$type) %>%
  purrr::map(
    ~ ez::ezANOVA(data = ., dv = RT, wid = id,
                  within = .(PrimeGender, TargetGender),
                  detailed = TRUE,
                  return_aov = FALSE,
                  type = 3) %>%
      psychReport::aovEffectSize()
    ) -> ez_obj_type

#'
#' ### Response priming ANOVA
#'
#' Make the ANOVA table for the *response priming* condition.
make_nice_anova_table(
  df = ez_obj_type$response$ANOVA,
  title = 'Subgroup repeated measures ANOVA',
  subtitle = 'Subgroup: response priming; DV: RT'
)

#'
#' ### Semantic priming ANOVA
#'
#' Make the ANOVA table for the *semantic priming* condition.
make_nice_anova_table(
  df = ez_obj_type$semantic$ANOVA,
  title = 'Subgroup repeated measures ANOVA',
  subtitle = 'Subgroup: semantic priming; DV: RT'
)
