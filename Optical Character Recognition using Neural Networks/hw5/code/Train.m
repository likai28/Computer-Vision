function [W, b] = Train(W, b, train_data, train_label, learning_rate)
% [W, b] = Train(W, b, train_data, train_label, learning_rate) trains the network
% for one epoch on the input training data 'train_data' and 'train_label'. This
% function should returned the updated network parameters 'W' and 'b' after
% performing backprop on every data sample.


% This loop template simply prints the loop status in a non-verbose way.
% Feel free to use it or discard it
r=randperm(size(train_data,1),size(train_data,1))';
train_data = train_data(r,:);
train_label=train_label(r,:);

for i = 1:size(train_data,1)
 X=train_data(i,:)';
[~, act_h, act_a] = Forward(W, b, X);
Y=train_label(i,:)';
[grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a);
[W, b] = UpdateParameters(W, b, grad_W, grad_b, learning_rate);
% 
%     if mod(i, 100) == 0
%         fprintf('Done %.2f %% \n', i/size(train_data,1)*100)
%     end
end



end
