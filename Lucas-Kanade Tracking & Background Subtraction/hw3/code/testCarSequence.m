function [] = testCarSequence()
load('carseq.mat');

rect=[60, 117, 146, 152];
rects=[];
rects=[rects;rect];
for i=1:415-1
    It= im2double(frames(:,:,i));
    It1=im2double(frames(:,:,i+1));
    [u,v] = LucasKanadeInverseCompositional(It, It1, rect);
    rect=rect+[u,v,u,v];
    rects=[rects;rect];
end
save('carseqrects.mat','rects');


sample = [1,100,200,300,415];
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


