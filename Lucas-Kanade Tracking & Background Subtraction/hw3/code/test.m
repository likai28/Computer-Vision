function [ u,v ] = test( It,It1,rect)
%This code is slighly modified to be compatable to the EC part, but still
%can be used normally.

    u = 0;
    v = 0;
    th = 0.15;
    ref = interpoI(It,rect);
    [gx,gy] = gradient(ref);
    A = [reshape(gx,numel(gx),1),reshape(gy,numel(gy),1)];
    d = 1;
    
    while sum(d.*d) > th
    	errorImage = interpoI(It1,rect+[u,v,u,v]);
        errorImage = errorImage - ref;
    	errorImage = reshape(errorImage,numel(errorImage),1);
    	d = A\errorImage;	
    	u = u - d(1);
    	v = v - d(2);
    end
end

function interpoI = interpoI(I,rect)
    [x,y] = meshgrid(rect(1):1:rect(3)+0.1,rect(2):1:rect(4)+0.1);
    interpoI = interp2(I,x,y);
end
