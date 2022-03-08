# Assignment: 2.1 Assignment: 2014 American Community Survey
# Name: Nelson, Rachel
# Date: 2020-06-13


# For this assignment, you will need to load and activate the ggplot2 package. (I urge you to do the DataCamp exercise first!). For this deliverable, you should provide the following:
rm(list=ls())
library(ggplot2)
library(pastecs)
setwd("C:/Users/Rachel/Desktop/College/DSC520/dsc520-master")
acs_df <- read.csv("data/acs-14-1yr-s0201.csv")

# 1. What are the elements in your data (including the categories and data types)?
summary(acs_df)
attributes(acs_df)
# The elements include ID=factor, ID2=int, Geography=factor, PhotoGroupID=int, PopGroup=factor, Races Reported=int, HSDegree=num, BachDegree=nium

# 2. Please provide the output from the following functions: str(); nrow(); ncol()
str(acs_df)
nrow(acs_df)
ncol(acs_df)

# 3. Create a Histogram of the HSDegree variable using the ggplot2 package.
ggplot(acs_df, aes(HSDegree))
#   a. Set a bin size for the Histogram.
ggplot(acs_df, aes(HSDegree)) + geom_histogram(bins = 10)
#   b. Include a Title and appropriate X/Y axis labels on your Histogram Plot.
ggplot(acs_df, aes(HSDegree)) + geom_histogram(bins = 10) + ggtitle("Histogram of HS Degree") + xlab("HSDegree") + ylab("Count of occurrance") 

# 4. Answer the following questions based on the Histogram produced:
#   a. Based on what you see in this histogram, is the data distribution unimodal?
#       answer: Yes, the distribution is unimodal as it has one clear peak
#   b. Is it approximately symmetrical?
#       answer: No, the data is skewed to the left
#   c. Is it approximately bell-shaped?
#       answer:   No
#   d. Is it approximately normal?
shapiro.test(acs_df$HSDegree) #I'm using the sharpiro test to check if the data is normal
#       answer: No, the p-value < .05 p-value which implies the distribution of the data is significantly different from 
#       normal distribution.
#   e. If not normal, is the distribution skewed? If so, in which direction?
#       answer: Yes, the data is skewed to the left
#   f. Include a normal curve to the Histogram that you plotted.
#       answer: see below
gg <- ggplot(acs_df, aes(x=HSDegree))
gg <- gg + geom_histogram(binwidth=2, colour="black", 
                          aes(y=..density.., fill=..count..))
gg <- gg + scale_fill_gradient("Count", low="#DCDCDC", high="#7C7C7C")
gg <- gg + stat_function(fun=dnorm,
                         color="red",
                         args=list(mean=mean(acs_df$HSDegree), 
                                   sd=sd(acs_df$HSDegree)))
gg

# g. Explain whether a normal distribution can accurately be used as a model for this data.
#       answer: No, because the data does not have the characteristics of normal data (99.9% of the data will not be within six sigma (or three standard deviations either way)) since the data is skewed left

# 5. Create a Probability Plot of the HSDegree variable.
ggplot(acs_df, aes(sample=HSDegree))+stat_qq()

# 6. Answer the following questions based on the Probability Plot:
#   a. Based on what you see in this probability plot, is the distribution approximately normal? Explain how you know.
#       answer: No, if the data was normal the line would be linear. Because of the curvature, you can tell that the data is nor normal.
#   b. If not normal, is the distribution skewed? If so, in which direction? Explain how you know.
#       answer: Yes, the distribution is skewed to the left. You can tell by the downward curvature of the line. 

# 7. Now that you have looked at this data visually for normality, you will now quantify normality with numbers using the stat.desc() function. Include a screen capture of the results produced.
stat.desc(acs_df,  norm = FALSE) 
stat.desc(acs_df$`HSDegree`, basic = FALSE, norm = TRUE)

# 8. In several sentences provide an explanation of the result produced for skew, kurtosis, and z-scores. In addition, explain how a change in the sample size may change your explanation?
#       answer: Skew measures the asymmetry of the data and kurtosis measure the peakedness of the data. 
#       For skew, a score of 0 represents a perfect normal distribution. In this case, the skew is -1.67, the negative number indicates the data is skewed to the left
#       For kutorsis, a value of 0 represents a perfect normal distribution. In this case, the kurtosis is 4.35, which indicates the peakedness of the data is not considered normal
#       The Z score For medium-sized samples, you can reject the null hypothesis at absolute z-value over 3.29,and determine the data is considered non-normal.
#       The more samples, the greater probability of rejecting that the values come from a normal distribution because it becoems more sensitive to small deviations within the data

rmarkdown::render("analysis.R", "pdf_document")
