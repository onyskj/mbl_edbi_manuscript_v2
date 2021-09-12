%% Initialise (with rho for statistial test)
clear all; close all; clc
addpath('fitted_data/','simulated_data/','export/','data/','processed/','tables/','figures');

results_nt_ed = readtable("fitted_data/fitted_ind_params_df_2021_09_09_02_06_39_ED_NT_niter_4000_foerde_alter_JO_wrong_ship.csv");
results_tr_ed = readtable("fitted_data/fitted_ind_params_df_2021_09_09_03_35_02_ED_BID_niter_4000_foerde_alter_JO_wrong_ship.csv");
results_nt_hc = readtable("fitted_data/fitted_ind_params_df_2021_09_09_05_00_16_HC_NT_niter_4000_foerde_alter_JO_wrong_ship.csv");
results_tr_hc = readtable("fitted_data/fitted_ind_params_df_2021_09_09_06_38_21_HC_BID_niter_4000_foerde_alter_JO_wrong_ship.csv");

data_all_scores = readtable("fitted_data/data_all_scores.csv");
data_all_scores_simulated = readtable("simulated_data/data_all_scores_simulated.csv");

delta_w_ed = array2table(results_tr_ed{:,6} - results_nt_ed{:,6},'VariableNames',{'delta_w'}); 
delta_w_hc = array2table(results_tr_hc{:,6} - results_nt_hc{:,6},'VariableNames',{'delta_w'}); 

qs_scores = readtable("data/qs_scores.csv");
qs_scores.bmi=qs_scores.weight./(qs_scores.height/100).^2;
qs_scores.age_z=qs_scores.age2;
% qs_scores(contains(qs_scores.group,'HC'),:).age_z=(qs_scores(contains(qs_scores.group,'HC'),:).age2-nanmean(qs_scores(contains(qs_scores.group,'HC'),:).age2))/nanstd(qs_scores(contains(qs_scores.group,'HC'),:).age2);
% qs_scores(contains(qs_scores.group,'ED'),:).age_z=(qs_scores(contains(qs_scores.group,'ED'),:).age2-nanmean(qs_scores(contains(qs_scores.group,'ED'),:).age2))/nanstd(qs_scores(contains(qs_scores.group,'ED'),:).age2);
qs_scores.age_z=(qs_scores.age2-nanmean(qs_scores.age2))/nanstd(qs_scores.age2);

qs_scores.EAT_26_z=qs_scores.EAT_26;
% qs_scores(contains(qs_scores.group,'HC'),:).EAT_26_z=(qs_scores(contains(qs_scores.group,'HC'),:).EAT_26-nanmean(qs_scores(contains(qs_scores.group,'HC'),:).EAT_26))/nanstd(qs_scores(contains(qs_scores.group,'HC'),:).EAT_26);
% qs_scores(contains(qs_scores.group,'ED'),:).EAT_26_z=(qs_scores(contains(qs_scores.group,'ED'),:).EAT_26-nanmean(qs_scores(contains(qs_scores.group,'ED'),:).EAT_26))/nanstd(qs_scores(contains(qs_scores.group,'ED'),:).EAT_26);
qs_scores.EAT_26_z=(qs_scores.EAT_26-nanmean(qs_scores.EAT_26))/nanstd(qs_scores.EAT_26);

qs_scores.AAI_z=qs_scores.AAI;
% qs_scores(contains(qs_scores.group,'HC'),:).AAI_z=(qs_scores(contains(qs_scores.group,'HC'),:).AAI-nanmean(qs_scores(contains(qs_scores.group,'HC'),:).AAI))/nanstd(qs_scores(contains(qs_scores.group,'HC'),:).AAI);
% qs_scores(contains(qs_scores.group,'ED'),:).AAI_z=(qs_scores(contains(qs_scores.group,'ED'),:).AAI-nanmean(qs_scores(contains(qs_scores.group,'ED'),:).AAI))/nanstd(qs_scores(contains(qs_scores.group,'ED'),:).AAI);
qs_scores.AAI_z=(qs_scores.AAI-nanmean(qs_scores.AAI))/nanstd(qs_scores.AAI);

