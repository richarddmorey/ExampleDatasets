source(here::here('R/00_read_data.R'))

# Create a correlation matrix as in described in
# Dewey & Knoblich (2014):
# 
# "All reported correlations are Pearson’s R,
# except for the values in columns seven and eight, which are
# Spearman’s Rho due to the non-normality of the Likert scale
# ratings." (p. 5)
#
# @param df 
# @param .test return (uncorrected) p values instead of correlations?
#
create_cor_mat = function(df, .test = FALSE){
  df %>%
    select(-(1:3)) -> df
  
  df %>%
    as.matrix() %>%
    Hmisc::rcorr(type = 'p') -> tab
  
  df %>%
    as.matrix() %>%
    Hmisc::rcorr(type = 's') -> spearman_tab
  
  if(.test){
    tab = tab[[3]]
    spearman_tab = spearman_tab[[3]]
  }else{
    tab = tab[[1]]
    spearman_tab = spearman_tab[[1]]
  }
  
  tab[,7:8] = spearman_tab[,7:8]
  tab[lower.tri(tab)] = NA 
  diag(tab) = NA
  return(tab)
}


library(tidyr)

tb_data %>%
  pivot_wider(
    id_cols = c(subid, gender, order, delay),
    values_from = estimated_interval,
    names_from = condition) %>%
  mutate(tb_agency = Observational - Operant) %>%
  pivot_wider(
    id_cols = c(subid, gender, order),
    names_from = delay,
    values_from = tb_agency, names_prefix = 'tb_'
  ) -> tb_agency

sa_data %>%
  pivot_wider(
    id_cols = c(subid, gender, order),
    values_from = pse,
    names_from = condition) %>%
  mutate(
    sa_agency = Observational - Operant
    ) %>%
  select(-Operant, -Observational) -> sa_agency

agency_data %>%
  pivot_wider(
    id_cols = c(subid, gender, order),
    values_from = agency,
    names_from = task,
    names_prefix = 'likert_') -> likert_agency
  
sa_agency %>%
  full_join(tb_agency) %>%
  full_join(likert_agency) -> all_agency_measures

# Grab magical ideation and Locus of Control from
# correlation data
correlation_data %>%
  select(subid, MI, LoC) %>%
  right_join(all_agency_measures) %>%
  select(
    subid, gender, order, 
    sa_agency, matches('tb_'), 
    MI, LoC, likert_SensAtt, likert_TemBin
    ) %>%
  mutate(
    likert_SAminusTB = likert_SensAtt - likert_TemBin
    ) -> all_agency_measures

library(gt)

# Table 1
all_agency_measures %>%
  create_cor_mat() -> tab1 

all_agency_measures %>%
  create_cor_mat(.test = TRUE) %>%
  stats::p.adjust(method = 'BH', n = sum(!is.na(.))) %>%
  matrix(nrow = nrow(tab1)) %>%
  `dimnames<-`(dimnames(tab1))-> tab1_corrected_p

tab1 %>%
  as.data.frame() %>%
  mutate(row = rownames(.)) %>%
  gt(rowname_col = 'row') %>%
  fmt_number(1:9,decimals = 3) %>%
  fmt_missing(1:9, missing_text = '') %>%
  tab_header(
    title = 'Table 1',
    subtitle = 'Correlations between implicit and explicit measure of the SoA, all data.'
  ) %>%
  tab_options(
    table.font.size = '80%'
  ) %>%
  tab_footnote(
    'c.f. Dewey & Knoblich, 2014, p. 6',
    locations = cells_title('title')
  )

tab1_corrected_p %>%
  as.data.frame() %>%
  mutate(row = rownames(.)) %>%
  gt(rowname_col = 'row') %>%
  fmt_number(1:9,decimals = 3) %>%
  fmt_missing(1:9, missing_text = '') %>%
  tab_header(
    title = 'Table 1, BH-corrected p values'
  ) %>%
  data_color(
    1:9,
    scales::col_bin(
      bins = c(0,.05,1),
      palette = c('darkred', 'white'),
    )
  ) %>%
  tab_options(
    table.font.size = '80%'
  )


# Table 2
all_agency_measures %>%
  filter(order == 'SenAtt-TemBin') %>%
  create_cor_mat() -> tab2

all_agency_measures %>%
  filter(order == 'SenAtt-TemBin') %>%
  create_cor_mat(.test = TRUE) %>%
  stats::p.adjust(method = 'BH', n = sum(!is.na(.))) %>%
  matrix(nrow = nrow(tab1)) %>%
  `dimnames<-`(dimnames(tab2))-> tab2_corrected_p


tab2 %>%
  as.data.frame() %>%
  mutate(row = rownames(.)) %>%
  gt(rowname_col = 'row') %>%
  fmt_number(1:9,decimals = 2) %>%
  fmt_missing(1:9, missing_text = '') %>%
  tab_header(
    title = 'Table 2',
    subtitle = 'Correlations among implicit and explicit measure of the SoA, SA-TB task order.'
    ) %>%
  tab_options(
    table.font.size = '80%'
  ) %>%
  tab_footnote(
    'c.f. Dewey & Knoblich, 2014, p. 6',
    locations = cells_title('title')
  )


tab2_corrected_p %>%
  as.data.frame() %>%
  mutate(row = rownames(.)) %>%
  gt(rowname_col = 'row') %>%
  fmt_number(1:9,decimals = 3) %>%
  fmt_missing(1:9, missing_text = '') %>%
  tab_header(
    title = 'Table 2, BH-corrected p values'
  ) %>%
  data_color(
    1:9,
    scales::col_bin(
      bins = c(0,.05,1),
      palette = c('darkred', 'white'),
    )
  ) %>%
  tab_options(
    table.font.size = '80%'
  )


