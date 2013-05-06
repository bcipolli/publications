addpath('rilling/_predict_human'); 
w_predict_human

addpath('ringo/scripts/TDLC2013'); 
tdlc2013_figures('~/_cache/ringo/tdlc2013_cache.mat', [1], 'inter', 'err');
tdlc2013_figures('~/_cache/ringo/tdlc2013_cache.mat', [1], 'intra', 'err');

addpath('ringo/scripts/evolution');
all_h10_figures;
