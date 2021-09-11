setwd("~/Google Drive/Academia/PostUoE_Man/manuscript_v2/R_analysis/")
library(lme4)
library(lmerTest) # for regression functions

results_nt_ed = read.table(Sys.glob(file.path('stan_fitted/', "*ED_NT*.csv")),sep=",",header=T)
results_tr_ed = read.table(Sys.glob(file.path('stan_fitted/', "*ED_BID*.csv")),sep=",",header=T)
results_nt_hc = read.table(Sys.glob(file.path('stan_fitted/', "*HC_NT*.csv")),sep=",",header=T)
results_tr_hc = read.table(Sys.glob(file.path('stan_fitted/', "*HC_BID*.csv")),sep=",",header=T)

data_all=rbind(results_nt_ed,results_tr_ed,results_nt_hc,results_tr_hc)
data_delta_w_ED=cbind(results_tr_ed$w-results_nt_ed$w,results_tr_ed[,c(7,8,10,11)])
colnames(data_delta_w_ED)[1]<-'delta_w'
data_delta_w_HC=cbind(results_tr_hc$w-results_nt_hc$w,results_tr_hc[,c(7,8,10,11)])
colnames(data_delta_w_HC)[1]<-'delta_w'
data_delta_w=rbind(data_delta_w_HC,data_delta_w_ED)

data_all$age_z = rep(0,dim(data_all)[1])


for (i in data_all$sub){
  locator_temp0=which(data_all$sub==i)
  locator_temp=which(data_all$condition=='NT' & data_all$group==unique(data_all$group[data_all$sub==i]))
  data_all[locator_temp0,]$age_z = (data_all[locator_temp0,]$age-mean(data_all[locator_temp,]$age,na.rm = TRUE))/sd(data_all[locator_temp,]$age,na.rm=TRUE)
}

data_all$group=factor(data_all$group)
data_all$condition=factor(data_all$condition)
data_all$cond_order=factor(data_all$cond_order)

data_all$group = relevel(data_all$group, ref="HC")
data_all$cond_order = relevel(data_all$cond_order, ref="NTfirst")
data_all$condition = relevel(data_all$condition, ref="NT")

data_delta_w$age_z = rep(0,dim(data_delta_w)[1])
for (i in data_delta_w$sub){
  data_delta_w[data_delta_w$sub==i,]$age_z=unique(data_all[data_all$sub==i,]$age_z)
}

data_delta_w$group=factor(data_delta_w$group)
data_delta_w$cond_order=factor(data_delta_w$cond_order)

data_delta_w$group = relevel(data_delta_w$group, ref="HC")
data_delta_w$cond_order = relevel(data_delta_w$cond_order, ref="NTfirst")


# model1 <- lmer(mb~group*condition+eat_26+aai+oci_r+(1|sub),data=data_all)
# summary(model1)
# AIC(model1)
# anova(model1)

model_MB <- lmer(beta_1_MB~group*condition+age_z+(1|sub),data=data_all)
summary(model_MB)
AIC(model_MB)
anova(model_MB)

model_MF <- lmer(beta_1_MF~group*condition+age_z+(1|sub),data=data_all)
summary(model_MF)
AIC(model_MF)
anova(model_MF)

model_alpha <- lmer(alpha~group*condition+age_z+(1|sub),data=data_all)
summary(model_alpha)
AIC(model_alpha)
anova(model_alpha)

model_beta_2 <- lmer(beta_2~group*condition+age_z+(1|sub),data=data_all)
summary(model_beta_2)
AIC(model_beta_2)
anova(model_beta_2)

model_pers <- lmer(pers~group*condition+age_z+(1|sub),data=data_all)
summary(model_pers)
AIC(model_pers)
anova(model_pers)

model_w <- lmer(w~group*condition+age_z+(1|sub),data=data_all)
summary(model_w)
AIC(model_w)
anova(model_w)

# model4 <- lm(delta_w~group+age_z,data=data_delta_w)
# summary(model4)
# AIC(model4)
# anova(model4)


########## DF MB #########
df_results = read.table("df_nt_tr.csv",sep=",",header=T)
df_results=as.data.frame(df_results)

df_results$group=factor(df_results$group)
df_results$group = relevel(df_results$group, ref="HC")

m1 <- lm(EAT_26~mb_df, data=df_results)
m2 <- lm(AAI~mb_df, data=df_results)
m3 <- lm(OCI_R~mb_df, data=df_results)
m4 <- glm(group~mb_df, family = binomial(),data=df_results)
summary(m1)
summary(m2)
summary(m3)

pred_class=ifelse(m4$fitted.values>=0.5,"ED","HC")
comparetabl <- table(df_results$group,pred_class)
