function im3= generatePanorama(im1,im2)

[locs1,desc1,locs2,desc2,matches]= testMatch(im1,im2);
[H2to1] = ransacH(matches, locs1, locs2, 100, 1);

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

im1=im2double(im1);
im2=im2double(im2);

M=[1,0,0;0,1,163;0,0,1];

warp_im1=warpH(im1, M, out_size,0);
warp_im2 = warpH(im2, M*H2to1, out_size,0);

mask1 = zeros(size(im1,1), size(im1,2),3);
mask1(1,:) = 1; mask1(end,:) = 1; mask1(:,1) = 1; mask1(:,end) = 1;
mask1 = bwdist(mask1, 'city');
mask1 = mask1/max(mask1(:));
mask1=warpH(mask1, M, out_size,0);

mask2 = zeros(size(im2,1), size(im2,2),3);
mask2(1,:) = 1; mask2(end,:) = 1; mask2(:,1) = 1; mask2(:,end) = 1;
mask2 = bwdist(mask2, 'city');
mask2 = mask2/max(mask2(:));
mask2=warpH(mask2, M*H2to1, out_size,0);


im3=(warp_im1.*mask1+warp_im2.*mask2)./(mask1+mask2);
imshow(im3);
imwrite(im3,'q6_2.jpg');


