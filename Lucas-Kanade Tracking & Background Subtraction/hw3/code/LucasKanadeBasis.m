function [u,v] = LucasKanadeBasis(It, It1, rect, bases)

% input - image at time t, image at t+1, rectangle (top left, bot right
% coordinates), bases 
% output - movement vector, [u,v] in the x- and y-directions.
for i=1:size(bases,3)
    b(:,i)=reshape(bases(:,:,i),numel(bases(:,:,i)),1);
end
landa= bsxfun(@times,b,1./sqrt(sum(b .^ 2))); 

T=gettemplete(It,rect);
[TX,TY] = gradient(T);
A= [reshape(TX,numel(TX),1),reshape(TY,numel(TY),1)];
th_r=0.1;
error=1;
u=0;
v=0;
while sum(error.*error)>th_r
    It1_T=gettemplete(It1,rect+[u,v,u,v]);
    difference=It1_T-T;
    difference=reshape(difference,numel(difference),1);
    omiga= sum(bsxfun(@times,difference,landa),1);
    for j=1:size(bases,3)
    difference=difference- omiga(j)*b(:,j);
    end
    %sum(bsxfun(@times,errorImage,b),2);
    error=A\difference;
    u=u-error(1);
    v=v-error(2);
end

end

function gettemplete = gettemplete(I,rect)
[x,y] = meshgrid(rect(1):1:rect(3)+0.1,rect(2):1:rect(4)+0.1);
gettemplete =interp2(I,x,y);
end