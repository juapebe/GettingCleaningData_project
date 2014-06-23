---
output: html_document
---
# CodeBook
##Author: undisclosed for evaluation purposes. June 20, 2014.
This file contains a description of the data of origin and variables for the execution of the script 'run_analysis.R' attached. This is part of my project work for the course "getting and cleaning data" on Coursera.   


###Description of the dataset
The data used in this assignment contains the many recordings that a SAMSUNG mobile device took while the users were performing various activities.  

As in the website:  
*The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data*  

###Input data
The script will work on the files present in the folder *UCI HAR Dataset*, which can be obtained by unzipping the file from [this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). In short, the files it reads are as follows. 
* **activity_labels**: containing the names of the activities that the subject performed and the numerical code they are assigned to use in the '_Y' files (see below).   
* **features**: the names of the variables that are measured by the mobile device, as *per provider*   
* **subject_test**: the numerical identificator of the subject in the recording activity. For the test set.   
* **subject_train**: the numerical identificator of the subject in the recording activity. For the train set.   
* **test_X** and **train_X**: contains the numerical values for the different variables that are measured by the device. For the test and train sets, respectively.  
* **test_Y** and **train_Y**: describe the activity that the user was performing when the record was taken. They are expressed in numerical value, as explained above in 'activity_labels'.


###Functions in the script
I structured the 'run_analysis.R' script into four functions in an effort to make it more readable/easier to understand. The functions are:
* **readData()**: reads all the data files in the "UCI HAR Dataset". This directory must be in the same directory as the script or it will not run.
* **extract_mean_stdev(<data.frame>)**: traverses the names of the variables in the given data frame and remove those variables that do not correspond to means (contain *-mean()* anywhere in the name) or standard deviation values (*-std()* anywhere in the variable name).
* **replace_strings(query, string, newvalue)**: takes a string (*query*) and, if *string* characters are present, replace them with *newvalue*.
* **rename_features(fv)**: takes a vector of strings *fv* and executes a series of string modifications, mostly multiple callings to the *replace_strings* function.

###Description of the workflow


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

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
