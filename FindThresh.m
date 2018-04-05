function Thresh=FindThresh(I,show)
[h,t]=imhist(I);
h(1)=[];
h(end)=[];
h = sgolayfilt(h,5,41);
[p,ind]=findpeaks(h,'MinPeakDistance',50);
if show==1
    figure(3)
    clf
    plot(h)
    hold on
    plot(ind,p,'o')
    pause(.001)
end
p=sort(p,'descend');
p(3:end)=[];
IndMax=0;
for i=1:2
    Ind=find(p(i)==h);
    if IndMax<Ind
       IndMax=Ind; 
    end
end
[~,Thresh]=min(h(IndMax-50:IndMax));
Thresh=t(Thresh+IndMax-50);
end