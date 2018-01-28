function [panoImg] = imageStitching(img1, img2, H2to1)
%
% input
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
%
% output
% Blends img1 and warped img2 and outputs the panorama image

img1=imread('incline_L.png');
img2=imread('incline_R.png');

[locs1,desc1,locs2,desc2,matches]= testMatch(img1,img2);

p1=[];
p2=[];

for i=1:size(matches,1)
    p1(i,1)=locs1(matches(i,1),1);   % get xi
    p1(i,2)=locs1(matches(i,1),2);  % get yi
    p2(i,1)=locs2(matches(i,2),1);  % get ui
    p2(i,2)=locs2(matches(i,2),2);   % get vi
end
p1=p1';
p2=p2';

H2to1 = computeH(p1,p2);
warp_im = warpH(img2, H2to1,size(img1),0);
imwrite(warp_im,'q5_1.jpg');
save('q5_1.mat','H2to1');
% start creating panorama









    
    
    
