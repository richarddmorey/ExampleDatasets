# Code:
# Richard D. Morey, September 2021

# Data:
# Müller, F., & Rothermund, K. (2014). What Does It Take to 
#    Activate Stereotypes? Simple Primes Don’t Seem Enough. 
#    *Social Psychology*, *45(3)*, 187–193. 
#    https://doi.org/10.1027/1864-9335/a000183

# dplyr will give us the data science functions we'll use
# eg, "%>%", "filter", "mutate"
library(dplyr)

# tidylog will tell us what happens when we 
# filter/manipulate data
library(tidylog) 

# We want to do the following cleaning steps:
# 0. Read in the long data
# 1. Remove all incorrect trials
# 2. Remove trials where the Target is a town
# 3. Remove all trials with RTs greater than 1.5 times 
#    the IQR range over the third quartile, but 
#    grouped by: id,PrimeGender,TargetGender,type
#    (that is, participant and condition)
# 4. Get rid of the extra columns we created

here::here('derived_data/priming_long.sav') %>%
  haven::read_sav() %>%
  filter(Accuracy == 1) %>%
  filter(RequiredResponse != 'town') %>%
  group_by(id,PrimeGender,TargetGender,type) %>%
  mutate(Q3 = quantile(RT, p = 0.75),
         IQR = IQR(RT),
         upper_limit = Q3 + 1.5 * IQR) %>%
  filter(RT <= upper_limit) %>%
  select(-Q3, -IQR, -upper_limit) -> priming_clean

# Write data to an SPSS file
priming_clean %>%
  haven::write_sav(
    path = here::here('data/priming_long_clean.sav')
  )

# (Note that Mueller and Rothermund used type 6 quantiles,
# which are not the default. We use the default for simplicity. 
# The difference will be negligible)

