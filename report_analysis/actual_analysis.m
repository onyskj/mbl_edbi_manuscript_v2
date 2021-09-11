%% Initialise (with rho for statistial test)
clear all; close all; clc
addpath('fitted_data/','export/','data/','processed/','tables/');

results_nt_ed = readtable("fitted_data/fitted_ind_params_df_2021_09_05_21_01_29_ED_NT_niter_4000_foerde_JO_wrong_ship.csv");
results_tr_ed = readtable("fitted_data/fitted_ind_params_df_2021_09_05_22_38_20_ED_BID_niter_4000_foerde_JO_wrong_ship.csv");
results_nt_hc = readtable("fitted_data/fitted_ind_params_df_2021_09_06_00_28_41_HC_NT_niter_4000_foerde_JO_wrong_ship.csv");
results_tr_hc = readtable("fitted_data/fitted_ind_params_df_2021_09_06_02_16_35_HC_BID_niter_4000_foerde_JO_wrong_ship.csv");

delta_w_ed = array2table(results_tr_ed{:,6} - results_nt_ed{:,6},'VariableNames',{'delta_w'}); 
delta_w_hc = array2table(results_tr_hc{:,6} - results_nt_hc{:,6},'VariableNames',{'delta_w'}); 

qs_scores = readtable("data/qs_scores.csv");
qs_scores.bmi=qs_scores.weight./(qs_scores.height/100).^2;
qs_scores.age_z=qs_scores.age2;
qs_scores(contains(qs_scores.group,'HC'),:).age_z=(qs_scores(contains(qs_scores.group,'HC'),:).age2-nanmean(qs_scores(contains(qs_scores.group,'HC'),:).age2))/nanstd(qs_scores(contains(qs_scores.group,'HC'),:).age2);
qs_scores(contains(qs_scores.group,'ED'),:).age_z=(qs_scores(contains(qs_scores.group,'ED'),:).age2-nanmean(qs_scores(contains(qs_scores.group,'ED'),:).age2))/nanstd(qs_scores(contains(qs_scores.group,'ED'),:).age2);
subject_info = [qs_scores(:,2),readtable("data/subject_info.csv")];
results_all = {results_nt_ed,results_tr_ed,results_nt_hc,results_tr_hc};
subject_info_groups={subject_info(contains(subject_info.group,'HC'),:),subject_info(contains(subject_info.group,'ED'),:)};
qs_scores_groups={qs_scores(contains(qs_scores.group,'HC'),:),qs_scores(contains(qs_scores.group,'ED'),:)};

%% Archive Old
% 
% df_nt_tr_ed = [results_nt_ed(:,1),array2table(results_nt_ed{:,[5:8]} - results_tr_ed{:,[5:8]},'VariableNames',{'mb_df','mf_df','lr_df','w_df'})]; 
% df_nt_tr_hc = [results_nt_hc(:,1),array2table(results_nt_hc{:,[5:8]} - results_tr_hc{:,[5:8]},'VariableNames',{'mb_df','mf_df','lr_df','w_df'})]; 
% %rho
% df_nt_tr_ed = [results_nt_ed(:,1),array2table(results_nt_ed{:,[5:9]} - results_tr_ed{:,[5:9]},'VariableNames',{'mb_df','mf_df','lr_df','w_df','rho_df'})]; 
% df_nt_tr_hc = [results_nt_hc(:,1),array2table(results_nt_hc{:,[5:9]} - results_tr_hc{:,[5:9]},'VariableNames',{'mb_df','mf_df','lr_df','w_df','rho_df'})]; 
% df_all = {df_nt_tr_ed,df_nt_tr_hc};
% results_all = {results_nt_ed,results_tr_ed,results_nt_hc,results_tr_hc};
% 
% % writetable(df_nt_tr_ed, 'processed/df_nt_tr_ed.csv')
% % writetable(df_nt_tr_hc, 'processed/df_nt_tr_hc.csv')
% 
% qs_scores = readtable("data/qs_scores.csv");
% qs_scores.bmi=qs_scores.weight./(qs_scores.height/100).^2;
% qs_scores.weight((qs_scores.bmi>=51 | qs_scores.bmi<=15),:)=NaN;
% qs_scores.height((qs_scores.bmi>=51 | qs_scores.bmi<=15),:)=NaN;
% qs_scores.bmi((qs_scores.bmi>=51 | qs_scores.bmi<=15),:)=NaN;
% subject_info = [qs_scores(:,2),readtable("data/subject_info.csv")];
% subject_info = [subject_info(:,2),subject_info(:,[1,3:end])];
% subject_info_groups={subject_info(contains(subject_info.group,'HC'),:),subject_info(contains(subject_info.group,'ED'),:)};
% qs_scores_groups={qs_scores(contains(qs_scores.group,'HC'),:),qs_scores(contains(qs_scores.group,'ED'),:)};
% 
% df_nt_tr = [df_nt_tr_ed qs_scores_groups{2}(:,2:end);df_nt_tr_hc qs_scores_groups{1}(:,2:end)];
% % writetable(df_nt_tr,'processed/df_nt_tr.csv')

%% Summarise the fits
param_names = {'beta_mb','beta_mf','beta_2','alpha','pers','w'};
results_info = cell(1,4); %%(beta_mb,beta_mf,beta_2,alpha,pers,w)x(mean,std,SE) for each group_condition

for i=1:length(results_all)
    results_info{i}=zeros(length(param_names),3);
    for j=1:length(param_names)
        results_info{i}(j,1)=mean(results_all{i}{:,j});
        results_info{i}(j,2)=std(results_all{i}{:,j});
        results_info{i}(j,3)=std(results_all{i}{:,j})/sqrt(length(results_all{i}{:,j}));
    end
end

