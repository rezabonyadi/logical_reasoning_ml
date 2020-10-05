function masks = build_masked_mats(selected_rois)
all_roi_info = xml2struct('resources/AAL2.xml');
atlas = read_data.niftiread('resources/AAL2.nii');

roi_labels = all_roi_info.atlas.data.label;
temp_label_names =[];
for i=1:length(roi_labels)
    temp_label_names(i).name = roi_labels{i}.name.Text;
    temp_label_names(i).index = str2double(roi_labels{i}.index.Text);
end

labels_info.name = {temp_label_names.name};
labels_info.index = cell2mat({temp_label_names.index});

clear roi_labels temp_label_names;

for i=1:length(selected_rois)
    masked_atlas = atlas;
    roi_index = strcmp(labels_info.name,selected_rois{i});
    roi_value = labels_info.index(roi_index);
    masked_atlas(masked_atlas ~= roi_value) = 0;
    masked_atlas(masked_atlas > 0) = 1;
    save(['rois_mat\roi_' selected_rois{i} '.mat'],'masked_atlas');
    masks{i} = masked_atlas;
end

