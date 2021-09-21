clear all; close all; clc;
%load CSVs
w = warning ('query','last');
warning('off',w.identifier);
addpath('/Volumes/DATA/study_for_manu_v2/analyse/task/')
addpath('processed/');
all_csv =dir('/Volumes/DATA/study_for_manu_v2/analyse/task/*.csv');

%setup subject data arrays and exclude
all_subjects_pr=[];
all_subjects_nt=[];
all_subjects_tr=[];
subject_order=cell(length(all_csv),2);
subject_info = table(0,0,0,0,0,'VariableNames',{'subject','missed_nt','missed_tr','total_reward_nt','total_reward_tr'});
% non_female_sub = {'5b71aea63736d40001754f31','5a6d12e8038431000194792e','591aac50ef20c600015d8c5d','535ffd41fdf99b65eb1831b2','56ffd10b18705800099d0416','5b22378b60c40e000103a644'};
non_female_sub = {'5b71aea63736d40001754f31','535ffd41fdf99b65eb1831b2','5b22378b60c40e000103a644'}; %males
wrong_ship_sub = {'59e493ef24d7bf00012f0f17','5b126ec7c85dc400016220a4','59175c2896ffb800017c4caf','56051814e372c00011bd556a','5af37ef586e4d20001a02ddd'};
%wtf 59ada0805ea0f30001281732
bad_sub=unique([non_female_sub,wrong_ship_sub]);
removed_sub_list = cell(2,1);

%%% process each subject
for s=1:length(all_csv)
    data = readtable(all_csv(s).name);
    %remove if didn't complete the condition
    if height(data)~=329
%         subject_order(end,:)=[];
        subject_order(s,:)={0,0};
        subject_info.subject(s)=0;
        removed_sub_list{1,end+1}=s;
        removed_sub_list{2,end}='cond_incomplete';
        continue
    end
    %remove unused variables
    data = removevars(data,{'stage_1_keys', 'prob_trans', 'stage_2_keys', 'reward11', 'reward12', 'reward21', 'reward22', 'random_var_rew', 'nt_thisRepN', 'nt_thisTrialN', 'nt_thisIndex', 'nt_ran', 'date', 'expName', 'psychopyVersion', 'OS', 'frameRate', 'conditions_thisRepN', 'conditions_thisTrialN', 'conditions_thisN', 'conditions_thisIndex', 'conditions_ran', 'n_trials', 'reward_img', 'file_random'});
    
    %remove empty lines from the dataset
    data(find(isnan(data.nt_thisN)),:)=[]; 
    
    %count missed trials in each conditions
    missed_trigger = numel(find(data.stage1_choice(find(contains(data.condition,'trigger')))==0 | data.stage2_choice(find(contains(data.condition,'trigger')))==0));
    missed_neutral = numel(find(data.stage1_choice(find(contains(data.condition,'neutral')))==0 | data.stage2_choice(find(contains(data.condition,'neutral')))==0));
    
    %remove subjects with more that 10% missed trials
    if missed_neutral>15 | missed_trigger>15
%         subject_order(end,:)=[];
        subject_info.subject(s)=0;
        subject_order(s,:)={0,0};
        removed_sub_list{1,end+1}=s;
        removed_sub_list{2,end}='missed_trials';
        continue
    end
    
    %remove subjects that were to be excluded based on initial PID list
    if find(contains(bad_sub,data.participant{1}))
%         subject_order(end,:)=[];
        subject_order(s,:)={0,0};
        subject_info.subject(s)=0;
        removed_sub_list{1,end+1}=s;
        removed_sub_list{2,end}='male_wrongship';
        continue
    end
    
    %remove subjects if clicked the same choice on more than 95% trial
    tab_ch1_nt = tabulate(data.stage1_choice(find(contains(data.condition,'neutral'))));
    tab_ch2_nt = tabulate(data.stage2_choice(find(contains(data.condition,'neutral'))));
    tab_ch1_tr = tabulate(data.stage1_choice(find(contains(data.condition,'trigger'))));
    tab_ch2_tr = tabulate(data.stage2_choice(find(contains(data.condition,'trigger'))));
    if any([any(tab_ch1_nt(:,3)>95),any(tab_ch2_nt(:,3)>95),any(tab_ch1_tr(:,3)>95),any(tab_ch2_tr(:,3)>95)])
