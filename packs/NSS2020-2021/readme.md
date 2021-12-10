---
title: Description of NSS 2020/2021 data sets
author: Richard D. Morey
date: 26 November, 2021
output: html_document
---

This directory contains data from the 2020 and 2021 UK Education National Student Survey (NSS) obtained through the [Office for Students](https://www.officeforstudents.org.uk/advice-and-guidance/student-information-and-data/national-student-survey-nss/nss-data-provider-level/).

> "The NSS is managed by the OfS on behalf of the UK funding and regulatory bodies - the Department for the Economy (Northern Ireland), The Scottish Funding Council and the Higher Education Funding Council for Wales.
>
>The NSS gathers students’ opinions on the quality of their courses which helps to:
>
> * inform prospective students’ choices 
> * provide data that supports universities and colleges to improve the student experience support public accountability.
>
> Every university in the UK takes part in the NSS, as do many colleges. Response rates are consistently high." ([Office for Students](https://www.officeforstudents.org.uk/advice-and-guidance/student-information-and-data/national-student-survey-nss/))

## Introduction

The National Student Survey (NSS) is an annual survey of University and College students in the United Kingdom run by the survey company Ipsos Mori and sponsored by the UK Government Office for Students. Students in their final year of University respond to a variety of questions that tap their opinion about the quality of the course, from detailed questions about, for instance, IT services ("The IT resources and facilities provided have supported my learning well") to overall satisfaction ("Overall, I am satisfied with the quality of the course").

There are twenty-seven core questions. The first twenty-five of these questions are broken into eight scales:

* **Scale 1**: "The teaching on my course", Q1-Q4
* **Scale 2**: "Learning opportunities", Q5-Q7
* **Scale 3**: "Assessment and feedback", Q8-Q11
* **Scale 4**: "Academic support", Q12-Q14
* **Scale 5**: "Organisation and management", Q15-Q17
* **Scale 6**: "Learning resources", Q18-Q20
* **Scale 7**: "Learning community", Q21-Q22 
* **Scale 8**: "Student voice", Q23-Q25

The remaining two questions are about the perceived effectiveness of the Student Union (Q26) and overall satisfaction in the course (Q27). A full list of questions can be found in the table below listing the columns in the data set, or the lists of questions under `documents/surveys/`.

Responses are gathered on a five-point scale including "Definitely agree", "Mostly agree", "Neither agree nor disagree", "Mostly disagree", "Definitely disagree", with the additional option of responding "Not applicable".

The Office for Students has put together a [Frequently Asked Questions document](https://www.officeforstudents.org.uk/advice-and-guidance/student-information-and-data/national-student-survey-nss/questions-about-the-nss-data/) with answers to more detailed questions about the data.

---


## Files:


| Filename                | Type      | Description |
|:---|:---|:------------|
| `readme.md`             | File    | File describing the folder contents |
| `readme.html`           | File    | Compiled HTML version of `readme.md` |
| `NSS2021.Rproj` | File | RStudio project file for running the R code |
| `.Rprofile` | File | File to load `renv` for the R analyses (installs the necessary packages) |
| `renv.lock` | File | List of package versions used by `renv` |
| `data`  | Folder | Contains a `sav` file with summary data generated from the `xlsx` files in `raw_data/`. See `data/` section below for details. |
| `documents` | Folder | Contains PDFs with descriptions of National Student Survey methodology, the core questions, and a brief about controversies |
| `R` | Folder | Contains R code to compile the raw data and to do basic analyses |
| `raw_data`  | Folder | Contains `xlsx` files with the data as obtained from the [Office for Students](https://www.officeforstudents.org.uk/advice-and-guidance/student-information-and-data/national-student-survey-nss/nss-data-provider-level/) and a list of Russell group universities |
| `renv` | Folder | Contains the necessary working files for `renv` to install necessary packages  |

## Contents of the `documents/` folder

| Filename                | Type      | Description |
|:------------------------|:------|:------------|
| `about/the-national-student-survey-consistency-controversy-and-change.pdf`       | File    | Office for Students brief "The National Student Survey: Consistency, controversy and change" (2020), which describes the NSS and discusses its major issues |  
| `about/the-national-student-survey-2021.pdf` | File | 2021 Pre-survey circular sent to 'Providers' (Universities and Colleges) outlining the basic survey methodology and timelines, obtained from the [Office for Students](https://www.officeforstudents.org.uk/media/74f686a9-e42f-46d5-9390-f74b21d0cbae/the-national-student-survey-2021.pdf). Dates from October 2020. |
| `surveys/nss-2020-core-questionnaire-and-optional-banks.pdf`  | File    | List of questions asked in the 2020 National Student Survey, obtained from the [Office for Students](https://www.officeforstudents.org.uk/media/d462a46b-0eba-42fd-84a1-c8b6dc883c99/nss-2020-core-questionnaire-and-optional-banks.pdf)| 
| `surveys/nss-2021-core-questionnaire-optional-banks.pdf`  | File    | List of questions asked in the 2021 National Student Survey, obtained from the [Office for Students](https://www.officeforstudents.org.uk/media/703530d2-1c8f-48fc-a62d-23b278b8b799/nss-2021-core-questionnaire-optional-banks.pdf) |


## Contents of the `data/` folder

### Columns in `NSS_taught_psych-avg.sav`

In order to construct the data set for analysis, `NSS_taught_psych-avg.sav`, I did the following:

1. Compiled two years of data (2020 and 2021)
2. Restricted to first degree level
3. Restricted to courses whose categorization was "Psychology (non-specific)"
4. Focused on the listed "teaching provider" (the institution providing the teaching services, in case this is different from the institution who registered the student in the course)
5. Scored the five-point response scale from -2 ("Definitely disagree") to 2 ("Definitely agree"), computing the average response for each Provider

For the code that generated the summary data, see `R/00_read_data.R`.

| Column name          | Content | Description    |
|:--|:-----|:---------------|
| `Provider`           | String | Institution providing the teaching |
| `Russell_group`      | Integer (`0`: Not in Russell group; `1`: In Russel Group) | Whether the University is part of the [Russell group](https://russellgroup.ac.uk/about/our-universities/) of older, more research-oriented Universities |
| `Year`               | Integer (2020 or 2021) | In which year the results were collected |
| `Sample_size` | Integer | How many students could have responded |
| `Avg_rate`    | Numeric (min: .5, max: 1) | Average response rate across all questions. Note that records with less than 50% response rate were not included in the released data |
| `Q01` | Numeric (min: -2, max: 2) | "Staff are good at explaining things" (Scale 1, The teaching on my course) |
| `Q02` | Numeric (min: -2, max: 2)  | "Staff have made the subject interesting" (Scale 1, The teaching on my course) |
| `Q03` | Numeric (min: -2, max: 2)  | "The course is intellectually stimulating" (Scale 1, The teaching on my course) |
| `Q04` | Numeric (min: -2, max: 2)  | "My course has challenged me to achieve my best work" (Scale 1, The teaching on my course) |
| `Q05` | Numeric (min: -2, max: 2)  | "My course has provided me with opportunities to explore ideas or concepts in depth" (Scale 2, Learning opportunities) |
| `Q06` | Numeric (min: -2, max: 2)  | "My course has provided me with opportunities to bring information and ideas together from different topics" (Scale 2, Learning opportunities) |
| `Q07` | Numeric (min: -2, max: 2)  | "My course has provided me with opportunities to apply what I have learnt" (Scale 2, Learning opportunities) |
| `Q08` | Numeric (min: -2, max: 2)  | "The criteria used in marking have been clear in advance" (Scale 3, Assessment and feedback) |
| `Q09` | Numeric (min: -2, max: 2)  | "Marking and assessment has been fair" (Scale 3, Assessment and feedback) |
| `Q10` | Numeric (min: -2, max: 2)  | "Feedback on my work has been timely" (Scale 3, Assessment and feedback) |
| `Q11` | Numeric (min: -2, max: 2)  | "I have received helpful comments on my work" (Scale 3, Assessment and feedback) |
| `Q12` | Numeric (min: -2, max: 2)  | "I have been able to contact staff when I needed to" (Scale 4, Academic support)  |
| `Q13` | Numeric (min: -2, max: 2)  | "I have received sufficient advice and guidance in relation to my course" (Scale 4, Academic support)  |
| `Q14` | Numeric (min: -2, max: 2)  | "Good advice was available when I needed to make study choices on my course" (Scale 4, Academic support)  |
| `Q15` | Numeric (min: -2, max: 2)  | "The course is well organised and running smoothly" (Scale 5, Organisation and management)  |
| `Q16` | Numeric (min: -2, max: 2)  | "The timetable works efficiently for me" (Scale 5, Organisation and management)  |
| `Q17` | Numeric (min: -2, max: 2)  | "Any changes in the course or teaching have been communicated effectively" (Scale 5, Organisation and management)  |
| `Q18` | Numeric (min: -2, max: 2)  | "The IT resources and facilities provided have supported my learning well" (Scale 6, Learning resources)  |
| `Q19` | Numeric (min: -2, max: 2)  | "The library resources (e.g. books, online services and learning spaces) have supported my learning well" (Scale 6, Learning resources)  |
| `Q20` | Numeric (min: -2, max: 2)  | "I have been able to access course-specific resources (e.g. equipment, facilities, software, collections) when I needed to" (Scale 6, Learning resources)  |
| `Q21` | Numeric (min: -2, max: 2)  | "I feel part of a community of staff and students" (Scale 7, Learning community)  |
| `Q22` | Numeric (min: -2, max: 2)  | "I have had the right opportunities to work with other students as part of my course" (Scale 7, Learning community)  |
| `Q23` | Numeric (min: -2, max: 2)  | "I have had the right opportunities to provide feedback on my course" (Scale 8, Student voice)  |
| `Q24` | Numeric (min: -2, max: 2)  | "Staff value students’ views and opinions about the course" (Scale 8, Student voice)  |
| `Q25` | Numeric (min: -2, max: 2)  | "It is clear how students’ feedback on the course has been acted on" (Scale 8, Student voice)  |
| `Q26` | Numeric (min: -2, max: 2)  | "The students’ union (association or guild) effectively represents students’ academic interests" |
| `Q27` | Numeric (min: -2, max: 2)  | "Overall, I am satisfied with the quality of the course" |
| `Scale01` | Numeric (min: -2, max: 2)  | Average response across Q1-Q4, about "The teaching on my course" |
| `Scale02` | Numeric (min: -2, max: 2)  | Average response across Q5-Q7, about "Learning opportunities" |
| `Scale03` | Numeric (min: -2, max: 2)  | Average response across Q8-Q11, about "Assessment and feedback" |
| `Scale04` | Numeric (min: -2, max: 2)  | Average response across Q12-Q14, about "Academic support"  |
| `Scale05` | Numeric (min: -2, max: 2)  | Average response across Q15-Q17, about "Organisation and management"  |
| `Scale06` | Numeric (min: -2, max: 2)  | Average response across Q18-Q20, about "Learning resources"  |
| `Scale07` | Numeric (min: -2, max: 2)  | Average response across Q21-Q22, about "Learning community"  |
| `Scale08` | Numeric (min: -2, max: 2)  | Average response across Q23-Q25, about "Student voice"  |


## The `R` folder

The names of the R scripts begin with an integer that represents the order in which they're intended to be run. 

| File or Folder              | Type | Description      |
|:----------------------------|:-----|:-----------------|
| `00_read_data.R`      | File | Read in data from `cvs` files in `raw_data/` |
| `01_analysis.R`      | File | A basic (incomplete) analysis of the results |
| `99_write_spss_data.R`      | File | Write the SPSS data found in `data/`, for use in teaching |

If you are using R to run this code, it is recommended you open the project file `NSS2021.Rproj` in RStudio. You can then install `renv` and run:

```
renv::restore()
```

which will install all necessary packages listed in `renv.lock` to run the R scripts.


---

* Office for Students (2020, February 19). The National Student Survey: Consistency, controversy and change. *United Kingdom Office for Students*. https://www.officeforstudents.org.uk/publications/the-national-student-survey-consistency-controversy-and-change/

