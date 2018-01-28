function [] = testUltrasoundSequence()
load('usseq.mat');

rect=[255,105,310,170];
%plot([rect(1),rect(3),rect(3),rect(1),rect(1)],[rect(2),rect(2),rect(4),rect(4),rect(2)],'y');  
rects=[];
rects=[rects;rect];
for i=1:100-1
    
    It= im2double(frames(:,:,i));
    It1=im2double(frames(:,:,i+1));
     
    [u,v] = LucasKanadeInverseCompositional(It, It1, rect);
    rect=rect+[u,v,u,v];
    rects=[rects;rect];
end
save('usseqrects.mat','rects');


sample = [5,25,50,75,100];
figure;
axis equal;
for i = 1:5
    subplot(1,5,i);
    imshow(frames(:,:,sample(i)));
    hold on;
   
    plot([rects(sample(i),1),rects(sample(i),3),rects(sample(i),3),rects(sample(i),1),rects(sample(i),1)],[rects(sample(i),2),rects(sample(i),2),rects(sample(i),4),rects(sample(i),4),rects(sample(i),2)],'y');
    hold off;
    title(['Frame ',num2str(sample(i))]);
end


end


