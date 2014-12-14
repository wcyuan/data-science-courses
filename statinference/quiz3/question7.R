# Question 7
# 
# Suppose that 18 obese subjects were randomized, 9 each, to a new 
# diet pill and a placebo. Subjects’ body mass indices (BMIs) were 
# measured at a baseline and again after having received the treatment 
# or placebo for four weeks. The average difference from follow-up to
# the baseline (followup - baseline) was −3 kg/m2 for the treated
# group and 1 kg/m2 for the placebo group. The corresponding standard
# deviations of the differences was 1.5 kg/m2 for the treatment
# group and 1.8 kg/m2 for the placebo group. Does the change in BMI
# over the four week period appear to differ between the treated 
# and placebo groups? Assuming normality of the underlying data and
# a common population variance, calculate the relevant *90%* t
# confidence interval. Subtract in the order of (Treated - Placebo)
# with the smaller (more negative) number first.

go <- function() {
  # treatment
  nx <- 9
  mx <- -3
  sdx <- 1.5

  # placebo
  ny <- 9
  my <- 1
  sdy <- 1.8
  
  vp <- ((nx-1)*sdx^2 + (ny-1)*sdy^2)/(nx+ny-2)
  sp <- sqrt(vp)
  tinv <- mx - my + c(-1,1)*qt(0.95, nx+ny-2)*sp*sqrt(1/nx+1/ny) 
  tinv
}
