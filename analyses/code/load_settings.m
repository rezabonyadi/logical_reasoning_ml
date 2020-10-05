function settings=load_settings()
%% Manual settings 
settings.general.analysis_name = 'premise_event_threeconditions';
settings.general.image_files_root = 'R:/Projects/Maryam/LogicalReasoning/fMRI/fMRIData/preprocessed_v2/';
% settings.general.spm_address_root = 'R:/Projects/Maryam/LogicalReasoning/fMRI/Results/SPM/conclusion_event_all/firstLevel/';
settings.general.spm_address_root = 'R:/Projects/Maryam/LogicalReasoning/fMRI/Results/SPM/premise_event_threeconditions/firstLevel/';
settings.general.output_dir = 'R:/Projects/Maryam/LogicalReasoning/fMRI/Codes/graph_analysis_codes/out/';
settings.general.sessions_folder_prefix = 'R';
settings.general.files_prefix_load = strcat('^', {'swr'});
settings.general.num_sessions=6;
settings.general.num_scans = 473;
settings.general.group_name = 'young';
settings.general.subjects={'10','12','13','14','15','16','17','19','110','111','112',...
    '113','114','115','116','117','118','119','120','121','122','123','124',...
    '125','126','127','129','130','131','132'};
% settings.general.subjects={'10','12'};
% settings.general.subjects={'13','14','15','16','17','19','110','111','112',...
%     '113','114','115','117','118','119','120','121','122','123','124',...
%     '125','126','127','128','129','130','131'};

% settings.general.subjects={'13'};

settings.model_details.fir_length = 12; % in seconds
settings.model_details.ar_order = 2;

% Options: 'mean', 'median', 'eigen1', 'wtmean'
settings.model_details.summerization_approach = 'wtmean';

%% Preparing the setting variable
% The ROIs need to be selected in the "resources\ROI_maps.csv" first.
settings.general.output_dir = [settings.general.output_dir ...
    settings.general.analysis_name '/'];
[settings.roi_details, settings.general.selected_rois] = ...
    get_roi_details();

