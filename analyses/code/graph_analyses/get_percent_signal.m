function res=get_percent_signal(settings)
res=[];
for i=1:length(settings.subjects_data)% Subjects
    for j=1:length(settings.roi_details)% Roi
        psc=settings.subjects_data(i).data(j).percent_signal_change;
        conds=unique(settings.subjects_data(i).conds);
        for k=1:length(conds)% Condition
            indx=strfind(settings.subjects_data(i).conds,conds(k));
            v=0;
            z=0;
            for t=1:length(indx)
                if(indx{t}==1)
                    v=v+psc(t);
                    z=z+1;
                end                
            end
            v=v/z;
            res{j}(i,k)=v;
        end
    end
end