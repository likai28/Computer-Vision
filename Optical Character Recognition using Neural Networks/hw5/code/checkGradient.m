function error_W = checkGradient(W,b,X, Y) 

delta=1e-4;

for i=1:length(W)
    
    W_temp=W{i};
    row=randperm(size(W{i},1),1);
    column=randperm(size(W{i},2),1);
    W{i}(row,column)= W{i}(row,column)+delta;
    [~, loss_plus] = ComputeAccuracyAndLoss(W, b, X', Y');
    W{i}=W_temp;
    W{i}(row,column)=W{i}(row,column)-delta;
    [~, loss_minus] = ComputeAccuracyAndLoss(W, b, X', Y');
    grad_num_W(i)= (loss_plus-loss_minus)/(2*delta);
    W{i}=W_temp;
    [~, act_h, act_a] = Forward(W, b, X);
    [grad_W, ~] = Backward(W, b, X, Y, act_h, act_a);
    grad_back_W(i)=grad_W{i}(row,column);
    error_W(i)= abs(grad_back_W(i)-grad_num_W(i));
    
end
    
    
    