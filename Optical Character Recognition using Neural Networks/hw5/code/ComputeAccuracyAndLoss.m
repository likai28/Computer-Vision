function [accuracy, loss] = ComputeAccuracyAndLoss(W, b, data, labels)
% [accuracy, loss] = ComputeAccuracyAndLoss(W, b, X, Y) computes the networks
% classification accuracy and cross entropy loss with respect to the data samples
% and ground truth labels provided in 'data' and labels'. The function should return
% the overall accuracy and the average cross-entropy loss.
[outputs] = Classify(W, b, data);
correctness=0;
loss=0;
for i=1:size(data,1)
    [max_value,index]=max(outputs(i,:));
    if labels(i,index)==1
        correctness=correctness+1;
    end
    loss=loss-log(dot(outputs(i,:),labels(i,:)));
end
accuracy = correctness/size(data,1);
loss =loss/size(data,1);
end
