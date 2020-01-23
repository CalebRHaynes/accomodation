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
#create subset of data to exclude subjects with weird output that is yet to be debugged 
df_subset <- subset(df, df$exclude == 0)
attach(df_subset)
k <- as.numeric(discount_rate_k)
percent_delayed_choices <- as.numeric(percent_delayed_choices)
#normality tests-----------------------------------------------------------

#initial normality tests 
shapiro.test(k)
shapiro.test(percent_delayed_choices)
#log transform discount rate k 
k_transformed <- log10(k)
shapiro.test(k_transformed)

# plotting ----------------------------------------------------------------
#discount rate k normality log transformed 
disc_k_t <- density(k_transformed)
plot(disc_k_t, type="n", main="discount rate k (transformed)")
polygon(disc_k_t, col="lightgray", border="gray")
rug(k_transformed, col="red")

#percent of choices delayed normality
perent_delayed <- density(percent_delayed_choices)
plot(perent_delayed, type="n", main="percent of choices for delayed")
polygon(perent_delayed, col="lightgray", border="gray")
rug(percent_delayed_choices, col="red")

#correlations####

