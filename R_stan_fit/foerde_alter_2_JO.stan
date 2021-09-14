////////////////////////////////////
//
// adapted by Jakub Onysk 2021 based on vanessa brown 2018
//
////////////////////////////////////

data {
  int<lower=1> nT;
  int<lower=1> nS;
  int<lower=0,upper=1> choice[nS,nT,2]; 
  int<lower=0,upper=1> reward[nS,nT];
  int<lower=1,upper=2> state_2[nS,nT]; 
  int missing_choice[nS,nT,2];
  int missing_reward[nS,nT];
}

parameters {
  real alpha_m;
  real<lower=0> alpha_s;
  real<lower=0> beta_1_MF_m;
  real<lower=0> beta_1_MF_s;
  real<lower=0> beta_1_MB_m;
  real<lower=0> beta_1_MB_s;
  real<lower=0> beta_2_m;
  real<lower=0> beta_2_s;
  real pers_m;
  real<lower=0> pers_s;
  vector[nS] alpha_raw;
  vector<lower=0>[nS] beta_1_MF_raw;
  vector<lower=0>[nS] beta_1_MB_raw;
  vector<lower=0>[nS] beta_2_raw;
  vector[nS] pers_raw;
}

transformed parameters {
  //define transformed parameters
  vector<lower=0,upper=1>[nS] alpha;
  vector[nS] alpha_normal;
  vector<lower=0>[nS] beta_1_MF;
  vector<lower=0>[nS] beta_1_MB;
  vector<lower=0>[nS] beta_2;
  vector[nS] pers;

  //create transformed parameters using non-centered parameterization for all
  // and logistic transformation for alpha (range: 0 to 1)
  alpha_normal = alpha_m + alpha_s*alpha_raw;
  alpha = inv_logit(alpha_normal);
  beta_1_MF = (beta_1_MF_m) + beta_1_MF_s*(beta_1_MF_raw);
  beta_1_MB = (beta_1_MB_m) + beta_1_MB_s*(beta_1_MB_raw);
  beta_2 = (beta_2_m) + beta_2_s*(beta_2_raw);
  pers = pers_m + pers_s*pers_raw;
}

model {
  //define variables
  int prev_choice;
  int tran_count;
  int unchosen1;
  int unchosen2;
  int unvisited;
  int tran_type[2];
  real delta_1;
  real delta_2;
  real Q_TD[2];
  real Q_MB[2];
  real Q_2[2,2];
  
  //define priors
  alpha_m ~ normal(0,2.5);
  beta_1_MF_m ~ normal(0,5);
  beta_1_MB_m ~ normal(0,5);
  beta_2_m ~ normal(0,5);
  pers_m ~ normal(0,2.5);
  alpha_s ~ cauchy(0,1);
  beta_1_MF_s ~ cauchy(0,2);
  beta_1_MB_s ~ cauchy(0,2);
  beta_2_s ~ cauchy(0,2);
  pers_s ~ cauchy(0,1);
  alpha_raw ~ normal(0,1);
  beta_1_MF_raw ~ normal(0,1);
  beta_1_MB_raw ~ normal(0,1);
  beta_2_raw ~ normal(0,1);
  pers_raw ~ normal(0,1);
  
  for (s in 1:nS) {
  
  //set initial values
  for (i in 1:2) {
    Q_TD[i]=.5;
    Q_MB[i]=.5;
    Q_2[1,i]=.5;
    Q_2[2,i]=.5;
    tran_type[i]=0;
  }
  prev_choice=0;
  
    for (t in 1:nT) {
      //use if not missing 1st stage choice
      if (missing_choice[s,t,1]==0) {
        choice[s,t,1] ~ bernoulli_logit(beta_1_MF[s]*(Q_TD[2]-Q_TD[1])+beta_1_MB[s]*(Q_MB[2]-Q_MB[1])+pers[s]*prev_choice);
        prev_choice = 2*choice[s,t,1]-1; //1 if choice 2, -1 if choice 1
        
        //use if not missing 2nd stage choice
        if (missing_choice[s,t,2]==0) {
          choice[s,t,2] ~ bernoulli_logit(beta_2[s]*(Q_2[state_2[s,t],2]-Q_2[state_2[s,t],1]));
          
          //use if not missing 2nd stage reward
          if (missing_reward[s,t]==0) {
             //update transition counts: if choice=0 & state=1, or choice=1 & state=2, update 1st
             // expectation of transition, otherwise update 2nd expectation
             tran_count = (state_2[s,t]-choice[s,t,1]-1) ? 2 : 1;
             tran_type[tran_count] = tran_type[tran_count] + 1;
             
             //update chosen values
             Q_TD[choice[s,t,1]+1] = (1-alpha[s])*Q_TD[choice[s,t,1]+1] + reward[s,t]; 
             Q_2[state_2[s,t],choice[s,t,2]+1] = (1-alpha[s])*Q_2[state_2[s,t],choice[s,t,2]+1] + reward[s,t];
             Q_MB[1] = fmax(Q_2[1,1],Q_2[1,2]); 
             Q_MB[2] = fmax(Q_2[2,1],Q_2[2,2]);
          } //if missing 2nd stage reward: do nothing
          
        } 
        else if (missing_choice[s,t,2]==1||missing_reward[s,t]==1) { //if missing 2nd stage choice or reward: still update 1st stage TD values
          Q_TD[choice[s,t,1]+1] = (1-alpha[s])*Q_TD[choice[s,t,1]+1] + reward[s,t];
        }
      } 
      else { //if missing 1st stage choice: update previous choices
      prev_choice=0;
      }
      //decaying unvisted states and unchosen actions by (1-alpha)
      unchosen1 = (choice[s,t,1]>0) ? 0 : 1;
      unchosen2 = (choice[s,t,2]>0) ? 0 : 1;
      unvisited = (state_2[s,t]>1) ? 1 : 2;
      Q_TD[unchosen1+1] = Q_TD[unchosen1+1]*(1-alpha[s]);
      Q_2[unvisited,1]=Q_2[unvisited,1]*(1-alpha[s]);
      Q_2[unvisited,2]=Q_2[unvisited,2]*(1-alpha[s]);
      Q_2[state_2[s,t],unchosen2+1]=Q_2[state_2[s,t],unchosen2+1]*(1-alpha[s]);
      Q_MB[unchosen1+1]=Q_MB[unchosen1+1]*(1-alpha[s]);
      
    }
  }
}

