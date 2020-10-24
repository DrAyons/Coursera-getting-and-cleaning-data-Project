README
=============================================================
The raw dataset includes the following files:
=========================================
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt':Subjects identity
- 'test/subject_test.txt': Subjects identity
=============================================================
The tidy data set consists of one table summarizing the measurements, by each activity (described in the codebook), and by each participant involved in the study.
=============================================================
Processing of raw data to obtain the tidy data was carried out as follows (Also illustrated in the R script "run_analysis.R", accompanying this package):

## Preliminary processing such as reading-in the needed files, namely;
## X_test.txt, X_train.txt, subject_test.txt, subject_train.txt, y_train.txt and ## y_train.txt.

## Adding the subjects (participants) and activity to the data raw values ##contained in the X_test.txt, X_train.txt files read as 'testset' and 'trainset' ##respectively.

## Merging the trainset and testsets to create one data set, called 'mergeddata'

## Extracting only the measurements for mean and standard deviation from the merged dataset, 'mergeddata'.

## Using descriptive activity names to name the activities in the data set.

## Labeling (renaming) the data set variables with descriptive variable names.

## Temporarily splitting 'mergeddata' by 'activity' and 'subjects' in order to create the summarized average, and then finding the average for each.

## Finally, binding the two sets into one, and renaming variables to create 
## a tidy data set.

