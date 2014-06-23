# CodeBook
##Author: undisclosed for evaluation purposes. June 20, 2014.
This file contains a description of the data of origin and variables for the execution of the script 'run_analysis.R' attached. This is part of my project work for the course "getting and cleaning data" on Coursera.

###Input data
The script will work on the files present in the folder *UCI HAR Dataset*, which can be obtained by unzipping the file from [this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). In short, the files it reads are as follows. 
- **activity_labels**: containing the names of the activities 
        - Item 1

###Description of the workflow
I structured the 'run_analysis.R' script into four functions in an effort to make it more readable. The functions are:
- **readData()**: reads all the data files in the "UCI HAR Dataset". This directory must be in the same directory as the script or it will not run.
- **extract_mean_stdev(<data.frame>)**: traverses the names of the variables in the given data frame and remove those variables that do not correspond to means (contain *-mean()* anywhere in the name) or standard deviation values (*-std()* anywhere in the variable name).
- **replace_strings(query, string, newvalue)**: takes a string (*query*) and, if *string* characters are present, replace them with *newvalue*.
* **rename_features(fv)**: takes a vector of strings *fv* and executes a series of string modifications, mostly multiple callings to the *replace_strings* function.



The file also contains a rough description of the process followed by the run_analysis script to generate the output data

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:


```r
summary(cars)
```

```
##      speed           dist    
##  Min.   : 4.0   Min.   :  2  
##  1st Qu.:12.0   1st Qu.: 26  
##  Median :15.0   Median : 36  
##  Mean   :15.4   Mean   : 43  
##  3rd Qu.:19.0   3rd Qu.: 56  
##  Max.   :25.0   Max.   :120
```

You can also embed plots, for example:

![plot of chunk unnamed-chunk-2](./CodeBook_files/figure-html/unnamed-chunk-2.png) 

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
