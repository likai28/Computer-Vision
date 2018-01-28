function [locs1,desc1,locs2,desc2,matches]= testMatch(im1,im2)


im1 = im2double(im1);
if size(im1,3)==3          % change the rgb image into gray one
    im1= rgb2gray(im1);
end

 
im2 = im2double(im2);
if size(im2,3)==3          % change the rgb image into gray one
    im2= rgb2gray(im2);
end


[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
[matches] = briefMatch(desc1, desc2, 0.8);
plotMatches(im1, im2, matches, locs1, locs2);