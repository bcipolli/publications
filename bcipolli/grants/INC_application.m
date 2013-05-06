inc_dir = fileparts(which(mfilename));


% Figure 1-2
addpath(fullfile(inc_dir ,'..','_predict'));
clear('gmps'); close all;
predict_human;
keyboard

%
addpath(fullfile(inc_dir ,'..','lamantia_rakic_1990s'));
lrs_data;


% plots over all data
xl = [min(lrs_age)*.9 max(lrs_age)*1.1];

figure; set(gcf, 'Position', [ 69         258        1212         405]);
subplot(1,3,3); set(gca, 'FontSize', 14);
semilogx(lrs_age, lrs_dens/100, 'o', 'MarkerSize', 4, 'LineWidth',4); hold on;
semilogx(156*[1 1], get(gca, 'ylim'), 'r--', 'LineWidth', 2); hold on; 
semilogx(500*[1 1], get(gca, 'ylim'), 'y--', 'LineWidth', 2); hold on; 
set(gca, 'xlim', xl, 'xtick', 10.^[2:5]); axis square;
xlabel('Age (days since conception)');
ylabel('axons/mm^2');
title('Axon density', 'FontSize', 18); 

subplot(1,3,2); set(gca, 'FontSize', 14);
semilogx(lrs_age, lrs_pctmy, 'o', 'MarkerSize', 4, 'LineWidth',4); hold on;
set(gca, 'ylim', [0 100]);
semilogx(156*[1 1], get(gca, 'ylim'), 'r--', 'LineWidth', 2); hold on; 
semilogx(500*[1 1], get(gca, 'ylim'), 'y--', 'LineWidth', 2); hold on; 
set(gca, 'xlim', xl, 'xtick', 10.^[2:5]); axis square;
set(gca, 'yticklabel', guru_csprintf('%d%%',round(str2num(get(gca,'yticklabel'))))); 
xlabel('Age (days since conception)');
ylabel('%');
title('% myelination', 'FontSize', 18);

subplot(1,3,1); set(gca, 'FontSize', 14);
semilogx(lrs_age, lrs_nic/10^6, 'o', 'MarkerSize', 4, 'LineWidth',4); hold on;
semilogx(156*[1 1], get(gca, 'ylim'), 'r--', 'LineWidth', 2);  hold on; 
semilogx(500*[1 1], get(gca, 'ylim'), 'y--', 'LineWidth', 2); hold on; 
set(gca, 'xlim', xl, 'xtick', 10.^[2:5]); axis square;
xlabel('Age (days since conception)');
ylabel('million axons')
title('# axons', 'FontSize', 18);

export_fig('~/Desktop/macaque_development.png', gcf, '-transparent')

% Figure 3
addpath(fullfile(inc_dir ,'..','berbel_innocenti_1988'));
%clear all; close all;
bi_predict_pctmye;
bi_predict_date;

%