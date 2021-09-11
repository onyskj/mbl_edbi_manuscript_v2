% Visualise parameter recovery using EM-fitted parameters in Julia
clear all; close all; clc;
thetas_opt = load('params_recovered_study.csv');
thetas = load('params_original_study.csv');
NT = load('n_trials_study.csv');

NS = size(thetas,1);
param_names = {'beta_mb','beta_mf','beta_2','alpha','rho'};

disp(['Correlation ',param_names(1), ' original and recovered:'])
% R_all_nor=corrcoef(thetas_nor(:,1:2));
cc_beta_mb = corrcoef([thetas(:,1),thetas_opt(:,1)]);
cc_beta_mb(1,2)

disp(['Correlation ',param_names(2), ' original and recovered:'])
% R_all_nor=corrcoef(thetas_nor(:,1:2));
cc_beta_mf = corrcoef([thetas(:,2),thetas_opt(:,2)]);
cc_beta_mf(1,2)

disp(['Correlation ',param_names(3), ' original and recovered:'])
% R_all_nor=corrcoef(thetas_nor(:,1:2));
cc_beta_2 = corrcoef([thetas(:,3),thetas_opt(:,3)]);
cc_beta_2(1,2)

disp(['Correlation ',param_names(4), ' original and recovered:'])
% R_all_nor=corrcoef(thetas_nor(:,1:2));
cc_alpha = corrcoef([thetas(:,4),thetas_opt(:,4)]);
cc_alpha(1,2)

disp(['Correlation ',param_names(5), ' original and recovered:'])
% R_all_nor=corrcoef(thetas_nor(:,1:2));
cc_rho = corrcoef([thetas(:,5),thetas_opt(:,5)]);
cc_rho(1,2)

ccs = [cc_beta_mb(1,2),cc_beta_mf(1,2), cc_beta_2(1,2),cc_alpha(1,2), cc_rho(1,2)];

mSize=30;
axisFontSize=30;
param_names = {'\beta_{MB}','\beta_{MF}','\beta_2','\alpha','\rho'};
for i=1:5
subplot(2,3,i)
    plot(thetas(:,i),thetas_opt(:,i),'.','markersize',mSize,'HandleVisibility','off');
    hold on;
    [lb_eps, ub_eps] = bounds(thetas(:,i));
    plot(lb_eps:0.001:ub_eps,(lb_eps:0.001:ub_eps)*ccs(i), 'linewidth',5,'DisplayName',['PCC = ',num2str(ccs(i))]);
    legend('location','best')
    xlabel(['simulated' param_names(i)])
    ylabel(['recovered', param_names(i)])
    axis square
    title([param_names(i) ])
    set(gca,'fontsize',axisFontSize,'Box','off','TickDir','out','TickLength'...
        ,[.0175 .0175],'XMinorTick'  , 'on','YMinorTick','on','YGrid','off',...
        'XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',2,'FontName','Helvetica','XDir', 'default');
end
sgtitle(['Sample of simulated vs recovered parameters for ',num2str(NS), ' subjects on ',num2str(NT), ' trials.'],...
    'fontsize',axisFontSize,'FontName','Helvetica','Color',[.3 .3 .3],'FontWeight','bold')
set(gcf,'units','normalized','outerposition',[0 0 1 1])
fname = ['figs/recovery_study_nsub_',num2str(NS),'_ntrial',num2str(NT)];
% export_fig(fname,'-pdf', '-m1', '-transparent') 


