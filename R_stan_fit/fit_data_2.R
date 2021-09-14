##################
#
# adapted by Jakub Onysk based on vanessa brown 2018
#
##################

# set wd, load packages and functions ---------------
setwd("~/Google Drive/Academia/manuscripts/code/mbl_edbi_manuscript_v2/R_stan_fit/") #from JO
date.time.append <-dget("date_time_append.R")
library(rstan)
library(shinystan)
library(loo)
library(useful)
library(Rpdb)
library(tidyverse)
library(rlist)
rstan_options(auto_write = FALSE)
options(mc.cores =  parallel::detectCores())

# Load data ---------------
data_all = read.csv("collected_data/all_subjects.csv", header = T)
data_ed_nt = data_all[data_all$group=="ED" & data_all$condition=="NT",]
subjs_ed_nt = unique(data_all[data_all$group=="ED" & data_all$condition=="NT",]$sub) #ED NT subjects
data_ed_bid = data_all[data_all$group=="ED" & data_all$condition=="BID",]
subjs_ed_bid = unique(data_all[data_all$group=="ED" & data_all$condition=="BID",]$sub) #ED BID subjects
data_hc_nt = data_all[data_all$group=="HC" & data_all$condition=="NT",]
subjs_hc_nt = unique(data_all[data_all$group=="HC" & data_all$condition=="NT",]$sub) #HC NT subjects
data_hc_bid = data_all[data_all$group=="HC" & data_all$condition=="BID",]
subjs_hc_bid = unique(data_all[data_all$group=="HC" & data_all$condition=="BID",]$sub) #HC BID subjects

data_list = list(data_ed_nt,data_ed_bid,data_hc_nt,data_hc_bid)
subjs_list = list(subjs_ed_nt,subjs_ed_bid,subjs_hc_nt,subjs_hc_bid)
list_names = c("ED_NT","ED_BID","HC_NT","HC_BID")


# Set which models and datasets to use ---------------
test_bool = FALSE;
model_name = 'foerde_alter_2_JO.stan';
model_name_short='foerde_alter_2_JO_wrong_ship';


if (test_bool){
  model_name_short=paste(model_name_short,'test',sep='_')
}
model_par_names=c("beta_1_MB","beta_1_MF","beta_2","alpha", "pers")
with_w=c('foerde_alter_JO.stan','foerde_alter_2_JO.stan')

if (model_name %in% with_w){
  model_par_names_full=c(model_par_names,"w")
}
# sets = 1:length(data_list);
sets = 1:4
# sets = 1
save_outputs = TRUE;

# Prepare data for stan ---------------
nT=150
stan_lists = list()
info_lists = list()
for (i in sets){
  nS=length(subjs_list[[i]])
  choice=array(0,dim=c(nS,nT,2))
  state=array(0,dim=c(nS,nT))
  reward=array(0,dim=c(nS,nT))
  missing_choice=array(0,dim=c(nS,nT,2))
  missing_reward=array(0,dim=c(nS,nT))
  
  ind_info_list_sub = c()
  ind_info_list_group = c()
  ind_info_list_condition = c()
  ind_info_list_age = c()
  ind_info_list_cond_order = c()
  
  for (s in 1:nS) {
    subj_data=data_list[[i]][data_list[[i]]$sub==subjs_list[[i]][s],]
    choice[s,1:nT,1]=subj_data$ch1-1
    choice[s,1:nT,2]=subj_data$ch2-1
    state[s,1:nT]=subj_data$st-1
    reward[s,1:nT]=subj_data$r
    miss_c1_ind=which(is.na(subj_data$ch1))
    miss_c2_ind=which(is.na(subj_data$ch2))
    miss_rew_ind=which(is.na(subj_data$r))
    choice[s,miss_c1_ind,1]=0
    choice[s,miss_c2_ind,2]=0
    reward[s,miss_rew_ind]=0
    state[s,miss_c2_ind]=1
    missing_choice[s,miss_c1_ind,1]=1
    missing_choice[s,miss_c2_ind,2]=1
    missing_reward[s,miss_rew_ind]=1
    
    ind_info_list_sub[length(ind_info_list_sub)+1]=unique(subj_data$sub)
    ind_info_list_group[length(ind_info_list_group)+1]=unique(subj_data$group)
    ind_info_list_condition[length(ind_info_list_condition)+1]=unique(subj_data$condition)
    ind_info_list_age[length(ind_info_list_age)+1]=unique(subj_data$age)
    ind_info_list_cond_order[length(ind_info_list_cond_order)+1]=unique(subj_data$cond_order)
  }
  ind_stan_list=list(set=list_names[i],nS=nS,nT=nT,choice=choice,state_2=state,reward=reward,
                    missing_choice=missing_choice,missing_reward=missing_reward)
  ind_info_list=list(sub=ind_info_list_sub,group=ind_info_list_group,condition=ind_info_list_condition,age=ind_info_list_age, cond_order=ind_info_list_cond_order)
  stan_lists[[i]]<-ind_stan_list
  info_lists[[i]]<-ind_info_list
}

