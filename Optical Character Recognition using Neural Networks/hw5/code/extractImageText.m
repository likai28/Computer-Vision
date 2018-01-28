function [text] = extractImageText(fname)
% [text] = extractImageText(fname) loads the image specified by the path 'fname'
% and returns the next contained in the image as a string.

im= imread(fname);
[lines,bw]=findLetters(im);
load('nist36_model.mat');
text=[];

text_interval= 150;

for i=1:length(lines)
    center_x=(lines{i}(:,2)+lines{i}(:,4))/2;    
    for j=1:size(lines{i},1)
        if j>1
          if center_x(j)-center_x(j-1)>text_interval
            text = [text ' '];
          end
        end        
        element_corners=lines{i}(j,:);
        element_corners=floor(element_corners);
        element_image= bw(max(1,element_corners(1)):min(size(bw,1),element_corners(3)),max(1,element_corners(2)):min(size(bw,2),element_corners(4)));
        element_image=imresize(element_image,[32,32]);
        output = Classify(W, b, element_image(:)');
        [~,index] = max(output(1,:));
        
        if index < 27
            c = char(index+64);
        else
            c = char(index+21);
        end
        text = [text c];
    end
        text = [text '\n'];
end


end
