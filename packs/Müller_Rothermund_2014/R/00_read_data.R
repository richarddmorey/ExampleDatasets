# Code:
# Richard D. Morey, September 2021

# Data:
# Müller, F., & Rothermund, K. (2014). What Does It Take to 
#    Activate Stereotypes? Simple Primes Don’t Seem Enough. 
#    *Social Psychology*, *45(3)*, 187–193. 
#    https://doi.org/10.1027/1864-9335/a000183


library(dplyr)
library(magrittr) # for %<>%
library(tidyr) # for pivot_*

# Define custom function to read each data file in
# Importantly, includes two things:
# a) the type of each column (col_types) and
# b) the file name
# The function returns a tibble
read_file = function(fn, base_dir)
{
  file.path(base_dir, fn) %>%
    readr::read_csv(col_types = 'ccccccidcccc') %>%
    mutate(file = fn)
}

# Where are the data files stored?
data_path = here::here('raw_data')

# list.file: Produce a list of all the relevant data files (the 
#   ones ending in 'Priming.csv'), then
# purrr::map_df: pass every file name to read_file, combine them in a 
#   tibble, then
# mutate: create some additional necessary columns using the 
#   information in the file name, then
# put everthing in a variable called 'priming_data'
list.files(data_path, pattern = 'Priming.csv', recursive = TRUE) %>%
  purrr::map_df(
    read_file, base_dir = data_path
    ) %>%
  mutate(type = case_when(
    grepl(x = file, pattern = "Response") ~ "response",
    TRUE ~ "semantic"),
    id = stringr::str_extract(file, "S[0-9]+"),
    id = stringr::str_remove(id, 'S')
    ) -> priming_data

# Find all participant info files, and extract
# ID numbers
list.files(data_path, pattern = "Info.csv",  recursive = TRUE) %>%
  stringr::str_extract("S[0-9]+") %>%
  stringr::str_remove("S") -> info_ids

# Filter out participants having no corresponding info file,
# then work out which ids have complete numbers of 
# trials in both conditions, and save these ids in
# variable complete_data_ids
priming_data %>%
  filter( id %in% info_ids ) %>%
  group_by(id, type) %>%
  summarise(
    n = n()
    ) %>%
  pivot_wider(
    names_from = type, values_from = n
    ) %>%
  filter(
    response == 124 & semantic == 2*124
  ) %>%
  pull(id) -> complete_data_ids

# Filter to include only ids with complete data, then
# rearrange the columns and get rid of file column
priming_data %<>%
  filter( id %in% complete_data_ids) %>%
  select(id, everything(), -file)

priming_data %>%
  haven::write_sav(
    path = here::here('data/priming_long.sav')
  )
