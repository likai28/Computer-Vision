function [ F ] = sevenpoint( pts1, pts2, M )
% sevenpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.2 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat

%     Write recovered F and display the output of displayEpipolarF in your writeup
T=[1/M,0,-1;0,1/M,-1;0,0,1];


x=pts1(:,1)';
y=pts1(:,2)';
point=[x;y;zeros(1,size(pts1,1))];
point_norm=T*point;
point_norm=point_norm(1:2,:)';

x2=pts2(:,1)';
y2=pts2(:,2)';
point2=[x2;y2;zeros(1,size(pts2,1))];
point_norm2=T*point2;
point_norm2=point_norm2(1:2,:)';

A=[];
for i=1:7
    xl=point_norm(i,1);
    yl=point_norm(i,2);
    xr=point_norm2(i,1);
    yr=point_norm2(i,2);
    temp=[xl*xr,yl*xr,xr,xl*yr,yl*yr,yr,xl,yl,1];
    A=[A;temp];
end

Z=null(A);
f1=Z(:,1);
f2=Z(:,2);
F1=(reshape(f1,3,3))';
F2=(reshape(f2,3,3))';


landa= sym('a');
f= (1-landa).*F1+landa.*F2;
p=det(f);
c = coeffs(p);
c=double(c);
c =fliplr(c);
landa=roots(c);

for i=1:size(landa,1)
    if imag(landa(i,:))==0
         final_landa=landa(i,:);
     end
 end

% Fa=(1-landa(1)).*F1+landa(1).*F2;
% Fb=(1-landa(2)).*F1+landa(2).*F2;
% Fc=(1-landa(3)).*F1+landa(3).*F2;
F=(1-final_landa).*F1+final_landa.*F2;

F=T'*F*T;
F=refineF(F,pts1,pts2);

save('../results/q2_2.mat','F','M','pts1','pts2');
end

