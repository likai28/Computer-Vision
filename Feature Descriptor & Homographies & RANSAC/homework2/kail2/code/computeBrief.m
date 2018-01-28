function [locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k, levels, compareA, compareB)
%%Compute Brief feature
% input
% im - a grayscale image with values from 0 to 1
% locsDoG - locsDoG are the keypoint locations returned by the DoG detector
% levels - Gaussian scale levels that were given in Section1
% compareA and compareB - linear indices into the patchWidth x patchWidth image patch and are each nbits x 1 vectors
%
% output
% locs - an m x 3 vector, where the first two columns are the image coordinates of keypoints and the third column is 
%		 the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. m is the number of valid descriptors in the image and will vary
load('testPattern.mat');
locs=[];
for i= 1:size(locsDoG,1)
    if locsDoG(i,1)>=5&&locsDoG(i,1)<=(size(GaussianPyramid,2)-4)&&locsDoG(i,2)>=5&&locsDoG(i,2)<=(size(GaussianPyramid,1)-4)
        locs=[locs;locsDoG(i,:)];
    end
end



for i=1:size(locs,1) 
    xo= locs(i,1);
    yo= locs(i,2);
     zo=locs(i,3);
    temp=GaussianPyramid((yo-4):(yo+4),(xo-4):(xo+4),zo);   % ????????????????????????????????
    temp=reshape(temp,[1 81]);
    
    for j=1:256
        if temp(compareA(j))<temp(compareB(j))
            desc(i,j)=1;
        else
            desc(i,j)=0;
        end
    end
end

    
    
    
