load('Face_Detection.mat', 'W', 'b')
load('../data/faces_data.mat','data')

image_selected=835;
X=data(image_selected,:);
X=X/255;
im1=reshape(X,64,64);

imshow(im1);
[output,~,~] = FaceForward(W, b, X');
output=output*64;
hold on
rectangle('Position', [output(1) output(2) output(3) output(4)], 'EdgeColor', 'red');
