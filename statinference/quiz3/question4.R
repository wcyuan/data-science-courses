# Question 4
#
# In a study of emergency room waiting times, investigators 
# consider a new and the standard triage systems. To test the 
# systems, administrators selected 20 nights and randomly 
# assigned the new triage system to be used on 10 nights and 
# the standard system on the remaining 10 nights. They calculated
# the nightly median waiting time (MWT) to see a physician. The 
# average MWT for the new system was 3 hours with a variance of
# 0.60 while the average MWT for the old system was 5 hours with
# a variance of 0.68. Consider the 95% confidence interval 
# estimate for the differences of the mean MWT associated with
# the new system. Assume a constant variance. What is the interval? 
# Subtract in this order (New System - Old System).

go <- function () {
  nx <- 10
  mx <- 5
  vx <- 0.6
  sdx <- sqrt(vx)

  ny <- 10
  my <- 3
  vy <- 0.68
  sdy <- sqrt(vy)

  vp <- ((nx-1)*sdx^2 + (ny-1)*sdy^2)/(nx+ny-2)
  sp <- sqrt(vp)

  tinv <- my - mx + c(-1,1)*qt(0.975, nx+ny-2)*sp*sqrt(1/nx+1/ny)
  tinv
}

