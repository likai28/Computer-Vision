function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
% input
% locs1 and locs2 - matrices specifying point locations in each of the images
% matches - matrix specifying matches between these two sets of point locations
% nIter - number of iterations to run RANSAC
% tol - tolerance value for considering a point to be an inlier
% output
% bestH - homography model with the most inliers found during RANSAC

nIter=100;
tol=1;
img1=imread('incline_L.png');
img2=imread('incline_R.png');

[locs1,desc1,locs2,desc2,matches]= testMatch(img1,img2);
p1=[];
p2=[];
H={};

P1=[];
P2=[];
Ptest=zeros(3,4);
count_correct=zeros(1,100);

for i=1:size(matches,1)
    P1(i,1)=locs1(matches(i,1),1);   % get xi
    P1(i,2)=locs1(matches(i,1),2);  % get yi
    P2(i,1)=locs2(matches(i,2),1);  % get ui
    P2(i,2)=locs2(matches(i,2),2);   % get vi
end
P1=P1';
P2=P2';

for i=1:nIter
    rand_pick= randperm(size(matches,1),4);
    for j=1:size(rand_pick,2)
        p1(j,1)=locs1(matches(rand_pick(j),1),1);   % get xi
        p1(j,2)=locs1(matches(rand_pick(j),1),2);  % get yi
        p2(j,1)=locs2(matches(rand_pick(j),2),1);  % get ui
        p2(j,2)=locs2(matches(rand_pick(j),2),2);   % get vi 
    end
    p1=p1';
    p2=p2';
    H{i}=computeH(p1,p2);                         % get H matrix
    Ptest=H{i}*[P2;ones(1,size(P2,2))];
    Ptest(1,:)=Ptest(1,:)./Ptest(3,:);
    Ptest(2,:)=Ptest(2,:)./Ptest(3,:);
    Ptest=Ptest(1:2,:);
     
    for k=1:size(Ptest,2)
        if norm(P1(:,k)-Ptest(:,k))< tol
            count_correct(i)=count_correct(i)+1;
        end
    end
end
[C,K]=max(count_correct);
bestH=H{K};


            
    
    
    
   
    
    
    
    
    
    
  
                         
    