clc
clear
%% Load Data
[images, headers] = dicomfolder('SE000002');
Images_Main=images(:,:,190:230);
%% Normalize
for i=1:size(Images_Main,3)
   I=Images_Main(:,:,i)+abs(min(min(Images_Main(:,:,i))));
   I=uint8(round(I/max(I(:))*255));
   images_Norm(:,:,i)=I;
end
%% HistEq
show=0;
for i=1:size(images_Norm,3)
    I_GCELEWD(:,:,i)=HistEq_newMethod(images_Norm(:,:,i),show);
end
%% Find Threshold & Apply Openning
show=1;
I_tempMask=I_GCELEWD;
se = strel('disk',10);
for i=1:size(I_GCELEWD,3)
 Thresh=FindThresh(I_GCELEWD(:,:,i),show);
 I_tempMask(:,:,i)=I_GCELEWD(:,:,i)<Thresh;
 %Opening
 afterOpening = imopen( I_tempMask(:,:,i),se);
 [I_new,a,b,c,d]=Select_ROI_Auto(afterOpening,0);
 % Segmentaion
 L = bwlabel(I_new);
 L(L==1)=0;
 L(L==0)=0;
 L(L==2)=1;
 L(L==3)=1;
figure(2)
 imshow((L.*I_GCELEWD(a:b,c:d,i)),[])
 pause(.001);
end



