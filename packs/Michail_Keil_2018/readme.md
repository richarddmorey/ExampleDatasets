---
title: Description of Michail & Keil (2018) data set 
author: Richard D. Morey
date: 4 October, 2021
output: html_document
---

This directory contains data from Michail and Keil (2018), "High cognitive load enhances the susceptibility to non-speech
audiovisual illusions" in the journal *Scientific Reports*. 

> ABSTRACT: The role of attentional processes in the integration of input from different sensory modalities is complex and multifaceted. Importantly, little is known about how simple, non-linguistic stimuli are integrated when the resources available for sensory processing are exhausted. We studied this question by examining multisensory integration under conditions of limited endogenous attentional resources. Multisensory integration was assessed through the sound-induced flash illusion (SIFI), in which a flash presented simultaneously with two short auditory beeps is often perceived as two flashes, while cognitive load was manipulated using an n-back task. A one-way repeated measures ANOVA revealed that increased cognitive demands had a significant effect on the perception of the illusion while post-hoc tests showed that participants’ illusion perception was increased when attentional resources were limited. Additional analysis demonstrated that this effect was not related to a response bias. These findings provide evidence that the integration of non-speech, audiovisual stimuli is enhanced under reduced attentional resources and it therefore supports the notion that top-down attentional control plays an essential role in multisensory integration.

Michail and Keil quickly presented to participants zero, one, two tones paired with either no, one or two flashes. Participants were asked to report how many flashes they saw. Sometimes when they present two tones and only one flash, people perceive *two* flashes instead of one, as though the brain assumes that the tones and flashes together must be from a common source and 'fills in' the 'missing' flash.

Illusions are generally thought to be caused by low-level processes, which should mean they don't require attention (which is generally considered a higher-level process) to happen. Our conscious experience has sounds and visual images integrated together, but the process by which this occurs is not well-understood.

Michail and Keil wanted to understand better the things that can affect the integration of sound and vision. To do so, they examined rates of illusory flashes under an increasing working memory load. Their question: to what extent does taxing someone's working memory change how often they 'see' the illusion?

### Conditions

#### Tones and flashes

The table below shows the different ways tones could be paired with flashes. See Figure 1 (p. 2) for an outline of a trial.

|Condition (`A`: auditory, `V`: visual)   | Data included? | Description          |
|:------------|:------|--------------|
|`A2V1`       | Yes | Two tones, one flash *(critical condition)* | 
|`A0V1`       | No  | No tones, one flash | 
|`A0V2`       | No  | No tones, two flashes | 
|`A1V0`       | No  | One tone, no flash | 
|`A1V1`       | No  | One tone, one flash | 
|`A1V2`       | Yes | One tone, two flashes | 
|`A2V0`       | No  | Two tones, no flash | 
|`A2V1LATE`   | Yes | Two tones, one flash; second tone was delayed | 
|`A2V2`       | No  |Two tones, two flashes | 

Michail and Keil measured the response time and illusion rate: that is saying you saw two flashes in `A2V1` or `A2V1LATE`, or one flash in `A1V2`).

#### n-back

In-between the tone/flash task trials, participants were asked to perform n-back trials. In an [n-back](https://en.wikipedia.org/wiki/N-back) task, participants are given a letter to remember on the screen, one at a time. Participants are asked to indicate when the presented letter is the same as the one presented a few trials before ("n [trials] back"). Increasing n requires continually remembering more letters. 

|Condition    | Description   |
|:------------|:--------------|
| `no_back`   | Participants were not performing an n-back task |
| `0_back`    | Participants had to respond when the last-presented letter was the same as the current letter (e.g. `K,W,A,A`; the second A would trigger a response) |
| `1_back`    | Participants had to respond when the last-presented letter was the same as the letter presented *with one intervening trial* (e.g. `K,W,A,Z,A`; the second A would trigger a response)|
| `2_back`    | Participants had to respond when the last-presented letter was the same as the letter presented *with two intervening trials* (e.g. `K,W,A,Z,Q,A`; the second A would trigger a response)|

Results in the critical `A2V1` condition are shown in Figure 2 and Tables 2 and 3.

## Files:

Below I describe the critical files in the folder

| Filename                | Type      | Description |
|:------------------------|:------|:------------|
| `readme.md`             | File    | File describing the folder contents |
| `readme.html`           | File    | Compiled HTML version of `readme.md` |
| `Michail_Keil_2018.Rproj` | File | RStudio project file for running the R code |
| `.Rprofile` | File | File to load `renv` for the R analyses (installs the necessary packages) |
| `renv.lock` | File | List of package versions used by `renv` |
| `data`  | Folder | Contains a `csv` file with the compiled data |
| `documents` | Folder | Contains a PDF copy of Michail and Keil (2018), from which the data are taken |
| `raw-data` | Folder | Contains the data as received from author G. Michail in September 2021 |
| `R` | Folder | Contains R code to compile the raw data and to do a basic analysis |
| `renv` | Folder | Contains the necessary working files for `renv` to install necessary packages  |


## Contents of `data/Michail_Keil_2018.csv`

Each row in the file `Michail_Keil_2018.csv` represents an summary of responses of a single participant in a particular flash-task/n-back combination of conditions.

The following table describes the columns in the data file:

| Column name   | Content | Description    |
|:--------------|:--------|:---------------|
| `id`          | Integer (min: 1, max: 16) | Participant ID number |
| `cond`        | String | Tone/flash condition; see table above for key |
| `n_back`      | String | n-back condition; see table above for key |
| `flash_err_rate` | Numeric | Proportion of erroneous ('illusory') responses in the corresponding condition |
| `rt` | Numeric | Average time to respond to trials in the corresponding condition |


## The `R` folder

| File or Folder    | Type | Description      |
|:------------------|:-----|:-----------------|
| `read_write_raw_data.R`      | File | Script to read the data in `raw_data/` and output a combined `csv`, which is placed in `data/` | 
| `analysis.R`      | File | Script to perform all analyses. |

If you are using R to run this code, it is recommended you open the project file `Michail_Keil_2018.Rproj` in RStudio. You can then install `renv` and run:

```
renv::restore()
```

which will install all necessary packages listed in `renv.lock` to run the R scripts.


---

Michail, G., & Keil, J. (2018). High cognitive load enhances the susceptibility to non-speech audiovisual illusions. Scientific Reports, 8(1), 11530. https://doi.org/10.1038/s41598-018-30007-6
