function [locsDoG, GaussianPyramid] = DoGdetector(im, sigma0, k, levels,th_contrast, th_r)

GaussianPyramid = createGaussianPyramid(im, sigma0, k, levels);
[DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels);
PrincipalCurvature = computePrincipalCurvature(DoGPyramid);
locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature,th_contrast, th_r);

displayPyramid(DoGPyramid(:,:,1));
hold;
plot(locsDoG(:,1),locsDoG(:,2),'gx');