%% TASK, QS summary
subject_info_summary_task = cell(1,2); %% (r_nt, r_tr, r_tot, rt1, rt2,rt)x(mean, std, SE)
task_data = cell(2,12);
for i=1:length(subject_info_summary_task)
    subject_info_summary_task{i}=[mean(subject_info_groups{i}.total_reward_nt),std(subject_info_groups{i}.total_reward_nt),std(subject_info_groups{i}.total_reward_nt)/sqrt(length(subject_info_groups{i}.total_reward_nt));...
        mean(subject_info_groups{i}.total_reward_tr),std(subject_info_groups{i}.total_reward_tr),std(subject_info_groups{i}.total_reward_tr)/sqrt(length(subject_info_groups{i}.total_reward_tr));...
        mean(subject_info_groups{i}.total_reward),std(subject_info_groups{i}.total_reward),std(subject_info_groups{i}.total_reward)/sqrt(length(subject_info_groups{i}.total_reward));...
        
        mean(subject_info_groups{i}.avg_rt1),std(subject_info_groups{i}.avg_rt1),std(subject_info_groups{i}.avg_rt1)/sqrt(length(subject_info_groups{i}.avg_rt1));...
        mean(subject_info_groups{i}.avg_rt2),std(subject_info_groups{i}.avg_rt2),std(subject_info_groups{i}.avg_rt2)/sqrt(length(subject_info_groups{i}.avg_rt2));...
        mean(subject_info_groups{i}.avg_rt),std(subject_info_groups{i}.avg_rt),std(subject_info_groups{i}.avg_rt)/sqrt(length(subject_info_groups{i}.avg_rt));...
        
        mean(subject_info_groups{i}.avg_rt1_nt),std(subject_info_groups{i}.avg_rt1_nt),std(subject_info_groups{i}.avg_rt1_nt)/sqrt(length(subject_info_groups{i}.avg_rt1_nt));...
        mean(subject_info_groups{i}.avg_rt2_nt),std(subject_info_groups{i}.avg_rt2_nt),std(subject_info_groups{i}.avg_rt2_nt)/sqrt(length(subject_info_groups{i}.avg_rt2_nt));...
        mean(subject_info_groups{i}.avg_rt_nt),std(subject_info_groups{i}.avg_rt_nt),std(subject_info_groups{i}.avg_rt_nt)/sqrt(length(subject_info_groups{i}.avg_rt_nt));...
        
        mean(subject_info_groups{i}.avg_rt1_tr),std(subject_info_groups{i}.avg_rt1_tr),std(subject_info_groups{i}.avg_rt1_tr)/sqrt(length(subject_info_groups{i}.avg_rt1_tr));...
        mean(subject_info_groups{i}.avg_rt2_tr),std(subject_info_groups{i}.avg_rt2_tr),std(subject_info_groups{i}.avg_rt2_tr)/sqrt(length(subject_info_groups{i}.avg_rt2_tr));...
        mean(subject_info_groups{i}.avg_rt_tr),std(subject_info_groups{i}.avg_rt_tr),std(subject_info_groups{i}.avg_rt_tr)/sqrt(length(subject_info_groups{i}.avg_rt_tr))];
    
    task_data(i,:)={subject_info_groups{i}.total_reward_nt,subject_info_groups{i}.total_reward_tr,subject_info_groups{i}.total_reward,...
        subject_info_groups{i}.avg_rt1,subject_info_groups{i}.avg_rt2,subject_info_groups{i}.avg_rt,...
        subject_info_groups{i}.avg_rt1_nt,subject_info_groups{i}.avg_rt2_nt,subject_info_groups{i}.avg_rt_nt,...
        subject_info_groups{i}.avg_rt1_tr,subject_info_groups{i}.avg_rt2_tr,subject_info_groups{i}.avg_rt_tr};
end

subject_info_summary_qs = cell(1,2); %%(EAT-26, AAI, OCI-R, height, weight, age)x(mean, std, SE)
dem_qs_data = cell(2,7);
for i=1:length(subject_info_summary_qs)
    subject_info_summary_qs{i}=[mean(qs_scores_groups{i}.EAT_26),std(qs_scores_groups{i}.EAT_26),std(qs_scores_groups{i}.EAT_26)/sqrt(length(qs_scores_groups{i}.EAT_26));...
        mean(qs_scores_groups{i}.AAI),std(qs_scores_groups{i}.AAI),std(qs_scores_groups{i}.AAI)/sqrt(length(qs_scores_groups{i}.AAI));...
        mean(qs_scores_groups{i}.OCI_R),std(qs_scores_groups{i}.OCI_R),std(qs_scores_groups{i}.OCI_R)/sqrt(length(qs_scores_groups{i}.OCI_R));...
        nanmean(qs_scores_groups{i}.weight),nanstd(qs_scores_groups{i}.weight),nanstd(qs_scores_groups{i}.weight)/sqrt(sum(~isnan(qs_scores_groups{i}.weight)));...
        nanmean(qs_scores_groups{i}.height),nanstd(qs_scores_groups{i}.height),nanstd(qs_scores_groups{i}.height)/sqrt(sum(~isnan(qs_scores_groups{i}.height)));...
        nanmean(qs_scores_groups{i}.bmi),nanstd(qs_scores_groups{i}.bmi),nanstd(qs_scores_groups{i}.bmi)/sqrt(sum(~isnan(qs_scores_groups{i}.bmi)));...
        mean(qs_scores_groups{i}.age2),std(qs_scores_groups{i}.age2),std(qs_scores_groups{i}.age2)/sqrt(length(qs_scores_groups{i}.age2))];
    dem_qs_data(i,:)={qs_scores_groups{i}.EAT_26,qs_scores_groups{i}.AAI,qs_scores_groups{i}.OCI_R,qs_scores_groups{i}.weight,qs_scores_groups{i}.height,qs_scores_groups{i}.bmi,qs_scores_groups{i}.age2};
end

