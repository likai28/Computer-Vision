filename = cell(1,4);
text = cell(1,4);
filename{1} = '../images/01_list.jpg';
filename{2} = '../images/02_letters.jpg';
filename{3} = '../images/03_haiku.jpg';
filename{4} = '../images/04_deep.jpg';
for i=1:4
    text{i} = extractImageText(filename{i});
    fprintf([text{i} '\n']);
end