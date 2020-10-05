function [roi_details,selected_rois] = get_roi_details()
maps = readtable('resources\ROI_maps.csv');
selected_rois={};
for i=1:size(maps,1)
    if(maps{i,2}==1)
        roi = strsplit(maps{i,1}{1},'.');
        roi=roi{1};
        roi=roi(5:end-4);
        selected_rois=[selected_rois;roi];
    end
end

roi_struct=dir('rois_mat\*.mat');
roi_names = {roi_struct.name};
roi_details=[];
load('resources\atlas_names_map.mat');
for i=1:length(selected_rois)
    indx = find(startsWith(roi_names,['MNI_' selected_rois{i} '_roi.mat']));
    if(isempty(indx))
        % It does not exist!
    end
    roi_details(i).roi_paths = [roi_struct(i).folder ...
        '\MNI_' selected_rois{i} '_roi.mat'];
    
    roi_file_name=['MNI_' selected_rois{i} '_roi.mat'];
    indx=find(strncmp(roi_file_name,atlas_cord_map(:,6),length(roi_file_name)));
    roi_details(i).code=atlas_cord_map{indx,7};
    roi_details(i).coordinate=cell2mat(atlas_cord_map(indx,2:4));
    roi_details(i).full_name=atlas_cord_map{indx,1};
    roi_details(i).standard_name=selected_rois{i};
%     roi_details.coordinate=
end



