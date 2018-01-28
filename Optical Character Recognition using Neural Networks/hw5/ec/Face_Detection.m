num_epoch = 5;
classes = 4;
layers = [64*64,400,200,100,classes];
learning_rate = 0.01;

load('../data/faces_data.mat','data')
load('../data/faces_labels.mat','labels')
% normalize the data 
data=data/255;
labels=labels/64;
[W, b] = InitializeNetwork(layers);
train_loss=[];

for j = 1:num_epoch

    [W, b] = FaceTrain(W, b, data, labels, learning_rate);
    [loss] = FaceComputeLoss(W, b, data,labels); 
    train_loss=[train_loss,loss];
    fprintf('Epoch %dloss: %.5f \n', j,train_loss)
end


plot(1:num_epoch,train_loss)
xlabel('Number of Epochs') 
ylabel('Loss')
title('Face Detection Loss on epochs')

save('Face_Detection.mat', 'W', 'b')
