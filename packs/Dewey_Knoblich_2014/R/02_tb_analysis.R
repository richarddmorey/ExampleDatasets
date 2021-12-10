library(dplyr)


library(ggplot2)

tb_data %>%
  ggplot(aes(x = delay, y = estimated_interval, fill = condition)) +
  geom_boxplot() +
  ylab('Subjective delay (ms)') +
  xlab('Actual delay (ms)') +
  scale_fill_discrete(name = 'Condition') +
  facet_wrap(~order) 

tb_data %>%
  ggplot(aes(x = delay, y = estimated_interval, color = condition, shape = condition)) +
  geom_violin(aes(fill = condition), alpha = .3, position = position_dodge(1)) +
  geom_jitter(position=position_jitterdodge(dodge.width = 1)) +
  ylab('Subjective delay (ms)') +
  xlab('Actual delay (ms)') +
  scale_fill_discrete(name = 'Condition') +
  facet_wrap(~order) 


options(contrasts = c("contr.sum", "contr.poly"))

tb_data %>%
  ez::ezANOVA(
    dv = .(estimated_interval),
    wid = .(subid),
    within = .(delay, condition),
    between = .(order),
    type = 3, detailed = TRUE, return_aov = TRUE
    ) -> ez_obj

psychReport::aovEffectSize(ez_obj$aov)$ANOVA

ez_obj$`Mauchly's Test for Sphericity`

ez_obj$`Sphericity Corrections`


limitRange_lower <- function(data, mapping, ...) { 
  ggplot(data = data, mapping = mapping, ...) + 
    geom_point(...) + 
    geom_smooth(method = "lm", se = FALSE) +
    scale_y_continuous(limits = c(0, max(tb_data$estimated_interval)+.1)) +
    scale_x_continuous(limits = c(0, max(tb_data$estimated_interval)+.1)) 
}

limitRange_diag <- function (data, mapping, ..., rescale = FALSE) {
  if (is.null(mapping$fill)) {
    mapping$fill <- mapping$colour
  }
  
  ggplot(data, mapping) + 
    scale_y_continuous() + 
    geom_density(...) +
    xlim(c(0,max(tb_data$estimated_interval)+.1))
}

library(GGally)

tb_data %>%
  split(.$order) %>%
  purrr::map(function(d){
    d %>% 
      arrange(condition) %>%
      tidyr::pivot_wider(
        id_cols = c('subid', 'gender'),
        names_from = c('condition','delay'),
        values_from = 'estimated_interval'
      ) %>%
      select(-subid, -gender) %>%
      ggpairs(
        lower = list(continuous = wrap(limitRange_lower)),
        diag = list(continuous = wrap(limitRange_diag))
      )
  }) -> pairs_plots

pairs_plots[[1]] + ggtitle('Order: SenAtt-TemBin')
pairs_plots[[2]] + ggtitle('Order: TemBin-SenAtt')

# Note that this collapses across order
ez_obj$aov %>%
  emmeans::emmeans(specs = ~condition*delay) %>%
  data.frame() -> emm
  
dodge0 = position_dodge(width = .1)

emm %>% 
  ggplot(aes(x = delay, y = emmean, color = condition, group = condition)) +
  geom_point() +
  geom_line() +
  geom_errorbar(aes(ymin = emmean - SE, ymax = emmean + SE),
                width = 0) +
  labs(
    title = 'Subjective delay by condition', 
    subtitle = 'c.f. Figure 3 of Dewey & Knoblich, p. 5',
    x = 'Actual delay (ms)'
    ) +
  scale_y_continuous(
    limits = c(0,1200),
    name = 'Subjective delay (ms, estimated marginal mean)',
    breaks = c(200, 400, 1200),
    minor_breaks = c(0, seq(0,1200,200))
  ) + 
  scale_color_discrete(name = 'Condition')

# Try a robust method due to extremely heavy-tailed data
library(lme4)
library(robustlmm)
robustlmm::rlmer(estimated_interval ~ delay*condition*order + (1|subid), data = tb_data) %>%
  summary()
