---
title: Description of the stereograms data set
author: Richard D. Morey
date: 23 September, 2021
output: html_document
---

This directory contains data from Frisby and Clatworthy (1975), "Learning to see complex random-dot stereograms" in the journal Perception. The Data and Story Library (https://dasl.datadescription.com/datafile/stereograms/) gives the following description:

> Stereograms appear to be composed entirely of
random dots. However, they contain separate images that a
viewer can "fuse" into a three-dimensional (3D) image by staring
at the dots while defocusing the eyes. An experiment was
performed to determine whether knowledge of the embedded
image affected the time required for subjects to fuse the images.
One group of subjects (group NV) received no information or
just verbal information about the shape of the embedded object.
A second group (group VV) received both verbal information
and visual information (specifically, a drawing of the object).
The experimenters measured how many seconds it took for the
subject to report that he or she saw the 3D image.

The 3D image was a spiral (Figure 1, p. 175). The description above is somewhat incomplete; the experiment actually involved seven conditions, which have been grouped into two (nonvisual and visual). Here are the seven conditions, with descriptions from Frisby and Clatworthy (p. 175):

|condition          |help      | Instructions |
|:------------------|:---------|:-----------|
|no help            |nonvisual | "Be sure to press the button as soon as you see the object-in-depth". | 
|spiral and depth   |nonvisual | "The object-in-depth which you are to
look for is a spiral coming out from the screen towards you. The spiral will protrude about one foot from the screen surface. Be sure to press the button as soon as you see the spiral in depth".|
|spiral             |nonvisual | "The object-in-depth which your are to look for is a spiral. Be sure to press the button as soon as you see the spiral in depth".|
|depth              |nonvisual | "The object-in depth which you are to look for will seem to protrude about one foot from the screen surface. Be sure to press the button as soon as you see the object-in-depth".|
|model              |visual    | "The object-in-depth which you are to look for is depicted in a model which I will show you. Note that it is a spiral which protrudes about one foot from the screen surface. Be sure to press the button as soon as you see the spiral in depth". Subjects in this condition were then shown a full-scale replica of the spiral held up against the screen. |
|fixation point     |visual    | "Stare at the black dot throughout. Be sure to press the button as soon as you see the object-in-depth". In this condition a small black dot was arranged (via optical superimposition) to appear just where the tip of the spiral lay once binocular fusion had taken place. |
|monocular contours |visual    | The instructions used in this condition were the same as those used for conditions (b) full verbal prompt. However, a version of the basic spiral stereogram was used which had monocularly discriminable contours traced on to it which followed the outline of the spiral. |


## Files:

| Filename                      | Description |
|:------------------------------|:------------|
| `readme.md`                   | File describing the folder contents |
| `readme.html`                   | Compiled HTML version of `readme.md` |
| `data/stereograms_seven.csv`       | Comma-separated-values text file containing the data |
| `documents/Frisby_Clatworthy_1975.pdf`  | Copy of Frisby and Clatworthy (1975), "Learning to see complex random-dot stereograms" from which the data are taken |


## Contents of `stereograms_seven.csv`

Each row in the file `stereograms_seven.csv` represents a single participant. The 78 subjects are the ones shown in Frisby and Clatworthy's Figure 2 (p. 176). They also report (p. 176-177) that 25 participants' data were eliminated for various reasons, including responding on the wrong basis and failing a test of stereo vision.

The following table describes the columns in the data file:

| Column name   | Content | Description    |
|:--------------|:--------|:---------------|
| `ID`          | Integer (min: 1, max: 78) | Participant ID number |
| `fuseTime`    | Numeric; Time in seconds | Time taken for the participants to report that they have successfully seen ("fused") the three-dimensional image in the stereogram |
| `condition`   | String | Description of the experimental condition randomly assigned to the participants. See above for descriptions. |
| `fig2_order`  | Integer (min: 1, max: 7) | An integer giving the order of the condition in Frisby and Clatworthy's Figure 2 |
| `help` | String (`nonvisual` = no visual information given, `visual` = visual information given) | Whether the assigned condition involved visual help | 

The data in the column `fuseTime` were approximated from Figure 2 (p. 176) using [WebPlotDigitizer](https://automeris.io/WebPlotDigitizer/). The categorization into "nonvisual" and "visual" conditions was adopted from the [Data and Story Library](https://dasl.datadescription.com/datafile/stereograms/). Because the data were are approximate, the inferential statistics will not be exactly the same as what Frisby and Clatworthy report on p. 177 (nor as the descriptive statistics in Table 1, p. 178). 


---

* Frisby, J. P., & Clatworthy, J. L. (1975). Learning to See Complex Random-Dot Stereograms. *Perception*, 4(2), 173–178. https://doi.org/10.1068/p040173