%% OLD ARCHVIE
% results_info_df = cell(1,2); %%df_(mb,mf,lr,w_from_mean,rho)x(mean,std,SE) for each group
% for i=1:length(results_info_df)
%     results_info_df{i} = [mean(df_all{i}.mb_df),std(df_all{i}.mb_df),std(df_all{i}.mb_df)/sqrt(length(df_all{i}.mb_df));...
%         mean(df_all{i}.mf_df),std(df_all{i}.mf_df),std(df_all{i}.mf_df)/sqrt(length(df_all{i}.mf_df));...
%         mean(df_all{i}.lr_df),std(df_all{i}.lr_df),std(df_all{i}.lr_df)/sqrt(length(df_all{i}.lr_df));...
%         mean(df_all{i}.w_df),std(df_all{i}.w_df),std(df_all{i}.w_df)/sqrt(length(df_all{i}.w_df));...
%         mean(df_all{i}.rho_df),std(df_all{i}.rho_df),std(df_all{i}.rho_df)/sqrt(length(df_all{i}.rho_df))];
% end
% 
% subject_info_summary_task = cell(1,2); %% (r_nt, r_tr, r_tot, rt1, rt2,rt)x(mean, std, SE)
% task_data = cell(2,12);
% for i=1:length(subject_info_summary_task)
%     subject_info_summary_task{i}=[mean(subject_info_groups{i}.total_reward_nt),std(subject_info_groups{i}.total_reward_nt),std(subject_info_groups{i}.total_reward_nt)/sqrt(length(subject_info_groups{i}.total_reward_nt));...
%         mean(subject_info_groups{i}.total_reward_tr),std(subject_info_groups{i}.total_reward_tr),std(subject_info_groups{i}.total_reward_tr)/sqrt(length(subject_info_groups{i}.total_reward_tr));...
%         mean(subject_info_groups{i}.total_reward),std(subject_info_groups{i}.total_reward),std(subject_info_groups{i}.total_reward)/sqrt(length(subject_info_groups{i}.total_reward));...
%         
%         mean(subject_info_groups{i}.avg_rt1),std(subject_info_groups{i}.avg_rt1),std(subject_info_groups{i}.avg_rt1)/sqrt(length(subject_info_groups{i}.avg_rt1));...
%         mean(subject_info_groups{i}.avg_rt2),std(subject_info_groups{i}.avg_rt2),std(subject_info_groups{i}.avg_rt2)/sqrt(length(subject_info_groups{i}.avg_rt2));...
%         mean(subject_info_groups{i}.avg_rt),std(subject_info_groups{i}.avg_rt),std(subject_info_groups{i}.avg_rt)/sqrt(length(subject_info_groups{i}.avg_rt));...
%         
%         mean(subject_info_groups{i}.avg_rt1_nt),std(subject_info_groups{i}.avg_rt1_nt),std(subject_info_groups{i}.avg_rt1_nt)/sqrt(length(subject_info_groups{i}.avg_rt1_nt));...
%         mean(subject_info_groups{i}.avg_rt2_nt),std(subject_info_groups{i}.avg_rt2_nt),std(subject_info_groups{i}.avg_rt2_nt)/sqrt(length(subject_info_groups{i}.avg_rt2_nt));...
%         mean(subject_info_groups{i}.avg_rt_nt),std(subject_info_groups{i}.avg_rt_nt),std(subject_info_groups{i}.avg_rt_nt)/sqrt(length(subject_info_groups{i}.avg_rt_nt));...
%         
%         mean(subject_info_groups{i}.avg_rt1_tr),std(subject_info_groups{i}.avg_rt1_tr),std(subject_info_groups{i}.avg_rt1_tr)/sqrt(length(subject_info_groups{i}.avg_rt1_tr));...
%         mean(subject_info_groups{i}.avg_rt2_tr),std(subject_info_groups{i}.avg_rt2_tr),std(subject_info_groups{i}.avg_rt2_tr)/sqrt(length(subject_info_groups{i}.avg_rt2_tr));...
%         mean(subject_info_groups{i}.avg_rt_tr),std(subject_info_groups{i}.avg_rt_tr),std(subject_info_groups{i}.avg_rt_tr)/sqrt(length(subject_info_groups{i}.avg_rt_tr))];
%     
%     task_data(i,:)={subject_info_groups{i}.total_reward_nt,subject_info_groups{i}.total_reward_tr,subject_info_groups{i}.total_reward,...
%         subject_info_groups{i}.avg_rt1,subject_info_groups{i}.avg_rt2,subject_info_groups{i}.avg_rt,...
%         subject_info_groups{i}.avg_rt1_nt,subject_info_groups{i}.avg_rt2_nt,subject_info_groups{i}.avg_rt_nt,...
%         subject_info_groups{i}.avg_rt1_tr,subject_info_groups{i}.avg_rt2_tr,subject_info_groups{i}.avg_rt_tr};
% end
% 
% subject_info_summary_qs = cell(1,2); %%(EAT-26, AAI, OCI-R, height, weight, age)x(mean, std, SE)
% dem_qs_data = cell(2,7);
% for i=1:length(subject_info_summary_qs)
%     subject_info_summary_qs{i}=[mean(qs_scores_groups{i}.EAT_26),std(qs_scores_groups{i}.EAT_26),std(qs_scores_groups{i}.EAT_26)/sqrt(length(qs_scores_groups{i}.EAT_26));...
%         mean(qs_scores_groups{i}.AAI),std(qs_scores_groups{i}.AAI),std(qs_scores_groups{i}.AAI)/sqrt(length(qs_scores_groups{i}.AAI));...
%         mean(qs_scores_groups{i}.OCI_R),std(qs_scores_groups{i}.OCI_R),std(qs_scores_groups{i}.OCI_R)/sqrt(length(qs_scores_groups{i}.OCI_R));...
%         nanmean(qs_scores_groups{i}.weight),nanstd(qs_scores_groups{i}.weight),nanstd(qs_scores_groups{i}.weight)/sqrt(sum(~isnan(qs_scores_groups{i}.weight)));...
%         nanmean(qs_scores_groups{i}.height),nanstd(qs_scores_groups{i}.height),nanstd(qs_scores_groups{i}.height)/sqrt(sum(~isnan(qs_scores_groups{i}.height)));...
%         nanmean(qs_scores_groups{i}.bmi),nanstd(qs_scores_groups{i}.bmi),nanstd(qs_scores_groups{i}.bmi)/sqrt(sum(~isnan(qs_scores_groups{i}.bmi)));...
%         mean(qs_scores_groups{i}.age2),std(qs_scores_groups{i}.age2),std(qs_scores_groups{i}.age2)/sqrt(length(qs_scores_groups{i}.age2))];
%     dem_qs_data(i,:)={qs_scores_groups{i}.EAT_26,qs_scores_groups{i}.AAI,qs_scores_groups{i}.OCI_R,qs_scores_groups{i}.weight,qs_scores_groups{i}.height,qs_scores_groups{i}.bmi,qs_scores_groups{i}.age2};
% end

