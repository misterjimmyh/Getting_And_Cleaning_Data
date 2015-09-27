	##Section 1 - Reading the data tables, subjects, features (variable names), and activity labels into R.
		xtest <- read.table(file="C:\\R_WORKING_DIRECTORY\\_Data Science Specialist\\Course 03 Getting and Cleaning Data\\UCI HAR Dataset\\test\\X_test.txt", colClasses = "numeric")
		ytest <- read.table(file="C:\\R_WORKING_DIRECTORY\\_Data Science Specialist\\Course 03 Getting and Cleaning Data\\UCI HAR Dataset\\test\\y_test.txt", colClasses = "numeric")
		subtest <- read.table(file="C:\\R_WORKING_DIRECTORY\\_Data Science Specialist\\Course 03 Getting and Cleaning Data\\UCI HAR Dataset\\test\\subject_test.txt", colClasses = "numeric")
		
		xtrain <- read.table(file="C:\\R_WORKING_DIRECTORY\\_Data Science Specialist\\Course 03 Getting and Cleaning Data\\UCI HAR Dataset\\train\\X_train.txt", colClasses = "numeric")
		ytrain <- read.table(file="C:\\R_WORKING_DIRECTORY\\_Data Science Specialist\\Course 03 Getting and Cleaning Data\\UCI HAR Dataset\\train\\y_train.txt", colClasses = "numeric")
		subtrain <- read.table(file="C:\\R_WORKING_DIRECTORY\\_Data Science Specialist\\Course 03 Getting and Cleaning Data\\UCI HAR Dataset\\train\\subject_train.txt", colClasses = "numeric")
		
		varNames <- read.table(file="C:\\R_WORKING_DIRECTORY\\_Data Science Specialist\\Course 03 Getting and Cleaning Data\\UCI HAR Dataset\\features.txt")
		activityLabels <- read.table(file="C:\\R_WORKING_DIRECTORY\\_Data Science Specialist\\Course 03 Getting and Cleaning Data\\UCI HAR Dataset\\activity_labels.txt")
		
	##Section 2 - Labeling columns appropriately
		
		colnames(activityLabels) <- c("ActivityIDNumber","Activity")
		colnames(xtest) <- (varNames$V2)
		colnames(ytest) <- "ActivityIDNumber"
		colnames(subtest) <- "SubjectIDNumber"
		colnames(xtrain) <- (varNames$V2)
		colnames(ytrain) <- "ActivityIDNumber"
		colnames(subtrain) <- "SubjectIDNumber"
		
	##Section 3 - Binding data to creat final data set
		
		allTestData <- cbind(ytest, subtest, xtest)
		allTrainData <- cbind(ytrain, subtrain, xtrain)
		allData <- rbind(allTestData, allTrainData)
		allData2 <- merge(activityLabels, allData, by="ActivityIDNumber", all.x = TRUE)
		
	##Section 4 - Choosing desired Standard Deviation and Mean columns and importing descriptive activity name
		
		allDataNames <- names(allData2)
		desiredColumns <- (grepl("ActivityIDNumber",allDataNames) | grepl("Activity",allDataNames) | grepl("SubjectIDNumber",allDataNames) | grepl(".*mean.*",allDataNames) | grepl(".*std.*", allDataNames))
		DesiredData <- allData2[desiredColumns == TRUE]
		
	##Section 5 - Adjusting final Variable (column) names
		ncol(DesiredData)
		nrow(DesiredData)
		VarNames2 <- names(DesiredData)
			for (i in 1:length(VarNames2))  
				{ 
					VarNames2[i] = gsub("\\()","",VarNames2[i]) 
					VarNames2[i] = gsub("-std$"," Standard Deviation",VarNames2[i]) 
					VarNames2[i] = gsub("-mean"," Mean",VarNames2[i]) 
					VarNames2[i] = gsub("^(t)","Time",VarNames2[i]) 
					VarNames2[i] = gsub("^(f)","Frequency",VarNames2[i]) 
					VarNames2[i] = gsub("([Gg]ravity)"," Gravity",VarNames2[i]) 
					VarNames2[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",VarNames2[i])
					VarNames2[i] = gsub("([Bb]ody[Bb]ody)","Body",VarNames2[i])
					VarNames2[i] = gsub("([Bb]ody)"," Body ",VarNames2[i])
					VarNames2[i] = gsub("[Gg]yro","Gyro",VarNames2[i]) 
					VarNames2[i] = gsub("AccMag","Acc Magnitude",VarNames2[i]) 
					VarNames2[i] = gsub("([Bb]odyaccjerkmag)"," Body Acc Jerk Magnitude",VarNames2[i]) 
					VarNames2[i] = gsub("JerkMag"," Jerk Magnitude",VarNames2[i]) 
					VarNames2[i] = gsub("GyroMag","Gyro Magnitude",VarNames2[i]) 
				}
		colnames(DesiredData) <- VarNames2

	##Section 6 - Adjusting and writing out Tidy Data

		DesiredData2 <- DesiredData[,names(DesiredData) != "Activity"];
		TidyDataSet <- aggregate(DesiredData2[,names(DesiredData2) != c("ActivityIDNumber","SubjectIDNumber")],by=list(ActivityIDNumber=DesiredData2$ActivityIDNumber,SubjectIDNumber=DesiredData2$SubjectIDNumber),mean)
		TidyDataSet <- merge(activityLabels,TidyDataSet, by="ActivityIDNumber",all.x=TRUE)
		TidyDataSet <- TidyDataSet[order(TidyDataSet[1], TidyDataSet[3]),]
		write.table(TidyDataSet,"C:\\R_WORKING_DIRECTORY\\_Data Science Specialist\\Course 03 Getting and Cleaning Data\\UCI HAR Dataset\\TidyDataSet.txt",row.names=FALSE)
