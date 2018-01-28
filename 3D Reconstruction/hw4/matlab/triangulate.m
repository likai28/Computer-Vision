function [ P, error ] = triangulate( M1, p1, M2, p2 )
% triangulate:
%       M1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       M2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

% Q2.4 - Todo:
%       Implement a triangulation algorithm to compute the 3d locations
%       See Szeliski Chapter 7 for ideas
%

p1=p1';
p1=[p1;ones(1,size(p1,2))];
p2=p2';
p2=[p2;ones(1,size(p2,2))];
error=0;
for i=1:size(p1,2)
      
       sx1 = p1(:,i);
       sx2 = p2(:,i);
       
   A1 = sx1(1,1).*M1(3,:) - M1(1,:);
   A2 = sx1(2,1).*M1(3,:) - M1(2,:);
   A3 = sx2(1,1).*M2(3,:) - M2(1,:);
   A4 = sx2(2,1).*M2(3,:) - M2(2,:);
   
   A = [A1;A2;A3;A4];
  
   [U,D,V] = svd(A);
   
   X_temp = V(:,4);
   X_temp = X_temp ./ repmat(X_temp(4,1),4,1);
  
   P(:,i) = X_temp;
   error_temp= A*X_temp;
   error=error+norm(error_temp);
end
    
   P=P(1:3,:);
   P=P';

end

