clear all;
close all;

selected_rois = {'Hippocampus_R','Amygdala_R'};
roi_paths = get_roi_paths(selected_rois);
% masks = build_masked_mats(selected_rois);

spm_address = 'R:\Projects\Maryam\Signal extraction\data\results\SPM\premise_event_all\firstLevel\13\SPM.mat';
image_files = {'R:\Projects\Maryam\Signal extraction\data\preprocessed\13\R1\',...
    'R:\Projects\Maryam\Signal extraction\data\preprocessed\13\R2\',...
    'R:\Projects\Maryam\Signal extraction\data\preprocessed\13\R3\',...
    'R:\Projects\Maryam\Signal extraction\data\preprocessed\13\R4\',...
    'R:\Projects\Maryam\Signal extraction\data\preprocessed\13\R5\',...
    'R:\Projects\Maryam\Signal extraction\data\preprocessed\13\R6\'};
num_sessions=6;
numScans = 473;
nameRegEx = strcat('^', {'swr'});
roi_path = roi_paths;
files=[];
for i=1:num_sessions
    files = [files;spm_select('ExtFPList', image_files{i}, nameRegEx, 1:numScans)];
end
% files = [files;spm_select('ExtFPList', image_files, nameRegEx, 1:numScans)];

[signals,fir,fir_avr]=get_signals(files,spm_address,roi_path);
