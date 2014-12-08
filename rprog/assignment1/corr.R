# Write a function that takes a directory of data files and a threshold
# for complete cases and calculates the correlation between sulfate and
# nitrate for monitor locations where the number of completely observed
# cases (on all variables) is greater than the threshold. The function
# should return a vector of correlations for the monitors that meet the
# threshold requirement. If no monitors meet the threshold requirement,
# then the function should return a numeric vector of length 0. A
# prototype of this function follows

onecor <- function(data) {
  cln = data[!is.na(data$sulfate) & !is.na(data$nitrate),]
  cor(cln["sulfate"], cln["nitrate"])
}

ncomplete <- function(data) {
  sum(complete.cases(data))
}

do_id <- function(fn) {
  data <- read.csv(fn)
  c(ncomplete(data), onecor(data))
}

corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations



  id <- list.files(directory, pattern="*.csv", full.names=TRUE)
  
  alldata <- vapply(id, do_id, numeric(2))
  alldata <- unname(alldata)
  alldata[2, alldata[1,] > threshold]
  #fr = data.frame(nobs=alldata[1], corr=alldata[2])
  #fr
  #fr[fr$corr >= threshold, "nobs"]
}


