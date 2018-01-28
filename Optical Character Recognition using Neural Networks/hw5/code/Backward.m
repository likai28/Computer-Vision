function [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a)
% [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a) computes the gradient
% updates to the deep network parameters and returns them in cell arrays
% 'grad_W' and 'grad_b'. This function takes as input:
%   - 'W' and 'b' the network parameters
%   - 'X' and 'Y' the single input data sample and ground truth output vector,
%     of sizes Nx1 and Cx1 respectively
%   - 'act_a' and 'act_h' the network layer pre and post activations when forward
%     forward propogating the input smaple 'X'
n=length(act_a);
output= exp(act_a{n})/sum(exp(act_a{n}));
delta{n}=output-Y;

for i=n-1:-1:1
    delta{i}=W{i+1}'*delta{i+1}.*act_h{i}.*(1-act_h{i});
end

for j=n:-1:1
    if j ~=1
    grad_W{j}=delta{j}*act_h{j-1}';
    grad_b{j}=delta{j};
    else
    grad_W{1} = delta{1} * X';
    grad_b{1} = delta{1};
    end
end



end