generated quantities {
  //same code as above, with following changes: 
  // 1) values and choices used to calculate probability, rather than fitting values to choices
  // 2) no priors, etc.- uses estimated pararamter values from model block
  real log_lik[nS,nT,2]; //log likelihood- must be named this
  int prev_choice;
  int tran_count;
  int tran_type[2];
  int unchosen1;
  int unchosen2;
  int unvisited;
  real Q_TD[2];
  real Q_MB[2];
  real Q_2[2,2];
  
  for (s in 1:nS) {
    for (i in 1:2) {
      Q_TD[i]=.5;
      Q_MB[i]=.5;
      Q_2[1,i]=.5;
      Q_2[2,i]=.5;
      tran_type[i]=0;
    }
    prev_choice=0;
    for (t in 1:nT) {
      if (missing_choice[s,t,1]==0) {
        log_lik[s,t,1] = bernoulli_logit_lpmf(choice[s,t,1] | beta_1_MF[s]*(Q_TD[2]-Q_TD[1])+beta_1_MB[s]*(Q_MB[2]-Q_MB[1])+pers[s]*prev_choice);
        prev_choice = 2*choice[s,t,1]-1; //1 if choice 2, -1 if choice 1
        
        if (missing_choice[s,t,2]==0) {
          log_lik[s,t,2] = bernoulli_logit_lpmf(choice[s,t,2] | beta_2[s]*(Q_2[state_2[s,t],2]-Q_2[state_2[s,t],1]));
          if (missing_reward[s,t]==0) {
             tran_count = (state_2[s,t]-choice[s,t,1]-1) ? 2 : 1;
             tran_type[tran_count] = tran_type[tran_count] + 1;
             
             Q_TD[choice[s,t,1]+1] = (1-alpha[s])*Q_TD[choice[s,t,1]+1] + reward[s,t];
             Q_2[state_2[s,t],choice[s,t,2]+1] = (1-alpha[s])*Q_2[state_2[s,t],choice[s,t,2]+1] + reward[s,t]; 
             Q_MB[1] = fmax(Q_2[1,1],Q_2[1,2]);
             Q_MB[2] = fmax(Q_2[2,1],Q_2[2,2]);
          } //if missing 2nd stage reward: do nothing
          
        } 
        else  { //if missing 2nd stage choice: still update 1st stage TD values
        log_lik[s,t,2] = 0;
        Q_TD[choice[s,t,1]+1] = (1-alpha[s])*Q_TD[choice[s,t,1]+1] + reward[s,t];
        }
      } 
      else {
        prev_choice=0;
        log_lik[s,t,2] = 0;
        log_lik[s,t,1] = 0;
      }
      //decaying unvisted states and unchosen actions by (1-alpha)
      unchosen1 = (choice[s,t,1]>0) ? 0 : 1;
      unchosen2 = (choice[s,t,2]>0) ? 0 : 1;
      unvisited = (state_2[s,t]>1) ? 1 : 2;
      Q_TD[unchosen1+1] = Q_TD[unchosen1+1]*(1-alpha[s]);
      Q_2[unvisited,1]=Q_2[unvisited,1]*(1-alpha[s]);
      Q_2[unvisited,2]=Q_2[unvisited,2]*(1-alpha[s]);
      Q_2[state_2[s,t],unchosen2+1]=Q_2[state_2[s,t],unchosen2+1]*(1-alpha[s]);
      Q_MB[unchosen1+1]=Q_MB[unchosen1+1]*(1-alpha[s]);
    }
  }
}
