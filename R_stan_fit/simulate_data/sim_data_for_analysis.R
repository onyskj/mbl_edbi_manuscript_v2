setwd("~/Google Drive/Academia/manuscripts/code/mbl_edbi_manuscript_v2/R_stan_fit/simulate_data/") #from JO
library(MASS)
library(boot)
library(Rlab)
library(abind)
library(loo)
library(useful)
library(Rpdb)
library(tidyverse)

save_outputs = TRUE

NT=150
model_par_names=c("beta_1_MB","beta_1_MF","beta_2","alpha", "pers")
simulate_name = 'simulate_data_alter.R';

results_nt_ed = read.table(Sys.glob(file.path('fitted_params/', "*ED_NT*.csv")),sep=",",header=T)
results_tr_ed = read.table(Sys.glob(file.path('fitted_params/', "*ED_BID*.csv")),sep=",",header=T)
results_nt_hc = read.table(Sys.glob(file.path('fitted_params/', "*HC_NT*.csv")),sep=",",header=T)
results_tr_hc = read.table(Sys.glob(file.path('fitted_params/', "*HC_BID*.csv")),sep=",",header=T)

thetas_winfo=list(results_nt_ed,results_tr_ed,results_nt_hc,results_tr_hc)
output_converted_all = NULL
params_filename = str_replace(str_replace(paste(Sys.glob(file.path('fitted_params/', "*ED_NT*.csv")),'_plus',sep=''),'.csv',''),'fitted_params//','')

for (j in 1:length(thetas_winfo)){
  thetas = thetas_winfo[[j]][,1:5]
  subject_info = thetas_winfo[[j]][,7:11]
  
  NS=dim(thetas)[1]
  
  simulate_data <-dget(simulate_name)
  output = simulate_data(NT,NS,thetas)
  
  output_converted = NULL
  output_converted$sub <-rep(0,dim(subject_info)[1]*NT) 
  output_converted = as.data.frame(output_converted)
  output_converted$group <-rep(0,dim(subject_info)[1]*NT)
  output_converted$age <-rep(0,dim(subject_info)[1]*NT)
  output_converted$cond_order <-rep(0,dim(subject_info)[1]*NT)
  output_converted$condition <-rep(0,dim(subject_info)[1]*NT)
  output_converted$trialNo <-rep(1:150,dim(subject_info)[1])
  output_converted$ch1 <-rep(0,dim(subject_info)[1]*NT)
  output_converted$rt1 <-rep(NA,dim(subject_info)[1]*NT)
  output_converted$st <-rep(0,dim(subject_info)[1]*NT)
  output_converted$ch2 <-rep(0,dim(subject_info)[1]*NT)
  output_converted$rt2 <-rep(NA,dim(subject_info)[1]*NT)
  output_converted$r <-rep(0,dim(subject_info)[1]*NT)
  output_converted$transition <-rep(0,dim(subject_info)[1]*NT)
  output_converted$stay <-rep(0,dim(subject_info)[1]*NT)
  
  i=0
  for (s in subject_info$sub){
    i=i+1
    output_converted[(NT*(i-1)+1):(NT*i),]$sub=s
    output_converted[(NT*(i-1)+1):(NT*i),]$group=unique(subject_info[subject_info$sub==s,]$group)
    output_converted[(NT*(i-1)+1):(NT*i),]$age=unique(subject_info[subject_info$sub==s,]$age)
    output_converted[(NT*(i-1)+1):(NT*i),]$cond_order=unique(subject_info[subject_info$sub==s,]$cond_order)
    output_converted[(NT*(i-1)+1):(NT*i),]$condition=unique(subject_info[subject_info$sub==s,]$condition)
    output_converted[(NT*(i-1)+1):(NT*i),]$ch1 = output[["choices"]][i,,1]
    output_converted[(NT*(i-1)+1):(NT*i),]$st = output[["states"]][i,]
    output_converted[(NT*(i-1)+1):(NT*i),]$ch2 = output[["choices"]][i,,2]
    output_converted[(NT*(i-1)+1):(NT*i),]$r = output[["rewards"]][i,]
    output_converted[(NT*(i-1)+1):(NT*i),][((output$choices[i,,1] + output$states[i,]) %% 2)== 1,]$transition=1
    output_converted[(NT*(i-1)+1):(NT*i),]$ch1 = output_converted[(NT*(i-1)+1):(NT*i),]$ch1 + 1
    output_converted[(NT*(i-1)+1):(NT*i),]$st = output_converted[(NT*(i-1)+1):(NT*i),]$st +1
    output_converted[(NT*(i-1)+1):(NT*i),]$ch2 = output_converted[(NT*(i-1)+1):(NT*i),]$ch2 +1
    output_converted[(NT*(i-1)+1):(NT*i),]$stay = (c(1,diff(output_converted[(NT*(i-1)+1):(NT*i),]$ch1))==0)*1
  }
  output_converted_all = rbind(output_converted_all,output_converted)
}
if (save_outputs){
  write.csv(output_converted_all,file=paste("simulated_data",'_from_',params_filename,'.csv',sep=''),row.names=FALSE)
}