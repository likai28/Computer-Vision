% Q2.7 - Todo:
% Integrating everything together.
% Loads necessary files from ../data/ and visualizes 3D reconstruction
% using scatter3
im1=imread('im1.png');
im2=imread('im2.png');
load('some_corresp.mat');
M=max(size(im1,1),size(im1,2));
[F] = eightpoint( pts1, pts2, M );

load('templeCoords.mat');
for i=1:size(x1,1)
    [x2(i,1),y2(i,1)]= epipolarCorrespondence( im1, im2, F, x1(i,1), y1(i,1));
end

p1=[x1,y1];
p2=[x2,y2];

load('intrinsics.mat');
E=essentialMatrix(F,K1,K2);
M2s=camera2(E);

M1=[eye(3),zeros(3,1)];
M1=K1*M1;
Error_smallest=10000000;
for i=1:size(M2s,3)
    [P1,error]=triangulate(M1,p1,K2*M2s(:,:,i),p2);
     pz=P1(:,3);
    if error<Error_smallest && all(pz>=0)
        Error_smallest=error;
        P=P1;
        M2=M2s(:,:,i);
    end
end

X=P(:,1);
Y=P(:,2);
Z=P(:,3);
scatter3(X,Y,Z);
save('../results/q2_7.mat','F','M1','M2');

