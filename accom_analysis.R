#clear env, set working directory  ------------------
rm(list = ls(all.names = TRUE))
library("rstudioapi")
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

# libraries ---------------------------------------------------------------
library('readxl')
library("dplyr")
library("QuantPsyc")
library("corrplot")
library("tidyverse")
library('Hmisc')
library('apaTables')


#import data---------------------------------------------------------------
df <- read_excel("accom_clean.xlsx")
#create subset of data to exclude subjects with weird output that is yet to be debugged 
df_subset <- subset(df, df$exclude == 0)
attach(df_subset)
k <- as.numeric(discount_rate_k)
percent_delayed_choices <- as.numeric(percent_delayed_choices)

#necessary type conversions
`SCAARED - Total Score (Sum) (Adult)` <- as.double(`SCAARED - Total Score (Sum) (Adult)`)



#normality tests-----------------------------------------------------------

#initial normality tests 
shapiro.test(k)
shapiro.test(percent_delayed_choices)
#log transform discount rate k 
k_transformed <- log10(k)
k_transformed
shapiro.test(k_transformed)

# plotting variables ----------------------------------------------------------------
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

df_nums = df_subset[ , 20:50]
df_nums
df_nums <- mutate(df_nums, k_transformed)

df_nums <- na.omit(df_nums)
res1 <- cor.mtest(df_nums, conf.level = .95)
df_nums %>% cor() -> M
M
corrplot(M, p.mat = res1$p, insig = "blank",  diag = FALSE, tl.cex = 0.5, type="upper", order="hclust")
