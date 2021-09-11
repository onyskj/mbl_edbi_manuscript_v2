setwd("~/Google Drive/Academia/manuscripts/code/mbl_edbi_manuscript_v2/R_results_analysis/logistic_regression") #from JO
library(lme4)
library(jtools)
library(tidyverse)
library(useful)
library(caret)
library(Rpdb)
library(lme4)
library(lmerTest) # for regression functions

shiftMe=FALSE
recodeMe=FALSE
load_recoded=TRUE
saveCSV=FALSE
file_name_load = "simulated_data_from_fitted_ind_params_df_2021_09_09_02_06_39_ED_NT_niter_4000_foerde_alter_JO_wrong_ship_plus"
# Shift data ---------------------------------
if(shiftMe){
  data_all = read.table(paste('data/simulated/',file_name_load,".csv",sep=""),sep=",",header=T)
  shift<-function(x,k){
    head(c(rep(1,k),x[seq(length(x))[k:tail(length(x),n=1)]]),-1)
  }
  
  subs = unique(data_all$sub)
  conditions = unique(data_all$condition)
  data_all_shifted <- data_all
  for (j in conditions){
    for (i in subs){
      locator_temp=which(data_all_shifted$sub==i & data_all_shifted$condition==j)
      data_all_shifted[locator_temp,]$transition<-shift(data_all_shifted[locator_temp,]$transition,1)
      data_all_shifted[locator_temp,]$r<-shift(data_all_shifted[locator_temp,]$r,1)
    }
  }
  
  data_all_shifted$age_z = rep(0,dim(data_all_shifted)[1])
  for (i in data_all_shifted$sub){
    locator_temp0=which(data_all_shifted$sub==i)
    locator_temp=which(data_all$group==unique(data_all$group[data_all$sub==i])& data_all_shifted$condition=='NT')
    data_all_shifted[locator_temp0,]$age_z = (data_all_shifted[locator_temp0,]$age-mean(data_all_shifted[locator_temp,]$age,na.rm = TRUE))/sd(data_all_shifted[locator_temp,]$age,na.rm=TRUE)
  }
  if(saveCSV){
    write.csv(data_all_shifted,paste('data/simulated/',file_name_load,'_shifted.csv',sep=''),row.names = FALSE)
  }
}

# Recode data ---------------------------------
if (recodeMe || shiftMe){
  data_all_shifted = read.table(paste('data/simulated/',file_name_load,'_shifted.csv',sep=''),sep=",",header=T)
  data_all_shifted_recoded <- data_all_shifted
  
  data_all_shifted_recoded$r=recode(data_all_shifted$r,'0'=-1L)
  data_all_shifted_recoded$transition=recode(data_all_shifted$transition,'0'=-1L)
  
  data_all_shifted_recoded$group=factor(data_all_shifted_recoded$group)
  data_all_shifted_recoded$cond_order=factor(data_all_shifted_recoded$cond_order)
  data_all_shifted_recoded$condition=factor(data_all_shifted_recoded$condition)
  
  data_all_shifted_recoded$transition=factor(data_all_shifted_recoded$transition)
  data_all_shifted_recoded$r=factor(data_all_shifted_recoded$r)
  data_all_shifted_recoded$stay=factor(data_all_shifted_recoded$stay)
  
  data_all_shifted_recoded$group = relevel(data_all_shifted_recoded$group, ref="HC")
  data_all_shifted_recoded$cond_order = relevel(data_all_shifted_recoded$cond_order, ref="NTfirst")
  data_all_shifted_recoded$condition = relevel(data_all_shifted_recoded$condition, ref="NT")
  
  if(saveCSV){
    write.csv(data_all_shifted_recoded,paste('data/simulated/',file_name_load,'_shifted_recoded.csv',sep=''),row.names = FALSE)
  }
}

# Load data ---------------------------------
if(load_recoded && !(recodeMe || shiftMe)){
  data_all_shifted_recoded = read.table(paste('data/simulated/',file_name_load,"_shifted_recoded.csv",sep=''),sep=",",header=T)
}

data_all_shifted_recoded$group=factor(data_all_shifted_recoded$group)
data_all_shifted_recoded$cond_order=factor(data_all_shifted_recoded$cond_order)
data_all_shifted_recoded$condition=factor(data_all_shifted_recoded$condition)