# Fit the data----
iters = 4000;
# iters = 10;

HBA_fits = list();

fitted_params = list();
fitted_params_summary = list(); #mean and sd
for (i in sets){
  print(paste('started fitting data for',list_names[i],'with',model_name_short))
  HBA_ind_fit = stan(file=model_name,data=stan_lists[[i]],verbose=FALSE,save_warmup=FALSE,
                    pars=c('lp_','prev_choice','tran_count','tran_type','Q_TD','Q_MB','Q_2','delta_1','delta_2'),include=FALSE,
                    iter=iters,control=list(adapt_delta=0.99,stepsize=.01))
  print(paste('done fitting data for',list_names[i],'with',model_name_short))
  HBA_fits[[length(HBA_fits)+1]]<-HBA_ind_fit
  if (save_outputs){ # iters>=1000 && 
    saveRDS(HBA_ind_fit,file=paste("output/HB_fits/2/",date.time.append("HBA_ind_fit"),'_niter_',iters,'_',list_names[i],'_',model_name_short,'.rds',sep=''))
    print(paste('done saving fitted parameters for',list_names[i],'with',model_name_short))
  }
  
  fitted_ind_params = list();
  for (j in 1:length(model_par_names)){
    fitted_ind_params[[length(fitted_ind_params)+1]] <-summary(HBA_ind_fit,pars=model_par_names[j])$summary[,'mean']
  }
  if (model_name %in% with_w){
    fitted_ind_params[[length(fitted_ind_params)+1]] <-fitted_ind_params[[1]]/(fitted_ind_params[[1]]+fitted_ind_params[[2]])
    names(fitted_ind_params[[length(model_par_names)+1]]) <- sub("beta_1_MB", "w", names(fitted_ind_params[[length(model_par_names)+1]]))
  }
  fitted_params[[length(fitted_params)+1]] <-fitted_ind_params
  
  fitted_params_ind_summary = list()
  for (j in 1:length(model_par_names_full)){
    fitted_params_ind_summary[[length(fitted_params_ind_summary)+1]]=c(mean(fitted_params[[length(fitted_params)]][[j]]),sd(fitted_params[[length(fitted_params)]][[j]]))
  }
  names(fitted_params_ind_summary)<-model_par_names_full
  fitted_params_summary[[length(fitted_params_summary)+1]]=fitted_params_ind_summary
  
  fitted_params_ind_summary_df = data.frame(fitted_params_ind_summary)
  names(fitted_params_ind_summary_df)<-model_par_names_full
  fitted_ind_params_df<-data.frame(fitted_ind_params)
  names(fitted_ind_params_df)<-model_par_names_full
  rownames(fitted_ind_params_df)<-NULL
  fitted_ind_params_df$sub <- info_lists[[i]]$sub
  fitted_ind_params_df$group <- info_lists[[i]]$group
  fitted_ind_params_df$condition <- info_lists[[i]]$condition
  fitted_ind_params_df$age <- info_lists[[i]]$age
  fitted_ind_params_df$cond_order <- info_lists[[i]]$cond_order
  
  if (save_outputs){
    saveRDS(fitted_ind_params,file=paste("output/params/RDS/2/",date.time.append("fitted_ind_params"),'_','niter_',iters,'_',list_names[i],'_',model_name_short,'.rds',sep=''))
    saveRDS(fitted_params_ind_summary,file=paste("output/params/RDS/2/",date.time.append("fitted_params_ind_summary"),'_','niter_',iters,'_',list_names[i],'_',model_name_short,'.rds',sep=''))
    write.csv(fitted_params_ind_summary_df,file=paste("output/params/CSV/2/",date.time.append("fitted_ind_params_summary"),'_','niter_',iters,'_',list_names[i],'_',model_name_short,'.csv',sep=''),row.names=FALSE)
    write.csv(fitted_ind_params_df,file=paste("output/params/CSV/2/",date.time.append("fitted_ind_params_df"),'_',list_names[i],'_','niter_',iters,'_',model_name_short,'.csv',sep=''),row.names=FALSE)
    print(paste('saved parameters and parameter summary for',list_names[i],'with',model_name_short))
  }
  
}


