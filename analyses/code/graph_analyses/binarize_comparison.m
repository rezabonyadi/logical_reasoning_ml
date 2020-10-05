function binarize_comparison(k1,k2,corr_matrix)
c1=squeeze(corr_matrix(k1,:,:,:));
c2=squeeze(corr_matrix(k2,:,:,:));

i=1;
for thr=0:0.01:1
    bc1=binar(c1,thr);
    bc2=binar(c2,thr);
    s1=squeeze(sum(bc1,1));
    s2=squeeze(sum(bc2,1));
    d1(i,:,:)=abs(s1-s2)/size(c1,1);
    imagesc(squeeze(d1(i,:,:)));
    i=i+1;
end

function bc=binar(c,thr)
bc=abs(c)>thr;