data_all_shifted_recoded$group = relevel(data_all_shifted_recoded$group, ref="HC")
data_all_shifted_recoded$cond_order = relevel(data_all_shifted_recoded$cond_order, ref="NTfirst")
data_all_shifted_recoded$condition = relevel(data_all_shifted_recoded$condition, ref="NT")


save_outputs = TRUE;

# Fit data ---------------------------------
model1 <- glmer(stay~r*transition*(group+condition)+(r*transition+1|sub), family = binomial, data=data_all_shifted_recoded,control = glmerControl(optimizer = "bobyqa",optCtrl = list(maxfun=1e5)))
summary(model1)
if (save_outputs){
  sink("model_summaries/simulated_data/model1_summary_simulated.txt")
  print(summary(model1))
  sink()
}

model1_2 <- glmer(stay~r*transition*(group+condition+age_z)+(r*transition+1|sub), family = binomial, data=data_all_shifted_recoded,control = glmerControl(optimizer = "bobyqa",optCtrl = list(maxfun=1e5)))
summary(model1_2)
if (save_outputs){
  sink("model_summaries/simulated_data/model1_2_summary_simulated.txt")
  print(summary(model1_2))
  sink()
}
# 
model2 <- glmer(stay~r*transition*(group*condition)+(r*transition+1|sub), family = binomial, data=data_all_shifted_recoded,control = glmerControl(optimizer = "bobyqa",optCtrl = list(maxfun=1e5)))
summary(model2)
if (save_outputs){
  sink("model_summaries/simulated_data/model2_summary_simulated.txt")
  print(summary(model2))
  sink()
}

model2_2 <- glmer(stay~r*transition*(group*condition+age_z)+(r*transition+1|sub), family = binomial, data=data_all_shifted_recoded,control = glmerControl(optimizer = "bobyqa",optCtrl = list(maxfun=1e5)))
summary(model2_2)
if (save_outputs){
  sink("model_summaries/simulated_data/model2_2_summary_simulated.txt")
  print(summary(model2_2))
  sink()
}

model3 <- glmer(stay~r*transition*(group)+(r*transition+1|sub), family = binomial, data=data_all_shifted_recoded,control = glmerControl(optimizer = "bobyqa",optCtrl = list(maxfun=1e5)))
summary(model3)
if (save_outputs){
  sink("model_summaries/simulated_data/model3_summary_simulated.txt")
  print(summary(model3))
  sink()
}
# 
model3_2 <- glmer(stay~r*transition*(group+age_z)+(r*transition+1|sub), family = binomial, data=data_all_shifted_recoded,control = glmerControl(optimizer = "bobyqa",optCtrl = list(maxfun=1e5)))
summary(model3_2)
if (save_outputs){
  sink("model_summaries/simulated_data/model3_2_summary_simulated.txt")
  print(summary(model3_2))
  sink()
}

model4 <- glmer(stay~r*transition*(condition)+(r*transition+1|sub), family = binomial, data=data_all_shifted_recoded,control = glmerControl(optimizer = "bobyqa",optCtrl = list(maxfun=1e5)))
summary(model4)
if (save_outputs){
  sink("model_summaries/simulated_data/model4_summary_simulated.txt")
  print(summary(model4))
  sink()
}

model4_2 <- glmer(stay~r*transition*(condition+age_z)+(r*transition+1|sub), family = binomial, data=data_all_shifted_recoded,control = glmerControl(optimizer = "bobyqa",optCtrl = list(maxfun=1e5)))
summary(model4_2)
if (save_outputs){
  sink("model_summaries/simulated_data/model4_2_summary_simulated.txt")
  print(summary(model4_2))
  sink()
}

model5 <- glmer(stay~r*transition+(r*transition+1|sub), family = binomial, data=data_all_shifted_recoded,control = glmerControl(optimizer = "bobyqa",optCtrl = list(maxfun=1e5)))
summary(model5)
if (save_outputs){
  sink("model_summaries/simulated_data/model5_summary_simulated.txt")
  print(summary(model5))
  sink()
}

