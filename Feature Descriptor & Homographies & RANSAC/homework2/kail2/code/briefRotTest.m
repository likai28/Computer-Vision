function briefRotTest()

im1=imread('../data/model_chickenbroth.jpg');
im2=imread('../data/model_chickenbroth.jpg');

match_points=[];
for i=1:10                      % fisrt try 3, then use cmu company to try 36
    [locs1,desc1,locs2,desc2,matches]=testMatch(im1,im2);
    im2= imrotate(im2,10);
    match_points(i)=size(matches,1);
end
x=1:1:10;
figure;
bar(x,match_points);
    

