function build_braph_atlas(settings)
group_dir = [settings.general.output_dir settings.general.group_name '/'];
if(~exist(group_dir))
    mkdir(group_dir);
end
atlas_file=[group_dir 'atlas_coordinates.xml'];
fid=fopen(atlas_file,'w');
fprintf(fid,'%s\n','<?xml version="1.0" encoding="UTF-8"?>');
fprintf(fid,'%s\n','<xml>');
fprintf(fid,'%s\n','   <BrainAtlas brainsurf="BrainMesh_ICBM152.nv" name="AAL90">');
for i=1:length(settings.roi_details)
    lr=strsplit(settings.roi_details(i).code,'.');
    if(strcmp(lr{2},'L'))
        lateral='left';
    else
        lateral='right';
    end
    
    st=['<BrainRegion hemisphere="' lateral '" label="' settings.roi_details(i).code...
        '" name="' settings.roi_details(i).full_name '" notes="." x="' ...
        num2str(settings.roi_details(i).coordinate(1)) ...
        '" y="' num2str(settings.roi_details(i).coordinate(2)) ...
        '" z="' num2str(settings.roi_details(i).coordinate(3)) '"/>'];
    fprintf(fid,'%s\n',st);
end
fprintf(fid,'%s\n','   </BrainAtlas>');

fprintf(fid,'%s\n','</xml>');
fclose(fid);

for k=1:length(settings.subjects_data(1).conds_avr)
    cond = settings.subjects_data(1).conds_avr{k};
    cond_dir = [group_dir cond '/'];
    if(~exist(cond_dir))
        mkdir(cond_dir);
    end
    for i=1:length(settings.general.subjects)
        
        for j=1:length(settings.roi_details)            
            fir_avr(:,j) = settings.subjects_data(i).data(j).fir_avr(:,k);            
        end
        eval(['subject' settings.general.subjects{i} '=fir_avr']);
        save([cond_dir 'subject' settings.general.subjects{i} '.mat'], ...
            ['subject' settings.general.subjects{i}]);
    end
end
