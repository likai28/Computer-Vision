function [outputs] = FaceClassify(W, b, data)

outputs=[];
for i=1:size(data,1)
    X=data(i,:)';
    [output,~,~] = FaceForward(W, b, X);
    output=output';
    outputs=[outputs;output];  
end
end
