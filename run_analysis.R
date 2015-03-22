##Get the data
if(!file.exists("./data")){dir.create("./data")}
fileurlII<-("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
arch<-file.path(getwd(),"./data/project_data.zip")	

download.file(fileurlII,arch)
unzip("./data/project_data.zip",exdir="./data")

trayecto<- file.path("./data" , "UCI HAR Dataset")
list.files(trayecto,recursive=TRUE)

##Read and create the sets and subsets
##Activity
a_ytst<-read.table(file.path(trayecto, "test" , "Y_test.txt" ),header = FALSE)
head(a_ytst)
str(a_ytst)

a_ytr<-read.table(file.path(trayecto, "train", "Y_train.txt"),header = FALSE)
head(a_ytr)
str(a_ytr)

##Subject
s_train<-read.table(file.path(trayecto, "train", "subject_train.txt"),header = FALSE)
head(s_train)
str(s_train)

s_test<-read.table(file.path(trayecto, "test" , "subject_test.txt"),header = FALSE)
head(s_test)
str(s_test)

##Features
f_xtst<-read.table(file.path(trayecto, "test" , "X_test.txt" ),header = FALSE)
head(f_xtst)
str(f_xtst)

f_xtr<-read.table(file.path(trayecto, "train" , "X_train.txt" ),header = FALSE)
head(f_xtr)
str(xtr)


##To Merge Subjetc
s_tst_train<-rbind(s_train,s_test)
str(s_tst_train)

##To Merge Activities
y_tst_train<-rbind(a_ytr,a_ytst)
str(y_tst_train)

##To Merge Features
x_tst_train<-rbind(f_xtr,f_xtst)
str(x_tst_train)


##to Rename the variables
names(s_tst_train)<-c("subject")
names(y_tst_train)<-c("activity")
features_names<-read.table(file.path(trayecto, "features.txt"),head=FALSE)
names(x_tst_train)<-features_names$V2


##To put toguether tha data
datos_ys<-cbind(s_tst_train,y_tst_train)
datos_combina<-cbind(x_tst_train,datos_ys)

nombres_1<-features_names$V2[grep("mean\\(\\)|std\\(\\)", features_names$V2)]
nombres_2<-c(as.character(nombres_1), "subject", "activity" )

datos_extract<-subset(datos_combina,select=nombres_2)

## Assign names to activities and completing the names of variables
datos_extract$activity<-as.character(datos_extract$activity)
datos_extract$activity[datos_extract$activity==1]<- "Walking"
datos_extract$activity[datos_extract$activity==2]<- "Walking Upstairs"
datos_extract$activity[datos_extract$activity==3]<- "Walking Downstairs"
datos_extract$activity[datos_extract$activity==4]<- "Sitting"
datos_extract$activity[datos_extract$activity==5]<- "Standing"
datos_extract$activity[datos_extract$activity==6]<- "Laying"

head(datos_extract$activity,30)

names(datos_extract)<-gsub("^t", "time", names(datos_extract))
names(datos_extract)<-gsub("^f", "frequency", names(datos_extract))
names(datos_extract)<-gsub("Acc", "Accelerometer", names(datos_extract))
names(datos_extract)<-gsub("Gyro", "Gyroscope", names(datos_extract))
names(datos_extract)<-gsub("Mag", "Magnitude", names(datos_extract))
names(datos_extract)<-gsub("BodyBody", "Body", names(datos_extract))

##creating the first tidy data
datos_tidy<-aggregate(. ~subject + activity, datos_extract, mean)
datos_tidy<-datos_tidy[order(datos_tidy$subject,datos_tidy$activity),]
write.table(datos_extract, file = "./data/frst_tidydata.txt",row.name=FALSE)

##creating the second tidy data
etiquets = c("subject", "activity")
dats_etiquets = setdiff(colnames(datos_extract), etiquets)
conj_dats=melt(datos_extract, id = etiquets, measure.vars = dats_etiquets)

tidy_data = dcast(conj_dats, subject + activity ~ variable, mean)

write.table(tidy_data, file = "./data/secnd_tidydata.txt")
