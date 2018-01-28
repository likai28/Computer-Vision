function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.
    filterBank  = createFilterBank();
    
    % TODO Implement your code here
    filter_responses=zeros(200*length(imPaths),108);
    for i=1:length(imPaths)  
     filterResponses=extractFilterResponses(imread(imPaths{i}),filterBank);
     filterResponses=reshape(filterResponses,size(filterResponses,1)*size(filterResponses,2),size(filterResponses,3)*size(filterResponses,4));
     
     p=randperm(size(filterResponses,1),200);       % set alpha=200
     filterResponses=filterResponses(p,:);
     filter_responses((200*i-199):(200*i),:)=filterResponses;
   
    end;
    
    [~, dictionary] = kmeans(filter_responses,150, 'EmptyAction','drop');  % set K =150
     dictionary=dictionary';
   
end
