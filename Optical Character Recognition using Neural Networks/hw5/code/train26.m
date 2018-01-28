num_epoch = 30;
classes = 26;
layers = [32*32, 400, classes];
learning_rate = 0.01;

load('../data/nist26_train.mat', 'train_data', 'train_labels');
load('../data/nist26_test.mat', 'test_data', 'test_labels');
load('../data/nist26_valid.mat', 'valid_data', 'valid_labels');

[W, b] = InitializeNetwork(layers);
figure;
weights_visual = zeros(32,32,1,400);
for i=1:400
    weights_visual(:,:,1,i) = reshape(W{1}(i,:),[32,32]);
end
montage(weights_visual,'Size',[20,20]);
title('visualization of weight images before training');


train_acc = zeros(num_epoch,1);
valid_acc = zeros(num_epoch,1);
train_loss = zeros(num_epoch,1);
valid_loss = zeros(num_epoch,1);

for j = 1:num_epoch
    [W, b] = Train(W, b, train_data, train_labels, learning_rate);

    [train_acc(j), train_loss(j)] = ComputeAccuracyAndLoss(W, b, train_data, train_labels);
    [valid_acc(j), valid_loss(j)] = ComputeAccuracyAndLoss(W, b, valid_data, valid_labels);

    fprintf('Epoch %d - accuracy: %.5f, %.5f \t loss: %.5f, %.5f \n', j, train_acc(j), valid_acc(j), train_loss(j), valid_loss(j))
end

figure;
subplot(1,2,1);
plot(1:num_epoch, train_acc, 1:num_epoch, valid_acc);
legend('train accuracy', 'validation accuray', 'Location', 'southeast');
xlabel('number of epochs');
ylabel('accuracy');
title('Accuracy over epochs on training and validation set');
subplot(1,2,2);
plot(1:num_epoch, train_loss, 1:num_epoch, valid_loss);
legend('train loss', 'validation loss');
xlabel('number of epochs');
ylabel('loss');
title('loss over epochs on training and validation set');

save('nist26_model.mat', 'W', 'b')

[test_acc, test_loss] = ComputeAccuracyAndLoss(W, b, test_data, test_labels);
figure;
weights_visual = zeros(32,32,1,400);
for i=1:400
    weights_visual(:,:,1,i) = reshape(W{1}(i,:),[32,32]);
end
montage(weights_visual,'Size',[20,20]);
title('visualization of weight images after training');

figure;
outputs = Classify(W, b, test_data);
confusion_matrix = zeros(26);
for i=1:size(test_labels,1)
    j = find(test_labels(i,:) == 1);
    [~,k] = max(outputs(i,:));
    
    confusion_matrix(j,k)= confusion_matrix(j,k)+1;  
end
imagesc(confusion_matrix);