%% Demographic and questionnaire Welch's test (HC vs ED)
dem_qs_stat_tests = zeros(size(dem_qs_data,2),3); %(eat, aai, oci-r, weight, height, bmi, age2)x(p-value, t-value, sd)
for i=1:size(dem_qs_stat_tests,1)
    [h,p,~,stats] = ttest2(dem_qs_data{1,i},dem_qs_data{2,i});
    dem_qs_stat_tests(i,:)= [p,stats.tstat,stats.sd];
end

%% Task performance Welch's test (HC vs ED)
task_stat_tests = zeros(size(task_data,2),3); %(rew_nt,rew_tr,total_rew, avg_rt1, avg_rt2,avg_rt,avg_rt1_nt, avg_rt2_nt,avg_rt_nt,avg_rt1_tr, avg_rt2_tr,avg_rt_tr)x(p-value, t-value, sd)
for i=1:size(task_stat_tests,1)
    [h,p,~,stats] = ttest2(task_data{1,i},task_data{2,i});
    task_stat_tests(i,:)=[p,stats.tstat,stats.sd]; 
end

%% Welch's test for differences between groups and conditions
% clc
% disp('MB tests')
% [h_mb_ednt_edtr,p_mb_ednt_edtr,~,stats_mb_ednt_edtr]=ttest2(results_nt_ed.mb,results_tr_ed.mb)
% [h_mb_hcnt_hctr,p_mb_hcnt_hctr,~,stats_mb_hcnt_hctr]=ttest2(results_nt_hc.mb,results_tr_hc.mb)
% [h_mb_ednt_hcnt,p_mb_ednt_hcnt,~,stats_mb_ednt_hcnt]=ttest2(results_nt_ed.mb,results_nt_hc.mb)
% [h_mb_edtr_hctr,p_mb_edtr_hctr,~,stats_mb_edtr_hctr]=ttest2(results_tr_ed.mb,results_tr_hc.mb)
% fprintf('\n')
% 
% disp('MF tests')
% [h_mf_ednt_edtr,p_mf_ednt_edtr,~,stats_mf_ednt_edtr]=ttest2(results_nt_ed.mf,results_tr_ed.mf)
% [h_mf_hcnt_hctr,p_mf_hcnt_hctr,~,stats_mf_hcnt_hctr]=ttest2(results_nt_hc.mf,results_tr_hc.mf)
% [h_mf_ednt_hcnt,p_mf_ednt_hcnt,~,stats_mf_ednt_hcnt]=ttest2(results_nt_ed.mf,results_nt_hc.mf)
% [h_mf_edtr_hctr,p_mf_edtr_hctr,~,stats_mf_edtr_hctr]=ttest2(results_tr_ed.mf,results_tr_hc.mf)
% fprintf('\n')
% 
% disp('Alpha tests')
% [h_lr_ednt_edtr,p_lr_ednt_edtr,~,stats_lr_ednt_edtr]=ttest2(results_nt_ed.lr,results_tr_ed.lr)
% [h_lr_hcnt_hctr,p_lr_hcnt_hctr,~,stats_lr_hcnt_hctr]=ttest2(results_nt_hc.lr,results_tr_hc.lr)
% [h_lr_ednt_hcnt,p_lr_ednt_hcnt,~,stats_lr_ednt_hcnt]=ttest2(results_nt_ed.lr,results_nt_hc.lr)
% [h_lr_edtr_hctr,p_lr_edtr_hctr,~,stats_lr_edtr_hctr]=ttest2(results_tr_ed.lr,results_tr_hc.lr)
% fprintf('\n')
% 
% disp('w tests')
% [h_w_ednt_edtr,p_w_ednt_edtr,~,stats_w_ednt_edtr]=ttest2(results_nt_ed.w,results_tr_ed.w)
% [h_w_hcnt_hctr,p_w_hcnt_hctr,~,stats_w_hcnt_hctr]=ttest2(results_nt_hc.w,results_tr_hc.w)
% [h_w_ednt_hcnt,p_w_ednt_hcnt,~,stats_w_ednt_hcnt]=ttest2(results_nt_ed.w,results_nt_hc.w)
% [h_w_edtr_hctr,p_w_edtr_hctr,~,stats_w_edtr_hctr]=ttest2(results_tr_ed.w,results_tr_hc.w)
% fprintf('\n')
% 
% disp('rho tests')
% [h_rho_ednt_edtr,p_rho_ednt_edtr,~,stats_rho_ednt_edtr]=ttest2(results_nt_ed.rho,results_tr_ed.rho)
% [h_rho_hcnt_hctr,p_rho_hcnt_hctr,~,stats_rho_hcnt_hctr]=ttest2(results_nt_hc.rho,results_tr_hc.rho)
% [h_rho_ednt_hcnt,p_rho_ednt_hcnt,~,stats_rho_ednt_hcnt]=ttest2(results_nt_ed.rho,results_nt_hc.rho)
% [h_rho_edtr_hctr,p_rho_edtr_hctr,~,stats_rho_edtr_hctr]=ttest2(results_tr_ed.rho,results_tr_hc.rho)
% fprintf('\n')
% 
% mb_table = [p_mb_ednt_edtr,stats_mb_ednt_edtr.tstat;p_mb_hcnt_hctr stats_mb_hcnt_hctr.tstat;p_mb_ednt_hcnt,stats_mb_ednt_hcnt.tstat;p_mb_edtr_hctr stats_mb_edtr_hctr.tstat];
% mf_table = [p_mf_ednt_edtr,stats_mf_ednt_edtr.tstat;p_mf_hcnt_hctr stats_mf_hcnt_hctr.tstat;p_mf_ednt_hcnt,stats_mf_ednt_hcnt.tstat;p_mf_edtr_hctr stats_mf_edtr_hctr.tstat];
% lr_table = [p_lr_ednt_edtr,stats_lr_ednt_edtr.tstat;p_lr_hcnt_hctr stats_lr_hcnt_hctr.tstat;p_lr_ednt_hcnt,stats_lr_ednt_hcnt.tstat;p_lr_edtr_hctr stats_lr_edtr_hctr.tstat];
% w_table =  [p_w_ednt_edtr,stats_w_ednt_edtr.tstat;p_w_hcnt_hctr stats_w_hcnt_hctr.tstat;p_w_ednt_hcnt,stats_w_ednt_hcnt.tstat;p_w_edtr_hctr stats_w_edtr_hctr.tstat];
% rho_table =[p_rho_ednt_edtr,stats_rho_ednt_edtr.tstat;p_rho_hcnt_hctr stats_rho_hcnt_hctr.tstat;p_rho_ednt_hcnt,stats_rho_ednt_hcnt.tstat;p_rho_edtr_hctr stats_rho_edtr_hctr.tstat];

