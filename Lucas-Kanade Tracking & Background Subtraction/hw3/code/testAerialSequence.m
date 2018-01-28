function [] = testAerialSequence()

load('aerialseq.mat');
%n=size(frames,3);
sample = [30,60,90,120];
for i = 1:4
    mask = SubtractDominantMotion(frames(:,:,sample(i)),frames(:,:,sample(i)+1));
    subplot(1,4,i)
    imshow(imfuse(frames(:,:,sample(i)),frames(:,:,sample(i)) .* uint8(~mask),'falsecolor'));
    title(['Frame ',num2str(sample(i))]);
end

