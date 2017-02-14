function [ list, flags, h_list ] = bfs( root, links, flags, H )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
imagesNum = size(links, 1);
indexQueue = ones(1, imagesNum);
indexQueue(1) = root;
h = cell(1, imagesNum);
h{root} = eye(3);
ptr = 1;
flags(root) = 1;
list = zeros(1, imagesNum);
h_list = cell(1, imagesNum);
h_list{1} = eye(3);
count = 1;

while ptr <= count
    % pop
    index = indexQueue(ptr);
    list(ptr) = index;
    h_list{ptr} = h{index};
    ptr = ptr + 1;
    flags(index) = 1;
    % find unexplored linked nodes
    linkIndexs = find((links(index, :) & (~flags)));
    for i = 1:numel(linkIndexs)
        nextIndex = linkIndexs(i);
        % push
        count = count + 1;
        indexQueue(count) = nextIndex;
        
        flags(nextIndex) = 1;
        h{nextIndex} = h{index} * H{index, nextIndex};
        h{nextIndex} = h{nextIndex} ./ h{nextIndex}(3, 3);
    end
end

list = list(1:count);
h_list = h_list(1:count);

end

