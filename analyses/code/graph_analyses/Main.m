clear all;
close all;


load('D:\Maryam\Projects\Logical reasoning\graph analyses\analyses\out\premise_event_threeconditions_median\settings_file.mat')
[corr_matrix_avr,corr_matrix,...
    cov_matrix_avr,cov_matrix, final_data]=overall_comparison(settings);

k1=1;
k2=3;
% roi_select_codes={'ANG.L','ANG.R','CUN.L','CUN.R','FFG.L','FFG.R','HIP.L'...
%     ,'HIP.R','MTG.L','MTG.R','ORBsupmed.L','ORBsupmed.R','PCG.L','PCG.R',...
%     'PoCG.L','PoCG.R','PreCG.L','PreCG.R'};

% roi_select_codes={'CAU.L','CAU.R','IFGoperc.L','IFGoperc.R','IFGtriang.L','IFGtriang.R',...
%     'IOG.L','IOG.R','IPL.L','IPL.R','LING.L','LING.R','MFG.L','MFG.R',...
%     'PCUN.L','PCUN.R','PUT.L','PUT.R','SFGdor.L','SFGdor.R','SPG.L','SPG.R',...
%     'THA.L','THA.R'};

% roi_select_codes={'ACG.L','ACG.R','AMYG.L','AMYG.R','DCG.L','DCG.R',...
%     'INS.L','INS.R','ITG.L','ITG.R','ORBinf.L','ORBinf.R','ORBmid.L','ORBmid.R',...
%     'ORBsup.L','ORBsup.R','PHG.L','PHG.R','ROL.L','ROL.R','SFGmed.L','SFGmed.R',...
%     'STG.L','STG.R','TPOmid.L','TPOmid.R','TPOsup.L','TPOsup.R'};
% 
% roi_select_indx=[];
% for i=1:length(settings.roi_details)
%     kk=strfind(roi_select_codes,settings.roi_details(i).code);
%     for j=1:length(kk)
%         if(kk{j}==1)
%             roi_select_indx=[roi_select_indx,i];
%             break;
%         end
%     end
% end
% for i=1:3
%     cov_matrix_avr{i}=cov_matrix_avr{i}(roi_select_indx,roi_select_indx);
%     corr_matrix_avrm(i,:,:)=squeeze(corr_matrix_avr(i,roi_select_indx,roi_select_indx));
% end
% corr_matrix_avr=corr_matrix_avrm;
log_measure=cov_matrix_difference(k1,k2,cov_matrix_avr);

for i=1:28
    log_measures(i)=cov_matrix_difference(k1,k2,{cov_matrix{1,i},cov_matrix{2,i},cov_matrix{3,i}});
end

difference=two_conditions_difference(k1,k2,settings,corr_matrix,roi_select_codes);
d=corr_difference_per_region(k1,k2,corr_matrix_avr,settings);

% a=squeeze(final_data(1,:,3,:));
% b=squeeze(final_data(3,:,3,:));

