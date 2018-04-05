function [I_new,a,b,c,d]=Select_ROI_Auto(I,show)
BW = grayconnected(I,2,2);
I=uint8(double(~BW).*double(I));
[x,y]=find(BW==0);
a=min(x);
b=max(x);
c=min(y);
d=max(y);
I_new=I(a:b,c:d);
if show==1
    figure(1)
    imshow(I_new,[])
    xlabel('Selected ROI')
end
end