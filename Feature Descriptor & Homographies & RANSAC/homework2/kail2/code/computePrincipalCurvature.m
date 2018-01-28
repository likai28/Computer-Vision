function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
%%Edge Suppression
% inputs
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%
% outputs
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix where each point contains the curvature ratio R for the 
% 					   corresponding point in the DoG pyramid

        [FX,FY]=gradient(DoGPyramid);
        [FXX,FXY]=gradient(FX);
        [FXY,FYY]=gradient(FY);
        for k=1: size(DoGPyramid,3)
            for i=1:size(DoGPyramid,1)
                for j=1:size(DoGPyramid,2)
                    H=[FXX(i,j,k),FXY(i,j,k);FXY(i,j,k),FYY(i,j,k)];
                    R(i,j,k)= trace(H)*trace(H)/det(H);
                end
            end
        end

        PrincipalCurvature=R;
end

   
        