
#############################################################
#
# Financial Analytics Assignment
#
# In this assignment, you are asked to use some of the 
# commands demonstrated in the video examples to analyze
# the problem.  You will then be asked to interpret the 
# results.  
#
# For this assignment, you may use any resources necessary
# to be able to exectute the code.  However, the interpretation 
# should reflect your thinking.
#
# You are to work on the problem alone, without help 
# from any other person.
#
###############################################################

# INSTRUCTIONS:  Enter your code between the comments line 
# as directed.  Comments begin with a hashtag '#'.
# For example

### Start Code

### End Code

# If you are asked to interpret results, make sure to put your
# answers in a comment line.

################################################################ 

###  required libraries  ###
# Run the following code to load the packages (libraries)
# If the library package does not load properly, make sure 
# that you have installed the package onto  your system.  
# Use the 'Packages' tab in RStudio to install the package.

library(fma)
library(ggplot2)




### end required libraries

### Run the following code


data(housing)                   # This load the housing dataset into R


hstarts <- housing[,'hstarts']  # This line moves one column of housing 
# to a variable called hstarts.

# The data housing is a time series dataset with three columns.  
# We will only use one column to simplify the code.
# This data is the monthly housing starts from Jan. 1983 - Oct. 1989.

######################################################################
######################################################################
#
#*** START CODING:  Question 1

# Q1.A Inspect the first 10 elements of hstarts using the head() command.

head(hstarts)

# Q1.B Plot the hstarts data using autoplot().
autoplot(hstarts)

# Q1.C Describe the plot in your own words.
# (answer here - remember to use hash tags for comments)
#doesn't look like the data has a trend but seasonality seem to be present.

# Q1.D Plot the hstarts data using the seasonplot() command.
seasonplot(hstarts)


# Q1.E Describe and interpret theseason plot in your own words.
# seems to have increse in Mar-Oct time period, x axis : Months, Y-axis: monthly housing starts

#** A good description will note what is on the y-axis, x-axis, 
#** describe the trend, and descrbie any seasonal or cyclical patterns



#*** END CODING: Question 1




### QUESTION 2

# The next set of questions analyze the kkong dataset.  
# using linear regression.

data(kkong)   # This data set has height and weight of 21 gorillas.
attach(kkong) # This command allows you to reference just the column names.
# The column names are 'weight' and 'height'.



#*** START CODING:  Question 2


# Q2.A Use the summary() command on the column 'height' and 'weight'.
summary(height)
summary(weight)
# Q2.B Describe the results in your own words. Include

# a description of the range, min, max, and central tendencies will suffice.
# Height: mean = 35.14, Min = 13.00, Max = 150 range = 137.0 Median = 29.0

# Weight: Mean = 50.0, Min = 31, Max = 130 Range =  99 Median = 47.0

# Q2.C Plot the data using the command plot().
plot(height)
plot(weight)
# Q2.D Describe the results in your own words.

#* The desciption should include a description of the graph and a description
#* of the data clustered around the bottom left corner 
#* as well as a discussion of the one outlier at the top left.
# prettty even distribution on height a bit of clusteing on the left one outlier 
# Even distribution of Weight samples, no clustering

# Q2.E Run a regression using height as the dependent variable
#      and store the results in 'fit'.  Use the summary() command to see 
#      the results.
fit  <- lm(height ~ weight)
summary(fit)


# Q2.F From the results answer the following (short answer):
#   - What is the coefficient for weight? Ans: 1.3708
#   - Is the coefficient significant? no
#   - What does the coefficient mean? In other words, interpret the coefficient. the coeff is -ve indicating a 
#   - What is the Adjusted R-squared and what does it mean? adjusted r squared is thr R squared value adjusted to the predictor values


#*** END CODING:  Question 2


#*** START CODING:  Question 3

# In this question, we will using the hstarts time series used in Question 1.

# Q3.A  Create a moving average of hstarts using 5 lags and store it in hstartsMA5.

hstartsMA5 <- ma(hstarts, 5)

# Q3.B  Create a moving average of hstarts using 15 lags and store it in hstartsMA15.
hstartsMA15 <- ma(hstarts, 15)

# RUN the following lines to make a graph.
plot(hstartsMA5, col = 'red')
lines(hstartsMA15, col = 'green')


# Q3.C  Describe the two moving average plots in your own words.
# both moving averages display a trend

#*** END CODING:  Question 3


#*** START CODING:  Question 4
# 

# Q4.A Create a simple exponential smoothing series using ses()
#     with h=5 lags and store it in hstartsSES5
hstartsSES5 <- ses(hstarts, h=5)


# Q4.B What is the RMSE?  (Use the accurancy() command.)
accuracy(hstartsSES5)
#RMSE = 19.46083

# Q4.C Create a Holt-Winters model using the hw() command and store it in hstartsHWa 
#      using the option : seasonal = "additive". 
hstartsHWa <- hw(hstarts, seasonal = "additive")


# Q4.D Create a Holt-Winters model using the hw() command and store it in hstartsHWm 
#      using the option : seasonal = "multiplicative".
hstartsHWm <- hw(hstarts, seasonal = "multiplicative")


# run the following to create the plot

autoplot(hstarts) +
  autolayer(hstartsHWa, series="HW additive forecasts",
            PI=FALSE) +
  autolayer(hstartsHWm, series="HW multiplicative forecasts",
            PI=FALSE) +
  ggtitle("Housing Starts") +
  guides(colour=guide_legend(title="Forecast"))

# Q4.E Which model (additive or multiplicative) looks better and why?
# Answer
# Both models are good possibilities for forecasts as they both exibit the cyclical cycles as well 
# the downward trend from 1987 onward.  However, the multiplicative mode also seems to dampen the cycles.
# A visual inspection of the previous 3-4 cycles seem to confirm the dampening of the cycles.


# A good answer will describe the two forecast graphs and also describe how the the multiplicative
# forecast will use a percentage of past changes.

#* Sample answer
#* Both models are good possibilities for forecasts as they both exibit the cyclical cycles as well 
#* the downward trend from 1987 onward.  However, the multiplicative mode also seems to dampen the cycles.
#* A visual inspection of the previous 3-4 cycles seem to confirm the dampening of the cycles.


#*** END CODING:  Question 4

