function [] = testUSSequenceWithTemplateCorrection()
load('usseq.mat');

rect=[255,105,310,170];
rects=[];
rects=[rects;rect];
It=im2double(frames(:,:,1));
T1=gettemplete(It,rect);

for i=1:100-1
    
    % computinng pn
    It= im2double(frames(:,:,i));
    It1=im2double(frames(:,:,i+1));
    [u,v] = LucasKanadeInverseCompositional(It, It1, rect); 
    rect=rect+[u,v,u,v];
    % computing pn*
   [TX,TY] = gradient(T1);
   A= [reshape(TX,numel(TX),1),reshape(TY,numel(TY),1)];
   th_r=0.1;
   error=1;
   u_test=0;
   v_test=0;
  while sum(error.*error)>th_r
    It1_T=gettemplete(It1,rect+[u_test,v_test,u_test,v_test]);
    difference=It1_T-T1;
    difference=reshape(difference,numel(difference),1);
    error=A\difference;
    u_test=u_test-error(1);
    v_test=v_test-error(2);
  end
   
   if norm([u;v]-[u_test;v_test])<=1
       rect=rect+[u_test,v_test,u_test,v_test];
       rects=[rects;rect];
   else
       rect=rect;
       rects=[rects;rect];
   end
end
    
save('usseqrects-wcrt.mat','rects');
R= load('usseqrects.mat');      % notice that only by this is not enough, should have next command so that can load R matrix
R=R.rects;

sample = [5,25,50,75,100];
figure;
axis equal;
for i = 1:5
    subplot(1,5,i);
    imshow(frames(:,:,sample(i)));
    hold on;
    
    plot([rects(sample(i),1),rects(sample(i),3),rects(sample(i),3),rects(sample(i),1),rects(sample(i),1)],[rects(sample(i),2),rects(sample(i),2),rects(sample(i),4),rects(sample(i),4),rects(sample(i),2)],'y');
    plot([R(sample(i),1),R(sample(i),3),R(sample(i),3),R(sample(i),1),R(sample(i),1)],[R(sample(i),2),R(sample(i),2),R(sample(i),4),R(sample(i),4),R(sample(i),2)],'g');

    hold off;
    title(['Frame ',num2str(sample(i))]);
end
end

function gettemplete = gettemplete(I,rect)
[x,y] = meshgrid(rect(1):1:rect(3)+0.1,rect(2):1:rect(4)+0.1);
gettemplete =interp2(I,x,y);
end