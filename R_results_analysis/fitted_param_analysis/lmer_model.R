setwd("~/Google Drive/Academia/manuscripts/code/mbl_edbi_manuscript_v2/R_results_analysis/fitted_param_analysis") #from JO
library(lme4)
library(lmerTest) # for regression functions

results_nt_ed = read.table(Sys.glob(file.path('stan_fitted/', "*ED_NT*.csv")),sep=",",header=T)
results_tr_ed = read.table(Sys.glob(file.path('stan_fitted/', "*ED_BID*.csv")),sep=",",header=T)
results_nt_hc = read.table(Sys.glob(file.path('stan_fitted/', "*HC_NT*.csv")),sep=",",header=T)
results_tr_hc = read.table(Sys.glob(file.path('stan_fitted/', "*HC_BID*.csv")),sep=",",header=T)

data_all=rbind(results_nt_ed,results_tr_ed,results_nt_hc,results_tr_hc)

# data_delta_w_ED=cbind(results_tr_ed$w-results_nt_ed$w,results_tr_ed[,c(7,8,10,11)])
# colnames(data_delta_w_ED)[1]<-'delta_w'
# data_delta_w_HC=cbind(results_tr_hc$w-results_nt_hc$w,results_tr_hc[,c(7,8,10,11)])
# colnames(data_delta_w_HC)[1]<-'delta_w'
# data_delta_w=rbind(data_delta_w_HC,data_delta_w_ED)

data_all$age_z = rep(0,dim(data_all)[1])

for (i in unique(data_all$sub)){
  locator_temp0=which(data_all$sub==i)
  locator_temp=which(data_all$condition=='NT')
  data_all[locator_temp0,]$age_z = (data_all[locator_temp0,]$age-mean(data_all[locator_temp,]$age,na.rm = TRUE))/sd(data_all[locator_temp,]$age,na.rm=TRUE)
}

data_all$group=factor(data_all$group)
data_all$condition=factor(data_all$condition)
data_all$cond_order=factor(data_all$cond_order)

data_all$group = relevel(data_all$group, ref="HC")
data_all$cond_order = relevel(data_all$cond_order, ref="NTfirst")
data_all$condition = relevel(data_all$condition, ref="NT")

# #---------------- Add qs data
# ppt_qs_data = read.table('ppt_data/qs_scores.csv',sep=",",header=T)
# data_all$eat26_z = rep(0,dim(data_all)[1])
# data_all$aai_z = rep(0,dim(data_all)[1])
# data_all$ocir_z = rep(0,dim(data_all)[1])
# 
# for (i in unique(data_all$sub)){
#   locator_temp0=which(data_all$sub==i)
#   locator_temp=which(ppt_qs_data$sub==i)
#   data_all[locator_temp0,]$eat26_z = (ppt_qs_data[locator_temp,]$EAT_26-mean(ppt_qs_data$EAT_26,na.rm = TRUE))/sd(ppt_qs_data$EAT_26,na.rm=TRUE)
#   data_all[locator_temp0,]$aai_z = (ppt_qs_data[locator_temp,]$AAI-mean(ppt_qs_data$AAI,na.rm = TRUE))/sd(ppt_qs_data$AAI,na.rm=TRUE)
#   data_all[locator_temp0,]$ocir_z = (ppt_qs_data[locator_temp,]$OCI_R-mean(ppt_qs_data$AAI,na.rm = TRUE))/sd(ppt_qs_data$OCI_R,na.rm=TRUE)
# }
# 
# #Deltaw
# data_delta_w$age_z = rep(0,dim(data_delta_w)[1])
# data_delta_w$eat26_z = rep(0,dim(data_delta_w)[1])
# data_delta_w$aai_z = rep(0,dim(data_delta_w)[1])
# data_delta_w$ocir_z = rep(0,dim(data_delta_w)[1])
# for (i in data_delta_w$sub){
#   data_delta_w[data_delta_w$sub==i,]$age_z=unique(data_all[data_all$sub==i,]$age_z)
#   data_delta_w[data_delta_w$sub==i,]$eat26_z=unique(data_all[data_all$sub==i,]$eat26_z)
#   data_delta_w[data_delta_w$sub==i,]$aai_z=unique(data_all[data_all$sub==i,]$aai_z)
#   data_delta_w[data_delta_w$sub==i,]$ocir_z=unique(data_all[data_all$sub==i,]$ocir_z)
# }
# 
# data_delta_w$group=factor(data_delta_w$group)
# data_delta_w$cond_order=factor(data_delta_w$cond_order)
# 
# data_delta_w$group = relevel(data_delta_w$group, ref="HC")
# data_delta_w$cond_order = relevel(data_delta_w$cond_order, ref="NTfirst")


save_outputs = TRUE;

model_MB <- lmer(beta_1_MB~group*condition+age_z+(1|sub),data=data_all)
summary(model_MB)
if (save_outputs){
  sink("model_summaries/model_MB_summary.txt")
  print(summary(model_MB))
  sink()
}

model_MF <- lmer(beta_1_MF~group*condition+age_z+(1|sub),data=data_all)
summary(model_MF)
if (save_outputs){
  sink("model_summaries/model_MF_summary.txt")
  print(summary(model_MF))
  sink()
}

model_alpha <- lmer(alpha~group*condition+age_z+(1|sub),data=data_all)
summary(model_alpha)
if (save_outputs){
  sink("model_summaries/model_alpha_summary.txt")
  print(summary(model_alpha))
  sink()
}

model_beta_2 <- lmer(beta_2~group*condition+age_z+(1|sub),data=data_all)
summary(model_beta_2)
if (save_outputs){
  sink("model_summaries/model_beta_2_summary.txt")
  print(summary(model_beta_2))
  sink()
}

model_pers <- lmer(pers~group*condition+age_z+(1|sub),data=data_all)
summary(model_pers)
if (save_outputs){
  sink("model_summaries/model_pers_summary.txt")
  print(summary(model_pers))
  sink()
}

model_w <- lmer(w~group*condition+age_z+(1|sub),data=data_all)
summary(model_w)
if (save_outputs){
  sink("model_summaries/model_w_summary.txt")
  print(summary(model_w))
  sink()
}


