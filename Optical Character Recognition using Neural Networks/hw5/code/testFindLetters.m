im = cell(1,4);
bw = cell(1,4);

im{1} = imread('../images/01_list.jpg');
im{2} = imread('../images/02_letters.jpg');
im{3} = imread('../images/03_haiku.jpg');
im{4} = imread('../images/04_deep.jpg');

for i=1:4
    [lines, bw{i}] = findLetters(im{i});
    figure;
    imshow(im{i});
    for j=1:length(lines)
        for k=1:size(lines{j},1)
            hold on;
              rectangle('Position', [lines{j}(k,2) lines{j}(k,1) lines{j}(k,4)-lines{j}(k,2)...
                lines{j}(k,3)-lines{j}(k,1)], 'EdgeColor', 'red');
        end
    end
end
