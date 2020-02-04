rm(list = ls(all.names = TRUE))
library("rstudioapi")
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()
library(hBayesDM)

df <- read.delim(file = 'accom_merged.txt')

output <- dd_hyperbolic(
  data = , niter = 2000, nwarmup = 1000, nchain = 4, ncore = 4)

