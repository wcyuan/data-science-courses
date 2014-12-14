# Question 1
# 
# Consider the following data with x as the predictor
# and y as as the outcome.

x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
fit1 <- lm(y~x)


# Give a P-value for the two sided hypothesis test of
# whether β1 from a linear regression model is 0 or not.
# 0.025
# 0.05296
# 2.325
# 0.391

getCoefTable <- function(x,y) {
  n<-length(y)
  beta1<-cor(y,x)*sd(y)/sd(x)
  beta0<-mean(y)-beta1*mean(x)
  e<-y-beta0-beta1*x
  sigma<-sqrt(sum(e^2)/(n-2))
  ssx<-sum((x-mean(x))^2)
  seBeta0<-(1/n+mean(x)^2/ssx)^.5*sigma
  seBeta1<-sigma/sqrt(ssx)
  tBeta0<-beta0/seBeta0;
  tBeta1<-beta1/seBeta1
  pBeta0<-2*pt(abs(tBeta0),df=n-2,lower.tail=FALSE)
  pBeta1<-2*pt(abs(tBeta1),df=n-2,lower.tail=FALSE)
  coefTable<-rbind(c(beta0,seBeta0,tBeta0,pBeta0),
                   c(beta1,seBeta1,tBeta1,pBeta1)) 
  colnames(coefTable)<-c("Estimate","Std.Error","tvalue","P(>|t|)")
  rownames(coefTable)<-c("(Intercept)","x")
  coefTable
}
getCoefTable(x, y)

# > summary(fit)
#
# Call:
#   lm(formula = y ~ x)
#
# Residuals:
#      Min       1Q   Median       3Q      Max 
# -0.27636 -0.18807  0.01364  0.16595  0.27143 
#
# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)  
# (Intercept)   0.1885     0.2061   0.914    0.391  
# x             0.7224     0.3107   2.325    0.053 .
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
# Residual standard error: 0.223 on 7 degrees of freedom
# Multiple R-squared:  0.4358,  Adjusted R-squared:  0.3552 
# F-statistic: 5.408 on 1 and 7 DF,  p-value: 0.05296

# so, it appears to be 0.053

# Question 2
# 
# Consider the previous problem, give the estimate
# of the residual standard deviation.
# 0.4358
# 0.3552
# 0.05296
# 0.223

# from the output above, it looks like 0.223

# Question 3

# In the mtcars data set, fit a linear regression 
# model of weight (predictor) on mpg (outcome). 
# Get a 95% confidence interval for the expected 
# mpg at the average weight. What is the lower endpoint?
# -6.486
# 21.190
# -4.00
# 18.991

fit <- lm(mpg~wt, data=mtcars)
predict(fit, data.frame(wt=mean(mtcars$wt)), interval = ("confidence"))
#        fit      lwr      upr
# 1 20.09062 18.99098 21.19027

# so, 18.991

# Question 4

# Refer to the previous question. Read the help 
# file for mtcars. What is the weight coefficient 
# interpreted as?

# The estimated 1,000 lb change in weight per 
# 1 mpg increase.

# The estimated expected change in mpg per 
# 1 lb increase in weight.

# The estimated expected change in mpg per 
# 1,000 lb increase in weight.

# It can't be interpreted without further information

# clearly it's change in mpg per 1,000 lb increase

# Question 5

# Consider again the mtcars data set and a linear 
# regression model with mpg as predicted by weight 
# (1,000 lbs). A new car is coming weighing 3000 
# pounds. Construct a 95% prediction interval for 
# its mpg. What is the upper endpoint?
# -5.77
# 27.57
# 21.25
# 14.93

predict(fit, data.frame(wt=3), interval = ("prediction"))
# fit      lwr      upr
# 1 21.25171 14.92987 27.57355

# so 27.57

# Question 6

# Consider again the mtcars data set and a linear 
# regression model with mpg as predicted by 
# weight (in 1,000 lbs). A “short” ton is defined 
# as 2,000 lbs. Construct a 95% confidence interval 
# for the expected change in mpg per 1 short ton 
# increase in weight. Give the lower endpoint.
# -6.486
# -12.973
# -9.000
# 4.2026

sumCoef <- summary(fit)$coefficients
sumCoef[2,1] + c(-1,1) * qt(.975, df=fit$df) * sumCoef[2,2]
# [1] -6.486308 -4.202635
(sumCoef[2,1] + c(-1,1) * qt(.975, df=fit$df) * sumCoef[2,2]) * 2
# [1] -12.97262  -8.40527

# so, -12.973

# Question 7

# If my X from a linear regression is measured 
# in centimeters and I convert it to meters what
# would happen to the slope coefficient?
# It would get multiplied by 100.
# It would get multiplied by 10
# It would get divided by 10
# It would get divided by 100

