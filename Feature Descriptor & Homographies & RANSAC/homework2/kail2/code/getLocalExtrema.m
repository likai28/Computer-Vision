function locs = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature,th_contrast, th_r)
%%Detecting Extrema
% inputs
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
% DoG Levels
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix contains the curvature ratio R
% th_contrast - remove any point that is a local extremum but does not have a DoG response magnitude above this threshold
% th_r - remove any edge-like points that have too large a principal curvature ratio
% output
% locs - N x 3 matrix where the DoG pyramid achieves a local extrema in both scale and space, and also satisfies the two thresholds.


       %  if grad_DoG_x(i,j,k)==0&&grad_DoG_y(i,j,k)==0&&(DoGPyramid(i,j,k)==max(DoGPyramid(i,j,:)))&& DoGPyramid(i,j,k)>th_contrast&& PrincipalCurvature(i,j,k)<th_r
       x=[];   % x represent column
       y=[];   % y represent row
       lev=[];
       for k=1:size(DoGPyramid,3)
       for i=2:(size(DoGPyramid,1)-1)
         for j=2:(size(DoGPyramid,2)-1)
             temp_matrix=[DoGPyramid(i-1,j-1,k),DoGPyramid(i-1,j,k),DoGPyramid(i,j-1,k),DoGPyramid(i,j,k),DoGPyramid(i+1,j+1,k),DoGPyramid(i+1,j,k),DoGPyramid(i,j+1,k),DoGPyramid(i+1,j-1,k),DoGPyramid(i-1,j+1,k)];
            
             if k==1
               if (DoGPyramid(i,j,k)==max(temp_matrix)&&DoGPyramid(i,j,k)>=DoGPyramid(i,j,k+1)&&abs(DoGPyramid(i,j,k))>th_contrast&&abs(PrincipalCurvature(i,j,k)<th_r))||(DoGPyramid(i,j,k)==min(temp_matrix)&&DoGPyramid(i,j,k)<=DoGPyramid(i,j,k+1)&&abs(DoGPyramid(i,j,k))>th_contrast&&abs(PrincipalCurvature(i,j,k))<th_r)
                 x=[x;j];
                 y=[y;i];
                 lev=[lev;k];
               end
             else if k==size(DoGPyramid,3)
               if (DoGPyramid(i,j,k)==max(temp_matrix)&&DoGPyramid(i,j,k)>=DoGPyramid(i,j,k-1)&&abs(DoGPyramid(i,j,k))>th_contrast&&abs(PrincipalCurvature(i,j,k)<th_r))||(DoGPyramid(i,j,k)==min(temp_matrix)&&DoGPyramid(i,j,k)<=DoGPyramid(i,j,k-1)&&abs(DoGPyramid(i,j,k))>th_contrast&&abs(PrincipalCurvature(i,j,k))<th_r)
                 x=[x;j];
                 y=[y;i];
                 lev=[lev;k];
               end
                 else 
                if (DoGPyramid(i,j,k)==max(temp_matrix)&&DoGPyramid(i,j,k)>=DoGPyramid(i,j,k+1)&&DoGPyramid(i,j,k)>=DoGPyramid(i,j,k-1)&&abs(DoGPyramid(i,j,k))>th_contrast&&abs(PrincipalCurvature(i,j,k)<th_r))||(DoGPyramid(i,j,k)==min(temp_matrix)&&DoGPyramid(i,j,k)<=DoGPyramid(i,j,k+1)&&DoGPyramid(i,j,k)<=DoGPyramid(i,j,k-1)&&abs(DoGPyramid(i,j,k))>th_contrast&&abs(PrincipalCurvature(i,j,k))<th_r)
                 x=[x;j];
                 y=[y;i];
                 lev=[lev;k];
                end
                 end
             end
         end
       end
       end
       locs=[x,y,lev];
       
                 
             