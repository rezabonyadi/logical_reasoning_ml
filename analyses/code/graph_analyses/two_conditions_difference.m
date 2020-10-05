function difference=two_conditions_difference(k1,k2,settings,corr_matrix,rois)
%% Statistical difference between two conditions, k1 and k2
% k1=3;
% k2=1;
difference=zeros(length(rois));
for k=1:1
    disp(k);
    num_subject = length(settings.general.subjects);
    subs=randperm(num_subject,ceil(num_subject*1));
    for i=1:length(rois)
        for j=i+1:length(rois)
            c1=squeeze(corr_matrix(k1,subs,i,j));
            c2=squeeze(corr_matrix(k2,subs,i,j));
            [p,h]=ranksum(c1,c2);
            difference(i,j)=difference(i,j)+h;
            difference(j,i)=difference(j,i)+h;
        end
    end
end
% difference=difference/100;
for i=1:length(rois)
    all_rois{i}=rois{i};
end
imagesc(difference);
set(gca,'ytick',1:70,'yticklabel',all_rois);
set(gca,'xtick',1:70,'xticklabel',all_rois);
xtickangle(90);