qs_scores.OCI_R_z=qs_scores.OCI_R;
% qs_scores(contains(qs_scores.group,'HC'),:).OCI_R_z=(qs_scores(contains(qs_scores.group,'HC'),:).OCI_R-nanmean(qs_scores(contains(qs_scores.group,'HC'),:).OCI_R))/nanstd(qs_scores(contains(qs_scores.group,'HC'),:).OCI_R);
% qs_scores(contains(qs_scores.group,'ED'),:).OCI_R_z=(qs_scores(contains(qs_scores.group,'ED'),:).OCI_R-nanmean(qs_scores(contains(qs_scores.group,'ED'),:).OCI_R))/nanstd(qs_scores(contains(qs_scores.group,'ED'),:).OCI_R);
qs_scores.OCI_R_z=(qs_scores.OCI_R-nanmean(qs_scores.OCI_R))/nanstd(qs_scores.OCI_R);

qs_scores.bmi_z=qs_scores.bmi;
qs_scores.bmi_z=(qs_scores.bmi-nanmean(qs_scores.bmi))/nanstd(qs_scores.bmi);

subject_info = [qs_scores(:,2),readtable("data/subject_info.csv")];
results_all = {results_nt_ed,results_tr_ed,results_nt_hc,results_tr_hc};
subject_info_groups={subject_info(contains(subject_info.group,'HC'),:),subject_info(contains(subject_info.group,'ED'),:)};
qs_scores_groups={qs_scores(contains(qs_scores.group,'HC'),:),qs_scores(contains(qs_scores.group,'ED'),:)};

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
    subject_info_summary_task{i}=array2table(subject_info_summary_task{i},'VariableNames',{'mean','std','SE'},'RowNames',{'total_reward_nt','total_reward_tr','total_reward',...
    'avg_rt1','avg_rt2','avg_rt','avg_rt1_nt','avg_rt2_nt','avg_rt_nt','avg_rt1_tr','avg_rt2_tr','avg_rt_tr'});
end

subject_info_summary_qs = cell(1,2); %%(EAT-26, AAI, OCI-R, height, weight,bmi, age)x(mean, std, SE)
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
    subject_info_summary_qs{i}=array2table(subject_info_summary_qs{i},'VariableNames',{'mean','std','SE'},'RowNames',{'EAT-26', 'AAI', 'OCI-R', 'height', 'weight', 'bmi','age'});
end

%% Demographic and questionnaire Welch's test (HC vs ED)
dem_qs_stat_tests = zeros(size(dem_qs_data,2),3); %(eat, aai, oci-r, weight, height, bmi, age2)x(p-value, t-value, sd)
for i=1:size(dem_qs_stat_tests,1)
    [h,p,~,stats] = ttest2(dem_qs_data{1,i},dem_qs_data{2,i});
    dem_qs_stat_tests(i,:)= [p,stats.tstat,stats.sd];
end
dem_qs_stat_tests = array2table(dem_qs_stat_tests,'VariableNames',{'p-value','t-value','sd'},'RowNames',{'EAT-26', 'AAI', 'OCI-R', 'height', 'weight', 'bmi','age'});

%% Task performance Welch's test (HC vs ED)
task_stat_tests = zeros(size(task_data,2),3); %(rew_nt,rew_tr,total_rew, avg_rt1, avg_rt2,avg_rt,avg_rt1_nt, avg_rt2_nt,avg_rt_nt,avg_rt1_tr, avg_rt2_tr,avg_rt_tr)x(p-value, t-value, sd)
for i=1:size(task_stat_tests,1)
    [h,p,~,stats] = ttest2(task_data{1,i},task_data{2,i});
    task_stat_tests(i,:)=[p,stats.tstat,stats.sd]; 
end
task_stat_tests = array2table(task_stat_tests,'VariableNames',{'p-value','t-value','sd'},'RowNames',{'total_reward_nt','total_reward_tr','total_reward',...
    'avg_rt1','avg_rt2','avg_rt','avg_rt1_nt','avg_rt2_nt','avg_rt_nt','avg_rt1_tr','avg_rt2_tr','avg_rt_tr'});

%% Save to csv
%demo+qs: stats and info
writetable(dem_qs_stat_tests,'tables/dem_qs_stat_tests.csv','WriteRowNames',true)
writetable(subject_info_summary_qs{1},'tables/subject_info_summary_qs_hc.csv','WriteRowNames',true)
writetable(subject_info_summary_qs{2},'tables/subject_info_summary_qs_ed.csv','WriteRowNames',true)

%task perm: stats and info
writetable(task_stat_tests,'tables/task_stat_tests.csv','WriteRowNames',true)
writetable(subject_info_summary_task{1},'tables/subject_info_summary_task_hc.csv','WriteRowNames',true)
writetable(subject_info_summary_task{2},'tables/subject_info_summary_task_ed.csv','WriteRowNames',true)

