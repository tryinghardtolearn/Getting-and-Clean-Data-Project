#Libraries
library(dplyr)
library(plyr)

#Download Data file and store in a file called Course3Project
file_url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./Course3Project")){dir.create("./Course3Project")}
download.file(file_url,"./Course3Project/WearableData.zip")

#Unzip the data file
directory<-getwd()
data<-unzip("./Course3Project/WearableData.zip",exdir="./Course3Project")
data_file_path<-file.path(directory,"Course3Project/UCI HAR Dataset")

#Read test data
X_test<-read.table(file.path(data_file_path,"./test","./X_test.txt"),header=F)
Y_test<-read.table(file.path(data_file_path,"./test","./Y_test.txt"),header=F)
subject_test<-read.table(file.path(data_file_path,"./test","./subject_test.txt"),header=F)
#Read train data
X_train<-read.table(file.path(data_file_path,"./train","./X_train.txt"),header=F)
Y_train<-read.table(file.path(data_file_path,"./train","./Y_train.txt"),header=F)
subject_train<-read.table(file.path(data_file_path,"./train","./subject_train.txt"),header=F)
#Read Activity Labels and Features
activity_labels<-read.table(file.path(data_file_path,"./activity_labels.txt"),header=F)
features<-read.table(file.path(data_file_path,"./features.txt"),header=F)

#Merge train and test datasets
X_combined<-rbind(X_train,X_test)
Y_combined<-rbind(Y_train,Y_test)
subject_combined<-rbind(subject_train,subject_test)

#Assign Column names to the datasets
colnames(subject_combined)<-"SubjectCode"
colnames(X_combined)<-features$V2
colnames(Y_combined)<-"ActivityCode"

#Extract Mean and Standard Deviation Measurements
features_mean_std<-grep("mean\\(\\)|std\\(\\)",features$V2)
X_mean_std<-X_combined[,features_mean_std]

#Add in New Columns, AcitivityCode, AcitivityName, and SubjectCode
X_mean_std$ActivityCode<-as.factor(Y_combined$ActivityCode)
ActivityNames<-factor(Y_combined$ActivityCode,labels = activity_labels$V2)
X_mean_std$ActivityName<-ActivityNames
X_mean_std$SubjectCode<-as.factor(subject_combined$SubjectCode)

#Change Column Names to more descriptive names
names(X_mean_std)<-gsub("^t","Time",names(X_mean_std))
names(X_mean_std)<-gsub("^f","Frequency",names(X_mean_std))
names(X_mean_std)<-gsub("Acc","Acceleration",names(X_mean_std))
names(X_mean_std)<-gsub("Mag","Magnitude",names(X_mean_std))
names(X_mean_std)<-gsub("BodyBody","Body",names(X_mean_std))

#Aggregate the data by ActivityName and SubjectCode
data<-select(X_mean_std,-ActivityCode)
result<-aggregate(select(data,-c(ActivityName,SubjectCode)),list(data$ActivityName,data$SubjectCode),mean)
colnames(result)<-paste("Average of",colnames(result))
colnames(result)[1:2]<-c("ActivityName","SubjectCode")


#Output
write.table(result,file=file.path(data_file_path,"Aggregated_TidyData.txt"))

## REVIEW: the resulted dataset is read through the following code, uncomment the View line to bring up the dataset
review<-read.table(file.path(data_file_path,"Aggregated_TidyData.txt"),TRUE)
#View(review)


