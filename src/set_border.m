function im = set_border(im, width, value)
%{
Sets width-border of 2D image to value.

Inputs:
1. im - m-by-n array representing single-channel image.
2. width - (optional, may be empty) scalar positive int-like, default 1.
3. value - (optional) scalar value of same type as im, default 0.

Outputs:
1. im - m-by-n array representing modified image.
%}

if nargin < 2
    width = [];
end

if nargin < 3
    value = cast(0.0, class(im));
end

if isempty(width)
    width = 1;
end

assert(isnumeric(im) || islogical(im));
assert(ismatrix(im));
sz = size(im);
t = class(im);

assert(isnumeric(width));
assert(isscalar(width));
assert(fix(width) == width);

assert(isnumeric(value) || islogical(value));
assert(isscalar(value));
assert(strcmp(class(value), class(im)));

width = repmat(width, [2 1]);

width(1) = min(width(1), size(im, 1));
width(2) = min(width(2), size(im, 2));

im(1:width(1), :) = value;
im(end-width(1)+1:end, :) = value;
im(:, 1:width(2)) = value;
im(:, end-width(2)+1:end) = value;

assert(ismatrix(im));
assert(all(size(im) == sz));
assert(strcmp(class(im), t));
    
end

