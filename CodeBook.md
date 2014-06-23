---
output: html_document
---
# CodeBook
**Author: undisclosed for evaluation purposes. June 20, 2014.**  
This file contains a description of the data of origin and variables for the execution of the script `run_analysis.R` attached. This is part of my project work for the course "getting and cleaning data" on Coursera. It requires the __plyr__ library.  


###Description of the dataset
The data used in this assignment comes from the Human Activity Recognition database, built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.  

As in the website:    

>*The experiments have been carried out with a group of 30 volunteers within an age bracket >of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, >WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) >on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear >acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments >have been video-recorded to label the data manually. The obtained dataset has been >randomly partitioned into two sets, where 70% of the volunteers was selected for >generating the training data and 30% the test data.*    

###Input data
The script will work on the files present in the folder *UCI HAR Dataset*, which can be obtained by unzipping the file from [this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). In short, the files it reads are as follows.   
* **activity_labels**: containing the names of the activities that the subject performed and the numerical code they are assigned to use in the 'Y' files (see below).   
* **features**: the names of the variables that are measured by the mobile device, as *per provider*   
* **subject_test**: the numerical identificator of the subject in the recording activity. For the test set.   
* **subject_train**: the numerical identificator of the subject in the recording activity. For the train set.   
* **test_X** and **train_X**: contains the numerical values for the different variables that are measured by the device. For the test and train sets, respectively.  
* **test_Y** and **train_Y**: describe the activity that the user was performing when the record was taken. They are expressed in numerical value, as explained above in 'activity_labels'.

###Output

Once run, the script will have generated two files:   
* **original_DataFrame** which contains all the observations (rows) in the dataset, with descriptive variable names and a column providing subject identifier number and the activity they were performing when the record was measured.  
* **means_tidyDataFrame**: which contains the average values per subject per activity, for every measured feature. This could be considered a _wide_ dataset.

###Functions in the script
I structured the 'run_analysis.R' script into four functions in an effort to make it more readable/easier to understand. The functions are:
* **readData()**: reads all the data files in the "UCI HAR Dataset". This directory must be in the same directory as the script or it will not run.  
* **extract_mean_stdev(<data.frame>)**: traverses the names of the variables in the given data frame and remove those variables that do not correspond to means (contain *-mean()* anywhere in the name) or standard deviation values (*-std()* anywhere in the variable name).  
* **replace_strings(query, string, newvalue)**: takes a string (*query*) and, if *string* characters are present, replace them with *newvalue*.  
* **rename_features(fv)**: takes a vector of strings *fv* and executes a series of string modifications, mostly multiple callings to the *replace_strings* function.  

###Description of the workflow
This script will perform the following actions:  
1. Load the data in the "UCI HAR Dataset" folder, if present in the current directory, using the 'readData()' function.  
2. Concatenates the pairs of features, subject and activity files, respectively. Sets new names for activity labels, making them more readable (lowercase and no underscore).  
3. Of the 561 original features, select only 66 that correspond to average and standard deviation values. This is done using the 'extract_mean_stdev()' function.  
4. Changes the feature (variable) names to make them more descriptive and readable. A full description of the features can be found on the `CodeBook.md` file. This is done using the 'rename_features' function, that makes multiple calls to the 'replace_strings' function.  
5. Merge the subject identified, the activity descriptor, and their corresponding features.  
6. Prints the first file containing all features to file: `original_DataFrame.txt`.  
7. Generates the second, tidy dataset containing mean values (see above sections). To do so, it:  
+ Creates a new variable that combines subject ID and activity label.  
+ Uses it to create subsets of the features in the original dataframe (total 35 sub-dataframes).  
+ Calculates the mean values for all features in each one of the 35 dataframes.  
+ Adds again the subject and activity fields, and concatenates all the sub-dataframes into a final one.  
8. Prints the tidy data frame to file `means_tidyDataFrame.txt`.

###Description of the output dataset variables
The different measurements being recorded by the Smartphone (referred as 'features') were renamed in an attempt to make them easier to understand. A more complete understanding of what each one of the columns means can be found here.  
* **Subject**: a number (1-24) that identifies the subject performing the activity being measured.  
* **Activity**: a self-explanatory description of the activity the subject was performing while the recording was taken.  
* **BodyAcc_t_[Mean/STDev][X/Y/Z]**: estimated body motion from the accelerometer, time domain. Mean and standard deviation, in the three dimensions (6 variables total).  
* **GravityAcc_t_[Mean/STDev][X/Y/Z]**: estimated gravity acceleration from the accelerometer, time domain. Mean and standard deviation, in the three dimensions (6 variables total).  
* **BodyAcc_tJerk_[Mean/STDev][X/Y/Z]**: Jerk signal (i.e. acceleration of the acceleration) for the body acceleration calculated by the accelerometer, time domain (6 variables total).  
* **BodyGyro_t_[Mean/STDev][X/Y/Z]**: angular velocity form the gyroscope, time domain.  Mean and standard deviation, in the three dimensions (6 variables total).  
* **BodyGyro_tJerk_[Mean/STDev][X/Y/Z]**: Jerk signal (i.e. acceleration of the acceleration) for the angular velocity calculated by the gyroscope, time domain (6 variables total).  
* **BodyAcc_tMag_[Mean/STDev]**: magnitude for the body acceleration measured by the accelerometer, time domain. Calculated using the Euclidean norm. Mean and standard deviation (2 variables total).   
* **GravityAcc_tMag_[Mean/STDev]**: magnitude for the gravity acceleration measured by the accelerometer, time domain. Calculated using the Euclidean norm. Mean and standard deviation (2 variables total).   
* **BodyAcc_tJerkMag_[Mean/STDev]**: Jerk signal (i.e. acceleration of the acceleration) of the magnitude of the angular velocity calculated by the gyroscope, time domain. Mean and standard deviation (2 variables total).  
* **BodyGyro_tMag_[Mean/STDev]**: magnitude for the angular velocity measured by the gyroscope, time domain. Calculated using the Euclidean norm. Mean and standard deviation (2 variables total).   
* **BodyAcc_f_[Mean/STDev][X/Y/Z]**: estimated body motion from the accelerometer, frequency domain. Mean and standard deviation, in the three dimensions (6 variables total).  
* **BodyAcc_fJerk_[Mean/STDev][X/Y/Z]**: Jerk signal (i.e. acceleration of the acceleration) for the body acceleration calculated by the accelerometer, frequency domain (6 variables total).  
* **BodyGyro_f_[Mean/STDev][X/Y/Z]**: BodyGyro_t_[Mean/STDev][X/Y/Z]: angular velocity form the gyroscope, frequency domain.  Mean and standard deviation, in the three dimensions (6 variables total).  
* **BodyAcc_fMag_[Mean/STDev]**: magnitude for the body acceleration measured by the accelerometer, frequency domain. Calculated using the Euclidean norm. Mean and standard deviation (2 variables total).     
* **BodyGyro_fJerk_[Mean/STDev][X/Y/Z]**: Jerk signal (i.e. acceleration of the acceleration) for the body acceleration calculated by the accelerometer, frequency domain. Mean and standard deviation, in the three dimensions   (6 variables total).  
* **BodyGyro_fMag_[Mean/STDev]**: magnitude for the angular velocity measured by the gyroscope, frequency domain. Calculated using the Euclidean norm. Mean and standard deviation (2 variables total).   
* **BodyGyro_fJerkMag_[Mean/STDev]**: Jerk signal (i.e. acceleration of the acceleration) of the magnitude of the angular velocity calculated by the gyroscope, time domain. Mean and standard deviation (2 variables total).   