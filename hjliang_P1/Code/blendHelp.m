function [ output ] = blendHelp( laplac1, laplac2, mask )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% depth = numel(laplac1);
% output = cell(1, depth);

output = cellfun(@(x, y, z) cellBlend(x, y, z), laplac1, laplac2, mask, 'UniformOutput', false);

end

function [ output ] = cellBlend( laplac1, laplac2, mask )

output = mask .* laplac1 + (1.0 - mask) .* laplac2;

end

