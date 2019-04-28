library(dplyr)


##Part1
setwd("C:/Users/AZIZ/Documents/UCI HAR Dataset/test")

test1<-read.table("subject_test.txt")
test2<-read.table("x_test.txt")
test3<-read.table("y_test.txt")

setwd("C:/Users/AZIZ/Documents/UCI HAR Dataset/train")

train1<-read.table("subject_train.txt")
train2<-read.table("x_train.txt")
train3<-read.table("y_train.txt")

merge1<- rbind(test1,train1)
merge2<- rbind(test2,train2)
merge3<- rbind(test3,train3)

setwd("C:/Users/AZIZ/Documents/UCI HAR Dataset")
labels<- read.table("activity_labels.txt")
feat<- read.table("features.txt")


##Part2
feat1 <- feat[grep("mean\\(\\)|std\\(\\)",feat$V2),]
merge4<- merge2[,feat1$V1]

##Part 3
colnames(merge3)<- "Activity"


##Part 4

colnames(merge4)<- feat1$V2

##Part 5

colnames(merge1)<- "Subjects"

merge4<-cbind(merge4,merge1,merge3)

merge5<- merge4 %>%
  group_by(Activity,Subjects) %>%
  summarise_each(funs = mean)

write.table(merge5,"tidydata.txt",row.names = F,col.names = T)