%% Plots params
close all
% MB
axisFontSize=30;
subplot(1,3,1)
y=[results_info{3}(1,1), results_info{1}(1,1);results_info{4}(1,1),results_info{2}(1,1)];
errors = [results_info{3}(1,3), results_info{1}(1,3);results_info{4}(1,3),results_info{2}(1,3)];

bar(y,'grouped')
hold on
ylabel('\beta_{MB}')
title('MB learning: \beta_{MB}')
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
ylim([0 max(y,[],'all')+max(errors,[],'all')*4/3])
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
title('MF learning: \beta_{MF}')
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
ylim([0 max(y,[],'all')+max(errors,[],'all')*4/3])
axis square
set(gca,'fontsize',axisFontSize,'Box','off','TickDir','out','TickLength'...
        ,[.0175 .0175],'XMinorTick'  , 'off','YMinorTick','on','YGrid','off',...
        'XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',2,'FontName','Helvetica','XDir', 'default');

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
ylim([0 max(y,[],'all')+max(errors,[],'all')*4/3])
axis square
set(gca,'fontsize',axisFontSize,'Box','off','TickDir','out','TickLength'...
        ,[.0175 .0175],'XMinorTick'  , 'off','YMinorTick','on','YGrid','off',...
        'XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',2,'FontName','Helvetica','XDir', 'default');
    
sgtitle('Average parameter values in HC and ED at the neutral and BID condition','fontsize',40)

set(gcf,'units','normalized','outerposition',[0 0 1 1])
fname = 'figures/params_ED_HC_NT_TR';
% export_fig(fname,'-pdf', '-m1', '-transparent')

%% All together corrleations with delta w
clc
close all
scores=[qs_scores_groups{1};qs_scores_groups{2}];
dfs = [delta_w_hc;delta_w_ed];
param_names_corr= {'beta_1_MB','beta_1_MF','w'};
group_cond_list = {'ED_NT','ED_BID','HC_NT','HC_BID'};

mSize=100;
axisFontSize=30;
lineWidthSize=5;
lineColour = [0.8500, 0.3250, 0.0980];

scores_for_corr = {scores.EAT_26,scores.AAI,scores.OCI_R,scores.bmi,scores.age_z};
scores_for_corr = {scores.EAT_26_z,scores.AAI_z,scores.OCI_R_z,scores.bmi_z,scores.age_z};
names = {'EAT-26 score','AAI score', 'OCI-R score','BMI','Age'};

for i=1:length(scores_for_corr)
    ax=subplot(2,3,i);    
    [lb_eps, ub_eps] = bounds(dfs.delta_w);
    [r,p]=corrcoef([dfs.delta_w,scores_for_corr{i}],'rows','complete');
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
    legend('location','best');
    ylabel(names{i});
    xlabel('\Deltaw');
    ylim([lower_y_lim(scores_for_corr{i}),max(scores_for_corr{i})*1.5+1])
    axis square
%     axis tight
    set(gca,'fontsize',axisFontSize,'Box','off','TickDir','out','TickLength'...
        ,[.0175 .0175],'XMinorTick'  , 'on','YMinorTick','on','YGrid','off',...
        'XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',2,'FontName','Helvetica','XDir', 'default');
end
sgtitle('Correlations of demographic and questionnaire information with \Deltaw','fontsize',38)
set(gcf,'units','normalized','outerposition',[0 0 1 1])
fname_df = 'figures/corr_info_delta_w';
% export_fig(fname_df,'-pdf', '-m1', '-transparent')

%% Plot stay probabilities - collected data
data_all_scores.group =  categorical(data_all_scores.group);
data_all_scores.condition =  categorical(data_all_scores.condition);
data_all_scores.cond_order =  categorical(data_all_scores.cond_order);

data_all_scores_nt_ed = data_all_scores(data_all_scores.group=='ED' & data_all_scores.condition=='NT',:);
data_all_scores_tr_ed = data_all_scores(data_all_scores.group=='ED' & data_all_scores.condition=='BID',:);
data_all_scores_nt_hc = data_all_scores(data_all_scores.group=='HC' & data_all_scores.condition=='NT',:);
data_all_scores_tr_hc = data_all_scores(data_all_scores.group=='HC' & data_all_scores.condition=='BID',:);

data_all_scores_all = {data_all_scores_nt_ed,data_all_scores_tr_ed,data_all_scores_nt_hc,data_all_scores_tr_hc};

