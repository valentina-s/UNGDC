# Topic Modeling Results

## Data

- Data used for topic modeling: `cleaned.csv` (193.5MB)
- This version was generated after removing stop words, white spaces by using the `light.RDS` (105MB). 


## Trial 1: duration 1945:2022, interval 10
This version did not get read of punctuations and numbers. Top 1-2 words across various topics included punctuations and numbers without any semantic significance.

Execute the file [`LDA_trial1.R`](https://github.com/Jihyeonbae/UNGDC/blob/main/notebooks/exploratory/LDA_trial1.R) 

Outputs are stored in [`output`](https://github.com/Jihyeonbae/UNGDC/blob/main/output/lda/decade_0112).

Average time took for one interval: 15 minutes

## Trial 2: duration 1945:2022, interval 10
This version removed punctuations and numbers. I tried to store results in .json format, but couldn’t read in the results successfully. 


Execute the file [`LDA_trial2.R`](https://github.com/Jihyeonbae/UNGDC/blob/main/notebooks/exploratory/LDA_trial2.R)

Outputs are stored in [`output`](https://github.com/Jihyeonbae/UNGDC/blob/main/output/lda/decade_0114)

|Window|Time taken|
|---|---|
|(1945,1955] | 336.201000000001 seconds|
|(1955,1965] | 679.948 seconds|
|(1965,1975] | 785.632999999998 seconds|
|(1975,1985] | 1193.288 seconds|
|(1985,1995] | 960.959999999999 seconds|
|(1995,2005] | 688.788 seconds|
|(2005,2015] | 795.713000000003 seconds|
|(2015,2022] | 643.760999999999 seconds|

## Trial 3: duration 1945:2022, interval 10

This version removed punctuations and numbers. I saved results in .RDS format. 

Execute the file [`LDA_trial3.R`](https://github.com/Jihyeonbae/UNGDC/blob/main/notebooks/exploratory/LDA_trial3.R)

Outputs are stored in [output](https://github.com/Jihyeonbae/UNGDC/blob/main/output/lda/decade_0115).


## Trial 4: duration 1945:2022, interval 10
This version removed punctuations and numbers. I saved results in .RDS format. 
Filtered statements that mention the keyword of interest “sovereignty.” 
Execute file name [`LDA_trial4.R`]("https://github.com/Jihyeonbae/UNGDC/blob/main/notebooks/exploratory/LDA_trial1.R).

Outputs are stored in [`output`](https://github.com/Jihyeonbae/UNGDC/blob/main/output/lda/decade_0115_2).


