function [ list, flags, h_list ] = dfs( root, links, flags, H )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
imagesNum = size(links, 1);
indexStack = ones(1, imagesNum);
h = cell(1, imagesNum);
h{root} = eye(3);
ptr = 1;
flags(root) = 1;
list = zeros(1, imagesNum);
h_list = cell(1, imagesNum);
count = 0;

while ptr > 0
    % pop
    index = indexStack(ptr);
    ptr = ptr - 1;
    count = count + 1;
    list(count) = index;
    h_list{count} = h{index};
    % find unexplored linked nodes
    linkIndexs = find((links(index, :) & (~flags)));
    for i = 1:numel(linkIndexs)
        nextIndex = linkIndexs(i);
        % push
        ptr = ptr + 1;
        indexStack(ptr) = nextIndex;
        
        flags(nextIndex) = 1;
        h{nextIndex} = h{index} * H{index, nextIndex};
    end
end

list = list(1:count);
h_list = h_list(1:count);

end

