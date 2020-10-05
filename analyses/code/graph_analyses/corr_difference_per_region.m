function res=corr_difference_per_region(k1,k2,corr_matrix_avr,settings)
for reg=1:size(corr_matrix_avr,2)
    reg_name{reg}=settings.roi_details(reg).full_name;
    reg_n{reg}=settings.roi_details(reg).code;
    d(reg)=sum((squeeze(corr_matrix_avr(k1,reg,:))-squeeze(corr_matrix_avr(k2,reg,:))).^2);
%     figure;
%     plot(squeeze(corr_matrix_avr(k1,reg,:)));hold on;
%     plot(squeeze(corr_matrix_avr(k2,reg,:)));
%     title([reg_name{reg} ',' num2str(d(reg))]);
end

[d,ind]=sort(d);
for i=1:size(corr_matrix_avr,2)
    res{i,1}=reg_name{ind(i)};
    res{i,2}=reg_n{ind(i)};
    res{i,3}=d(i);
end