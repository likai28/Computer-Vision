function [W, b] = FaceTrain(W, b, train_data, train_label, learning_rate)


P=randperm(size(train_data,1))';
for i = 1:size(train_data,1)
    X=train_data(P(i),:);
    X=X';
    [output,act_h,act_a] = FaceForward(W, b,X);
    Y=train_label(P(i),:);
    Y=Y';
    [grad_W, grad_b] = FaceBackward(W, b,X,Y,act_h,act_a);
    [W, b] = UpdateParameters(W, b, grad_W, grad_b,learning_rate);

end

end
