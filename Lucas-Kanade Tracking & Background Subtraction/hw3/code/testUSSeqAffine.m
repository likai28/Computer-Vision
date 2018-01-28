function [] = testUSSeqAffine()

load('usseq.mat');
load('usseqrects.mat')

sample = [5,25,50,75,100];
for i = 1:5
    % avoid matrix dimension exceed problem
    if sample(i)==size(frames,3)   
    
    rect1=frames(rects(sample(i)-1,2):rects(sample(i)-1,4),rects(sample(i)-1,1):rects(sample(i)-1,3),sample(i)-1);
    rect2=frames(rects(sample(i),2):rects(sample(i),4),rects(sample(i),1):rects(sample(i),3),sample(i));
    mask = SubtractDominantMotion(rect1,rect2);
    
    big_mask=zeros(size(frames(:,:,i),1),size(frames(:,:,i),2));
    big_mask(rects(sample(i),2):rects(sample(i),4),rects(sample(i),1):rects(sample(i),3))=mask;
    
    else
    rect1=frames(rects(sample(i),2):rects(sample(i),4),rects(sample(i),1):rects(sample(i),3),sample(i));
    rect2=frames(rects(sample(i)+1,2):rects(sample(i)+1,4),rects(sample(i)+1,1):rects(sample(i)+1,3),sample(i)+1);
    mask = SubtractDominantMotion(rect1,rect2);
    
    big_mask=zeros(size(frames(:,:,i),1),size(frames(:,:,i),2));
    big_mask(rects(sample(i),2):rects(sample(i),4),rects(sample(i),1):rects(sample(i),3))=mask;
    end
    subplot(1,5,i)
    
    imshow(imfuse(frames(:,:,i),frames(:,:,i) .* uint8(big_mask),'falsecolor'));
    title(['Frame ',num2str(sample(i))]);
end