model5_2 <- glmer(stay~r*transition*(age_z)+(r*transition+1|sub), family = binomial, data=data_all_shifted_recoded,control = glmerControl(optimizer = "bobyqa",optCtrl = list(maxfun=1e5)))
summary(model5_2)
if (save_outputs){
  sink("model_summaries/simulated_data/model5_2_summary_simulated.txt")
  print(summary(model5_2))
  sink()
}


# MB/MF scores ---------------------------------
saveCSV_scores=FALSE
data_all_scores<-NULL
subs = unique(data_all_shifted_recoded$sub)
conditions = unique(data_all_shifted_recoded$condition)
data_all_scores$sub <- rep(0,length(subs)*2)
data_all_scores$condition <- rep(0,length(subs)*2)
data_all_scores$group <- rep(0,length(subs)*2)
data_all_scores$cond_order <- rep(0,length(subs)*2)

data_all_scores$n_com_rew <- rep(0,length(subs)*2)
data_all_scores$n_com_unrew <- rep(0,length(subs)*2)
data_all_scores$n_rare_rew <- rep(0,length(subs)*2)
data_all_scores$n_rare_unrew <- rep(0,length(subs)*2)

data_all_scores$p_com_rew <- rep(0,length(subs)*2)
data_all_scores$p_com_unrew <- rep(0,length(subs)*2)
data_all_scores$p_rare_rew <- rep(0,length(subs)*2)
data_all_scores$p_rare_unrew <- rep(0,length(subs)*2)
data_all_scores$mb_score <- rep(0,length(subs)*2)
data_all_scores$mf_score <- rep(0,length(subs)*2)
data_all_scores$age_z <- rep(0,length(subs)*2)
data_all_scores= as.data.frame(data_all_scores)

k=1
for (j in conditions){
  for (i in subs){
    locator_com_rew=which(data_all_shifted_recoded$condition==j & data_all_shifted_recoded$sub==i & data_all_shifted_recoded$stay==1 & data_all_shifted_recoded$r==1 & data_all_shifted_recoded$transition==1)
    locator_com_unrew=which(data_all_shifted_recoded$condition==j & data_all_shifted_recoded$sub==i & data_all_shifted_recoded$stay==1 & data_all_shifted_recoded$r==-1 & data_all_shifted_recoded$transition==1)
    locator_rare_rew=which(data_all_shifted_recoded$condition==j & data_all_shifted_recoded$sub==i & data_all_shifted_recoded$stay==1 & data_all_shifted_recoded$r==1 & data_all_shifted_recoded$transition==-1)
    locator_rare_unrew=which(data_all_shifted_recoded$condition==j & data_all_shifted_recoded$sub==i & data_all_shifted_recoded$stay==1 & data_all_shifted_recoded$r==-1 & data_all_shifted_recoded$transition==-1)
    
    locator_com_rew_all=which(data_all_shifted_recoded$condition==j & data_all_shifted_recoded$sub==i & data_all_shifted_recoded$r==1 & data_all_shifted_recoded$transition==1)
    locator_com_unrew_all=which(data_all_shifted_recoded$condition==j & data_all_shifted_recoded$sub==i & data_all_shifted_recoded$r==-1 & data_all_shifted_recoded$transition==1)
    locator_rare_rew_all=which(data_all_shifted_recoded$condition==j & data_all_shifted_recoded$sub==i & data_all_shifted_recoded$r==1 & data_all_shifted_recoded$transition==-1)
    locator_rare_unrew_all=which(data_all_shifted_recoded$condition==j & data_all_shifted_recoded$sub==i & data_all_shifted_recoded$r==-1 & data_all_shifted_recoded$transition==-1)
    
    temp_group = unique(data_all_shifted_recoded[which(data_all_shifted_recoded$condition==j & data_all_shifted_recoded$sub==i),]$group)
    temp_cond_order = unique(data_all_shifted_recoded[which(data_all_shifted_recoded$condition==j & data_all_shifted_recoded$sub==i),]$cond_order)
    temp_age_z = unique(data_all_shifted_recoded[which(data_all_shifted_recoded$condition==j & data_all_shifted_recoded$sub==i),]$age_z)
    
    data_all_scores[k,]$sub = i
    data_all_scores[k,]$condition = j
    data_all_scores[k,]$cond_order = temp_cond_order
    data_all_scores[k,]$group = temp_group
    data_all_scores[k,]$age_z = temp_age_z
    
    data_all_scores[k,]$n_com_rew <- length(locator_com_rew)
    data_all_scores[k,]$n_com_unrew <- length(locator_com_unrew)
    data_all_scores[k,]$n_rare_rew <- length(locator_rare_rew)
    data_all_scores[k,]$n_rare_unrew <- length(locator_rare_unrew)
    
    data_all_scores[k,]$p_com_rew <- length(locator_com_rew)/length(locator_com_rew_all)
    data_all_scores[k,]$p_com_unrew <- length(locator_com_unrew)/length(locator_com_unrew_all)
    data_all_scores[k,]$p_rare_rew <- length(locator_rare_rew)/length(locator_rare_rew_all)
    data_all_scores[k,]$p_rare_unrew <- length(locator_rare_unrew)/length(locator_rare_unrew_all)
    
    data_all_scores[k,]$mf_score <- data_all_scores[k,]$p_com_rew+data_all_scores[k,]$p_rare_rew-data_all_scores[k,]$p_com_unrew-data_all_scores[k,]$p_rare_unrew
    data_all_scores[k,]$mb_score <- data_all_scores[k,]$p_com_rew-data_all_scores[k,]$p_rare_rew-data_all_scores[k,]$p_com_unrew+data_all_scores[k,]$p_rare_unrew

    k=k+1
  }
}

