simseq <- function(NT,NS,params){
  #generate random walk for rewards
  sigma = 0.025*1.1;
  rewardRange_hi = 0.75;
  rewardRange_lo = 0.25;
  prob_rew = array(0,dim=c(2,2,NT))
  prob_rew[1,,1]=c((0.72-0.58)*runif(1)+0.58,(0.45-0.31)*runif(1)+0.31)
  prob_rew[2,,1]=c((0.45-0.31)*runif(1)+0.31,(0.72-0.58)*runif(1)+0.58)
  
  for (t in 1:(NT-1)){
    re = prob_rew[,,t]+matrix(rnorm(4,0,sigma),2,2)
    re[re>rewardRange_hi]=2*rewardRange_hi-re[re>rewardRange_hi]
    re[re<rewardRange_lo]=2*rewardRange_lo-re[re<rewardRange_lo]
    prob_rew[,,t+1]=re
  }
  
  choice=array(0,dim=c(NS,NT,2))
  reward=array(0,dim=c(NS,NT))
  state_2=array(0,dim=c(NS,NT))
  
  beta_1_MB = params[,1]
  beta_1_MF = params[,2]
  beta_2 = params[,3]
  alpha = params[,4]
  pers = params[,5]
  
  Q_TD = array(0,dim=c(1,2))
  Q_MB = array(0,dim=c(1,2))
  Q_2 = array(0,dim=c(2,2))
  tran_type = array(0,dim=c(1,2))
  
  for (s in 1:NS) {
    #set initial values
    for (i in 1:2) {
      Q_TD[i]=.5;
      Q_MB[i]=.5;
      Q_2[1,i]=.5;
      Q_2[2,i]=.5;
      tran_type[i]=0;
    }
    prev_choice=0;
    
    
    for (t in 1:NT) {
      choice[s,t,1] <- rbern(1,inv.logit(beta_1_MF[s]*(Q_TD[2]-Q_TD[1])+beta_1_MB[s]*(Q_MB[2]-Q_MB[1])+pers[s]*prev_choice))
      prev_choice = 2*choice[s,t,1]-1; #1 if choice 2, -1 if choice 1
      state_2[s,t] = (runif(1) > if(choice[s,t,1]==0){0.7}else{0.3})+1
      
      choice[s,t,2] <- rbern(1,inv.logit((beta_2[s]*(Q_2[state_2[s,t],2]-Q_2[state_2[s,t],1]))));
      
      reward[s,t]=1*(prob_rew[state_2[s,t],choice[s,t,2]+1,t]>runif(1))
      
      tran_count = if(state_2[s,t]-choice[s,t,1]-1==0){1}else{2};
      tran_type[tran_count] = tran_type[tran_count] + 1;
      
      Q_TD[choice[s,t,1]+1] = (1-alpha[s])*Q_TD[choice[s,t,1]+1] + reward[s,t];
      Q_2[state_2[s,t],choice[s,t,2]+1] = (1-alpha[s])*Q_2[state_2[s,t],choice[s,t,2]+1] + reward[s,t];
      
      Q_MB[1] = if(tran_type[1] > tran_type[2]) { (.7*max(Q_2[1,1],Q_2[1,2]) + .3*max(Q_2[2,1],Q_2[2,2]))} else{ (.3*max(Q_2[1,1],Q_2[1,2]) + .7*max(Q_2[2,1],Q_2[2,2]))};
      Q_MB[2] = if(tran_type[1] > tran_type[2]) { (.3*max(Q_2[1,1],Q_2[1,2]) + .7*max(Q_2[2,1],Q_2[2,2]))}else{(.7*max(Q_2[1,1],Q_2[1,2]) + .3*max(Q_2[2,1],Q_2[2,2]))};
    }
  }
  return(list(choices=choice,states=state_2,rewards=reward))
}
