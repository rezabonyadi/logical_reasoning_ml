function files_details=prepare_files(settings)
disp('Preparing files');

subjects=settings.general.subjects;
num_scans = settings.general.num_scans;
nameRegEx = settings.general.files_prefix_load;
num_sessions = settings.general.num_sessions;
files_details =[];

for i=1:length(subjects)
    files_details(i).spm_files = ...
        [settings.general.spm_address_root subjects{i} '/SPM.mat'];
    files=[];
    for session=1:num_sessions
        files_address = [settings.general.image_files_root subjects{i} '/' ...
            settings.general.sessions_folder_prefix num2str(session) '/'];
        files = [files;...
            spm_select('ExtFPList', files_address, nameRegEx, 1:num_scans)];
    end
    files_details(i).image_files=files;
    disp(['Done with reading subject ' subjects{i}]);
end

disp('Files prepration done!');
disp('************************');
