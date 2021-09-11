setwd("~/Google Drive/Academia/PostUoE_Man/manuscript_v2/hBayesDM/brown_my_version/HB_mine/best_version/") #from JO
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

seed_num = 10;
n_iter = 2000;

seeds = sample(1:6000,size=seed_num);

NS = 36; #number of subjects
NT = 150; #number of trials
NP = 5; #number of parameters

save_outputs = TRUE

thetas <- matrix(0, ncol = NS, nrow = NP);
err = 1e-2;
L=0+err;
U=1-err;
L2=0+err;
U2=1000-err;

model_name = 'foerde_JO.stan';
simulate_name = 'simulate_data.R';

model_name = 'foerde_alter_JO.stan';
simulate_name = 'simulate_data_alter.R';

model_par_names=c("beta_1_MB","beta_1_MF","beta_2","alpha", "pers")
param_sum_filename = 'fitted_ind_params_summary_2021_08_31_21_19_07_HC_NT_foerde_JO.csv'
param_sum_filename = 'fitted_ind_params_summary_2021_09_05_17_15_57_niter_1000_HC_NT_foerde_JO_wrong_ship.csv'
param_sum_filename = 'fitted_ind_params_summary_2021_09_06_00_28_41_niter_4000_HC_NT_foerde_JO_wrong_ship.csv'
param_sum_filename = 'fitted_ind_params_summary_2021_09_07_12_38_29_niter_1000_HC_NT_foerde_alter_JO_wrong_ship.csv'
param_sum_filename = 'fitted_ind_params_summary_2021_09_07_11_41_15_niter_1000_ED_NT_foerde_alter_JO_wrong_ship.csv'
param_sum_filename = 'fitted_ind_params_summary_2021_09_07_19_40_17_niter_1000_ED_NT_foerde_alter_JO_wrong_ship.csv'
param_sum_filename = 'fitted_ind_params_summary_2021_09_08_23_39_08_niter_1000_HC_NT_foerde_alter_JO_wrong_ship.csv'
param_sum_filename = 'fitted_ind_params_summary_2021_09_09_05_00_16_niter_4000_HC_NT_foerde_alter_JO_wrong_ship.csv'
param_sum_filename = 'fitted_ind_params_summary_2021_09_10_12_54_00_niter_1000_HC_NT_foerde_alter_gamma_JO_wrong_ship.csv'



fitted_par_sum <- read.csv(paste("output/params/CSV/",param_sum_filename,sep=''), header = T)
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
  thetas[,1:3]=matrix(sapply(thetas[,1:3], function(x) min(max(x,L2+rnorm(1,0,err/10)),U2-rnorm(1,0,err/10))),ncol=3,nrow=NS) #manually constrain
  print(paste('Drawn parameters for seed:',seeds[seed]))
  
  simulate_data <-dget(simulate_name)
  output = simulate_data(NT,NS,thetas)
  print(paste('Simulated fake data for seed:',seeds[seed]))
  
  missing_choices = array(0,dim=c(NS,NT,2))
  missing_rewards = array(0,dim=c(NS,NT))
  stan_list=list(nS=NS,nT=NT,choice=output$choices,state_2=output$states,reward=output$rewards,
                 missing_choice=missing_choices,missing_reward=missing_rewards)
  
  HBA_fit=stan(file=model_name,data=stan_list,verbose=FALSE,save_warmup=FALSE,
                  pars=c('lp_','prev_choice','tran_count','tran_type','Q_TD','Q_MB','Q_2','delta_1','delta_2'),include=FALSE,
                  iter=n_iter,control=list(adapt_delta=0.99,stepsize=.01))
  print(paste('Fit fake data for seed:',seeds[seed]))
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
    write.csv(simulated,file=paste("output/recovery/","recovery_sim_params_seed_",seeds[seed],'_','itern_',n_iter,'_',time_run,'_from',param_sum_filename,'.csv',sep=''),row.names=FALSE)
    write.csv(fitted,file=paste("output/recovery/","recovery_fit_params_seed_",seeds[seed],'_','itern_',n_iter,'_',time_run,'_from',param_sum_filename,'.csv',sep=''),row.names=FALSE)
    write.csv(thetas_corr[seed,],file=paste("output/recovery/","recovery_corr_seed_",seeds[seed],'_','itern_',n_iter,'_',time_run,'_from',param_sum_filename,'.csv',sep=''),row.names=FALSE)
  }

}
mean_corr = apply(thetas_corr,2,mean)
sd_corr = apply(thetas_corr,2,sd)

theta_corr_summary = data.frame(mean_corr,sd_corr)
names(theta_corr_summary)<-c("mean",'std')

if (save_outputs){
  time_saved=date.time.append('');
  write.csv(thetas_corr,file=paste("output/recovery/","recovery_corr_all_",time_saved,'_seedn_',seed_num,'itern_',n_iter,'_from',param_sum_filename,'.csv',sep=''),row.names=FALSE)
  write.csv(theta_corr_summary,file=paste("output/recovery/","recovery_corr_summary",time_saved,'_seedn_',seed_num,'itern_',n_iter,'_from',param_sum_filename,'.csv',sep=''),row.names=FALSE)
}

print('correlations')
print(thetas_corr)

print('mean')
print(theta_corr_summary$mean)

print('standard deviation')
print(theta_corr_summary$std)

set.seed(NULL)



