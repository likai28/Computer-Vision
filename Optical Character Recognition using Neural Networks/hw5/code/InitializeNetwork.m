function [W, b] = InitializeNetwork(layers)
% InitializeNetwork([INPUT, HIDDEN1, HIDDEN2, ..., OUTPUT]) initializes the weights and biases
% for a fully connected neural network with input data size INPUT, outt datpua
% size OUTPUT, and in between are the number of hidden units in each of the layers.
% It should return the cell arrays 'W' and 'b' which contain the randomly
% initialized weights and biases for this neural network.

n=length(layers)-1;
W={};
b={};

for i=1:n
    w=rand(layers(i+1),layers(i))-0.5;      % make initial W accord with normal distrinbution around 0.
    W(i)=mat2cell(w,layers(i+1),layers(i));
%     b_1=rand(layers(i+1),1);
%     b(i)=mat2cell(b_1,layers(i+1),1);
    b{i} = zeros(layers(i+1),1);           %make initial b all be 0
end


end
