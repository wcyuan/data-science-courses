# Question 6
#
# To further test the hospital triage system, administrators
# selected 200 nights and randomly assigned a new triage system 
# to be used on 100 nights and a standard system on the remaining 
# 100 nights. They calculated the nightly median waiting time (MWT) 
# to see a physician. The average MWT for the new system was 4 hours 
# with a standard deviation of 0.5 hours while the average MWT for
# the old system was 6 hours with a standard deviation of 2 hours.
# Consider the hypothesis of a decrease in the mean MWT associated
# with the new treatment. What does the 95% independent group
# confidence interval with unequal variances suggest vis a vis 
# this hypothesis? (Because there's so many observations per group, 
# just use the Z quantile instead of the T.)


go <- function () {
  # old
  nx <- 100
  mx <- 6
  sdx <- 2
  vx <- sdx^2

  # new
  ny <- 100
  my <- 4
  sdy <- 0.5
  vy <- sdy^2

  # a T confidence interval
  #vp <- ((nx-1)*sdx^2 + (ny-1)*sdy^2)/(nx+ny-2)
  #sp <- sqrt(vp)
  #tinv <- mx - my + c(-1,1)*qt(0.975, nx+ny-2)*sp*sqrt(1/nx+1/ny)

  # a Z confidence interval -- not sure if this is correct
  tinv <- mx - my + c(-1,1)*qnorm(0.975)*sqrt(1/nx+1/ny)
  tinv
}