%% Welch's test for differences between groups on df
% clc
% disp('df_MB tests')
% [h_df_mb_ed_hc,p_df_mb_ed_hc,~,stats_df_mb_ed_hc]=ttest2(df_nt_tr_ed.mb_df,df_nt_tr_hc.mb_df)
% fprintf('\n')
% 
% disp('df_MF tests')
% [h_df_mf_ed_hc,p_df_mf_ed_hc,~,stats_df_mf_ed_hc]=ttest2(df_nt_tr_ed.mf_df,df_nt_tr_hc.mf_df)
% fprintf('\n')
% 
% disp('df_Alpha tests')
% [h_df_lr_ed_hc,p_df_lr_ed_hc,~,stats_df_lr_ed_hc]=ttest2(df_nt_tr_ed.lr_df,df_nt_tr_hc.lr_df)
% fprintf('\n')
% 
% disp('df_w tests')
% [h_df_w_ed_hc,p_df_w_ed_hc,~,stats_df_w_ed_hc]=ttest2(df_nt_tr_ed.w_df,df_nt_tr_hc.w_df)
% fprintf('\n')
% 
% disp('df_rho tests')
% [h_df_rho_ed_hc,p_df_rho_ed_hc,~,stats_df_rho_ed_hc]=ttest2(df_nt_tr_ed.rho_df,df_nt_tr_hc.rho_df)
% fprintf('\n')
% 
% df_table = [p_df_mb_ed_hc,stats_df_mb_ed_hc.tstat;p_df_mf_ed_hc,stats_df_mf_ed_hc.tstat;p_df_lr_ed_hc,stats_df_lr_ed_hc.tstat;p_df_w_ed_hc,stats_df_w_ed_hc.tstat;p_df_rho_ed_hc,stats_df_rho_ed_hc.tstat];

%% Save to csv
%demo+qs: stats and info
writematrix(dem_qs_stat_tests,'tables/dem_qs_stat_tests.csv')
writematrix(subject_info_summary_qs{1},'tables/subject_info_summary_qs_hc.csv')
writematrix(subject_info_summary_qs{2},'tables/subject_info_summary_qs_ed.csv')

%task perm: stats and info
writematrix(task_stat_tests,'tables/task_stat_tests.csv')
writematrix(subject_info_summary_task{1},'tables/subject_info_summary_task_hc.csv')
writematrix(subject_info_summary_task{2},'tables/subject_info_summary_task_ed.csv')
% 
% %parms: stats and info
% writematrix(results_info{1},'tables/results_info_nt_ed.csv')
% writematrix(results_info{2},'tables/results_info_tr_ed.csv')
% writematrix(results_info{3},'tables/results_info_nt_hc.csv')
% writematrix(results_info{4},'tables/results_info_tr_hc.csv')
% writematrix(mb_table,'tables/mb_table.csv')
% writematrix(mf_table,'tables/mf_table.csv')
% writematrix(lr_table,'tables/lr_table.csv')
% writematrix(w_table,'tables/w_table.csv')
% writematrix(rho_table,'tables/rho_table.csv')
% 
% %df params: stats and info
% writematrix(results_info_df{1},'tables/results_info_df_ed.csv')
% writematrix(results_info_df{2},'tables/results_info_df_hc.csv')
% writematrix(df_table,'tables/df_table.csv')

%% Plots params
close all
% MB
axisFontSize=40;
subplot(1,3,1)
y=[results_info{3}(1,1), results_info{1}(1,1);results_info{4}(1,1),results_info{2}(1,1)];
errors = [results_info{3}(1,3), results_info{1}(1,3);results_info{4}(1,3),results_info{2}(1,3)];

