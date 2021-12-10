---
title: Data and analysis files for Müller & Rothermund (2014)
author: Richard D. Morey (moreyr@cardiff.ac.uk)
date: 8 September 2021
---

## Description

This folder contains the raw data files, a compiled data file, cleaning code, and analysis code for Müller & Rothermund (2014), "What Does It Take to Activate Stereotypes? Simple Primes Don’t Seem Enough". It also contains a copy of the published paper.

> **ABSTRACT**: According to social cognition textbooks, stereotypes are activated automatically if appropriate categorical cues are processed. Although many studies have tested effects of activated stereotypes on behavior, few have tested the process of stereotype activation. Blair and Banaji (1996) demonstrated that subjects were faster to categorize first names as male or female if those were preceded by gender congruent attribute primes. The same, albeit smaller, effects emerged in a semantic priming design ruling out response priming by Banaji and Hardin (1996). We sought to replicate these important effects. Mirroring Blair and Banaji (1996) we found strong priming effects as long as response priming was possible. However, unlike Banaji and Hardin (1996), we did not find any evidence for automatic stereotype activation, when response priming was ruled out. Our findings suggest that automatic stereotype activation is not a reliable and global phenomenon but is restricted to more specific conditions.

Participants performed two tasks. In the first, the Gender Categorization Task (GCT) participants were asked to categorize names that are stereotypically male or female (e.g., "Albert" and "Susanne", respectively). Importantly, these words were be preceded by a quickly-presented "prime" (on screen for 200ms). Previous researchers (e.g. Blair & Banaji, 1996), have found that presenting a female-stereotyped prime word (e.g., 'flowers') speeds categorization of female-stereotyped names (and similarly for male-stereotyped words/names). This has been taken as evidence that stereotypes are automatically activated, as the prime is irrelevant to the decision. Müller & Rothermund sought to replicate this result, as well as test the stereotype automaticity hypothesis.

One problem with inferring stereotype automaticity is that in the GCT, *both* the prime and the target could be categorised as "male" or "female". Thus, if the task is "categorize the words you see as male or female", then priming would be expected simply because "female" primes and "female" targets would share a response. This is called "response priming" and can occur simply because of the demands of the task, rather than automatic stereotype activation. 

In Müller & Rothermund's second task, the Semantic Categorization Task (SCT), participants had to categorize names as cities (e.g., "Berlin") or persons (e.g., "Monika" or "Wolfgang"). As in the GCT, these target words were preceded by primes that were male- or female-stereotyped. Importantly, in the SCT, male and female names *share* the same response. If stereotype activation is automatic, then female-stereotyped words should still prime categorization of female names, and similarly with male words/names. If, on the other hand, priming in the GCT task is due to response priming, we'd expect the priming effect to disappear in the SCT.

The data and code below is setup to enable replication of Müller & Rothermund's analysis (p. 190-191).

## Files and folders


