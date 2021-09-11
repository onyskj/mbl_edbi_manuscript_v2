setwd("~/Google Drive/Academia/PostUoE_Man/manuscript_v2/R_analysis/log reg")
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

# Shift data ---------------------------------
if(shiftMe){
  # data_all = read.table("data_all.csv",sep=",",header=T)
  data_all = read.table("all_subjects.csv",sep=",",header=T)
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
    write.csv(data_all_shifted,"data_all_shifted.csv",row.names = FALSE)
  }
}

# Recode data ---------------------------------
if (recodeMe || shiftMe){
  data_all_shifted = read.table("data_all_shifted.csv",sep=",",header=T)
  data_all_shifted_recoded <- data_all_shifted

  # data_all_shifted_recoded$condition=recode(data_all_shifted$condition,'2'="BID",'1'="NT")
  # data_all_shifted_recoded$group=recode(data_all_shifted$group,'1'="NTfirst",'2'="BIDfirst")
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
    write.csv(data_all_shifted_recoded,"data_all_shifted_recoded.csv",row.names = FALSE)
  }
}

# Load data ---------------------------------
if(load_recoded && !(recodeMe || shiftMe)){
  data_all_shifted_recoded = read.table("data_all_shifted_recoded.csv",sep=",",header=T)
}

# data_all_shifted_recoded_ED<-data_all_shifted_recoded[data_all_shifted_recoded$group=='ED',]
# data_all_shifted_recoded_ED_BID <-data_all_shifted_recoded[data_all_shifted_recoded$group=='ED' &data_all_shifted_recoded$condition=='BID',]

# data_all_shifted_recoded$group = relevel(data_all_shifted_recoded$group, ref="HC")
# data_all_shifted_recoded$cond_order = relevel(data_all_shifted_recoded$cond_order, ref="NTfirst")
# data_all_shifted_recoded$condition = relevel(data_all_shifted_recoded$condition, ref="NT")

# Fit data ---------------------------------
model1 <- glmer(stay~r*transition*(group+condition)+(r*transition+1|sub), family = binomial, data=data_all_shifted_recoded,control = glmerControl(optimizer = "bobyqa",optCtrl = list(maxfun=1e5)))
summary(model1)
# sink("model_summaries/model1_summary.txt")
# print(summary(model1))
# sink()

model1_2 <- glmer(stay~r*transition*age_z+(r*transition+1|sub), family = binomial, data=data_all_shifted_recoded,control = glmerControl(optimizer = "bobyqa",optCtrl = list(maxfun=1e5)))
summary(model1_2)

model2 <- glmer(stay~r*transition*(group+condition+age_z)+(r*transition+1|sub), family = binomial, data=data_all_shifted_recoded,control = glmerControl(optimizer = "bobyqa",optCtrl = list(maxfun=1e5)))
summary(model2)
# sink("model_summaries/model2_summary.txt")
# print(summary(model2))
# sink()

model3 <- glmer(stay~r*transition*(group*condition+age_z)+(r*transition+1|sub), family = binomial, data=data_all_shifted_recoded,control = glmerControl(optimizer = "bobyqa",optCtrl = list(maxfun=1e5)))
summary(model3)
# sink("model_summaries/model3_summary.txt")
# print(summary(model3))
# sink()

model4 <- glmer(stay~r*transition*(group*condition)+(r*transition+1|sub), family = binomial, data=data_all_shifted_recoded,control = glmerControl(optimizer = "bobyqa",optCtrl = list(maxfun=1e5)))
summary(model4)
# sink("model_summaries/model4_summary.txt")
# print(summary(model4))
# sink()

model5 <- glmer(stay~r*transition*(condition)+(r*transition+1|sub), family = binomial, data=data_all_shifted_recoded_ED,control = glmerControl(optimizer = "bobyqa",optCtrl = list(maxfun=1e5)))
summary(model5)


# MB/MF scores ---------------------------------
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


model_A_MB <- lmer(mb_score~group*condition+age_z+(1|sub),data=data_all_scores)
# model_A <- lm(mb_score~group*condition,data=data_all_scores)
summary(model_A_MB)

