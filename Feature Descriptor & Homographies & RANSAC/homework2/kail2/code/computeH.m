function H2to1 = computeH(p1,p2)
% inputs:
% p1 and p2 should be 2 x N matrices of corresponding (x, y)' coordinates between two images
%
% outputs:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation


x=p1(1,:);
y=p1(2,:);
u=p2(1,:);
v=p2(2,:);
A=[];
for i=1:size(p1,2)
    A=[A;u(i),v(i),1,0,0,0,-x(i)*u(i),-x(i)*v(i),-x(i)];
    A=[A;0,0,0,u(i),v(i),1,-y(i)*u(i),-y(i)*v(i),-y(i)];
end

[U,S,V]=svd(A);
 h=V(:,end);
 H2to1=reshape(h,[3,3]);
 H2to1=H2to1';
 


 
 
 
