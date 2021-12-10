#' The code in this script reads the original perl scripts and works out
#' which stimuli were presented, and in what order. These files are written
#' to the materials/ordering folder.

library(dplyr)
library(stringr)

here::here('materials/code/present_stim.pl') %>%
  readLines() %>%
  str_subset(pattern = '@fullsize = ') %>%
  str_extract_all(pattern = '0[1-8]') %>%
  do.call(what = rbind) -> thumb_mat

here::here('materials/code/present_stim.pl') %>%
  readLines() %>%
  str_subset(pattern = '@resp_vars = ') %>%
  str_extract_all(pattern = 'stim[0-9]{2}') %>%
  do.call(what = rbind) -> stim_mat

here::here('materials/code/present_stim.pl') %>%
  readLines() %>%
  str_subset(pattern = '\\$thumb0[1-8] = ') %>%
  tolower() %>%
  str_extract_all('[a-zA-Z_0-9]{1,}.jpg') %>%
  unlist() %>%
  str_remove('.jpg') -> fn

stim_mapping = data.frame(
  thumb = as.integer(thumb_mat[1,]),
  stim  = stim_mat[1,],
  fn    = fn 
)

here::here('materials/code/picture_rating_2_savedata.pl') %>%
  readLines() %>%
  str_subset(pattern = 'param\\(\'stim[0-9]{2}') %>%
  str_extract_all('stim[0-9]{2}') %>%
  unlist() %>%
  data.frame(
    stim = .,
    colnum = 1:8) %>%
  full_join(stim_mapping) -> stim_mapping

apply(stim_mat, 1, function(r){
  stim_mapping$fn[match(x = r, table = stim_mapping$stim)]
}) %>% 
  t() %>%
  data.frame(
    order = 1:16,
    .) %>%
  rename_with( ~ str_replace(., 'X', 'stimnum_')) -> all_orders_stim

apply(stim_mat, 1, function(r){
  stim_mapping$colnum[match(x = r, table = stim_mapping$stim)] %>%
    order()
}) %>%
  t() %>%
  data.frame(
    order = 1:16,
    .) %>%
  rename_with( ~ str_replace(., 'X', 'colnum_')) -> all_orders_columns

expand.grid(1:2, c('lo','hi'),c('lo','hi')) %>%
  transmute(x = glue::glue('{Var3}{Var2}{Var1}_ord')) %>%
  pull(x) -> cnames
  
colnames(all_orders_columns) = c('order', cnames)

all_orders_stim %>%
  write.csv(here::here('materials/orderings/order_stimuli.csv'),
            row.names = FALSE)

all_orders_columns %>%
  write.csv(here::here('materials/orderings/order_data_columns.csv'),
            row.names = FALSE)


