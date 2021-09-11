clear all
clc
% addpath('/Volumes/DATA/qs')
addpath('/Volumes/DATA/study_for_manu_v2/analyse/qs')
addpath('/Volumes/DATA/study_for_manu_v2/analyse/age')
% addpath('qs/')
addpath('processed/');
load('subject_order.mat')
ids = subject_order(:,2);
s = subject_order(:,1);
all_csv =dir('/Volumes/DATA/study_for_manu_v2/analyse/qs/*.csv');
age_csv = dir('/Volumes/DATA/study_for_manu_v2/analyse/age/*.csv');

csv_name = all_csv(1).name;
data = readtable(csv_name);
age_csv = readtable(age_csv(1).name);
%
gender_code = {11 'male';12 'female'; 14 'gender-fluid'; 15 'other'};
age_code = {11 '<18';12 '18-24';13 '25-34';14 '35-44';15 '45-54';16 '55-64';17 '65-74';18 '75-84';19 '85+'};

% [~,id_relev] = ismember({'EAT-26','AAI','OCI-R','PROLIFIC_PID','GROUP','SESSION_ID'}, table2cell(data(1,:))); %old matlab 2019a
[~,id_relev] = ismember({'SC0','SC1','SC2','PROLIFIC_PID','GROUP','SESSION_ID'}, data.Properties.VariableNames); %new matlabt 2020a
[~,id_extra_info] = ismember({'Q20','Q39','Q15_4','Q15_5'}, data.Properties.VariableNames);
data=data(:,[id_relev,id_extra_info]);
%
data.Properties.VariableNames={'EAT_26','AAI', 'OCI_R','participant','group','session','gender','age','weight','height'};
% data(1:2,:)=[];
% comma_idx_w=find(contains(data.weight,','));
% comma_idx_h=find(contains(data.height,','));
% for i=comma_idx_w
%     data.weight(i)=strrep(data.weight(i),',','.');
% end
% for i=comma_idx_h
%     data.height(i)=strrep(data.height(i),',','.');
% end
%
% data(:,[1:3,6:end])=array2table(str2double(table2array(data(:,[1:3,6:end]))),'VariableNames',{'EAT_26','AAI', 'OCI_R','gender','age','weight','height'});
% data = [data(:,[4:6]),array2table(str2double(table2array(data(:,[1:3,7:end]))),'VariableNames',{'EAT_26','AAI', 'OCI_R','gender','age','weight','height'})];
data = [data(:,[4:6]),array2table(table2array(data(:,[1:3,7:end])),'VariableNames',{'EAT_26','AAI', 'OCI_R','gender','age','weight','height'})];
data.height(find(data.height<2))=data.height(find(data.height<2))*100;
data.height(find(data.height<100))=repmat(nan,size(data.height(find(data.height<100))));

[~,idx_age2]=ismember(ids,age_csv.participant_id);

%
[~,idx_order] = ismember(ids, data.participant);
idx_order(idx_order==0)=[];
data=data(idx_order,:);
data.age2 = age_csv(idx_age2,2).age;

% data = [table((1:size(data,1))','VariableNames',{'sub'}),data];
data = [table([s{:}]','VariableNames',{'sub'}),data];

data=data(:,[1,3, 5:end]);

data_char = table({''},{''},'VariableNames',{'gender','age'});
%
for i=1:height(data)
    which_id=find([age_code{:,1}]==data.age(i));
    data_char.age{i}=age_code{which_id,2};
    which_id=find([gender_code{:,1}]==data.gender(i));
    data_char.gender{i}=gender_code{which_id,2};
end

data=[data(:,[1:5 8:10]),data_char];

%
writetable(data, 'processed/qs_scores.csv')
delete subject_order.mat
disp('done')
