function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../dat/traintest.mat');

	% TODO create train_features
     
    n = length(train_imagenames);
    train_features = zeros(150*(4^3-1)/3,n);

    train_imagenames = strcat('../dat/',train_imagenames);

   for i = 1 : n
   filename = train_imagenames{i};
   disp(['processing ',filename]);
   filename = [filename(1:end-3),'mat'];
   load(filename);
   h = getImageFeaturesSPM(3,wordMap,150);
   
   train_features(:,i) = h;
   end

	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end