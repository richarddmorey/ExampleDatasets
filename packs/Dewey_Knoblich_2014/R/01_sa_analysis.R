library(dplyr)


here::here('raw_data/sa_data.csv') %>%
  readr::read_csv(col_types = 'ffffd') %>%
  mutate(
    condition = factor(condition, levels = 1:2, labels = c('Operant','Observational')),
    gender = factor(gender, levels = 0:1, labels = c('female','male')),
    order = factor(order, levels = 1:2, labels = c('SenAtt-TemBin', 'TemBin-SenAtt'))    
    ) -> sa_data


library(ggplot2)

sa_data %>%
  ggplot(aes(x = condition, y = pse, fill = order)) +
  geom_boxplot() +
  ylab('PSE (%)') +
  xlab('Condition') 

sa_data %>%
  ggplot(aes(x = condition, y = pse, fill = order)) +
  geom_violin(alpha = .3, position = position_dodge(1)) +
  geom_jitter(position=position_jitterdodge(dodge.width = 1)) +
  ylab('PSE (%)') +
  xlab('Condition') 


options(contrasts = c("contr.sum", "contr.poly"))

sa_data %>%
  ez::ezANOVA(
    dv = .(pse),
    wid = .(subid),
    within = .(condition),
    between = .(order),
    type = 3, detailed = TRUE, return_aov = TRUE
    ) -> ez_obj

psychReport::aovEffectSize(ez_obj$aov)$ANOVA


ez_obj$aov %>%
  emmeans::emmeans(specs = ~condition*order) %>%
  data.frame() -> emm
  
dodge0 = position_dodge(width = .1)

emm %>% 
  ggplot(aes(x = condition, y = emmean, color = order, group = order)) +
  geom_point() +
  geom_line() +
  geom_errorbar(aes(ymin = emmean - SE, ymax = emmean + SE),
                width = 0) +
  labs(
    title = 'PSE by condition and Order', 
    subtitle = 'c.f. Figure 2 of Dewey & Knoblich, p. 5',
    x = 'Condition'
    ) +
  ylab('PSE (%)') +
  scale_color_discrete(name = 'Order')

# Try a robust method due to heavy-tailed data
library(lme4)
library(robustlmm)
robustlmm::rlmer(pse ~ condition*order + (1|subid), data = sa_data) %>%
  summary()
