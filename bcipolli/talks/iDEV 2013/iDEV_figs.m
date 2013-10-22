function iDEV_figs(fig_list, saving)

cur_dir  = fileparts(which(mfilename));
GURU_dir = fullfile(cur_dir, '..','..','..','..');

if ~exist('fig_list','var'), fig_list={'all'}; end;
if ~exist('saving','var'),   saving  = false; end;
if ~iscell(fig_list), fig_list = {fig_list}; end;

for fi = 1:length(fig_list)
    
    % Ringo et al. as original
    if ismember('all', fig_list) || strcmp(fig_list{fi}, 'ringo_orig')
        addpath(genpath(fullfile(GURU_dir, 'ringo', 'scripts', 'ringo_etal_1994')));
        demo_ringo_fig;
        if saving, export_fig(gcf, './Ringo_orig.png', '-transparent'); end;
    end;
        
    % Ringo et al. as a diff
    if ismember('all', fig_list) || strcmp(fig_list{fi}, 'ringo_diff')
        addpath(genpath(fullfile(GURU_dir, 'ringo', 'scripts', 'ringo_etal_1994')));
        demo_ringo_fig_diff;
        if saving, export_fig(gcf, './Ringo_diff.png', '-transparent'); end;
    end;
        
    % Wang et al. regression
    if ismember('all', fig_list) || strcmp(fig_list{fi}, 'wang_regression')
        addpath(genpath(fullfile(cur_dir, '..', 'GURU_April8')));
        GURU_April8('w_dens');
        if saving, export_fig(gcf, './wang_regression.png', '-transparent'); end;
        GURU_April8('w_denshc');
        if saving, export_fig(gcf, './wang_regression_w_human.png', '-transparent'); end;
    end;
        
    % Rilling & Insel brain volume vs. inter- connections regression
    if ismember('all', fig_list) || strcmp(fig_list{fi}, 'ri_basic_compare')
        addpath(genpath(fullfile(GURU_dir, 'rilling', 'rilling_insel_1999s')));
        rib_response('individual', 'wm_cxns_vs_cc_cxns');
        if saving, export_fig(gcf, './ri_bv_vs_cc_cxns.png', '-transparent'); end;
        
        addpath(genpath(fullfile(GURU_dir, 'rilling', 'rilling_insel_1999b')));
        rib_data;
        [p,g] = allometric_regression(rib_fig2_gmas, rib_fig2_ccas, 'log', 1, true);
        allometric_plot2(rib_fig2_gmas, rib_fig2_ccas, p, g);
        if saving, export_fig(gcf, './rilling_orig.png', '-transparent'); end;
    end;
        
    % Rilling & Insel connectivity scaling comparison
    if ismember('all', fig_list) || strcmp(fig_list{fi}, 'ri_scaling_compare')
        addpath(genpath(fullfile(GURU_dir, 'rilling', 'rilling_insel_1999s')));
        for collation = {'species' 'family'}
            rib_response(collation{1}, 'prop_fibers_vs_prop_aa_cxns');
            if saving, export_fig(gcf, sprintf('./ri_prop_fibers_vs_prop_aa_cxns_%s.png',collation{1}), '-transparent'); end;
            
            rib_response(collation{1}, 'prop_fibers_vs_prop_aa_cxns_linear');
            if saving, export_fig(gcf, sprintf('./ri_prop_fibers_vs_prop_aa_cxns_linear_%s.png',collation{1}), '-transparent'); end;
        end;
    end;
    
    % Rilling & Insel connection strength comparison
    if ismember('all', fig_list) || strcmp(fig_list{fi}, 'ri_strength_compare')
        addpath(genpath(fullfile(GURU_dir, 'rilling', 'rilling_insel_1999s')));
        for collation = {'species' 'family'}
            rib_response(collation{1}, 'intra_vs_cc_scaling_linear');
            if saving, export_fig(gcf, sprintf('./ri_intra_vs_cc_scaling_linear_%s.png',collation{1}), '-transparent'); end;
        end;
    end; 
        
    % LaMantia & Rakic age vs. density regression
    if ismember('all', fig_list) || strcmp(fig_list{fi}, 'age_vs_density')
        addpath(genpath(fullfile(cur_dir, '..', 'GURU_April8')));
        GURU_April8('lma_dens');
        keyboard
    end;

    % Ringo repro w/ noise
    if ismember('all', fig_list) || strcmp(fig_list{fi}, 'ringo_repro')
        addpath(genpath(fullfile(GURU_dir, 'ringo', 'scripts', 'tdlc2013')));

        % Intrahemispheric patterns
        figs = tdlc2013_figures('~/_cache/ringo/tdlc2013/tdlc2013_cache.mat', 1.2, 'intra', 'clserr');
        figure(figs(1));
        if saving, export_fig(gcf, './ringo_repro_intra_n0.png', '-transparent'); close(figs(1)); end;
        figure(figs(2));
        if saving, export_fig(gcf, './ringo_repro_intra_n1.png', '-transparent'); close(figs(2)); end;
    end;        

    % Ringo repro w/ TRUE difference
    if ismember('all', fig_list) || strcmp(fig_list{fi}, 'ringo_true')
        addpath(genpath(fullfile(GURU_dir, 'ringo', 'scripts', 'tdlc2013')));

        % Intrahemispheric patterns
        figs = tdlc2013_figures('~/_cache/ringo/tdlc2013/tdlc2013_cache.mat', 1.2, 'inter', 'clserr');
        figure(figs(1));
        if saving, export_fig(gcf, './ringo_repro_inter_n0.png', '-transparent'); close(figs(1)); end;
        figure(figs(2));
        if saving, export_fig(gcf, './ringo_repro_inter_n1.png', '-transparent'); close(figs(2)); end;

        % Intrahemispheric patterns
        figs = tdlc2013_figures('~/_cache/ringo/tdlc2013/tdlc2013_cache.mat', 1.2, 'inter', 'err');
        close(figs(1));
        figure(figs(2));
        if saving, export_fig(gcf, './ringo_repro_inter_n1_sse.png', '-transparent'); close(figs(2)); end;
    end;
        
        
    % Predict ADD
    if ismember('all', fig_list) || strcmp(fig_list{fi}, 'predict_add')
        clear global % force production of all predict_ figures
        addpath(genpath(fullfile(GURU_dir, 'rilling', '_predict')));
        predict_human('gamma', 'predict_ab');
        
        % Predicted aboitiz data
        set(gcf, 'Position', [-454         218        1735         466]);
        if saving, export_fig(gcf, './predict_ab_add.png', '-transparent'); close(gcf); end;
        
        % Predicted pct myelination
        if saving, export_fig(gcf, './predict_pct_mye.png', '-transparent'); close(gcf); end;
        
        % Regressed fit parameters
        if saving, export_fig(gcf, './predict_regress_add.png', '-transparent'); close(gcf); end;
        
        % Fit myelinated
        if saving, export_fig(gcf, './predict_fit_add_mye.png', '-transparent'); close(gcf); end;
        
        % Fit unmyelinated
        if saving, export_fig(gcf, './predict_fit_add_unmye.png', '-transparent'); close(gcf); end;
    end;
    
end;
