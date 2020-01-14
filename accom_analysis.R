
#clear env, set working directory  ------------------
rm(list = ls(all.names = TRUE))
library("rstudioapi")
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

# libraries ---------------------------------------------------------------
library('readxl')
library("dplyr")

#import data---------------------------------------------------------------
df <- read_excel("accom_clean.xlsx")
attach(df)

#normality tests-----------------------------------------------------------
shapiro.test(discount_rate_k)
shapiro.test(percent_delayed_choices)

#log transform discount rate k 
discount_rate_k <- lm(log1p(discount_rate_k) ~ log1p(discount_rate_k))

# plotting ----------------------------------------------------------------
disc_k <- density(discount_rate_k)
plot(disc_k, type="n", main="discount rate k")
polygon(disc_k, col="lightgray", border="gray")
rug(discount_rate_k, col="red")

perent_delayed <- density(percent_delayed_choices)
plot(perent_delayed, type="n", main="percent of choices for delayed")
polygon(perent_delayed, col="lightgray", border="gray")
rug(percent_delayed_choices, col="red")







