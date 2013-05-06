if ~exist('naconperarea','var')
    addpath('rilling_insel_1999b');
    rib_response; close all;
end;

%% Figure 1: Rilling & Insel data

% Re-create the plot!
p_cca = polyfit(log10(rib_fig2_gmas), log10(rib_fig2_ccas), 1);
g_cca = @(gma) 10.^polyval(p_cca, log10(gma));
xvals = linspace(min(rib_fig2_gmas), max(rib_fig2_gmas), 100);

figure; set(gcf, 'Position', [49         119        1194         565]);

subplot(1,2,1); set(gca, 'FontSize', 16); % raw
plot(rib_fig2_gmas, rib_fig2_ccas, 'ro', 'LineWidth', 5, 'MarkerSize', 15);
hold on; 
plot(xvals, g_cca(xvals), 'LineWidth', 10);
xlabel('grey matter surface area (mm^2)'); ylabel('corpus callosum area (mm^2)');
legend({' Original data', sprintf(' %4.2fX^{%4.2f}', p_cca(2), p_cca(1)), }, 'Location', 'NorthWest');
axis square;

subplot(1,2,2); set(gca, 'FontSize', 16); 
loglog(rib_fig2_gmas, rib_fig2_ccas, 'ro', 'LineWidth', 5, 'MarkerSize', 15);
hold on; 
loglog(xvals, g_cca(xvals), 'LineWidth', 10);
xlabel('log(grey matter surface area) (mm^2)'); ylabel('log(corpus callosum area) (mm^2)');
legend({' Estimated data', sprintf(' %4.2fX + %4.2f', p_cca)}, 'Location', 'NorthWest');
axis square; set(gca, 'xlim', [5 1000], 'ylim', [5 1000]);


%% Figure 2: Density and new rilling data
figure; set(gcf, 'Position', [49         119        1194         565]);


% Assign and plot results
p_cca = polyfit(log10(w_fig1e_brwt_est), log10(w_fig1e_dens_est), 1);
g_cca = @(gma) 10.^polyval(p_cca, log10(gma));
xvals = linspace(min(w_fig1e_brwt_est), 1500, 100);

subplot(1,2,1);  set(gca, 'FontSize', 16);
loglog(w_fig1e_brwt_est, 1E3*w_fig1e_dens_est, 'ro', 'LineWidth', 5, 'MarkerSize', 15);
hold on; 
loglog(xvals, 1E3*g_cca(xvals), 'LineWidth', 10);
loglog(1300, 1E3*0.33*1.2, 'g*', 'LineWidth', 5, 'MarkerSize', 15);
xlabel('brain weight (g)'); ylabel('CC fiber density (fibers/ \mum)');
legend({' Original data', sprintf(' %4.2fX + {%4.2f}', p_cca), ' Humans'}, 'Location', 'NorthEast');
axis square; set(gca, 'xlim', [-100 1300], 'ylim', 10.^[2.1 3.8]);

p_cca = polyfit(log10(nneurons), log10(ncc_fibers), 1);
g_cca = @(gma) 10.^polyval(p_cca, log10(gma));
xvals = linspace(min(nneurons), max(nneurons), 100);

subplot(1,2,2); set(gca, 'FontSize', 16); % raw
plot(nneurons, ncc_fibers, 'ro', 'LineWidth', 5, 'MarkerSize', 15);
hold on; 
plot(xvals, g_cca(xvals), 'LineWidth', 10);
xlabel('# neurons'); ylabel('# corpus callosum fibers');
legend({' Estimated data', sprintf(' %4.2fX^{%4.2f}', p_cca(2), p_cca(1)), }, 'Location', 'NorthWest');
axis square;

%subplot(1,2,2); set(gca, 'FontSize', 16); 
%loglog(nneurons, ncc_fibers, 'ro', 'LineWidth', 5, 'MarkerSize', 15);
%hold on; 
%loglog(xvals, g_cca(xvals), 'LineWidth', 10);
%xlabel('log(grey matter surface area) (mm^2)'); ylabel('log(corpus callosum area) (mm^2)');
%title(sprintf('Regressions: %4.2fX + %4.2f', p_cca));
%axis square; set(gca, 'xlim', 10.^[8.2 10.2], 'ylim', 10.^[7 9]);



%% Figure 3: Final data
xv = 1./(naconperarea-1);
yv =  1./(0.3*nneurons./ncc_fibers-1);
p_cca = allometric_regression(xv,yv, 'log', 1, false, false)
g_cca = @(gma) 10.^polyval(p_cca, log10(gma));
xvals = linspace(min(xv), max(xv), 100);


figure; set(gcf,'position',[360   221   645   457]);
set(gca, 'FontSize', 16);
loglog(xv, yv, 'ro', 'LineWidth', 5, 'MarkerSize', 15);
hold on; 
lin=loglog(xvals, g_cca(xvals), 'LineWidth', 10);
loglog(xv(end-5:end), yv(end-5:end)*1.2, 'g*', 'LineWidth', 5, 'MarkerSize', 15);
xlabel('# areas connected'); ylabel('#cc fibers/# neurons');
legend({' Estimated data', sprintf(' %4.2fX + {%4.2f}', p_cca),'humans'}, 'Location', 'NorthWest');
axis square; set(gca, 'xlim', 10.^[-1.9 -1.1], 'ylim', 10.^[-1.2 -0.4]);
