function subjects_data = get_subjects_data(settings)
disp('Getting subjects data');

subjects_data =[];
parfor subject=1:length(settings.general.subjects)
    for rois=1:length(settings.roi_details)
        roi_path = settings.roi_details(rois).roi_paths;
        [signals,fir,fir_avr,pct_ev,conds,conds_avr]=...
            get_signals(settings.files_details,settings.model_details,...
            roi_path);  
        subjects_data(subject).data(rois).signals = signals;
        subjects_data(subject).data(rois).fir = fir;
        subjects_data(subject).data(rois).fir_avr = fir_avr;
        subjects_data(subject).data(rois).percent_signal_change = pct_ev;
        subjects_data(subject).conds=conds;
        subjects_data(subject).conds_avr=conds_avr;
        subjects_data(subject).data(rois).roi = settings.roi_details(rois);
        
        disp(['Done: ROI ' num2str(rois) ...
            ', subject ' num2str(subject) '/out of: ' ...
            num2str(length(settings.general.selected_rois)) ' rois and ' ...
            num2str(length(settings.general.subjects)) ' subjects']);
    end
end
disp('Subjects data collected!');
disp('************************');

