function [ x_n, y_n ] = ANMS( C, N )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

maxC = imregionalmax(C);
C(~maxC) = 0;
[x, y, v] = find(C);
nStrong = numel(x);
N = min([nStrong, N]);
r = Inf(nStrong, 1);
for i = 1:nStrong
    for j = 1:nStrong
        if v(j) > v(i)
            ED = (x(j) - x(i)).^2 + (y(j) - y(i)).^2;
            if ED < r(i)
                r(i) = ED;
            end
        end
    end
end
[~, index] = sort(r, 'descend');
index = index(1:N);
x_n = x(index);
y_n = y(index);

end

