function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W*H x N*3 matrix of filter responses

	% TODO Implement your code here

    if(size(img,3)==1)                % change the dimension of grey picture
      img=repmat(img,[1, 1, 3]);
    else
        img=img;
    end;
        img = RGB2Lab(img);               % use RGB2Lab() function
        
     for i= 1:20
         %filterResponses(:,:,1,i)=imfilter(image(:,:,1),filterBank{i});
         %filterResponses(:,:,2,i)=imfilter(image(:,:,2),filterBank{i});
         %filterResponses(:,:,3,i)=imfilter(image(:,:,3),filterBank{i});
         filter=cell2mat(filterBank((i),1));
         filterResponses(:,:,:,i)=imfilter(img,filter,'symmetric');
        % filterResponses=cat(2,filterResponses,B);
     end;
       %  montage(filterResponses,'Size',[4,5]);  

end
