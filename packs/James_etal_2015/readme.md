---
title: Data and analysis of James et al (2015), Experiment 2
author: Richard D. Morey (moreyr@cardiff.ac.uk)
date: 8 September 2021
---

## Description

This folder contains the data and analysis scripts for James et al. (2015), "Computer Game Play Reduces Intrusive Memories of Experimental Trauma via Reconsolidation-Update Mechanisms". It also contains a copy of the published paper and their codebook.

> **ABSTRACT**: Memory of a traumatic event becomes consolidated within hours. Intrusive memories can then flash back repeatedly into the mind’s eye and cause distress. We investigated whether reconsolidation—the process during which memories become malleable when recalled—can be blocked using a cognitive task and whether such an approach can reduce these unbidden intrusions. We predicted that reconsolidation of a reactivated visual memory of experimental trauma could be disrupted by engaging in a visuospatial task that would compete for visual working memory resources. We showed that intrusive memories were virtually abolished by playing the computer game Tetris following a memoryreactivation task 24 hr after initial exposure to experimental trauma. Furthermore, both memory reactivation and playing Tetris were required to reduce subsequent intrusions (Experiment 2), consistent with reconsolidation-update mechanisms. A simple, noninvasive cognitive-task procedure administered after emotional memory has already consolidated (i.e., > 24 hours after exposure to experimental trauma) may prevent the recurrence of intrusive memories of those emotional events.

James et al examined effect of an intervention for reducing intrusive visual imagery from traumatic experiences. Memories are malleable when they are recalled. "Consolidation" is the process by which information settles into long-term memory; "Reconsolidation" is the process by which a recalled memories are changed and then re-enter long-term memory in their modified form. James et al. theorized that performing a secondary visual task during reconsolidation would disrupt the memory, weakening it and thus reducing future intrusive thoughts.

In Experiment 2, participants watched a disturbing video and during the next day were asked to record how many intrusive thoughts they experienced (called "Day 0"). The next day, they were brought back and randomly allocated to one of four groups:

* Reconsolidation-plus-tetris (experimental): Participants were shown images from the video ("reconsolidation"), completed a filler task, and then played Tetris.

* Tetris-only: Participants played Tetris without viewing the images from the video.

* Reconsolidation-only: Participants were shown images from the video, but then did not play Tetris.

* Control: Participants only completed the filler task and then sat, doing nothing, for the same amount of time that experimental participants played Tetris. 

The question is whether both reconsolidation and Tetris are necessary for the benefit of the intervention, in line with their hypothesis. 

## Files:

See the project Open Science Framework repository at https://osf.io/ideta/ for all project materials. Where relevant, I've supplied copies of the files contained in that repository.

| File or folder      | Type    | Description |
|:--------------------|:--------|:------------|
| `James et al.Rproj` | File    | Project file for Rstudio |
| `readme.md`         | File    | Description of the project |
| `readme.html`       | File    | An HTML compiled version of `readme.md` |
| `renv.lock`         | File    | File containing a list of all package needed for R to run the project (using `renv`) |
| `.Rprofile`         | File    | Script file loaded when R starts (loads `renv`) |
| `data`              | Folder  | Script file loaded when R starts (loads `renv`) |
| `documents`         | Folder  | Contains documents relevant to the data, including manuscript and codebook |
| `figures`           | Folder  | When figures are written by the R script, they'll be placed in this folder |
| `R`                 | Folder  | `R` scripts to run the analysis |
| `renv`              | Folder  | Contains package files needed to run the R scripts (using `renv`) |


### Files in `data/`

| File                                 | Description                                   |
|:-------------------------------------|-----------------------------------------------|
| `James_et_al_2015_Exp2.csv`          | Comma-separated-values text file containing the data |

Each row in the file `James_et_al_2015_Exp2.csv` represents a single participant. See the codebook for explanations of the data columns. 

According to the codebook (p. 1), 

> Missing data values are coded as 9999.00.

and

> All VAS mood scales [were] anchored from "not at all"" to "extremely" in response to the question "Right at this very moment I am feeling"...[The] composite for [the] pre-film mood [was] calculated by summing the six [pre/post]-film VAS mood ratings[.]


