function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q2.6 - Todo:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q2_6.mat
%
%           Exp,lain your methods and optimization in your writeup

p1 = [x1; y1; 1];
line1 = F*p1;
scale = sqrt(line1(1)^2 + line1(2)^2);
line1 = line1/scale;

% find approximate point
% of search region
x_guess=[x1-20:x1+20];
y_guess=[y1-20:y1+20];
point_guess=[];

for i=1:size(x_guess,2)
    for j=1:size(y_guess,2)
        temp=[x_guess(i),y_guess(j),1];
        point_guess=[point_guess;temp];
    end
end


thr=1;
point_guess2=[];

for i=1:size(point_guess,1)
    if abs(point_guess(i,:)*line1)<thr
       point_guess2=[point_guess2;point_guess(i,:)];
    end
end

% set parameter
windowsize=10;
kernelSize = 2*windowsize+1;
patch1 = double(im1((y1-windowsize):(y1+windowsize), (x1-windowsize):(x1+windowsize)));
minerror=1000;
sigma = 3;
weight = fspecial('gaussian', [kernelSize kernelSize], sigma);

% compute the difference
for i=1:size(point_guess2,1)

           patch2=double(im2(point_guess2(i,2)-windowsize:point_guess2(i,2)+windowsize,point_guess2(i,1)-windowsize:point_guess2(i,1)+windowsize));
           distance = patch1 - patch2;
           error = norm(weight .* distance); 
           if error<minerror
                minerror=error;
                x2=point_guess2(i,1);
                y2=point_guess2(i,2);
           end   
end

end