# It gets multiplied by 100

# Question 8
# I have an outcome, Y, and a predictor, X and 
# fit a linear regression model with Y=β0+β1X+ϵ 
# to obtain β^0 and β^1. What would be the 
# consequence to the subsequent slope and 
# intercept if I were to refit the model with a 
# new regressor, X+c for some constant, c?
# The new slope would be β^1+c
# The new slope would be cβ^1
# The new intercept would be β^0+cβ^1
# The new intercept would be β^0−cβ^1

# answer:
# The new intercept would be β^0-cβ^1


# Question 9

# Refer back to the mtcars data set with mpg as 
# an outcome and weight (wt) as the predictor. 
# About what is the ratio of the the sum of the 
# squared errors, ∑ni=1(Yi−Y^i)2 when comparing a 
# model with just an intercept (denominator) to 
# the model with the intercept and slope (numerator)?
# 0.25
# 0.75
# 0.50
# 4.00

# the model with an intercept
# > fit <- lm(mpg~wt, data=mtcars)
# the model without an intercept
# > fit2 <- lm(mpg~wt-1, data=mtcars)
# > sum(resid(fit)^2) / sum(resid(fit2)^2)
# [1] 0.07070081

# but wait, that's not what they wanted,
# they wanted the model with only an intercept.
# the predicted value is then just Ybar

# > sum((mtcars$mpg-mean(mtcars$mpg))^2) / sum(resid(fit2)^2)
# [1] 0.2860445

# so I guess 0.25 is the closest

summary(fit2)
# 
# Call:
#   lm(formula = mpg ~ wt - 1, data = mtcars)
# 
# Residuals:
#      Min       1Q   Median       3Q      Max 
# -18.3018  -3.3177   0.7468   7.7538  24.1899 
# 
# Coefficients:
#    Estimate Std. Error t value Pr(>|t|)    
# wt   5.2916     0.5932   8.921 4.55e-10 ***
#   ---
#   Signif. codes:  
#   0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 11.27 on 31 degrees of freedom
# Multiple R-squared:  0.7197,  Adjusted R-squared:  0.7106 
# F-statistic: 79.58 on 1 and 31 DF,  p-value: 4.553e-10

# but that's not what they wanted.  They wanted
# just an intercept.  In that version, the predicted
# value is just Ybar, the mean of the Ys



# Question 10

# Do the residuals always have to sum to 0 in 
# linear regression?

# The residuals must always sum to zero.

# If an intercept is included, the residuals most likely won't sum to zero.

# If an intercept is included, then they will sum to 0.

# The residuals never sum to zero.

# Answer: If an intercept is included, then they will
# sum to 0

# --------------------------------------
# Some properties of the residual:

# Model Yi = B0 + B1*Xi + epsilon_i
#  where epsilon_i is N(0, sigma^2)
# Yi is observed outcome, Xi is predictor
# Yhati is predicted outcome:
# Yhati = B0hat + B1hat * Xi
# Resid = ei = Yi - Yhati
# Least squares minimizes sum(ei^2)
# ei can be thought of as esimates of epsilon_i

# Expected value of ei = 0
# If intercept is included, sum(ei) = 0
# If intercept is not included, sum(ei * Xi) = 0
# Residuals are useful for investigating poor model fit

# The Max Likelihood estimate of sigma^2 is
#   1/n * sum(ei^2)
# i.e., the average squared residual
# unbiased version is
#   sigma_hat^2 = 1/(n-2) * sum(ei^2)
# So E[sigma_hat^2] = sigma^2

# sum((Yi - Ybar)^2) =
#   sum((Yi - Yhati)^2) + sum((Yhati - Ybar)^2)
#
# Total variation =
#   Residual Variation + Regression Variation
#
# Percent of total variation described by the model
#   = Regression Variation / Total Variation
#   = 1 - Residual Variation / Total Variation
#
#  R^2 = sum((Yhati - Ybar)^2) / sum((Yi - Ybar)^2)
#      = 1 - (sum(Yi - Yhati)^2) / sum((Yi - Ybar)^2)
#
#  R2  = Correlation(Y, X)^2
#  squared correlation!  Literally "r squared"
#  (if r is correlation)
#
# - R^2 is the percentage of variation explained
#     by the regression
# - 0 <= R^2 <= 1
# - R^2 is the sample correlation squared
# - R^2 may be misleading if that's all you look at
#   - Deleting data can inflate R^2
#   - Adding terms to a regression always increases
#     R^2
#   - Models that have the same R^2 could vary greatly
#     in how well they fit the data, in terms of
#     how well they COULD fit the data.
#     E.g., maybe the data is actually non-linear
#     and a different model would work much better,
#     Or maybe it would be a much better fit if some
#     outliers were removed or data cleaned, etc.
#

