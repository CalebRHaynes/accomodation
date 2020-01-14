#clear env, set working directory  ------------------
rm(list = ls(all.names = TRUE))
library("rstudioapi")
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

# libraries ---------------------------------------------------------------
library('readxl')
library("dplyr")
library("QuantPsyc")
#import data---------------------------------------------------------------
df <- read_excel("accom_clean.xlsx")
attach(df)

#mean center k, normality tests-----------------------------------------------------------

#initial normality tests 
shapiro.test(discount_rate_k)
shapiro.test(percent_delayed_choices)

#mean center k

discount_rate_k_cent <- meanCenter(discount_rate_k)

#log transform discount rate k 

discount_rate_k_cent_transformed <- log10(discount_rate_k_cent + 1)
shapiro.test(discount_rate_k_cent_transformed)

# plotting ----------------------------------------------------------------

#discount rate k normality
disc_k <- density(discount_rate_k)
plot(disc_k, type="n", main="discount rate k")
polygon(disc_k, col="lightgray", border="gray")
rug(discount_rate_k_transformed, col="red")

#discount rate k normality log transformed 
disc_k_c_t <- density(discount_rate_k_cent_transformed)
plot(disc_k_c_t, type="n", main="discount rate k (transformed and centered)")
polygon(disc_k_c_t, col="lightgray", border="gray")
rug(discount_rate_k_cent_transformed, col="red")

#percent of choices delayed normality
perent_delayed <- density(percent_delayed_choices)
plot(perent_delayed, type="n", main="percent of choices for delayed")
polygon(perent_delayed, col="lightgray", border="gray")
rug(percent_delayed_choices, col="red")







