## Preliminary processing before merging the two data sets.
## Reading-in the needed files.
testset <- read.table("X_test.txt")
trainset <- read.table("X_train.txt")
subjecttest <- read.table("subject_test.txt",col.names = "subjects")
subjecttrain <- read.table("subject_train.txt", col.names = "subjects")
activitytrain <- read.table("y_train.txt", col.names = "activity")
activitytest <- read.table("y_test.txt", col.names = "activity")

## Adding the subjects (participants) and activity data to the data sets.
testset <- cbind(subjecttest, activitytest, testset)
trainset <- cbind(subjecttrain, activitytrain, trainset)

## Merging the training and test data sets to create one data set.

mergeddata <- merge(testset, trainset, all = TRUE)

## Extracting only the measurements for mean and standard deviation
library(dplyr)
mergeddata <- select(mergeddata,subjects,activity,V1:V6,V41:V46,V81:V86,
                     V121:V126,V161:V166,V201,V202,V214,V215,V227,V228,V240,
                     V241,V253,V254,V266:V271,
                     V345:V350,
                     V424:V429,V503,V504,V516,V517,V529,V530,V542,V543)

## Using descriptive activity names to name the activities in the data set.
## First, a function that seeks to change the figure coding in activity column
## to descriptive names,...

descriptive_activity <- function(x){
        nrx <- nrow(x)
        for (i in 1:nrx) {
                if(x[i,2]==1){x[i,2] <- "Walking"}
                if(x[i,2]==2){x[i,2] <- "Walking upstairs"}
                if(x[i,2]==3){x[i,2] <- "Walking downstairs"}
                if(x[i,2]==4){x[i,2] <- "Sitting"}
                if(x[i,2]==5){x[i,2] <- "Standing"}
                if(x[i,2]==6){x[i,2] <- "Laying"}
        }
        x
}

## ...and then, applying the function to the data set.
mergeddata <- descriptive_activity(mergeddata)

## Labeling (renaming) the data set variables with descriptive variable names.

mergeddata <- rename(mergeddata,tBodyAccmeanx= V1, tBodyAccmeany=V2,
        tBodyAccmeanz=V3, tBodyAccstdx=V4,tBodyAccstdy=V5, tBodyAccstdz=V6,
        tGravityAccmeanx=V41,
        tGravityAccmeany=V42,tGravityAccmeanz=V43,tGravityAccstdx=V44,
        tGravityAccstdy=V45,tGravityAccstdz=V46,tBodyAccJerkmeanx=V81,
        tBodyAccJerkmeany=V82,tBodyAccJerkmeanz=V83,tBodyAccJerkstdx=V84,
        tBodyAccJerkstdy=V85,tBodyAccJerkstdz=V86,tBodyGyromeanx=V121,
        tBodyGyromeany=V122,tBodyGyromeanz=V123,tBodyGyrostdx=V124,
        tBodyGyrostdy=V125,tBodyGyrostdz=V126,tBodyGyroJerkmeanx=V161,
        tBodyGyroJerkmeany=V162,tBodyGyroJerkmeanz=V163,tBodyGyroJerkstdx=V164,
        tBodyGyroJerkstdy=V165,tBodyGyroJerkstdz=V166,tBodyAccMagmean=V201,
        tBodyAccMagstd=V202,tGravityAccMagmean=V214,tGravityAccMagstd=V215,
        tBodyAccJerkMagmean=V227,tBodyAccJerkMagstd=V228,tBodyGyroMagmean=V240,
        tBodyGyroMagstd=V241,tBodyGyroJerkMagmean=V253,tBodyGyroJerkMagstd=V254,
        fBodyAccmeanx=V266,fBodyAccmeany=V267,fBodyAccmeanz=V268,
        fBodyAccstdx=V269,fBodyAccstdy=V270,fBodyAccstdz=V271,
        fBodyAccJerkmeanx=V345,fBodyAccJerkmeany=V346,fBodyAccJerkmeanz=V347,
        fBodyAccJerkstdx=V348,fBodyAccJerkstdy=V349,fBodyAccJerkstdz=V350,
        fBodyGyromeanx=V424,fBodyGyromeany=V425,fBodyGyromeanz=V426,
        fBodyGyrostdx=V427,fBodyGyrostdy=V428,fBodyGyrostdz=V429,
        fBodyAccMagmean=V503,fBodyAccMagstd=V504,fBodyBodyAccJerkMagmean=V516,
        fBodyBodyAccJerkMagstd=V517,fBodyBodyGyroMagmean=V529,
        fBodyBodyGyroMagstd=V530,fBodyBodyGyroJerkMagmean=V542,
                      fBodyBodyGyroJerkMagstd=V543)

## The final data set, showing the average of the measurements for each activity
## and each subject.

## First, splitting 'mergeddata' by 'activity' and 'subjects' and
## finding the average for each.
byactivity <- sapply(split(mergeddata, mergeddata$activity),function(x){
        y <- select(x,-(subjects:activity))
        z <- colMeans(y);z
})

bysubjects <- sapply(split(mergeddata, mergeddata$subjects),function(x){
        y <- select(x,-(subjects:activity))
        z <- colMeans(y);z
})

## Finally, binding the two sets into one, and renaming variables to create 
## a tidy data set. 
avgof_act_subj <- as.data.frame(cbind(byactivity,bysubjects))

avgof_act_subj <- rename(avgof_act_subj,subject1="1",subject2="2",
        subject3="3",subject4="4",subject5="5", subject6="6",subject7="7",
        subject8="8",subject9="9",subject10="10",subject11="11",
        subject12="12",subject13="13",subject14="14",subject15="15",
        subject16="16",subject17="17",subject18="18",subject19="19",
        subject20="20",subject21="21",subject22="22",subject23="23",
        subject24="24",subject25="25",subject26="26",
        subject27="27",subject28="28",subject29="29",subject30="30")

## End of script.