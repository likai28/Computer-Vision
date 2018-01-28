function [ F ] = ransacF( pts1, pts2, M )
% ransacF:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.X - Extra Credit:
%     Implement RANSAC
%     Generate a matrix F from some '../data/some_corresp_noisy.mat'
%          - using sevenpoint
%          - using ransac

%     In your writeup, describe your algorith, how you determined which
%     points are inliers, and any other optimizations you made

N = size(pts1, 1);
t = 5e-2;

while (true)
    inlier=[];
    inlierNum = 0;
    temp=randperm(N,7);
    p_1 = pts1(temp, :);
    p_2 = pts2(temp, :);
    F = sevenpoint( p_1, p_2, M );

    for j = 1:N
        l = F * [pts1(j, 1); pts1(j, 2); 1]; 
        dist = [pts2(j, 1) pts2(j, 2) 1] * l / sqrt(sum(l.*l));
        if abs(dist) < t
            inlierNum = inlierNum + 1;
            inlier=[inlier;j];
        end
    end

    if inlierNum / N > 0.75
        break;
    end
end
bestinlier=inlier;
F=eightpoint(pts1(bestinlier,:),pts2(bestinlier,:),M);
        