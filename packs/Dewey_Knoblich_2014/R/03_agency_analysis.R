library(dplyr)


agency_data %>%
  group_by(task) %>%
  summarise(mean = mean(agency))


library(ARTool)

agency_data %>%
  art(agency ~ task * order + Error(subid/task), data=.) %>%
  anova() %>%
  mutate(
    p.eta.sq = `Sum Sq`/(`Sum Sq` + `Sum Sq.res`)
    ) -> art_obj
  
print(art_obj, verbose = TRUE)

library(gt)

art_obj %>%
  gt() %>%
  fmt_number(
    columns = 5:10,
    decimals = 3
    )
