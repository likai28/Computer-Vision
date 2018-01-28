function [] = testSylvSequence()
load('sylvseq.mat');
load('sylvbases.mat');
rect=[102,62,156,108];
%plot([rect(1),rect(3),rect(3),rect(1),rect(1)],[rect(2),rect(2),rect(4),rect(4),rect(2)],'y');  
rects=[];
rects=[rects;rect];
rect1=[102,62,156,108];
R=[];
R=[R;rect1];

for i=1:451-1
    It= im2double(frames(:,:,i));
    It1=im2double(frames(:,:,i+1));
    [u,v] = LucasKanadeBasis(It, It1, rect,bases);
    rect=rect+[u,v,u,v];
    rects=[rects;rect];
    % using the previous algorithm
    [m,n] = LucasKanadeInverseCompositional(It,It1,rect1);
    rect1=rect1+[m,n,m,n];
    R=[R;rect1];
    
end
save('sylvseqrects.mat','rects');


sample = [2,200,300,350,400];
figure;
axis equal;

for i = 1:5
    subplot(1,5,i);
    imshow(frames(:,:,sample(i)));
    hold on;
   
    plot([rects(sample(i),1),rects(sample(i),3),rects(sample(i),3),rects(sample(i),1),rects(sample(i),1)],[rects(sample(i),2),rects(sample(i),2),rects(sample(i),4),rects(sample(i),4),rects(sample(i),2)],'y');
    plot([R(sample(i),1),R(sample(i),3),R(sample(i),3),R(sample(i),1),R(sample(i),1)],[R(sample(i),2),R(sample(i),2),R(sample(i),4),R(sample(i),4),R(sample(i),2)],'r');
    hold off;
    title(['Frame ',num2str(sample(i))]);
end


end


