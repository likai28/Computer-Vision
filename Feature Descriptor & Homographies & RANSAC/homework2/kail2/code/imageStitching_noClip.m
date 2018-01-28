function [panoImg] = imageStitching_noClip(img1, img2, H2to1)
%
% input
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
%
% output
% Blends img1 and warped img2 and outputs the panorama image
%
% To prevent clipping at the edges, we instead need to warp both image 1 and image 2 into a common third reference frame 
% in which we can display both images without any clipping.
img1=imread('incline_L.png');
img2=imread('incline_R.png');
[locs1,desc1,locs2,desc2,matches]= testMatch(img1,img2);
nIter=100;
tol=1;
[H2to1] = ransacH(matches, locs1, locs2, nIter, tol);

%h_top=[945.75;2.75;1];
%h_bottom=[945.75;568.25;1];
h_top=[1064;1;1];
h_bottom=[1064;576;1];
warpped_h_top=H2to1*h_top;
warpped_h_bottom=H2to1*h_bottom;
warpped_h_top(1,1)=warpped_h_top(1,1)/warpped_h_top(3,1);
warpped_h_top(2,1)=warpped_h_top(2,1)/warpped_h_top(3,1);
warpped_h_bottom(1,1)=warpped_h_bottom(1,1)/warpped_h_bottom(3,1);
warpped_h_bottom(2,1)=warpped_h_bottom(2,1)/warpped_h_bottom(3,1);

height=ceil(warpped_h_bottom(2,1)-warpped_h_top(2,1));
width=ceil(warpped_h_top(1,1));
out_size=[height,width];            % get the out_size

img1=im2double(img1);
img2=im2double(img2);

M=[1,0,0;0,1,163;0,0,1];         % y-direction translation, no need to scale

warp_im1=warpH(img1, M, out_size,0);
warp_im2 = warpH(img2, M*H2to1, out_size,0);

mask1 = zeros(size(img1,1), size(img1,2),3);
mask1(1,:) = 1; mask1(end,:) = 1; mask1(:,1) = 1; mask1(:,end) = 1;
mask1 = bwdist(mask1, 'city');
mask1 = mask1/max(mask1(:));
mask1=warpH(mask1, M, out_size,0);

mask2 = zeros(size(img2,1), size(img2,2),3);
mask2(1,:) = 1; mask2(end,:) = 1; mask2(:,1) = 1; mask2(:,end) = 1;
mask2 = bwdist(mask2, 'city');
mask2 = mask2/max(mask2(:));
mask2=warpH(mask2, M*H2to1, out_size,0);


panoImg=(warp_im1.*mask1+warp_im2.*mask2)./(mask1+mask2);

imwrite(panoImg,'q5_2_pan.jpg');
%for k=1:3
%for i=1:height
%    for j=1:width
%          panoImg(i,j,k)=max(warp_im1(i,j,k),warp_im2(i,j,k));
%    end
%end
%end