model_A_MF <- lmer(mf_score~group*condition+age_z+(1|sub),data=data_all_scores)
# model_A <- lm(mb_score~group*condition,data=data_all_scores)
summary(model_A_MF)

model_p_com_rew <- lmer(p_com_rew~group*condition+age_z+(1|sub),data=data_all_scores)
# model_A <- lm(mb_score~group*condition,data=data_all_scores)
summary(model_p_com_rew)

model_p_rare_unrew <- lmer(p_rare_unrew~group*condition+age_z+(1|sub),data=data_all_scores)
# model_A <- lm(mb_score~group*condition,data=data_all_scores)
summary(model_p_rare_unrew)

mean(data_all_scores[(data_all_scores$group=='ED' & data_all_scores$condition=='NT'),]$mb_score)
sd(data_all_scores[(data_all_scores$group=='ED' & data_all_scores$condition=='NT'),]$mb_score)

mean(data_all_scores[(data_all_scores$group=='HC' & data_all_scores$condition=='NT'),]$mb_score)
sd(data_all_scores[(data_all_scores$group=='HC' & data_all_scores$condition=='NT'),]$mb_score)


# OLD ---------------------------------

# Past processing ---------------------------------
# all_subjects_nt = read.table("all_subjects_nt.csv",sep=",",header=T)
# all_subjects_tr = read.table("all_subjects_tr.csv",sep=",",header=T)
# qs_scores = read.table("qs_scores.csv", sep=",",header=T)
# 
# df_results = read.table("df_nt_tr.csv",sep=",",header=T)
# df_results=as.data.frame(df_results)
# df_results$group=factor(df_results$group)
# df_results$group = relevel(df_results$group, ref="HC")
# 
# all_subjects_nt$cl_group = rep(0,dim(all_subjects_nt)[1])
# all_subjects_tr$cl_group = rep(0,dim(all_subjects_tr)[1])
# 
# all_subjects_nt$cond = rep(1,dim(all_subjects_nt)[1])
# all_subjects_tr$cond = rep(2,dim(all_subjects_tr)[1])
# 
# for (i in all_subjects_nt$sub){
#   all_subjects_nt[which(all_subjects_nt$sub==i),]$cl_group = qs_scores[qs_scores$sub==i,]$group
# }
# 
# for (i in all_subjects_tr$sub){
#   all_subjects_tr[which(all_subjects_tr$sub==i),]$cl_group = qs_scores[qs_scores$sub==i,]$group
# }
# 
# data_all = rbind(all_subjects_nt,all_subjects_tr)
# rownames(data_all)<-NULL
# 
# data_all$r=recode(data_all$r,'0'=-1L)
# data_all$transition=recode(data_all$transition,'0'=-1L)
# 
# data_all$age = rep(0,dim(data_all)[1])
# data_all$age_z = rep(0,dim(data_all)[1])
# 
# for (i in data_all$sub){
#   data_all[which(data_all$sub==i),]$age = df_results[df_results$sub==i,]$age2
#   data_all[which(data_all$sub==i),]$age_z = (df_results[df_results$sub==i,]$age2-mean(df_results$age2,na.rm = TRUE))/sd(df_results$age2,na.rm=TRUE)
# }



all_subjects_nt_ED = all_subjects_nt[which(all_subjects_nt$cl_group=="ED"),]
all_subjects_nt_HC = all_subjects_nt[which(all_subjects_nt$cl_group=="HC"),]
rownames(all_subjects_nt_ED)<-NULL
rownames(all_subjects_nt_HC)<-NULL

all_subjects_nt_ED$r=recode(all_subjects_nt_ED$r,'0'=-1L)
all_subjects_nt_ED$transition=recode(all_subjects_nt_ED$transition,'0'=-1L)

all_subjects_nt_ED$age = rep(0,dim(all_subjects_nt_ED)[1])
all_subjects_nt_ED$age_z = rep(0,dim(all_subjects_nt_ED)[1])