%         subject_order(end,:)=[];
        subject_order(s,:)={0,0};
        subject_info.subject(s)=0;
        removed_sub_list{1,end+1}=s;
        removed_sub_list{2,end}='same_choice';
        continue        
    end
    %add subject info - count of missed trials
    subject_info.subject(s)=s;
    subject_info.missed_nt(s)=missed_neutral;
    subject_info.missed_tr(s)=missed_trigger;
    
    %nan missed choices in each stage
    if ~isempty(data(find(data.stage1_choice==0),:).stage2_state) %nan missed trials
        data(find(data.stage1_choice==0),:).stage2_state=data(find(data.stage1_choice==0),:).stage_1_rt;
    end
    if ~isempty(data(find(data.stage1_choice==0),:).stage1_choice) %nan missed trials
        data(find(data.stage1_choice==0),:).stage1_choice=data(find(data.stage1_choice==0),:).stage_1_rt;
    end
    if ~isempty(data(find(data.stage2_choice==0),:).stage2_choice) %nan missed trials
        data(find(data.stage2_choice==0),:).stage2_choice=data(find(data.stage2_choice==0),:).stage_2_rt;
    end
    
    %label groups and relabel variables
    if data.group(1)==1
        data.group=repmat({'NTfirst'},size(data,1),1);
    else
        data.group=repmat({'BIDfirst'},size(data,1),1);
    end
    data=removevars(data,{'order'});
    data = [table(repmat(s,size(data,1),1),'VariableNames',{'sub'}),data];
    data.Properties.VariableNames(9)={'trialNo'};
    data.Properties.VariableNames(12)={'cond_order'};
    
    %number trials
    data_pr = data(find(contains(data.condition,'practice')),:);
    data_pr.trialNo=data_pr.trialNo+1;
    data_nt = data(find(contains(data.condition,'neutral')),:);
    data_nt.trialNo=data_nt.trialNo+1;
    data_nt.trialNo(76:end)=data_nt.trialNo(76:end)+75;
    data_tr = data(find(contains(data.condition,'trigger')),:);
    data_tr.trialNo=data_tr.trialNo+1;
    data_tr.trialNo(76:end)=data_tr.trialNo(76:end)+75;
    
    %%% organise each conditions and rename variables
    %practice
    data_pr.condition=repmat({'PR'},size(data_pr,1),1);
    [~,idx_change_name_pr] = ismember({'stage1_choice','stage2_choice','stage2_state', 'stage_1_rt', 'stage_2_rt','reward'}, data_pr.Properties.VariableNames);
    data_pr.Properties.VariableNames(idx_change_name_pr)={'ch1', 'ch2', 'st', 'rt1', 'rt2','r'};
    
    %neutral
    data_nt.condition=repmat({'NT'},size(data_nt,1),1);
    [~,idx_change_name_nt] = ismember({'stage1_choice', 'stage2_choice','stage2_state', 'stage_1_rt', 'stage_2_rt','reward'}, data_nt.Properties.VariableNames);
    data_nt.Properties.VariableNames(idx_change_name_nt)={'ch1','ch2', 'st', 'rt1', 'rt2','r'};
    
    %BID
    data_tr.condition=repmat({'BID'},size(data_tr,1),1);
    [~,idx_change_name_tr] = ismember({'stage1_choice','stage2_choice','stage2_state', 'stage_1_rt', 'stage_2_rt','reward'}, data_tr.Properties.VariableNames);
    data_tr.Properties.VariableNames(idx_change_name_tr)={'ch1', 'ch2','st', 'rt1', 'rt2','r'};
    
    %reorder variables
    ordered_vars = {'sub','cond_order','condition','participant','session','trialNo','ch1','rt1','st','ch2','rt2','r'};
    [~,ord_idx_pr] = ismember(ordered_vars, data_pr.Properties.VariableNames);
    data_pr=data_pr(:,ord_idx_pr);
    [~,ord_idx_nt] = ismember(ordered_vars, data_nt.Properties.VariableNames);
    data_nt=data_nt(:,ord_idx_nt);
    [~,ord_idx_tr] = ismember(ordered_vars, data_tr.Properties.VariableNames);
    data_tr=data_tr(:,ord_idx_tr);
    subject_order{s,1}=subject_info.subject(s);
    subject_order{s,2}=data_nt.participant{1};
    
    %save task and performance info
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

removed_sub_list(:,1)=[];
all_subjects_pr=all_subjects_pr(:,[1:3,6:14]);
all_subjects_nt=all_subjects_nt(:,[1:3,6:14]);
all_subjects_tr=all_subjects_tr(:,[1:3,6:14]);

subject_order(find([subject_order{:,1}]==0),:)=[];
subject_info(find(subject_info.subject==0),:)=[];

% subject_order=subject_order([subject_order{:,1}],:);
% subject_info=subject_info(ismember(subject_info.subject,[subject_order{:,1}]),:);

rew_cutoff = mean(subject_info.total_reward)-2*std(subject_info.total_reward);
rew_cutoff_subjs = subject_info(find(subject_info.total_reward<rew_cutoff),:).subject;
rt_cutoff = mean(subject_info.avg_rt)-2*std(subject_info.avg_rt);
rt_cutoff_subjs = subject_info(find(subject_info.avg_rt<rt_cutoff),:).subject;

rew_sub_cell = [num2cell(rew_cutoff_subjs),cellstr(repmat('rew_cutoff',length(rew_cutoff_subjs),1))]';
rt_sub_cell = [num2cell(rt_cutoff_subjs),cellstr(repmat('rt_cutoff',length(rt_cutoff_subjs),1))]';


cutoff_subjs = unique([rew_cutoff_subjs;rt_cutoff_subjs]);
removed_sub_list=[removed_sub_list,[rew_sub_cell,rt_sub_cell]];

all_subjects_pr(ismember(all_subjects_pr.sub,cutoff_subjs),:)=[];
all_subjects_nt(ismember(all_subjects_nt.sub,cutoff_subjs),:)=[];
all_subjects_tr(ismember(all_subjects_tr.sub,cutoff_subjs),:)=[];

% subject_order([subject_order{:,1}]==find(subject_info.total_reward<rew_cutoff),:)=[];
subject_order(ismember([subject_order{:,1}],cutoff_subjs),:)=[];
% subject_info(subject_info.subject==find(subject_info.total_reward<rew_cutoff),:)=[];
subject_info(ismember(subject_info.subject,cutoff_subjs),:)=[];
disp('done processing')

writetable(all_subjects_pr, 'processed/all_subjects_pr.csv')
writetable(all_subjects_nt, 'processed/all_subjects_nt.csv')
writetable(all_subjects_tr, 'processed/all_subjects_tr.csv')
writetable(subject_info,'processed/subject_info.csv')
writecell(removed_sub_list','processed/removed_sub_list.csv')
% writecell(subject_order,'processed/subject_order.csv') %order exclude
save('subject_order.mat','subject_order')
save('subject_info.mat','subject_info')
disp('done saving')

