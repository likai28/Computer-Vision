function M = LucasKanadeAffine(It, It1)

% input - image at time t, image at t+1 
% output - M affine transformation matrix

M = eye(3);
T= It;
[TX,TY] = gradient(T);
TX=TX(:);
TY=TY(:);

A=zeros(numel(T),6);
[x,y]=meshgrid(1:size(T,2),1:size(T,1));
x=x(:);
y=y(:);

A(:,1)=x.*TX;
A(:,2)=y.*TX;
A(:,3)=TX;
A(:,4)=x.*TY;
A(:,5)=y.*TY;
A(:,6)=TY;

th_r=0.1;
error=1;

p=zeros(6,1);
while sum(error.*error)>th_r
    
    It1_T=gettemplete(It1,M);
    difference=It1_T-T;
    difference=reshape(difference,numel(difference),1);
    error=A(~isnan(difference),:)\difference(~isnan(difference));
    %error=A\difference;
    
    p=p-error;
   % dM=[1+error(1),error(2),error(3);error(4),1+error(5),error(6);0,0,1];
   % M=dM\M;     
    M=[1+p(1),p(2),p(3);p(4),1+p(5),p(6);0,0,1];
end

   
function gettemplete = gettemplete(I,M)
    s = size(I);
    [X,Y] = meshgrid(1:s(2),1:s(1));
    tx = X*M(1,1)+Y*M(1,2)+M(1,3);
    ty = X*M(2,1)+Y*M(2,2)+M(2,3);
    gettemplete = interp2(I,tx,ty);            % because the (tx, ty) may not exist in It1/I image,therefore gettemplete may contains NaN 
end

end



