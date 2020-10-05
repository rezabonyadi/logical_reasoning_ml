function [corr_matrix_avr,corr_matrix,...
    cov_matrix_avr,cov_matrix,final_data]=overall_comparison(settings)

for i=1:length(settings.subjects_data(1).conds_avr)% for each condition
    for j=1:length(settings.subjects_data) % for all subjects
        for k=1:length(settings.roi_details) % for each ROI
            final_data(i,j,k,:)=settings.subjects_data(j).data(k).fir_avr(:,i)';
            all_data{i,j}(k,:)=settings.subjects_data(j).data(k).fir_avr(:,i)';
            cov_matrix{i,j}=cov(all_data{i,j}');
            mean_matrix{i,j}=mean(all_data{i,j}');
        end
        corr_matrix(i,j,:,:)=corr(all_data{i,j}');
    end
end
corr_matrix_avr=squeeze(mean(corr_matrix,2));
%% Average of covariance matrices
for i=1:size(cov_matrix,1)% Number of conditions
    t=zeros(size(cov_matrix{1,1}));
    for j=1:size(cov_matrix,2)
        t=t+cov_matrix{i,j};
    end
    cov_matrix_avr{i}=t/size(cov_matrix,2);
end

%% eigenvectors calculations
% for i=1:size(cov_matrix,1)%For each condition
%     for j=1:size(cov_matrix,2)%For each subject
%         [v,e]=eigs(cov_matrix{i,j});
%         myEgsVals{i,j}=diag(e);
%         myEgsVecs{i,j}=v;
%     end
% end

%% Relative eigenvalues
% re=[];
% for j=1:size(cov_matrix,2)%For each subject
%     c1=(cov_matrix{k1,j});
%     c2=(cov_matrix{k2,j});
%     e=eig(c1,c2);
%     re(j,:)=e;
% end

%% LDA calculations
% c1=cov_matrix_avr{k1};
% c2=cov_matrix_avr{k2};
% m1=mean(cell2mat(mean_matrix(1,:)'));
% m2=mean(cell2mat(mean_matrix(3,:)'));
% [v,e]=eig(c1+c2,(m1-m2)'*(m1-m2));% This minimizes the variance while maximizes means
% 
% d1=[];
% for j=1:length(settings.subjects_data)
%     d1=[d1;all_data{k1,j}'*v(:,1)];
% end
% d2=[];
% for j=1:length(settings.subjects_data)
%     d2=[d2;all_data{k2,j}'*v(:,1)];
% end
% 
% z=0;