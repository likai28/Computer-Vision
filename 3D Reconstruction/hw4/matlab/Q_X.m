
% first get the correspondences and colors
load('../data/intrinsics.mat', 'K1', 'K2');
load('q2_1.mat', 'F');
load('q2_5.mat', 'M2');
M1 = [eye(3), [0; 0; 0]];
im1 = imread('../data/im1.png'); % the temple pictures
im2 = imread('../data/im2.png');
im1Gray = im2double(rgb2gray(im1));
im1Gray(im1Gray < 0.2) = 0;
im2Gray = im2double(rgb2gray(im2));
im2Gray(im2Gray < 0.2) = 0;

p1 = zeros(0, 2);
allpixelcolors = zeros(0, 3);
for x = 1:size(im1, 2)
    for y = 1:size(im1, 1)
        if im1Gray(y, x) ~= 0
            p1 = [p1; [x, y]];
            allpixelcolors = [allpixelcolors; reshape(im1(y,x,:), 1, 3)];
        end
    end
end

size(p1, 1)
%% Compute P
numPixels = size(p1(:));

p2 = zeros(size(p1));
for i = 1:size(p1,1)
    i / size(p1,1)
    [x2, y2] = epipolarCorrespondence(im1, im2, F, p1(i, 1), p1(i, 2));
    p2(i, :) = [x2, y2];
end

[P, ~] = triangulate(K1 * M1, p1, K2 * M2, p2);
scatter3(P(:,1), P(:,2), P(:,3)); axis equal;

%% Visualization of the cloud
ptCloud = pointCloud(P, 'Color', allpixelcolors);

% Visualize the point cloud
pcshow(ptCloud, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', ...
    'MarkerSize', 500);

% Rotate and zoom the plot
camorbit(0, -30);
camzoom(1.5);

% Label the axes
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis')

title('Up to Scale Reconstruction of the Scene');
