function mask = SubtractDominantMotion(image1, image2)

% input - image1 and image2 form the input image pair
% output - mask is a binary image of the same size
image1= im2double(image1);
image2= im2double(image2);

M = LucasKanadeAffine(image1, image2);
image2= gettemplete(image2,M);

 th = 0.1;
 mask = abs(image1-image2) > th;
    B = [0,0,1,0,0;
        0,1,1,1,0;
        1,1,1,1,1;
        0,1,1,1,0;
        0,0,1,0,0];
    mask = imdilate(mask,B);
end


function gettemplete = gettemplete(I,M)
    s = size(I);
    [X,Y] = meshgrid(1:s(2),1:s(1));
    tx = X*M(1,1)+Y*M(1,2)+M(1,3);
    ty = X*M(2,1)+Y*M(2,2)+M(2,3);
    gettemplete = interp2(I,tx,ty);            % because the (tx, ty) may not exist in It1/I image,therefore gettemplete may contains NaN 
end