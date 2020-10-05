function log_measure=cov_matrix_difference(k1,k2,cov_matrix_avr)
[v,e]=eig(cov_matrix_avr{1,k1},cov_matrix_avr{1,k2});
log_measure=sqrt(sum(log(diag(e)).^2));