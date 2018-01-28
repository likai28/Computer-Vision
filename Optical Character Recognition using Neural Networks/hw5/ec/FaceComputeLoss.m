function [loss] = FaceComputeLoss(W, b, data, labels)

[outputs] =FaceClassify(W, b, data);
n= size(data,1);
loss=0;

for i=1:n
    r=sum((labels(i,:)-outputs(i,:)).^2);
    loss=loss+r;   
end
loss=loss/n;
end