| File or Folder | Type    | Description      |
|:---------------|:--------|:-----------------|
| `Müller and Rothermund.Rproj` | File | Project file for Rstudio |
| `readme.md`    | File    | A description of the folder contents, as markdown text |
| `readme.html`  | File    | An HTML compiled version of `readme.md` |
| `renv.lock`    | File    | File containing a list of all package needed for R to run the project (using `renv`) |
| `.Rprofile`    | File    | Script file loaded when R starts (loads `renv`) |
| `data` | Folder  | Contains compiled versions of the data set, with all participants combined into single SPSS files. See details below. |
| `documents`    | Folder  | Contains a PDF copy of Müller & Rothermund (2014) |
| `figure`       | Folder  | When figures are created by the R code, they will be placed in this folder |
| `R`            | Folder  | `R` scripts to run the loading, cleaning, and analysis |
| `raw_data`     | Folder  | Contains the raw data as obtained from Müller & Rothermund (2014) (see https://osf.io/tv8ai). These files are in an inconvenient format. |
| `renv`         | Folder | Contains package files needed to run the R scripts (using `renv`) |

## Data files in `data/`

See the codebook at https://osf.io/kifu5/.

### `data/priming_long.sav`

This data set was created by the R code in `R/00_read_data.R`. Note that it has been partially cleaned as described by Müller & Rothermund by:

1. removing participants with a missing info file, and
2. removing participants who did not complete all trials (124 response priming trials and 248 semantic priming trials).

After removing the corresponding participant IDs, the data set contains data for 294 participants (see Müller & Rothermund, p. 188).

#### Description of data columns

For a list of all primes and targets and their translations, see Müller & Rothermund's Table 1 (primes, p. 189) and Table 2 (targets, p. 190).

|Column             |Content                                                                            |Description                                                                                          |
|:------------------|:----------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------|
|`id`               |Integer code                                                                       |Subject ID                                                                                           |
|`PrimeGender`      |String ('f': female, 'm': male)                                                        |Prime is stereotypically male or female                                                              |
|`TargetID`         |Integer code                                                                       |ID identifying each target word                                                                      |
|`PrimeID`          |Integer code                                                                       |ID identifying each prime word                                                                       |
|`PrimeWordtype`    |String ('verb': verb, 'substantiv': noun, 'adjektiv': adjective, 'definition': by definition) |Wordtype of prime word. Words of type *definition* are related to their gender 'by definition', not by stereotype. |
|`TargetGender`     |String ('f': female, 'm': male)                                                        |Target is stereotypically male or female                                                             |
|`PrimeValence`     |('neutral', 'positive', 'negative', or blank [for prime type 'definition'])                                               |Valence of Prime if applicable                                        |
|`Accuracy`         |Integer (0: incorrect, 1: correct)                                                 |Whether the response was correct                               |
|`RT`               |Numeric, milliseconds                                                                            |Reaction time to categorize target                                                                                  |
|`TargetWord`       |String                                                                             |Actual Target word                                                                                   |
|`RequiredResponse` |String                                                                             |Correct response to the target                                                                       |
|`PrimeWord`        |String                                                                             |Actual Prime word                                                                                    |
|`Response`         |String                                                                             |Response actually given                                                                              |
|`type`             |String ('response': GCT, 'semantic': SCT)                                              |Type of Priming Task (Response or Semantic, i.e. GCT or SCT) 

### `data/priming_long_clean.sav`

This data set was created by the R code in `R/01_clean_data.R` from the partially-cleaned data in `data/priming_long.sav`. 

It has been partially cleaned as described by Müller & Rothermund by:

1. removing all incorrect trials,
2. removing all trials on which the target was a town (these filler trials are irrelevant to the hypothesis), and
3. removing all trials on which the response time is greater than 1.5 times the interquartile range over the third quartile for each participant in each condition.[^1]

[^1]: Note that this cleaning step is different from that described by Müller & Rothermund (p. 190). They only describe removing within participants, not conditions. I have confirmed via personal communication that they did, in fact, correctly clean within conditions as well.

The columns in the `priming_long_clean.sav` are the same as those for `priming_long.sav`

## The `R` folder

| File or Folder    | Type | Description      |
|:------------------|:-----|:-----------------|
| `00_read_data.R`  | File | Script to generate long form, uncleaned data set from raw data. This script will place the cleaned data in the `data/` folder. |
| `01_clean_data.R` | File | Script to clean the data (removing large RTs, errors) as described by Müller and Rothermund. This script will place the cleaned data in the `data/` folder. |
| `02_analysis.R`  | File | Script to analyze the cleaned data set. This script will place figures in the `figures/` folder. |

If you are using R to run this code, it is recommended you open the project file `Müller and Rothermund.Rproj` in RStudio. You can then install `renv` and run:

```
renv::restore()
```

which will install all necessary packages listed in `renv.lock` to run the R scripts.


## Citations

* Blair, I. V., & Banaji, M. R. (1996). Automatic and controlled processes in stereotype priming. *Journal of Personality and Social Psychology*, *70(6)*, 1142–1163. https://doi.org/10.1037/0022-3514.70.6.1142

* Banaji, M. R., & Hardin, C. D. (1996). Automatic stereotyping. *Psychological Science*, *7(3)*, 136–141. https://doi.org/10.1111/j.1467-9280.1996.tb00346.x


* Müller, F., & Rothermund, K. (2014). What Does It Take to Activate Stereotypes? Simple Primes Don’t Seem Enough. *Social Psychology*, *45(3)*, 187–193. https://doi.org/10.1027/1864-9335/a000183
