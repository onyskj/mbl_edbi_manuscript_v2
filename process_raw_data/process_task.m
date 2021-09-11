clear all
clc
w = warning ('query','last');
warning('off',w.identifier);
% a=addpath('/Volumes/DATA/task','Volumes/DATA/processed/')
% addpath('/Volumes/DATA/STUDY/analyse/task')
addpath('/Volumes/DATA/study_for_manu_v2/analyse/task/')
addpath('processed/');
% all_csv =dir('/Volumes/DATA/STUDY/analyse/task/*.csv');
all_csv =dir('/Volumes/DATA/study_for_manu_v2/analyse/task/*.csv');

% all_csv =dir('task/*.csv');
%
all_subjects_pr=[];
all_subjects_nt=[];
all_subjects_tr=[];
subject_order=cell(length(all_csv),2);
subject_info = table(0,0,0,0,0,'VariableNames',{'subject','missed_nt','missed_tr','total_reward_nt','total_reward_tr'});
% non_female_sub = {'5b71aea63736d40001754f31','5a6d12e8038431000194792e','591aac50ef20c600015d8c5d','535ffd41fdf99b65eb1831b2','56ffd10b18705800099d0416','5b22378b60c40e000103a644'};
non_female_sub = {'5b71aea63736d40001754f31','535ffd41fdf99b65eb1831b2','5b22378b60c40e000103a644'}; %males
wrong_ship_sub = {'59e493ef24d7bf00012f0f17','5b126ec7c85dc400016220a4','59175c2896ffb800017c4caf','56051814e372c00011bd556a','5af37ef586e4d20001a02ddd'};
% outlier = {'59ad42650acd5600012ec0b0'};
%wtf 59ada0805ea0f30001281732
% outlier={};
% wrong_ship_sub={};
% bad_sub=unique([non_female_sub,wrong_ship_sub,outlier]);
bad_sub=unique([non_female_sub,wrong_ship_sub]);
%
for s=1:length(all_csv)
    data = readtable(all_csv(s).name);
    if height(data)~=329
        subject_order(end,:)=[];
        continue
    end
%     data = removevars(data,{'stage_1_keys', 'prob_trans', 'stage_2_keys', 'reward11', 'reward12', 'reward21', 'reward22', 'random_var_rew', 'nt_thisRepN', 'nt_thisTrialN', 'nt_thisN', 'nt_thisIndex', 'nt_ran', 'date', 'expName', 'psychopyVersion', 'OS', 'frameRate', 'conditions_thisRepN', 'conditions_thisTrialN', 'conditions_thisN', 'conditions_thisIndex', 'conditions_ran', 'n_trials', 'reward_img', 'file_random'});
    data = removevars(data,{'stage_1_keys', 'prob_trans', 'stage_2_keys', 'reward11', 'reward12', 'reward21', 'reward22', 'random_var_rew', 'nt_thisRepN', 'nt_thisTrialN', 'nt_thisIndex', 'nt_ran', 'date', 'expName', 'psychopyVersion', 'OS', 'frameRate', 'conditions_thisRepN', 'conditions_thisTrialN', 'conditions_thisN', 'conditions_thisIndex', 'conditions_ran', 'n_trials', 'reward_img', 'file_random'});
%     data(find(isnan(data.stage1_choice)),:)=[]; %remove empty lines
    data(find(isnan(data.nt_thisN)),:)=[]; %remove empty lines
    missed_trigger = numel(find(data.stage1_choice(find(contains(data.condition,'trigger')))==0 | data.stage2_choice(find(contains(data.condition,'trigger')))==0));
    missed_neutral = numel(find(data.stage1_choice(find(contains(data.condition,'neutral')))==0 | data.stage2_choice(find(contains(data.condition,'neutral')))==0));
    
    if missed_neutral>15 | missed_trigger>15
        subject_order(end,:)=[];
        continue
    end
    if find(contains(bad_sub,data.participant{1}))
        subject_order(end,:)=[];
        continue
    end
    
    subject_info.subject(s)=s;
    subject_info.missed_nt(s)=missed_neutral;
    subject_info.missed_tr(s)=missed_trigger;
    
    if ~isempty(data(find(data.stage1_choice==0),:).stage2_state) %nan missed trials
        data(find(data.stage1_choice==0),:).stage2_state=data(find(data.stage1_choice==0),:).stage_1_rt;
    end
    if ~isempty(data(find(data.stage1_choice==0),:).stage1_choice) %nan missed trials
        data(find(data.stage1_choice==0),:).stage1_choice=data(find(data.stage1_choice==0),:).stage_1_rt;
    end
    if ~isempty(data(find(data.stage2_choice==0),:).stage2_choice) %nan missed trials
        data(find(data.stage2_choice==0),:).stage2_choice=data(find(data.stage2_choice==0),:).stage_2_rt;
    end
    
    if data.group(1)==1
        data.group=repmat({'NTfirst'},size(data,1),1);
    else
        data.group=repmat({'BIDfirst'},size(data,1),1);
    end
    
    data=removevars(data,{'order'});
    data = [table(repmat(s,size(data,1),1),'VariableNames',{'sub'}),data];
    data.Properties.VariableNames(9)={'trialNo'};
    data.Properties.VariableNames(12)={'cond_order'};
    
    
    data_pr = data(find(contains(data.condition,'practice')),:);
    data_pr.trialNo=data_pr.trialNo+1;
    data_nt = data(find(contains(data.condition,'neutral')),:);
    data_nt.trialNo=data_nt.trialNo+1;
    data_nt.trialNo(76:end)=data_nt.trialNo(76:end)+75;
    data_tr = data(find(contains(data.condition,'trigger')),:);
    data_tr.trialNo=data_tr.trialNo+1;
    data_tr.trialNo(76:end)=data_tr.trialNo(76:end)+75;
    
    
