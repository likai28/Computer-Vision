function [lines, bw] = findLetters(im)
% [lines, BW] = findLetters(im) processes the input RGB image and returns a cell
% array 'lines' of located characters in the image, as well as a binary
% representation of the input image. The cell array 'lines' should contain one
% matrix entry for each line of text that appears in the image. Each matrix entry
% should have size Lx4, where L represents the number of letters in that line.
% Each row of the matrix should contain 4 numbers [x1, y1, x2, y2] representing
% the top-left and bottom-right position of each box. The boxes in one line should
% be sorted by x1 value.

bw = rgb2gray(im);
bw = im2bw(bw,graythresh(bw));
bw = ~imdilate(~bw, strel('square',9));
connection=bwconncomp(~bw);
connect_pixel=connection.PixelIdxList;
element={};
j=1;

% get rid of small connections
for i=1:length(connect_pixel)
    if length(connect_pixel{i})>800
        element(j)=mat2cell(connect_pixel{i},size(connect_pixel{i},1));
        j=j+1;
    end
end

center= zeros(length(element),2);
position = zeros(length(element),4);

for i=1: length(element)
    [row,column] = ind2sub(size(bw),element{i});
    center(i,:)= mean([row column],1);
    lefttop_x=0.99*min(column);
    lefttop_y=0.99*min(row);
    rightbottom_x=1.01*max(column);
    rightbottom_y=1.01*max(row);
    position(i,:)=[lefttop_y,lefttop_x,rightbottom_y,rightbottom_x];
end

% sorting the elements line by line
[~,index]=sort(center(:,1));
center=center(index,:);
position=position(index,:);

% finding the entry of each line
line_entry=[];
line_entry=[line_entry;1];
for i=2:size(center,1)
    
    if center(i,1)-center(i-1,1)>50
        line_entry=[line_entry;i];
    end
end

lines = cell(1,length(line_entry));
for i=1:length(line_entry)
    if i == length(line_entry)
        t=line_entry(i):size(center,1);
    else
        t=line_entry(i):line_entry(i+1)-1;
    end
    [~,index] = sort(center(t,2));
    line_location = position(t,:);
    lines{i} = line_location(index,:);
end


end