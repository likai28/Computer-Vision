% Q2.5 - Todo:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       3. Save the correct M2, p1, p2, R and P to q2_5.mat

load('some_corresp.mat');
M=640;
F=eightpoint(pts1,pts2,M);
load('intrinsics.mat');
E=essentialMatrix(F,K1,K2);
M2s=camera2(E);

M1=[eye(3),zeros(3,1)];
M1=K1*M1;
Error_smallest=10000000;
for i=1:size(M2s,3)
    [P1,error]=triangulate(M1,pts1,K2*M2s(:,:,i),pts2);
    if error<Error_smallest
        Error_smallest=error;
        P=P1;
        M2=M2s(:,:,i);
    end
end
p1=pts1;
p2=pts2;
save('../results/q2_5.mat','M2','p1','p2','P');
        
    