data_all_scores$condition=recode(data_all_scores$condition,'2'="BID",'1'="NT")
data_all_scores$group=recode(data_all_scores$group,'2'="ED",'1'="HC")
data_all_scores$cond_order=recode(data_all_scores$cond_order,'1'="NTfirst",'2'="BIDfirst")

data_all_scores$group=factor(data_all_scores$group)
data_all_scores$cond_order=factor(data_all_scores$cond_order)
data_all_scores$condition=factor(data_all_scores$condition)

data_all_scores$group = relevel(data_all_scores$group, ref="HC")
data_all_scores$cond_order = relevel(data_all_scores$cond_order, ref="NTfirst")
data_all_scores$condition = relevel(data_all_scores$condition, ref="NT")

if(saveCSV_scores){
  write.csv(data_all_scores,"data/simulated/data_all_scores_simulated.csv",row.names = FALSE)
}

save_outputs=TRUE

model_A_MB_score <- lmer(mb_score~group*condition+age_z+(1|sub),data=data_all_scores)
summary(model_A_MB_score)
if (save_outputs){
  sink("model_summaries/simulated_data/model_A_MB_score_summary_simulated.txt")
  print(summary(model_A_MB_score))
  sink()
}

model_A_MF_score <- lmer(mf_score~group*condition+age_z+(1|sub),data=data_all_scores)
summary(model_A_MF_score)
if (save_outputs){
  sink("model_summaries/simulated_data/model_A_MF_score_summary_simulated.txt")
  print(summary(model_A_MF_score))
  sink()
}

model_p_com_rew <- lmer(p_com_rew~group*condition+age_z+(1|sub),data=data_all_scores)
summary(model_p_com_rew)
if (save_outputs){
  sink("model_summaries/simulated_data/model_p_com_rew_summary_simulated.txt")
  print(summary(model_p_com_rew))
  sink()
}

model_p_rare_unrew <- lmer(p_rare_unrew~group*condition+age_z+(1|sub),data=data_all_scores)
summary(model_p_rare_unrew)
if (save_outputs){
  sink("model_summaries/simulated_data/model_p_rare_unrew_summary_simulated.txt")
  print(summary(model_p_rare_unrew))
  sink()
}

model_p_com_unrew <- lmer(p_com_unrew~group*condition+age_z+(1|sub),data=data_all_scores)
summary(model_p_com_unrew)
if (save_outputs){
  sink("model_summaries/simulated_data/model_p_com_unrew_summary_simulated.txt")
  print(summary(model_p_com_unrew))
  sink()
}

model_p_rare_rew <- lmer(p_rare_rew~group*condition+age_z+(1|sub),data=data_all_scores)
summary(model_p_rare_rew)
if (save_outputs){
  sink("model_summaries/simulated_data/model_p_rare_rew_summary_simulated.txt")
  print(summary(model_p_rare_rew))
  sink()
}