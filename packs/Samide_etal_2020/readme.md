---
title: Description of Samide et al. (2020) data set
author: Richard D. Morey
date: 2 December, 2021
output: html_document
---

This directory contains data from Samide, Cooper, and Ritchie  (2020), "A database of news videos for investigating the dynamics
of emotion and memory", published in the journal *Behavior Research Methods*. The materials and data are as obtained from their [project website](https://www.thememolab.org/paper-videonorming/).

> ABSTRACT: Emotional experiences are known to be both perceived and remembered differently from nonemotional experiences, often leading to heightened encoding of salient visual details and subjectively vivid recollection. The vast majority of previous studies have used static images to investigate how emotional event content modulates cognition, yet natural events unfold over time. Therefore, little is known about how emotion dynamically modulates continuous experience. Here we report a norming study wherein we developed a new stimulus set of 126 emotionally negative, positive, and neutral videos depicting real-life news events. Participants continuously rated the valence of each video during its presentation and judged the overall emotional intensity and valence at the end of each video. In a subsequent memory test, participants reported how vividly they could recall the video details and estimated each video’s duration. We report data on the affective qualities and subjective memorability of each video. The results replicate the well-established effect that emotional experiences are remembered more vividly than nonemotional experiences. Importantly, this novel stimulus set will facilitate research into the temporal dynamics of emotional processing and memory.

## Introduction

In their paper "A database of news videos for investigating the dynamics of emotion and memory", Samide, Cooper, and Ritchie (2019) describe a set of television news clips that they collected from various sources (example: "Dallas bookstore selling rare books sees an increase in interest from buyers. The bookstore specializes in bibles, mormon [sic] texts, classics, and American history."). As part of their collection process, they asked 100 people to rate the news clips on a number of variables, including emotional valence (i.e., whether they evoke positive or negative emotions), arousal (the strength of the emotion evoked by the news clip), and coherence (how easy to follow the story in the clip was).

For valence and arousal, participants were asked to use a scale from 1 to 9 to rate the clips. For instance, an extremely negative emotional news clip might receive a valence rating of 1, while an extremely positive news clip might receive a rating of 9.

Samide et al. intend for these clips to be used in experiments on emotion and memory; for instance, one could might manipulate participants’ mood to be negative by showing negative news clips (i.e. "Children are dying from misuse and overprescribing of psychiatric drugs. One million children have been diagnosed with controversial childhood bipolar disorder.") or positive news clips (i.e., "Sea rescue informs trainer that her dolphin is saved from previous injuries. She expresses her gratitude and excitement regarding his newly improved condition.").

The authors collected 126 news clips. The average ratings on all the variables of interest are given in the included SPSS file `Video_Summary_Data.sav`.

## Files:

Below I describe the critical files in the folder. The files in `raw_data/` were obtained from the project's [project website](https://www.thememolab.org/paper-videonorming/).

| Filename                | Type      | Description |
|:------------------------|:------|:------------|
| `readme.md`             | File    | File describing the folder contents |
| `readme.html`           | File    | Compiled HTML version of `readme.md` |
| `Samide_etal_2020.Rproj` | File | RStudio project file for running the R code |
| `.Rprofile` | File | File to load `renv` for the R analyses (installs the necessary packages) |
| `renv.lock` | File | List of package versions used by `renv` |
| `data`  | Folder | Contains `sav` file for the, generated from the project `xlsx` files.  |
| `documents` | Folder | Contains a PDF copy of Samide et al (2020), from which the data are taken |
| `media` | Folder | Contains a png version of Figure 1 (p. 1472) (to help describe the study), as well as an example video (`CSPAN2_20170823_105600_Moons_Rare_Books.mp4`) |
| `R` | Folder | Contains R code to compile the raw data and to do basic analyses |
| `raw_data`  | Folder | Contains `csv` files with the data as obtained from the Open Science Framework |
| `renv` | Folder | Contains the necessary working files for `renv` to install necessary packages  |

## The `documents` folder

| Filename                | Type      | Description |
|:------------------------|:------|:------------|
| `Samide_etal_2020.pdf` | File  | Copy of Samide et al (2020) as published in *Behavior Research Methods* |
| `Samide_etal_2019_preprint.docx` | File    | Copy of Samide et al (2020) as a pre-print |

## The `data/` folder

The data file `data/Samide_etal_2020.sav` was generated from the `R/99_write_spss_data.R` script, which uses the compiled data obtained from the [project GitHub page](https://github.com/memobc/paper-videonorming) as found in `raw_data/Video_Summary_Data.xlsx`.

### Columns in `Samide_etal_2020.sav`


| Column name          | Content | Description    |
|:-----|:--------|:----------------------------|
|`video_number`         | Integer code | Unique numerical ID for each video  |
|`video_name`           | String       | File name of the video   |
|`url`                  | String       | Internet location of the video for downloading |
|`start_time_in_url_s`  | Numeric      | For norming, how many seconds into the video presentation start?  |
|`duration_s`           | Numeric      | For norming, how many seconds from `start_time_in_url_s` were presented? |
|`year`                 | Numeric      | Year the content was recorded |
|`short_label`          | String | Short description of content  |  
|`description`          | String | Long description of content   | 
|`category`             | String        | Broad topical category of news video   |
|`subcategory`          | String        | Narrow category of video |
|`newscaster_shown`     | String ("Yes", "No", "Briefly", "Two")  | Whether the newscaster was shown in the video            |
|`newscaster_gender`    | String ("Female", "Male", "Both")        | Gender of the newscaster            |
|`number_people_talking`| String ("1","2", "3", "4", "5", "Multiple") | How many people speak in the video |
|`location`             | String        | Geographical location that the content regards |

In addition, the means and standard deviation (`sd`) of the ratings and response times (`rt`) for the following are given:

| Value | Description       |
|:-----|------------------------------------------|
| valence            | "How pleasant overall?" (1-9) |
| arousal            | "How emotionally intense overall?" (1-9) |
| coherence          | "Was the story plot easy to follow?" ("YES": 1 or NO: 2) |
| familiarity        | "Seen or heard the story before?" ("Seen exact footage before": 1, "Familiar story, unfamiliar footage": 2, "Never seen or heard of story": 3) |
| auditory vividness | "How vividly can you recollect the auditory content?" (after a 3 second cue) | 
| visual vividness   | "How vividly can you recollect the visual content?" (after a 3 second cue) |
| duration           | "How long was the video clip (in seconds)"? (after a 3 second cue) |

Additionally, mean ratings for valence, arousal, and vividness are broken out by gender (male and female).

Column names for columns 15-50 are not given, as they are self explanatory.

## The `R` folder

The names of the R scripts begin with an integer that represents the order in which they're intended to be run. 

| File or Folder              | Type | Description      |
|:----------------------------|:-----|:-----------------|
| `00_read_data.R`      | File | Read the summary data from `raw_data/Video_Summary_Data.xlsx` and do some tidying/corrections |
| `99_write_spss_data.R`      | File | Write the SPSS data found in `data/`, for use in teaching |

If you are using R to run this code, it is recommended you open the project file `Samide_etal_2021.Rproj` in RStudio. You can then install `renv` and run:

```
renv::restore()
```

which will install all necessary packages listed in `renv.lock` to run the R scripts.


---

* Samide, R., Cooper, R. A., & Ritchey, M. (2020). A database of news videos for investigating the dynamics of emotion and memory. Behavior Research Methods, 52(4), 1469–1479. https://doi.org/10.3758/s13428-019-01327-w