|Column                                   |Content                                                                                        |Description                                                                                                                        |
|:----------------------------------------|:----------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------|
|`Condition`                              |Integer code (1: No-Task Control, 2: Reactivation+Tetris, 3: Tetris Only 4: Reactivation Only) |Condition allocation                                                                                                               |
|`Time_of_Day`                            |Integer code (1: morning, 2: afternoon, 3: evening)                                            |Time of day                                                                                                                        |
|`BDI_II`                                 |Integer                                                                                        |Beck Depression Inventory-II: Total score                                                                                          |
|`STAI_T`                                 |Integer                                                                                        |Spielberger State-Trait Anxiety Trait scale: Total score                                                                           |
|`pre_film_VAS_Sad`                       |Numeric Visual Analogue Scale (VAS) value                                                      |Pre-film mood: Self-rated Sadness                                                                                                  |
|`pre_film_VAS_Hopeless`                  |Numeric Visual Analogue Scale (VAS) value                                                      |Pre-film mood: Self-rated Hopelessness                                                                                             |
|`pre_film_VAS_Depressed`                 |Numeric Visual Analogue Scale (VAS) value                                                      |Pre-film mood: Self-rated Depressed                                                                                                |
|`pre_film_VAS_Fear`                      |Numeric Visual Analogue Scale (VAS) value                                                      |Pre-film mood: Self-rated Fear                                                                                                     |
|`pre_film_VAS_Horror`                    |Numeric Visual Analogue Scale (VAS) value                                                      |Pre-film mood: Self-rated Horror                                                                                                   |
|`pre_film_VAS_Anxious`                   |Numeric Visual Analogue Scale (VAS) value                                                      |Pre-film mood: Self-rated Anxiousness                                                                                              |
|`post_film_VAS_Sad`                      |Numeric Visual Analogue Scale (VAS) value                                                      |Post-film mood: Self-rated Sadness                                                                                                 |
|`post_film_VAS_Hopeless`                 |Numeric Visual Analogue Scale (VAS) value                                                      |Post-film mood: Self-rated Hopelessness                                                                                            |
|`post_film_VAS_Depressed`                |Numeric Visual Analogue Scale (VAS) value                                                      |Post-film mood: Self-rated Depressed                                                                                               |
|`post_film_VAS_Fear`                     |Numeric Visual Analogue Scale (VAS) value                                                      |Post-film mood: Self-rated Fear                                                                                                    |
|`post_film_VAS_Horror`                   |Numeric Visual Analogue Scale (VAS) value                                                      |Post-film mood: Self-rated Horror                                                                                                  |
|`post_film_VAS_Anxious`                  |Numeric Visual Analogue Scale (VAS) value                                                      |Post-film mood: Self-rated Anxiousness                                                                                             |
|`Attention_Paid_to_Film`                 |Integer rating (min: 0, max: 10)                                                               |"How much attention did you pay to the film?"                                                                                      |
|`Post_film_Distress`                     |Integer rating (min: 0, max: 10)                                                               |"How distressing did you find the film?"                                                                                           |
|`Day_Zero_Number_of_Intrusions`          |Integer count                                                                                  |Day 0: Number of image-based intrusive memories in the Intrusion Diary [preintervention]                                           |
|`Days_One_to_Seven_Number_of_Intrusions` |Integer count                                                                                  |Days 1-7: Number of image-based intrusive memories in the Intrusion Diary [postintervention]                                       |
|`Visual_Recognition_Memory_Test`         |Integer count (out of 22)                                                                      |Visual recognition memory test score: Number of correct responses                                                                  |
|`Verbal_Recognition_Memory_Test`         |Integer count (out of 32)                                                                      |Verbal recognition memory test score: Number of correct responses                                                                  |
|`Number_of_Provocation_Task_Intrusions`  |Integer count                                                                                  |Intrusion Provocation Task [IPT]: Number of image-based intrusive memories during 2min laboratory task on Day 7                    |
|`Diary_Compliance`                       |Integer rating (min: 1, max: 10)                                                               |Self-rated diary compliance: "Indicate how accurate you think your diary is."                                                      |
|`IES_R_Intrusion_subscale`               |Numeric                                                                                        |Impact of Event Scale-Revised [IES-R]: Intrusion Subscale                                                                          |
|`Tetris_Total_Score`                     |Integer                                                                                        |Tetris game play computer score total - cumulative [sum of all games]                                                              |
|`Self_Rated_Tetris_Performance`          |Numeric                                                                                        |Self-rated Tetris performance: "How difficult or easy did you find the game you just played?"                                      |
|`Tetris_Demand_Rating`                   |Integer rating (min: -10, max: 10)                                                             |Demand rating: "How much did you think Tetris after a distressing film would increase or decrease intrusive memories of the film?" |

### Files in `documents/`

| File                                 | Description                                   |
|:-------------------------------------|-----------------------------------------------|
| `James_et_al_2015_Exp2_codebook.pdf` | Codebook describing the columns in the data  |
| `James_etal_2015.pdf`                | Copy of James et al. (2015), from which the data are taken. |


## The `R` folder

| File or Folder    | Type | Description      |
|:------------------|:-----|:-----------------|
| `analysis.R`      | File | Script to perform all analyses. This script will place figures in the `figures/` folder. |

If you are using R to run this code, it is recommended you open the project file `James et al.Rproj` in RStudio. You can then install `renv` and run:

```
renv::restore()
```

which will install all necessary packages listed in `renv.lock` to run the R scripts.


## Citations

James, E. L., Bonsall, M. B., Hoppitt, L., Tunbridge, E. M., Geddes, J. R., Milton, A. L., & Holmes, E. A. (2015). Computer game play reduces intrusive memories of experimental trauma via reconsolidation-update mechanisms. *Psychological Science*, *26*, 1201-1215. https://doi.org/10.1177%2F0956797615583071
