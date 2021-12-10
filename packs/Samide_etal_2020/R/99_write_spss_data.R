
here::here('R/00_read_data.R') |>
  source()

video_summaries |>
  haven::write_sav(
    path = here::here('data/Samide_etal_2020.sav')
    )
