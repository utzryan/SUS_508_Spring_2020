#Chatham University SUS 508: Environmental statistics
#1.3 Introduction to ggplot2
##########

##### Part 1: ggplot Basics #####

require(ggplot2)

fb=read.delim('https://studysites.sagepub.com/dsur/study/DSUR%20Data%20Files/Chapter%204/FacebookNarcissism.dat')

#The first plot, as seen in Figure 4.11:

ggplot(data=fb, aes(x=NPQC_R_Total, y=Rating))+
  geom_point()

#Save the plot as a named entity

firstPlot = ggplot(data=fb, aes(x=NPQC_R_Total, y=Rating))+
  geom_point()

#To make a stylistic change, add a plus sign:

ggplot(data=fb, aes(x=NPQC_R_Total, y=Rating))+
  geom_point()+
  labs(x='Narcicism score', y='Rating') #Adds specific x- and y-labels.

#OR

firstPlot + labs(x='Narcicism score', y='Rating')

#To apply a theme, add a packaged or custom theme after a plus sign:

ggplot(data=fb, aes(x=NPQC_R_Total, y=Rating))+
  geom_point()+
  labs(x='Narcicism score', y='Rating')+
  theme_classic()

#Change the symbol size and shape:

ggplot(data=fb, aes(x=NPQC_R_Total, y=Rating))+
  geom_point(size=4, shape=17)+
  labs(x='Narcicism score', y='Rating')+
  theme_classic()

#Add another variable represented by color:

ggplot(data=fb, aes(x=NPQC_R_Total, y=Rating, color=Rating_Type))+
  geom_point(size=4, shape=17)+
  labs(x='Narcicism score', y='Rating')+
  theme_classic()

#ALTERNATIVE syntax but same outcome to above:

ggplot(data=fb, aes(x=NPQC_R_Total, y=Rating))+
  geom_point(size=4, shape=17, aes(color=Rating_Type))+
  labs(x='Narcicism score', y='Rating')+
  theme_classic()

##### Part 2: Exploring different geoms #####

#Simple scatter plot

exam=read.delim('https://studysites.sagepub.com/dsur/study/DSUR%20Data%20Files/Chapter%204/Exam%20Anxiety.dat')

scatter=ggplot(exam, aes(x=Anxiety, y=Exam))+
  geom_point()
scatter

ggplot(exam, aes(x=Anxiety, y=Exam, color=Gender))+
  geom_point()

#Histogram of continuous variables

fest = read.delim('https://studysites.sagepub.com/dsur/study/DSUR%20Data%20Files/Chapter%204/DownloadFestival.dat')

ggplot(fest, aes(x=day1))+
  geom_histogram()

#Note that you can manipulate a variable within the ggplot command, such as omitting an outlier:

noOutliers=ggplot(subset(fest, day1<20), aes(x=day1))+
  geom_histogram()
noOutliers

#Recolor the histogram to make it 

ggplot(subset(fest, day1<20), aes(x=day1))+
  geom_histogram(color='black',fill='gray50')

#Boxplot of festival data:

ggplot(subset(fest, day1<20), aes(x=gender, y=day1))+
  geom_boxplot()

#Bar charts with error bars:

cf=read.delim('https://studysites.sagepub.com/dsur/study/DSUR%20Data%20Files/Chapter%204/ChickFlick.dat')

ggplot(cf, aes(x=film, y=arousal))+
  stat_summary(fun.y = mean, geom = 'bar')

#Add another variable based on fill color, but don't forget to dodge the bars!

ggplot(cf, aes(x=film, y=arousal, fill=gender))+
  stat_summary(fun.y = mean, geom = 'bar', position = 'dodge')

#But you are NEVER done with just the means. To plot error bars (with sane widths):

ggplot(cf, aes(x=film, y=arousal, fill=gender))+
  stat_summary(fun.y = mean, geom = 'bar', position = position_dodge(width=.9))+
  stat_summary(fun.data=mean_cl_normal, geom='errorbar', position=position_dodge(width=0.9),width=0.2)

#To plot pointrange-style:

ggplot(cf, aes(x=film, y=arousal, fill=gender))+
  stat_summary(fun.y = mean, geom = 'bar', position = 'dodge')+
  stat_summary(fun.data=mean_cl_normal, geom='pointrange', position=position_dodge(width=1))
