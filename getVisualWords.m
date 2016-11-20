function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    % TODO Implement your code here
    filterBank= createFilterBank();
    filterResponses=extractFilterResponses(img, filterBank);
    filterResponses=reshape(filterResponses,size(filterResponses,1)*size(filterResponses,2),size(filterResponses,3)*size(filterResponses,4));
    
    dist=pdist2(filterResponses,dictionary');
    [~,wordMap]= min(dist,[],2);

    
     wordMap=reshape(wordMap,[size(img,1) size(img,2)]);
       
end
