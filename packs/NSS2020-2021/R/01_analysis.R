
source(here::here('R/00_read_data.R'))

all_qs_with_scale %>%
  select(-matches("^Scale")) -> all_qs


all_qs %>%
  filter(Year == '2021') %>%
  select(-Provider, -Year, Russell_group) %>%
  cor() %>%
  corrplot::corrplot.mixed()

all_qs %>%
  pivot_longer(cols = matches("^Q"),
               names_to = "Q",
               values_to = "avg") -> all_qs_long 

library(directlabels)

all_qs_long %>%
  ggplot(aes(x = Q, y = avg)) +
  geom_violin() +
  geom_line(data = all_qs_long %>% filter(Provider %in% russell),
            aes(color = Provider, group = Provider,
                linetype = Provider),
            size = 1.5) +
  scale_color_viridis_d() +
  scale_y_continuous(limits = c(-2,2)) +
  scale_x_discrete(expand=expansion(add=c(0,3))) +
  geom_dl(
    data = all_qs_long %>% filter(Provider %in% russell),
    aes(label = Provider, color = Provider),
    method = list("last.points"), 
    cex = 0.8
  ) +
  theme(legend.key.size = unit(1.5, "cm")) +
  facet_wrap(~ Year )

all_qs_with_scale %>%
  group_by(Year) %>%
  mutate(
    n = n(),
    across(matches('^Q|^Scale'), rank, .names = '{col}_rank'),
    across(matches('_rank$'), ~ . / n)
    ) %>%
  select(Provider, Year, matches('_rank')) %>%
  pivot_longer(
    matches('^Q|^Scale'), 
    names_to = 'Q',
    values_to = 'rank') %>%
  mutate(
    Q = stringr::str_remove(Q, '_rank'),
    scale = stringr::str_detect(Q, 'Scale')) %>%
  pivot_wider(
    id_cols = c(Provider, Q, scale),
    names_from = Year,
    values_from = rank,
    names_prefix = 'rank_'
    ) %>%
  mutate(
    which_scale = case_when(
      scale == TRUE ~ Q,
      Q %in% c('Q26','Q27') ~ Q,
      Q %in% paste0('Q0', 1:4) ~ 'Scale01',  
      Q %in% paste0('Q0', 5:7) ~ 'Scale02',  
      Q %in% paste0('Q', sprintf('%02d',8:11)) ~ 'Scale03',  
      Q %in% paste0('Q', 12:14) ~ 'Scale04',  
      Q %in% paste0('Q', 15:17) ~ 'Scale05',  
      Q %in% paste0('Q', 18:20) ~ 'Scale06',  
      Q %in% paste0('Q', 21:22) ~ 'Scale07',  
      Q %in% paste0('Q', 23:25) ~ 'Scale08',
      TRUE ~ NA_character_
    )
  ) -> rank_data

library(ggplot2)
library(ggrepel)

rank_data %>%
  filter(Provider == 'Cardiff University') %>%
  ggplot(aes(x = rank_2020, y = rank_2021, label = Q,
             color = which_scale)) +
  geom_point() + 
  geom_abline(slope = 1, intercept = 0) +
  coord_fixed(xlim = c(0,1), ylim = c(0,1)) +
  geom_text_repel() +
  scale_color_discrete() +
  facet_wrap(~ scale)

rank_data %>%
  split(.$Q) -> splt

names(splt) %>%
  purrr::map_df(function(Q){
    pcc = cor(splt[[Q]]$rank_2020,splt[[Q]]$rank_2021, use = 'pairwise') 
    bind_cols(Q = Q,
              correlation = pcc,
              scale = splt[[Q]]$scale[1],
              which_scale = splt[[Q]]$which_scale[1]
              )
  }) -> cors_Q

cors_Q %>%
  ggplot(aes(y = correlation, x = scale, color = which_scale, label = Q)) +
  geom_point(alpha = .5, size = 2) +
  geom_text_repel()


rank_data %>%
  split(.$Provider) -> splt

names(splt) %>%
  purrr::map_df(function(Provider){
    pcc = cor(splt[[Provider]]$rank_2020,splt[[Provider]]$rank_2021, use = 'pairwise') 
    bind_cols(Provider = Provider, correlation = pcc)
  }) -> cors

hist(cors$correlation)



all_qs %>%
  filter(Year == '2021') %>%
  select(-Provider, -Year) %>%
  lm(Q27 ~ ., data = .) -> lm_obj

lm_obj %>% summary()

regclass::VIF(lm_obj)

all_qs_with_scale %>%
  filter(Year == '2021') %>%
  select(Q26, Q27, matches('Scale'), Russell_group) %>%
  lm(Q27 ~ ., data = .) -> lm_obj

regclass::VIF(lm_obj)

lm_obj %>% summary()

all_qs_with_scale %>%
  filter(Year == '2021') %>%
  select(Q26, Q27, matches('Scale'), Russell_group) %>%
  cor() %>%
  corrplot::corrplot.mixed()

