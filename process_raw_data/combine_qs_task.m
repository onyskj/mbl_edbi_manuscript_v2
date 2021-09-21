clear all
clc
addpath('processed/');

all_subjects_nt = readtable('processed/all_subjects_nt.csv');
all_subjects_tr = readtable('processed/all_subjects_tr.csv');
all_subjects_pr = readtable('processed/all_subjects_pr.csv');

all_subjects_nt.group=repmat({'g'},size(all_subjects_nt,1),1);
all_subjects_tr.group=repmat({'g'},size(all_subjects_tr,1),1);
all_subjects_pr.group=repmat({'g'},size(all_subjects_pr,1),1);

all_subjects_nt.age=repmat(0,size(all_subjects_nt,1),1);
all_subjects_tr.age=repmat(0,size(all_subjects_tr,1),1);
all_subjects_pr.age=repmat(0,size(all_subjects_pr,1),1);

qs_scores = readtable('processed/qs_scores.csv');
subject_info = readtable('processed/subject_info.csv');
subject_info.group=repmat({'g'},size(subject_info,1),1);

for s=1:length(qs_scores.sub)
    ss = qs_scores.sub(s);
    all_subjects_nt(find(all_subjects_nt.sub==ss),:).group=repmat(qs_scores.group(s),size(find(all_subjects_nt.sub==ss)));
    all_subjects_tr(find(all_subjects_tr.sub==ss),:).group=repmat(qs_scores.group(s),size(find(all_subjects_tr.sub==ss)));
    all_subjects_pr(find(all_subjects_pr.sub==ss),:).group=repmat(qs_scores.group(s),size(find(all_subjects_pr.sub==ss)));
    
    all_subjects_nt(find(all_subjects_nt.sub==ss),:).age=repmat(qs_scores.age2(s),size(find(all_subjects_nt.sub==ss)));
    all_subjects_tr(find(all_subjects_tr.sub==ss),:).age=repmat(qs_scores.age2(s),size(find(all_subjects_tr.sub==ss)));
    all_subjects_pr(find(all_subjects_pr.sub==ss),:).age=repmat(qs_scores.age2(s),size(find(all_subjects_pr.sub==ss)));
    
    subject_info(find(subject_info.subject==ss),:).group=repmat(qs_scores.group(s),size(find(subject_info.subject==ss)));
end

all_subjects_nt = [all_subjects_nt(:,1), all_subjects_nt(:,13:14), all_subjects_nt(:,2:12)];
all_subjects_tr = [all_subjects_tr(:,1), all_subjects_tr(:,13:14), all_subjects_tr(:,2:12)];
all_subjects_pr = [all_subjects_pr(:,1), all_subjects_pr(:,13:14), all_subjects_pr(:,2:12)];


qs_scores.cond_order=repmat({'o'},size(qs_scores,1),1);
for s=1:length(qs_scores.sub)
    ss = qs_scores.sub(s);
    qs_scores.cond_order(s)=all_subjects_nt(find(all_subjects_nt.sub==ss),:).cond_order(1);
end

subject_info.cond_order=repmat({'o'},size(subject_info,1),1);
for s=1:length(subject_info.subject)
    ss = subject_info.subject(s);
    subject_info.cond_order(s)=all_subjects_nt(find(all_subjects_nt.sub==ss),:).cond_order(1);
end

subject_info = [subject_info(:,1), subject_info(:,16:17), subject_info(:,2:15)];
qs_scores = [qs_scores(:,1:2), qs_scores(:,11), qs_scores(:,3:10)];

data_all = [all_subjects_nt;all_subjects_tr];

writetable(data_all, 'processed/all_subjects.csv')

% data_all = sortrows(data_all,{'sub','condition','trialNo'},{'ascend','descend','ascend'});
% data_all_sorted = sortrows(data_all,{'sub','condition','trialNo'},{'ascend','descend','ascend'});