data_all_scores_summary = cell(4,4); %gr_cond x prob (mean, std, std/sqrtN)
prob_names = data_all_scores_all{1}(:,9:12).Properties.VariableNames;
for i=1:size(data_all_scores_summary,1)
    for j=1:length(prob_names)
        data_all_scores_summary{i,j} = [nanmean(data_all_scores_all{i}{:,8+j}),...
            nanstd(data_all_scores_all{i}{:,8+j}),...
            nanstd(data_all_scores_all{i}{:,8+j})/sqrt(length(data_all_scores_all{i}{:,8+j}))];
    end
end

close all
axisFontSize=30;
condnames = {'Neutral condition','BID condition'};
colors_cond = {[0.4660 0.6740 0.1880], [0.5940, 0.2840, 0.6560];...
    '#e7f4d7', '#ecdbf0'};
for k=1:2
    subplot(1,2,k)
    
    y_all=[data_all_scores_summary{k+2,1}(1) data_all_scores_summary{k+2,3}(1) data_all_scores_summary{k+2,2}(1) data_all_scores_summary{k+2,4}(1);
        data_all_scores_summary{k,1}(1) data_all_scores_summary{k,3}(1) data_all_scores_summary{k,2}(1) data_all_scores_summary{k,4}(1)];
   
    errors_all = [data_all_scores_summary{k+2,1}(3) data_all_scores_summary{k+2,3}(3) data_all_scores_summary{k+2,2}(3) data_all_scores_summary{k+2,4}(3);
        data_all_scores_summary{k,1}(3) data_all_scores_summary{k,3}(3) data_all_scores_summary{k,2}(3) data_all_scores_summary{k,4}(3)];
    
    for j=1:2
        y=y_all(j,:);
        errors=errors_all(j,:);
        barplot(j)=bar((1:4)*2+(j-1)/3,y,0.65,'grouped','FaceColor',colors_cond{j,k});
%         barplot(j).FaceAlpha=0.3+0.7*(j-1);
        hold on
        nbars = size(y,2);
        for i = 1:nbars
            hold on;
            errbar(j,i)=errorbar(barplot(j).XData, y, errors, 'k', 'linestyle', 'none','linewidth',4,'HandleVisibility','Off');
        end 
        xticklabels({'common','rare','common','rare'});
        ylim([0.6, 1])
        ylabel('stay probability')
        axis square
        set(gca,'fontsize',axisFontSize,'Box','off','TickDir','out','TickLength'...
            ,[.0175 .0175],'XMinorTick'  , 'off','YMinorTick','on','YGrid','off',...
            'XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',2,'FontName','Helvetica','XDir', 'default');
    
        
    end
    legend({'HC','ED'},'FontSize',axisFontSize+10)
    yticks(0.5:0.1:1)
    uistack(barplot(2),'top')
    uistack(errbar(1,:),'top')
    uistack(errbar(2,:),'top')
    title(condnames{k})
end
rew_1_x = 275;
rew_2_x=910;
rwidth=110;
unwidth=135;
rew_unre_dist=170;
uicontrol('style','text','string','rewarded','position',[rew_1_x,90,rwidth,30],'fontSize',axisFontSize-7.5,'FontWeight','bold');
uicontrol('style','text','string','unrewarded','position',[rew_1_x+rew_unre_dist,90,unwidth,30],'fontSize',axisFontSize-7.5,'FontWeight','bold');
uicontrol('style','text','string','rewarded','position',[rew_2_x,90,rwidth,30],'fontSize',axisFontSize-7.5,'FontWeight','bold');
uicontrol('style','text','string','unrewarded','position',[rew_2_x+rew_unre_dist,90,unwidth,30],'fontSize',axisFontSize-7.5,'FontWeight','bold');
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
sgtitle('Stay probabilities for Neutral and BID condition in collected data','fontsize',38)
fname_df = 'figures/stay_prob_plots';
% export_fig(fname_df,'-pdf', '-m1', '-transparent')

%% Plot stay probabilities - simulated data
data_all_scores_simulated.group =  categorical(data_all_scores_simulated.group);
data_all_scores_simulated.condition =  categorical(data_all_scores_simulated.condition);
data_all_scores_simulated.cond_order =  categorical(data_all_scores_simulated.cond_order);

data_all_scores_simulated_nt_ed = data_all_scores_simulated(data_all_scores_simulated.group=='ED' & data_all_scores_simulated.condition=='NT',:);
data_all_scores_simulated_tr_ed = data_all_scores_simulated(data_all_scores_simulated.group=='ED' & data_all_scores_simulated.condition=='BID',:);
data_all_scores_simulated_nt_hc = data_all_scores_simulated(data_all_scores_simulated.group=='HC' & data_all_scores_simulated.condition=='NT',:);
data_all_scores_simulated_tr_hc = data_all_scores_simulated(data_all_scores_simulated.group=='HC' & data_all_scores_simulated.condition=='BID',:);