# Table 3
all_agency_measures %>%
  filter(order == 'TemBin-SenAtt') %>%
  create_cor_mat() -> tab3

all_agency_measures %>%
  filter(order == 'TemBin-SenAtt') %>%
  create_cor_mat(.test = TRUE) %>%
  stats::p.adjust(method = 'BH', n = sum(!is.na(.))) %>%
  matrix(nrow = nrow(tab1)) %>%
  `dimnames<-`(dimnames(tab3))-> tab3_corrected_p


tab3 %>%
  as.data.frame() %>%
  mutate(row = rownames(.)) %>%
  gt(rowname_col = 'row') %>%
  fmt_number(1:9,decimals = 2) %>%
  fmt_missing(1:9, missing_text = '') %>%
  tab_header(
    title = 'Table 3',
    subtitle = 'Correlations among implicit and explicit measure of the SoA, TB-SA task order.'
  ) %>%
  tab_options(
    table.font.size = '80%'
  ) %>%
  tab_footnote(
    'c.f. Dewey & Knoblich, 2014, p. 7',
    locations = cells_title('title')
  )



tab3_corrected_p %>%
  as.data.frame() %>%
  mutate(row = rownames(.)) %>%
  gt(rowname_col = 'row') %>%
  fmt_number(1:9,decimals = 3) %>%
  fmt_missing(1:9, missing_text = '') %>%
  tab_header(
    title = 'Table 3, BH-corrected p values'
  ) %>%
  data_color(
    1:9,
    scales::col_bin(
      bins = c(0,.05,1),
      palette = c('darkred', 'white'),
    )
  ) %>%
  tab_options(
    table.font.size = '80%'
  )


article_pdf_path = here::here('documents/Dewey_Knoblich_2014.pdf') 

library(tabulizer)

article_pdf_path %>%
  extract_tables() -> pdf_tabs

pdf_tab1 = pdf_tabs[[1]][-1,4:12]
diag(pdf_tab1) = ''
pdf_tab1 %>%
  sub(pattern = '*', replacement = '', fixed = TRUE) %>%
  sub(pattern = '^2', replacement = '-') %>%
  as.numeric() %>%
  matrix(nrow = 9) -> pdf_tab1


(round(tab1,2) - pdf_tab1) %>%
  data.frame() %>%
  mutate(row = rownames(.)) %>%
  gt(rowname_col = 'row') %>%
  fmt_number(1:9) %>%
  tab_header(
    title = 'Deviations between calculated table and PDF table 1'
  ) %>%
  data_color(
    1:9,
    scales::col_numeric(
      palette = 'RdBu',
      domain = c(-.3,.3),
      reverse = TRUE
    )
  ) %>%
  fmt_missing(1:9, missing_text = '') %>%
  tab_options(
    table.font.size = '80%'
    )


pdf_tab2 = pdf_tabs[[2]][,5:13]
diag(pdf_tab2) = ''
pdf_tab2 %>%
  sub(pattern = '*', replacement = '', fixed = TRUE) %>%
  sub(pattern = '^2', replacement = '-') %>%
  as.numeric() %>%
  matrix(nrow = 9) -> pdf_tab2

(round(tab2,2) - pdf_tab2) %>%
  data.frame() %>%
  mutate(row = rownames(.)) %>%
  gt(rowname_col = 'row') %>%
  fmt_number(1:9) %>%
    tab_header(
    title = 'Deviations between calculated table and PDF table 2'
  ) %>%
  data_color(
    1:9,
    scales::col_numeric(
      palette = 'RdBu',
      domain = c(-.25,.25),
      reverse = TRUE
    )
  ) %>%
  fmt_missing(1:9, missing_text = '') %>%
  tab_options(
    table.font.size = '80%'
  )



# Frustratingly, table 3 does not come out with tabulizer. 
# We need to use OCR.

temppng = tempfile(fileext = '.png')

library(magick)

area_inches = c(4269, 957, 1550, 885) / 600
dpi = 600
area_pixels = area_inches * dpi

article_pdf_path %>%
  pdftools::pdf_convert(
    dpi = dpi,
    pages = 7,
    filenames = temppng
  ) %>%
  image_read() %>%
  image_rotate(90) %>%
  image_crop(
    geometry_area(
      width = area_pixels[1], 
      height = area_pixels[2], 
      x_off = area_pixels[3],
      y_off = area_pixels[4]
      )
    ) %>%
  image_write(path = temppng)

library(tesseract)

temppng %>%
  tesseract::ocr() %>%
  stringr::str_replace_all(pattern = '—', '-') %>%
  stringr::str_remove_all('\\*|^- ') %>%
  stringr::str_replace_all(pattern = '([- \n])([0-9])', '\\1.\\2') %>%
  stringr::str_replace_all(pattern = '\n- ', '\n') %>%
  strsplit('[\n ]') %>%
  unlist() %>%
  as.numeric() -> lt

# There is one element that doesn't seem to like to OCR properly
lt[9] = -lt[9]

pdf_tab3 = pdf_tab2 + NA
pdf_tab3[lower.tri(pdf_tab3)] = lt
pdf_tab3 = t(pdf_tab3)

(round(tab3,2) - pdf_tab3) %>%
  data.frame() %>%
  mutate(row = rownames(.)) %>%
  gt(rowname_col = 'row') %>%
  fmt_number(1:9) %>%
  tab_header(
    title = 'Deviations between calculated table and PDF table 3'
  ) %>%
  data_color(
    1:9,
    scales::col_numeric(
      palette = 'RdBu',
      domain = c(-.25,.25),
      reverse = TRUE
    )
  ) %>%
  fmt_missing(1:9, missing_text = '') %>%
  tab_options(
    table.font.size = '80%'
  )




