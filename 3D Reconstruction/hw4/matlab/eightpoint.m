function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save F, M, pts1, pts2 to q2_1.mat

%     Write F and display the output of displayEpipolarF in your writeup
%load('some_corresp.mat');

T=[2/M,0,-1;0,2/M,-1;0,0,1];

x=pts1(:,1)';
y=pts1(:,2)';
point=[x;y;ones(1,size(pts1,1))];
point_norm=T*point;
point_norm=point_norm(1:2,:)';

x2=pts2(:,1)';
y2=pts2(:,2)';
point2=[x2;y2;ones(1,size(pts2,1))];
point_norm2=T*point2;
point_norm2=point_norm2(1:2,:)';

A=[];
for i=1:size(pts1,1)
    xl=point_norm(i,1);
    yl=point_norm(i,2);
    xr=point_norm2(i,1);
    yr=point_norm2(i,2);
    temp=[xl*xr,yl*xr,xr,xl*yr,yl*yr,yr,xl,yl,1];
    A=[A;temp];
end

[U,S,V] = svd(A'*A);
f=V(:,end);
F=(reshape(f,3,3))';
[U,S,V]=svd(F);
S(3,3)=0;
F=U*S*V';


F=refineF(F,point_norm,point_norm2);
F=T'*F*T;

save('../results/q2_1.mat','F','M','pts1','pts2');

end

