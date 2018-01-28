function [h] = getImageFeatures(wordMap, dictionarySize)
% Compute histogram of visual words
% Inputs:
% 	wordMap: WordMap matrix of size (h, w)
% 	dictionarySize: the number of visual words, dictionary size
% Output:
%   h: vector of histogram of visual words of size dictionarySize (l1-normalized, ie. sum(h(:)) == 1)

	% TODO Implement your code here
  %  wordMap=reshape(wordMap,size(wordMap,1)*size(wordMap,2),1);
  %  h=hist(wordMap(:),dictionarySize);
  %  h=h/norm(h,1);
  %  h=h';
  
  
  
  h = zeros(dictionarySize,1);
    for i = 1 : dictionarySize
        h(i) = sum(sum(wordMap == i));
    end
   % h = h / sum(h);
	assert(numel(h) == dictionarySize);
end