##################
#
# adapted by Jakub Onysk based on vanessa brown 2018
#
##################

# set wd, load packages and functions ---------------
setwd("~/Google Drive/Academia/manuscripts/code/mbl_edbi_manuscript_v2/R_stan_fit/") #from JO
library(MASS)
library(boot)
library(Rlab)
library(abind)
library(rstan)
library(shinystan)
library(loo)
library(useful)
library(Rpdb)
library(tidyverse)
rstan_options(auto_write = FALSE)
options(mc.cores =  parallel::detectCores())
date.time.append <-dget("date_time_append.R")

seed_num = 10;
n_iter = 2000;
# seed_num = 2;
# n_iter = 5;
save_outputs = TRUE

seeds = sample(1:6000,size=seed_num);
err = 1e-3;
L=0+err;
U=1-err;
L2=0+err;
U2=1000-err;

NS = 38; #number of subjects
NT = 150; #number of trials
NP = 5; #number of parameters

model_name = 'foerde_alter_model.stan';
simulate_name = 'simulate_data_foerde_alter_model.R';

model_par_names=c("beta_1_MB","beta_1_MF","beta_2","alpha", "pers")

param_sum_filenames = c('prior_params.csv')

for (f in 1:length(param_sum_filenames)){
  fitted_par_sum <- read.csv(paste("output/params/CSV/prior/",param_sum_filenames[f],sep=''), header = T) 
  thetas <- matrix(0, ncol = NS, nrow = NP);
  
  fitted_par_sum$X<-NULL
  if ("w" %in% names(fitted_par_sum)){
    fitted_par_sum$w<-NULL
  }
  
  MU = as.numeric(fitted_par_sum[1,])
  SIG = diag(as.numeric(fitted_par_sum[2,]))
  
  thetas_corr = matrix(0, ncol = NP , nrow = seed_num);
  thetas_corr = data.frame(thetas_corr)
  colnames(thetas_corr)<-model_par_names
  
  for (seed in 1:length(seeds)){
    time_run=date.time.append('')
    set.seed(seeds[seed]);
    thetas = mvrnorm(n=NS, mu=MU, Sigma=SIG);
    thetas[,4]=matrix(sapply(thetas[,4], function(x) min(max(x,L+rnorm(1,0,err/10)),U-rnorm(1,0,err/10))),ncol=1,nrow=NS) #manually constrain
    #thetas[,1:3]=matrix(sapply(thetas[,1:3], function(x) min(max(x,L2+rnorm(1,0,err/10)),U2-rnorm(1,0,err/10))),ncol=3,nrow=NS) #manually constrain
    thetas[,1:2]=matrix(sapply(thetas[,1:2], function(x) min(max(x,L2+rnorm(1,0,err/10)),U2-rnorm(1,0,err/10))),ncol=2,nrow=NS) #manually constrain
    print(paste('Drawn parameters for seed:',seeds[seed],'for',param_sum_filenames[f]))
    
    simulate_data <-dget(simulate_name)
    output = simulate_data(NT,NS,thetas)
    print(paste('Simulated fake data for seed:',seeds[seed],'for',param_sum_filenames[f]))
    
    missing_choices = array(0,dim=c(NS,NT,2))
    missing_rewards = array(0,dim=c(NS,NT))
    stan_list=list(nS=NS,nT=NT,choice=output$choices,state_2=output$states,reward=output$rewards,
                   missing_choice=missing_choices,missing_reward=missing_rewards)
    
    HBA_fit=stan(file=model_name,data=stan_list,verbose=FALSE,save_warmup=FALSE,
                 pars=c('lp_','prev_choice','tran_count','tran_type','Q_TD','Q_MB','Q_2','delta_1','delta_2'),include=FALSE,
                 iter=n_iter,control=list(adapt_delta=0.99,stepsize=.01))
    print(paste('Fit fake data for seed:',seeds[seed],'for',param_sum_filenames[f]))
    fitted_ind_params = list();
    for (j in 1:length(model_par_names)){
      fitted_ind_params[[length(fitted_ind_params)+1]] <-summary(HBA_fit,pars=model_par_names[j])$summary[,'mean']
    }
    
    fitted = data.frame(fitted_ind_params)
    rownames(fitted)<-NULL
    colnames(fitted)<-model_par_names
    
    simulated = data.frame(thetas)
    colnames(simulated)<-model_par_names
    
    for (p in 1:NP){
      thetas_corr[seed,p]=cor(fitted[,p],simulated[,p])
    }
    print(thetas_corr[seed,])
    
    if (save_outputs){
      write.csv(simulated,file=paste("output/recovery/prior/","recovery_sim_params_seed_",seeds[seed],'_','itern_',n_iter,'_',time_run,'_from',param_sum_filenames[f],'.csv',sep=''),row.names=FALSE)
      write.csv(fitted,file=paste("output/recovery/prior/","recovery_fit_params_seed_",seeds[seed],'_','itern_',n_iter,'_',time_run,'_from',param_sum_filenames[f],'.csv',sep=''),row.names=FALSE)
      write.csv(thetas_corr[seed,],file=paste("output/recovery/prior/","recovery_corr_seed_",seeds[seed],'_','itern_',n_iter,'_',time_run,'_from',param_sum_filenames[f],'.csv',sep=''),row.names=FALSE)
    }
    
  }
  mean_corr = apply(thetas_corr,2,mean)
  sd_corr = apply(thetas_corr,2,sd)
  
  theta_corr_summary = data.frame(mean_corr,sd_corr)
  names(theta_corr_summary)<-c("mean",'std')
  
  if (save_outputs){
    time_saved=date.time.append('');
    write.csv(thetas_corr,file=paste("output/recovery/prior/","recovery_corr_all_",time_saved,'_seedn_',seed_num,'itern_',n_iter,'_from',param_sum_filenames[f],'.csv',sep=''),row.names=FALSE)
    write.csv(theta_corr_summary,file=paste("output/recovery/prior/","recovery_corr_summary",time_saved,'_seedn_',seed_num,'itern_',n_iter,'_from',param_sum_filenames[f],'.csv',sep=''),row.names=FALSE)
  }
  
  print(paste('correlations for: ',param_sum_filenames[f],sep=''))
  print(thetas_corr)
  
  print(paste('mean for: ',param_sum_filenames[f],sep=''))
  print(theta_corr_summary$mean)
  
  print(paste('standard deviation for: ',param_sum_filenames[f],sep=''))
  print(theta_corr_summary$std)
  
  set.seed(NULL)
  
}








