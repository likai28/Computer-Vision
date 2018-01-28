function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('..\dat\traintest.mat');

	% TODO Implement your code here
    
    test_imagenames = strcat('../dat/',test_imagenames);
    load('..\dat\traintest.mat','mapping');

    confusionMatrix = zeros(length(mapping),length(mapping));
    wrongInstance = {};
    
    for i = 1:length(test_imagenames)
    imagename = test_imagenames{i};
    image = im2double(imread(imagename));
    % imshow(image);
    fprintf(['[Getting Visual Words for ',imagename,'..]\n']);
    wordMap = getVisualWords(image, filterBank, dictionary);
    
    h = getImageFeaturesSPM( 3, wordMap, size(dictionary,2));
    %h = getImageFeatures(wordMap,size(dictionary,2));
    distances = distanceToSet(h, train_features);
    [~,nnI] = max(distances);
    guess_label = train_labels(nnI);
    confusionMatrix(test_labels(i),guess_label) = confusionMatrix(test_labels(i),guess_label) + 1;
    if (guess_label ~= test_labels(i))
        wrongInstance = [wrongInstance;[i,test_labels(i),guess_label]];
    end
    fprintf('[My Guess]:%d.\n',guess_label);
    end

    fprintf('[Accuracy]:%.3f\n',trace(confusionMatrix) / sum(confusionMatrix(:)));
   
    save mydata confusionMatrix;
     colormap('gray');
    imagesc(confusionMatrix);

end