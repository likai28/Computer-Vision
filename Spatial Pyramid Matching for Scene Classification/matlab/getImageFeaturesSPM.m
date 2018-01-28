function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    % TODO Implement your code here
    layerNum=3;
    dictionarySize=150;
    
n = pow2(layerNum-1);
    pixelCount = size(wordMap,1)*size(wordMap,2);
    xborder = size(wordMap,1)*[0:n] / n;
    xborder = floor(xborder);
    yborder = size(wordMap,2)*[0:n] / n;
    yborder = floor(yborder);
    hist = zeros(dictionarySize,1);
    h = [];
    hlayer = cell(layerNum,1);
    for i = 1 : n 
        for j = 1 : n
            patch = wordMap(xborder(i)+1:xborder(i+1),yborder(j)+1:yborder(j+1));
            for c = 1 : dictionarySize
                hist(c) = sum(sum(patch == c));
            end
            hlayer{1} = [hlayer{1},hist];
        end
    end
    
    for layer = 2 : layerNum
        prelayer = hlayer{layer-1};
        n = n / 2;
        for i = 1 : n
            for j = 1 : n
                hist = prelayer(:,((2*i-2)*2*n)+2*j-1);
                hist = hist + prelayer(:,((2*i-2)*2*n)+2*j);
                hist = hist + prelayer(:,((2*i-1)*2*n)+2*j);
                hist = hist + prelayer(:,((2*i-1)*2*n)+2*j-1);
                hlayer{layer} = [hlayer{layer},hist];
            end
        end
    end
    
   h = hlayer{layerNum};
    
    for layer = layerNum-1 : -1 : 1
       h1 = hlayer{layer};
       h = [h;reshape(h1,[numel(h1),1])];
       h = h / 2;
    end
    h = h / pixelCount;

end