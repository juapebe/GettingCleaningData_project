##run_analysis.R
##Author: <undisclosed for evaluation purposes>. June 20, 2014.
##This script is the product of the Course Project for the course "Getting and
##Cleaning Data" (Coursera. June 2014).

#Load files
readData<-function(){
        actLabels<<-read.table("./UCI HAR Dataset/activity_labels.txt")
        feature_names<<-read.table("./UCI HAR Dataset/features.txt")
        test_subject<<-read.table("./UCI HAR Dataset/test/subject_test.txt")
        train_subject<<-read.table("./UCI HAR Dataset/train/subject_train.txt")
        test_X<<-read.table("./UCI HAR Dataset/test/X_test.txt")
        test_Y<<-read.table("./UCI HAR Dataset/test/y_test.txt")
        train_X<<-read.table("./UCI HAR Dataset/train/X_train.txt")
        train_Y<<-read.table("./UCI HAR Dataset/train/y_train.txt")
}

#A function to remove all variables that are not mean or stdev
extract_mean_stdev<-function(df){
        for (cn in colnames(df)){
                if (!grepl("-mean\\(\\)", tolower(cn)) && !grepl("-std\\(\\)", tolower(cn))){
                        df[,cn]<-NULL
                }
        }
        return(df)
}

#A function that takes a variable name and replaces a given value for another one
#(this is used here to make the variable names more 'descriptive')
replace_strings<-function(query, string, newvalue){
        if(grepl(query, string)){
                string<-gsub(query, newvalue, string)
        }
        return(string)
}

#I decided to put all the renaming calls in this function. for readability.
#It also gets rid of characters that (1) are no good in a variable name and/or
#(2) are not legal as variable names on data frames in R.
rename_features<-function(fv){
        fv2<-vector()
        for (n in fv){
                #n<-tolower(n)
                forbiddencharacters<-c("\\(", "\\)", "\\-", "\\_", "\\.")
                for (c in forbiddencharacters){
                        n<-replace_strings(c, n, "")
                }
                n<-replace_strings("BodyBody", n, "Body")
                n<-replace_strings("tBodyAcc", n, "BodyAcc_t")
                n<-replace_strings("tGravityAcc", n, "GravityAcc_t")
                n<-replace_strings("fBodyAcc", n, "BodyAcc_f")
                n<-replace_strings("fGravityAcc", n, "GravityAcc_f")
                n<-replace_strings("Mag", n, "Mag")
                n<-replace_strings("tBodyGyro", n, "BodyGyro_t")
                n<-replace_strings("fBodyGyro", n, "BodyGyro_f")
                n<-replace_strings("mean", n, "_Mean")
                n<-replace_strings("std", n, "_STDev")
                fv2<-append(fv2, n)
        }
        return(fv2)
}

####
#Execution block (MAIN)
####

library(reshape2)

#Loads data
readData()

#Concatenate files. Obtain list of features, subjects, activities
features<-data.frame(rbind(test_X, train_X))
subjects<-rbind(test_subject, train_subject)
activities<-rbind(test_Y, train_Y)
actLabels[2]<-tolower(sub("_", " ", actLabels[,2])) #nicer activity names
#ERROR IS HERE - remake trying to avoid using this so early (it sorts them badly) and also using melt -> dcast

#Narrow down the number of features. Rename features to more readable
colnames(features)<-feature_names[,2]
features<-extract_mean_stdev(features)
colnames(features)<-rename_features(colnames(features))

#Merge feature, subject, and activity information.
firstData<-data.frame(Subject=subjects[,1], Activity=activities[,1], features)
firstData<-firstData[order(firstData$Subject),]

#Prints the first, non-summary dataframe to file
write.table(firstData, file="original_DataFrame.txt", sep="\t", quote=FALSE,
            row.names=FALSE)

#Generates the second, 'tidy' dataset.
firstDataMelt<-melt(firstData, id.vars=c("Subject","Activity"))
firstDataMelt<-merge(firstDataMelt, actLabels, by.x="Activity", by.y="V1")
tidyData<- dcast(firstDataMelt, formula = Subject + Activity ~ variable, mean)

#prints the tidy dataset
write.table(tidyData, file="means_tidyDataFrame.txt", sep="\t", quote=FALSE,
            row.names=FALSE)


