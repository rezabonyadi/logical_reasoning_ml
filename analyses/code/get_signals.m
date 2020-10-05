function [raw_signals,fir,fir_avr,pct_ev,conds,cond_avr]=...
    get_signals(files_details,model_details,roi_path)
files=files_details.image_files;
spm_file=files_details.spm_files;

des_path = spm_file;
rois = maroi('load_cell', roi_path); % make maroi ROI objects
D = mardo(des_path); % make mardo design object
SPM = des_struct(D);
row = block_rows(D);
nsess  = length(row);
SPM.xY.P=files;
VY     = spm_vol(SPM.xY.P);
SPM.xY.VY=VY;
D = mardo(SPM);
% extract data into marsy data object, mY is the raw then
mY = get_marsy(rois{:}, D, model_details.summerization_approach); 

raw_signals = summary_data(mY); % get summary time course(s)
% xCon = get_contrasts(D);
D1 = autocorr(D, 'fmristat', model_details.ar_order);
E = estimate(D1, mY);


[e_specs, conds] = event_specs(E);
n_events = size(e_specs, 2);
% Bin size in seconds for FIR
bin_size = tr(E);
% Length of FIR in seconds
fir_length = model_details.fir_length;
% Number of FIR time bins to cover length of FIR
bin_no = fir_length / bin_size;
% Options - here 'single' FIR model, return estimated
opts = struct('single', 1, 'percent', 1);
% Return time courses for all events in fir_tc matrix
for e_s = 1:n_events
%     disp(e_s);
    fir(:, e_s) = event_fitted_fir(E, e_specs(:,e_s), bin_size, bin_no, opts);
end

ets = event_types_named(E);
cond_avr = {ets.name};
n_event_types = length(ets);
for e_t = 1:n_event_types
   fir_avr(:, e_t) = event_fitted_fir(E, ets(e_t).e_spec, bin_size, ...
      bin_no, opts);
end

dur = 0;
% % Return percent signal esimate for all events in design
for e_s = 1:n_events
  pct_ev(e_s) = event_signal(E, e_specs(:,e_s), dur);
end

% [this_tc dt] = event_fitted(E, events(2,:), dur);
% 
% % Make fitted time course into ~% signal change
% tc = this_tc \ block_means(E) * 100;
% 
% % save('Estimated','E');
% Est{roin,i}=tc;
% % figure
% secs = [0:length(tc) - 1] * dt; 
