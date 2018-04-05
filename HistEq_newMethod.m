function I_GCELEWD=HistEq_newMethod(I,show)
%% GCELEWD
J=I(:); 
Pdf_GCELEWD=imhist(J)/numel(J);
Pdf_GCELEWD(1)=0;
Pdf_GCELEWD(end)=0;
alpha=max(1/(1+exp(-Pdf_GCELEWD)));
PdfW=max(Pdf_GCELEWD(:))*((Pdf_GCELEWD-min(Pdf_GCELEWD(:)))./((max(Pdf_GCELEWD(:))-min(Pdf_GCELEWD(:))))).^alpha;
Cdf=cumsum(PdfW);
Cdfn=Cdf./sum(PdfW);
for i=1:255
    TF_GCELEWD(i)=(Cdfn(i)+((i-1)/255).^(1-Cdfn(i)))./2;
end
%apply to image  
for i=1:size(I,1)
    for j=1:size(I,2)
   I_GCELEWD(i,j)=TF_GCELEWD(I(i,j)+1);
    end
end
% I_GCELEWD=im2uint8(I_GCELEWD);
J=I_GCELEWD(:); 
if show==1
figure(5),imhist(J); xlabel('GCELEWD Image Histogram ');
figure(6), imshow(I_GCELEWD,[]);xlabel('GCELEWD')
pause(.001)
end
end