%     data_pr=removevars(data_pr,{'condition'});
    data_pr.condition=repmat({'PR'},size(data_pr,1),1);
    [~,idx_change_name_pr] = ismember({'stage1_choice','stage2_choice','stage2_state', 'stage_1_rt', 'stage_2_rt','reward'}, data_pr.Properties.VariableNames);
    data_pr.Properties.VariableNames(idx_change_name_pr)={'ch1', 'ch2', 'st', 'rt1', 'rt2','r'};
    
%     data_nt=removevars(data_nt,{'condition'});
    data_nt.condition=repmat({'NT'},size(data_nt,1),1);
    [~,idx_change_name_nt] = ismember({'stage1_choice', 'stage2_choice','stage2_state', 'stage_1_rt', 'stage_2_rt','reward'}, data_nt.Properties.VariableNames);
    data_nt.Properties.VariableNames(idx_change_name_nt)={'ch1','ch2', 'st', 'rt1', 'rt2','r'};

%     data_tr=removevars(data_tr,{'condition'});
    data_tr.condition=repmat({'BID'},size(data_tr,1),1);
    [~,idx_change_name_tr] = ismember({'stage1_choice','stage2_choice','stage2_state', 'stage_1_rt', 'stage_2_rt','reward'}, data_tr.Properties.VariableNames);
    data_tr.Properties.VariableNames(idx_change_name_tr)={'ch1', 'ch2','st', 'rt1', 'rt2','r'};
     
    ordered_vars = {'sub','cond_order','condition','participant','session','trialNo','ch1','rt1','st','ch2','rt2','r'};
    [~,ord_idx_pr] = ismember(ordered_vars, data_pr.Properties.VariableNames);
    data_pr=data_pr(:,ord_idx_pr);
    [~,ord_idx_nt] = ismember(ordered_vars, data_nt.Properties.VariableNames);
    data_nt=data_nt(:,ord_idx_nt);
    [~,ord_idx_tr] = ismember(ordered_vars, data_tr.Properties.VariableNames);
    data_tr=data_tr(:,ord_idx_tr);
    
    subject_order{s,1}=subject_info.subject(s);
    subject_order{s,2}=data_nt.participant{1};
    
    subject_info.total_reward_nt(s)=nansum(data_nt.r);
    subject_info.total_reward_tr(s)=nansum(data_tr.r);
    subject_info.total_reward(s) = subject_info.total_reward_nt(s)+subject_info.total_reward_tr(s);
    
    subject_info.avg_rt1_nt(s) = nanmean(data_nt.rt1);
    subject_info.avg_rt2_nt(s) = nanmean(data_nt.rt2);
    subject_info.avg_rt_nt(s) = nanmean([data_nt.rt1;data_nt.rt2]);
    
    subject_info.avg_rt1_tr(s) = nanmean(data_tr.rt1);
    subject_info.avg_rt2_tr(s) = nanmean(data_tr.rt2);
    subject_info.avg_rt_tr(s) = nanmean([data_tr.rt1;data_tr.rt2]);
    
    subject_info.avg_rt1(s) = nanmean([data_nt.rt1;data_tr.rt1]);
    subject_info.avg_rt2(s) = nanmean([data_nt.rt2;data_tr.rt2]);
    subject_info.avg_rt(s) = nanmean([data_nt.rt1;data_tr.rt1;data_nt.rt2;data_tr.rt2]);
   
    data_nt.transition = mod(data_nt.ch1+data_nt.st,2);
    data_tr.transition = mod(data_tr.ch1+data_tr.st,2);
    data_pr.transition = mod(data_pr.ch1+data_pr.st,2);
    
    data_nt.stay = [0;(diff(data_nt.ch1)==0)*1];
    data_tr.stay = [0;(diff(data_tr.ch1)==0)*1];
    data_pr.stay = [0;(diff(data_pr.ch1)==0)*1];
     
    all_subjects_pr=[all_subjects_pr;data_pr];
    all_subjects_nt=[all_subjects_nt;data_nt];
    all_subjects_tr=[all_subjects_tr;data_tr];
end

all_subjects_pr=all_subjects_pr(:,[1:3,6:14]);
all_subjects_nt=all_subjects_nt(:,[1:3,6:14]);
all_subjects_tr=all_subjects_tr(:,[1:3,6:14]);

subject_order=subject_order([subject_order{:,1}],:);
subject_info=subject_info(ismember(subject_info.subject,[subject_order{:,1}]),:);
% subject_info.total_reward = subject_info.total_reward_nt+subject_info.total_reward_tr;

rew_cutoff = mean(subject_info.total_reward)-2*std(subject_info.total_reward);
all_subjects_pr(find(all_subjects_pr.sub==find(subject_info.total_reward<rew_cutoff)),:)=[];
all_subjects_nt(find(all_subjects_nt.sub==find(subject_info.total_reward<rew_cutoff)),:)=[];
all_subjects_tr(find(all_subjects_tr.sub==find(subject_info.total_reward<rew_cutoff)),:)=[];
subject_order([subject_order{:,1}]==find(subject_info.total_reward<rew_cutoff),:)=[];
subject_info(subject_info.subject==find(subject_info.total_reward<rew_cutoff),:)=[];
disp('done processing')
%
writetable(all_subjects_pr, 'processed/all_subjects_pr.csv')
writetable(all_subjects_nt, 'processed/all_subjects_nt.csv')
writetable(all_subjects_tr, 'processed/all_subjects_tr.csv')
writetable(subject_info,'processed/subject_info.csv')
% writecell(subject_order,'processed/subject_order.csv') %order exclude
save('subject_order.mat','subject_order')
save('subject_info.mat','subject_info')
disp('done saving')