data_all_scores_simulated_all = {data_all_scores_simulated_nt_ed,data_all_scores_simulated_tr_ed,data_all_scores_simulated_nt_hc,data_all_scores_simulated_tr_hc};

data_all_scores_simulated_summary = cell(4,4); %gr_cond x prob (mean, std, std/sqrtN)
prob_names = data_all_scores_simulated_all{1}(:,9:12).Properties.VariableNames;
for i=1:size(data_all_scores_simulated_summary,1)
    for j=1:length(prob_names)
        data_all_scores_simulated_summary{i,j} = [nanmean(data_all_scores_simulated_all{i}{:,8+j}),...
            nanstd(data_all_scores_simulated_all{i}{:,8+j}),...
            nanstd(data_all_scores_simulated_all{i}{:,8+j})/sqrt(length(data_all_scores_simulated_all{i}{:,8+j}))];
    end
end

close all
axisFontSize=30;
condnames = {'Neutral condition','BID condition'};
colors_cond = {[0.4660 0.6740 0.1880], [0.5940, 0.2840, 0.6560];...
    '#e7f4d7', '#ecdbf0'};
for k=1:2
    subplot(1,2,k)
    
    y_all=[data_all_scores_simulated_summary{k+2,1}(1) data_all_scores_simulated_summary{k+2,3}(1) data_all_scores_simulated_summary{k+2,2}(1) data_all_scores_simulated_summary{k+2,4}(1);
        data_all_scores_simulated_summary{k,1}(1) data_all_scores_simulated_summary{k,3}(1) data_all_scores_simulated_summary{k,2}(1) data_all_scores_simulated_summary{k,4}(1)];
   
    errors_all = [data_all_scores_simulated_summary{k+2,1}(3) data_all_scores_simulated_summary{k+2,3}(3) data_all_scores_simulated_summary{k+2,2}(3) data_all_scores_simulated_summary{k+2,4}(3);
        data_all_scores_simulated_summary{k,1}(3) data_all_scores_simulated_summary{k,3}(3) data_all_scores_simulated_summary{k,2}(3) data_all_scores_simulated_summary{k,4}(3)];
    
    for j=1:2
        y=y_all(j,:);
        errors=errors_all(j,:);
        barplot(j)=bar((1:4)*2+(j-1)/3,y,0.65,'grouped','FaceColor',colors_cond{j,k});
%         barplot(j).FaceAlpha=0.3+0.7*(j-1);
        hold on
        nbars = size(y,2); 
        for i = 1:nbars
            hold on;
            errbar(j,i)=errorbar(barplot(j).XData, y, errors, 'k', 'linestyle', 'none','linewidth',4,'HandleVisibility','Off');
        end 
        xticklabels({'common','rare','common','rare'});
        ylim([0.6, 1])
        ylabel('stay probability')
        axis square
        set(gca,'fontsize',axisFontSize,'Box','off','TickDir','out','TickLength'...
            ,[.0175 .0175],'XMinorTick'  , 'off','YMinorTick','on','YGrid','off',...
            'XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',2,'FontName','Helvetica','XDir', 'default');
    
        
    end
    legend({'HC','ED'},'FontSize',axisFontSize+10)
    yticks(0.5:0.1:1)
    uistack(barplot(2),'top')
    uistack(errbar(1,:),'top')
    uistack(errbar(2,:),'top')
    title(condnames{k})
end
rew_1_x = 275;
rew_2_x=910;
rwidth=110;
unwidth=135;
rew_unre_dist=170;
a=uicontrol('style','text','string','rewarded','position',[rew_1_x,90,rwidth,30],'fontSize',axisFontSize-7.5,'FontWeight','bold');
uicontrol('style','text','string','unrewarded','position',[rew_1_x+rew_unre_dist,90,unwidth,30],'fontSize',axisFontSize-7.5,'FontWeight','bold');
uicontrol('style','text','string','rewarded','position',[rew_2_x,90,rwidth,30],'fontSize',axisFontSize-7.5,'FontWeight','bold');
uicontrol('style','text','string','unrewarded','position',[rew_2_x+rew_unre_dist,90,unwidth,30],'fontSize',axisFontSize-7.5,'FontWeight','bold');
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
sgtitle('Stay probabilities for Neutral and BID condition in simulated data','fontsize',38)
fname_df = 'figures/stay_prob_plots_simulated';
% export_fig(fname_df,'-pdf', '-m1', '-transparent')