bar(y,'grouped')
hold on
ylabel('\beta_{MB}')
title('Model-based learning: \beta_{MB}')
ngroups = size(y,1);
nbars = size(y,2);
groupwidth = min(0.8, nbars/(nbars + 1.5));
for i = 1:nbars
    hold on;
    xx = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(xx(1)', y(1,i), errors(1,i), 'k', 'linestyle', 'none','linewidth',4);
    hold on;
    plot(xx(1)', y(1,i),'s','markersize',7,'color','k','MarkerFaceColor','k')
    hold on;
    errorbar(xx(2)', y(2,i), errors(2,i), 'k', 'linestyle', 'none','linewidth',4);
    hold on;
    plot(xx(2)', y(2,i),'s','markersize',7,'color','k','MarkerFaceColor','k')
end
xticklabels({'Neutral','BID'})
legend('HC','ED')
yticks(linspace(0, 0.5,3))
axis square
set(gca,'fontsize',axisFontSize,'Box','off','TickDir','out','TickLength'...
        ,[.0175 .0175],'XMinorTick'  , 'off','YMinorTick','on','YGrid','off',...
        'XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',2,'FontName','Helvetica','XDir', 'default');
%
% MF
subplot(1,3,2)
y=[results_info{3}(2,1), results_info{1}(2,1);results_info{4}(2,1),results_info{2}(2,1)];
errors = [results_info{3}(2,3), results_info{1}(2,3);results_info{4}(2,3),results_info{2}(2,3)];

bar(y,'grouped')
hold on
ylabel('\beta_{MF}')
title('Model-free learning: \beta_{MF}')
ngroups = size(y,1);
nbars = size(y,2);
groupwidth = min(0.8, nbars/(nbars + 1.5));
for i = 1:nbars
    hold on;
    xx = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(xx(1)', y(1,i), errors(1,i), 'k', 'linestyle', 'none','linewidth',4);
    hold on;
    plot(xx(1)', y(1,i),'s','markersize',7,'color','k','MarkerFaceColor','k')
    hold on;
    errorbar(xx(2)', y(2,i), errors(2,i), 'k', 'linestyle', 'none','linewidth',4);
    hold on;
    plot(xx(2)', y(2,i),'s','markersize',7,'color','k','MarkerFaceColor','k')
end
xticklabels({'Neutral','BID'})
legend('HC','ED')
yticks(linspace(0, 1.3,3))
axis square
set(gca,'fontsize',axisFontSize,'Box','off','TickDir','out','TickLength'...
        ,[.0175 .0175],'XMinorTick'  , 'off','YMinorTick','on','YGrid','off',...
        'XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',2,'FontName','Helvetica','XDir', 'default');

    
% % Alpha
% subplot(2,2,3)
% y=[results_info{3}(3,1), results_info{1}(3,1);results_info{4}(3,1),results_info{2}(3,1)];
% errors = [results_info{3}(3,3), results_info{1}(3,3);results_info{4}(3,3),results_info{2}(3,3)];
% 
% bar(y,'grouped')
% hold on
% ylabel('\alpha')
% title('Learning rate: \alpha')
% ngroups = size(y,1);
% nbars = size(y,2);
% groupwidth = min(0.8, nbars/(nbars + 1.5));
% for i = 1:nbars
%     hold on;
%     xx = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
%     errorbar(xx(1)', y(1,i), errors(1,i), 'k', 'linestyle', 'none','linewidth',4);
%     hold on;
%     plot(xx(1)', y(1,i),'s','markersize',7,'color','k','MarkerFaceColor','k')
%     hold on;
%     errorbar(xx(2)', y(2,i), errors(2,i), 'k', 'linestyle', 'none','linewidth',4);
%     hold on;
%     plot(xx(2)', y(2,i),'s','markersize',7,'color','k','MarkerFaceColor','k')
% end
% xticklabels({'Neutral','BID'})
% legend('HC','ED')
% yticks(linspace(0, 0.5,3))
% axis square
% set(gca,'fontsize',axisFontSize,'Box','off','TickDir','out','TickLength'...
%         ,[.0175 .0175],'XMinorTick'  , 'off','YMinorTick','on','YGrid','off',...
%         'XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',2,'FontName','Helvetica','XDir', 'default');
%     

%w
subplot(1,3,3)
y=[results_info{3}(6,1), results_info{1}(6,1);results_info{4}(6,1),results_info{2}(6,1)];
errors = [results_info{3}(6,3), results_info{1}(6,3);results_info{4}(6,3),results_info{2}(6,3)];

bar(y,'grouped')
hold on
title('Relative MB learning: w')
ylabel('w')
ngroups = size(y,1);
nbars = size(y,2);
groupwidth = min(0.8, nbars/(nbars + 1.5));
for i = 1:nbars
    hold on;
    xx = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(xx(1)', y(1,i), errors(1,i), 'k', 'linestyle', 'none','linewidth',4);
    hold on;
    plot(xx(1)', y(1,i),'s','markersize',7,'color','k','MarkerFaceColor','k')
    hold on;
    errorbar(xx(2)', y(2,i), errors(2,i), 'k', 'linestyle', 'none','linewidth',4);
    hold on;
    plot(xx(2)', y(2,i),'s','markersize',7,'color','k','MarkerFaceColor','k')
end
xticklabels({'Neutral','BID'})
legend('HC','ED')
yticks(linspace(0, 0.25,3))
axis square
set(gca,'fontsize',axisFontSize,'Box','off','TickDir','out','TickLength'...
        ,[.0175 .0175],'XMinorTick'  , 'off','YMinorTick','on','YGrid','off',...
        'XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',2,'FontName','Helvetica','XDir', 'default');
    
sgtitle('Average parameter values in HC and ED at the neutral and BID condition','fontsize',40)

set(gcf,'units','normalized','outerposition',[0 0 1 1])
fname = 'params_ED_HC_NT_TR';
% export_fig(fname,'-pdf', '-m1', '-transparent')

%% Plots df params - ARCHIVE
% close all
% axisFontSize=40;
% 
% %MB
% subplot(2,2,1)
% y=[results_info_df{2}(1,1); results_info_df{1}(1,1)];
% errors = [results_info_df{2}(1,3); results_info_df{1}(1,3)];
% bar(diag(y),'stacked')
% ngroups = size(y,1);
% nbars = size(y,2);
% groupwidth = min(0.8, nbars/(nbars + 1.5));
% for i = 1:nbars
%     hold on;
%     xx = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
%     errorbar(xx(1), y(1,i), errors(1,i), 'k', 'linestyle', 'none','linewidth',4,'HandleVisibility','off');
%     hold on
%     plot(xx(1), y(1,i),'s','markersize',12,'color','k','MarkerFaceColor','k')
%     hold on;
%     errorbar(xx(2), y(2,i), errors(2,i), 'k', 'linestyle', 'none','linewidth',4,'HandleVisibility','off');
%     hold on;
%     plot(xx(2), y(2,i),'s','markersize',12,'color','k','MarkerFaceColor','k')
% end
% ylabel('\Delta\beta_{MB}')
% title('Model-based diff.:\Delta\beta_{MB}')
% xticklabels({'HC','ED'})
% xticks([1 2])
% legend({'HC','ED'})
% ylim([-0.225,0.19])
% axis square
% set(gca,'fontsize',axisFontSize,'Box','off','TickDir','out','TickLength'...
%         ,[.0175 .0175],'XMinorTick'  , 'off','YMinorTick','on','YGrid','off',...
%         'XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',2,'FontName','Helvetica','XDir', 'default');
%     
% %MF
% subplot(2,2,2)
% y=[results_info_df{2}(2,1); results_info_df{1}(2,1)];
% errors = [results_info_df{2}(2,3); results_info_df{1}(2,3)];
% bar(diag(y),'stacked')
% ngroups = size(y,1);
% nbars = size(y,2);
% groupwidth = min(0.8, nbars/(nbars + 1.5));
% for i = 1:nbars
%     hold on;
%     xx = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
%     errorbar(xx(1), y(1,i), errors(1,i), 'k', 'linestyle', 'none','linewidth',4,'HandleVisibility','off');
%     hold on
%     plot(xx(1), y(1,i),'s','markersize',12,'color','k','MarkerFaceColor','k')
%     hold on;
%     errorbar(xx(2), y(2,i), errors(2,i), 'k', 'linestyle', 'none','linewidth',4,'HandleVisibility','off');
%     hold on;
%     plot(xx(2), y(2,i),'s','markersize',12,'color','k','MarkerFaceColor','k')
% end
% ylabel('\Delta\beta_{MF}')
% title('Model-free diff.:\Delta\beta_{MF}')
% xticklabels({'HC','ED'})
% xticks([1 2])
% legend({'HC','ED'})
% ylim([-0.275,0.175])
% axis square
% set(gca,'fontsize',axisFontSize,'Box','off','TickDir','out','TickLength'...
%         ,[.0175 .0175],'XMinorTick'  , 'off','YMinorTick','on','YGrid','off',...
%         'XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',2,'FontName','Helvetica','XDir', 'default');
%     
% %alpha
% subplot(2,2,3)
% y=[results_info_df{2}(3,1); results_info_df{1}(3,1)];
% errors = [results_info_df{2}(3,3); results_info_df{1}(3,3)];
% bar(diag(y),'stacked')
% ngroups = size(y,1);
% nbars = size(y,2);
% groupwidth = min(0.8, nbars/(nbars + 1.5));
% for i = 1:nbars
%     hold on;
%     xx = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
%     errorbar(xx(1), y(1,i), errors(1,i), 'k', 'linestyle', 'none','linewidth',4,'HandleVisibility','off');
%     hold on
%     plot(xx(1), y(1,i),'s','markersize',12,'color','k','MarkerFaceColor','k')
%     hold on;
%     errorbar(xx(2), y(2,i), errors(2,i), 'k', 'linestyle', 'none','linewidth',4,'HandleVisibility','off');
%     hold on;
%     plot(xx(2), y(2,i),'s','markersize',12,'color','k','MarkerFaceColor','k')
% end
% ylabel('\Delta\alpha')
% title('Learning rate diff.:\Delta\alpha')
% xticklabels({'HC','ED'})
% xticks([1 2])
% legend({'HC','ED'})
% ylim([-0.175,0.075])
% axis square
% set(gca,'fontsize',axisFontSize,'Box','off','TickDir','out','TickLength'...
%         ,[.0175 .0175],'XMinorTick'  , 'off','YMinorTick','on','YGrid','off',...
%         'XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',2,'FontName','Helvetica','XDir', 'default');
%     
% %w
% subplot(2,2,4)
% y=[results_info_df{2}(4,1); results_info_df{1}(4,1)];
% errors = [results_info_df{2}(4,3); results_info_df{1}(4,3)];
% bar(diag(y),'stacked')
% ngroups = size(y,1);
% nbars = size(y,2);
% groupwidth = min(0.8, nbars/(nbars + 1.5));
% for i = 1:nbars
%     hold on;
%     xx = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
%     errorbar(xx(1), y(1,i), errors(1,i), 'k', 'linestyle', 'none','linewidth',4,'HandleVisibility','off');
%     hold on
%     plot(xx(1), y(1,i),'s','markersize',12,'color','k','MarkerFaceColor','k')
%     hold on;
%     errorbar(xx(2), y(2,i), errors(2,i), 'k', 'linestyle', 'none','linewidth',4,'HandleVisibility','off');
%     hold on;
%     plot(xx(2), y(2,i),'s','markersize',12,'color','k','MarkerFaceColor','k')
% end
% ylabel('\Delta w')
% title('Relative MB diff.:\Delta w')
% xticklabels({'HC','ED'})
% xticks([1 2])
% legend({'HC','ED'})
% ylim([-0.15,0.220])
% sgtitle('Average difference of parameters between conditions: ``Neutral``-``BID``','fontsize',40)
% axis square
% set(gca,'fontsize',axisFontSize,'Box','off','TickDir','out','TickLength'...
%         ,[.0175 .0175],'XMinorTick'  , 'off','YMinorTick','on','YGrid','off',...
%         'XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',2,'FontName','Helvetica','XDir', 'default');
% 
% sgtitle('Average difference of parameters between conditions: ``Neutral``-``BID``','fontsize',40)
% set(gcf,'units','normalized','outerposition',[0 0 1 1])
% fname_df = 'param_df_NT_TR_nice';
% export_fig(fname_df,'-pdf', '-m1', '-transparent')

%% Correlations in ED
clc
scores=[qs_scores_groups{1};qs_scores_groups{2}];
% dfs = [df_all{2};df_all{1}];

% scores=[qs_scores_groups{2}];
% dfs = [df_all{1}];
mSize=30;
axisFontSize=30;

scores_for_corr = {scores.bmi,scores.age2,scores.EAT_26,scores.AAI,scores.OCI_R};
names = {'BMI','Age','EAT-26 score','AAI score', 'OCI-R score'};
for i=1:length(scores_for_corr)
    subplot(2,3,i)
    plot(dfs.mb_df,scores_for_corr{i},'.','markersize',mSize,'HandleVisibility','off')';
    [lb_eps, ub_eps] = bounds(dfs.mb_df);
    [r,p]=corrcoef([dfs.mb_df,scores_for_corr{i}],'rows','complete');
    hold on;
    plot(lb_eps:0.001:ub_eps,(lb_eps:0.001:ub_eps)*r(1,2)+nanmean(scores_for_corr{i}), 'linewidth',5,'DisplayName',['PCC = ',num2str(round(r(1,2),3)),10,'p-value = ',num2str(round(p(1,2),3))]);
    legend('location','best')
%     ylim([nanmin(scores_for_corr{i})*0.95,nanmax(scores_for_corr{i})*1.7])
    ylabel(names{i})
    xlabel('\Delta\beta_{MB}')
%     title(['\Delta\beta_{MB} vs ',names{i}])
    axis square
    set(gca,'fontsize',axisFontSize,'Box','off','TickDir','out','TickLength'...
        ,[.0175 .0175],'XMinorTick'  , 'on','YMinorTick','on','YGrid','off',...
        'XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',2,'FontName','Helvetica','XDir', 'default');
end
sgtitle('Correlations of demographic and questionnaire information with \Delta\beta_{MB}','fontsize',38)
set(gcf,'units','normalized','outerposition',[0 0 1 1])
fname_df = 'corr_info_dfbeta2';
% export_fig(fname_df,'-pdf', '-m1', '-transparent')

%% All together corrleations
clc
close all
scores=[qs_scores_groups{1};qs_scores_groups{2}];
% dfs = [df_all{2};df_all{1}];
dfs = [delta_w_hc;delta_w_ed];
% results_all
param_names_corr= {'beta_1_MB','beta_1_MF','w'};
group_cond_list = {'ED_NT','ED_BID','HC_NT','HC_BID'};
% results_all

% scores=[qs_scores_groups{2}];
% dfs = [df_all{1}];
mSize=60;
axisFontSize=30;
lineWidthSize=5;
lineColour = [0.8500, 0.3250, 0.0980];

scores_for_corr = {scores.bmi,scores.age_z,scores.EAT_26,scores.AAI,scores.OCI_R};
names = {'BMI','Age','EAT-26 score','AAI score', 'OCI-R score'};

for i=1:length(scores_for_corr)
    ax=subplot(2,3,i);
%     plot(dfs.delta_w,scores_for_corr{i},'.','markersize',mSize,'HandleVisibility','off');
    
    [lb_eps, ub_eps] = bounds(dfs.delta_w);
    [r,p]=corrcoef([dfs.delta_w,scores_for_corr{i}],'rows','complete');
%     disp(r(1,2))
    if p(1,2)<0.001
        scatter(ax,dfs.delta_w,scores_for_corr{i},mSize,'filled','DisplayName',['PCC = ',num2str(round(r(1,2),3)),10,'p-value = ',num2str(round(p(1,2),12),'%10.2e\n')]);
    else
        scatter(ax,dfs.delta_w,scores_for_corr{i},mSize,'filled','DisplayName',['PCC = ',num2str(round(r(1,2),3)),10,'p-value = ',num2str(round(p(1,2),3))]);
    end
    hold on;
    h=lsline(ax);
    h.LineWidth=lineWidthSize;
    h.Color=lineColour;
    h.HandleVisibility='off';
   
    
    
%     plot(lb_eps:0.001:ub_eps,(lb_eps:0.001:ub_eps)*r(1,2)+nanmean(scores_for_corr{i}), 'linewidth',5,'DisplayName',['PCC = ',num2str(round(r(1,2),3)),10,'p-value = ',num2str(round(p(1,2),6))]);
    legend('location','best');
%     ax.Legend.String{2}='';
%     ylim([nanmin(scores_for_corr{i})*0.95,nanmax(scores_for_corr{i})*1.7])
    ylabel(names{i});
    xlabel('\Deltaw');
%     title(['\Delta\beta_{MB} vs ',names{i}])
    axis square
    set(gca,'fontsize',axisFontSize,'Box','off','TickDir','out','TickLength'...
        ,[.0175 .0175],'XMinorTick'  , 'on','YMinorTick','on','YGrid','off',...
        'XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',2,'FontName','Helvetica','XDir', 'default');
end
sgtitle('Correlations of demographic and questionnaire information with \Delta\beta_{MB}','fontsize',38)
set(gcf,'units','normalized','outerposition',[0 0 1 1])
fname_df = 'corr_info_dfbeta_all';
% export_fig(fname_df,'-pdf', '-m1', '-transparent')