for (i in all_subjects_nt_ED$sub){
  all_subjects_nt_ED[which(all_subjects_nt_ED$sub==i),]$age = df_results[df_results$sub==i,]$age2
  all_subjects_nt_ED[which(all_subjects_nt_ED$sub==i),]$age_z = (df_results[df_results$sub==i,]$age2-mean(df_results$age2,na.rm = TRUE))/sd(df_results$age2,na.rm=TRUE)
}

# Pastish processing ---------------------------------
all_subjects_nt_ED_play<-all_subjects_nt_ED

shift<-function(x,k){
  head(c(rep(1,k),x[seq(length(x))[k:tail(length(x),n=1)]]),-1)
}


subs_ed_nt = unique(all_subjects_nt_ED_play$sub)

for (i in subs_ed_nt){
  all_subjects_nt_ED_play[which(all_subjects_nt_ED_play$sub==i),]$transition<-shift(all_subjects_nt_ED_play[which(all_subjects_nt_ED_play$sub==i),]$transition,1)
}

# Fit log regression to shifted data ---------------------------------

data_all_shifted_recoded = read.table("data_all_shifted_recoded.csv",sep=",",header=T)

data_all_shifted_recoded$group=factor(data_all_shifted_recoded$group)
data_all_shifted_recoded$cl_group=factor(data_all_shifted_recoded$cl_group)
data_all_shifted_recoded$cond=factor(data_all_shifted_recoded$cond)

data_all_shifted_recoded$transition=factor(data_all_shifted_recoded$transition)
data_all_shifted_recoded$r=factor(data_all_shifted_recoded$r)
data_all_shifted_recoded$stay=factor(data_all_shifted_recoded$stay)

data_all_shifted_recoded$cl_group = relevel(data_all_shifted_recoded$cl_group, ref="HC")
data_all_shifted_recoded$group = relevel(data_all_shifted_recoded$group, ref="NT_first")
data_all_shifted_recoded$cond = relevel(data_all_shifted_recoded$cond, ref="NT")

# Dum1 <- as.numeric(data_all_shifted_recoded$cl_group=="ED")
# Dum2 <- as.numeric(data_all_shifted_recoded$cond=="BID")
# 
# data_dummy <- cbind(data_all_shifted_recoded,Dum1,Dum2)

model1 <- glmer(stay~r*transition*(cl_group+cond)+(r*transition+1|sub), family = binomial, data=data_all_shifted_recoded,control = glmerControl(optimizer = "bobyqa",optCtrl = list(maxfun=1e5)))
summary(model1)
# sink("model_summaries/model1_summary.txt")
# print(summary(model1))
# sink()

model2 <- glmer(stay~r*transition*(cl_group+cond+age_z)+(r*transition+1|sub), family = binomial, data=data_all_shifted_recoded,control = glmerControl(optimizer = "bobyqa",optCtrl = list(maxfun=1e5)))
summary(model2)
# sink("model_summaries/model2_summary.txt")
# print(summary(model2))
# sink()

model3 <- glmer(stay~r*transition*(cl_group*cond+age_z)+(r*transition+1|sub), family = binomial, data=data_all_shifted_recoded,control = glmerControl(optimizer = "bobyqa",optCtrl = list(maxfun=1e5)))
summary(model3)
# sink("model_summaries/model3_summary.txt")
# print(summary(model3))
# sink()

model4 <- glmer(stay~r*transition*(cl_group*cond)+(r*transition+1|sub), family = binomial, data=data_all_shifted_recoded,control = glmerControl(optimizer = "bobyqa",optCtrl = list(maxfun=1e5)))
summary(model4)
# sink("model_summaries/model4_summary.txt")
# print(summary(model4))
# sink()




se <-sqrt(diag(vcov(model)))
tab <- cbind(Est=fixef(model),LL=fixef(model)-1.96*se,UL=fixef(model)+1.96*se)


# model_dummy <- glmer(stay~r*transition*(Dum1*Dum2+age_z)+(r*transition+1|sub), family = binomial, data=data_dummy,control = glmerControl(optimizer = "bobyqa",optCtrl = list(maxfun=1e5)))
# summary(model_dummy)
