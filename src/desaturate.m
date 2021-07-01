function gy = desaturate(rgb, weights)
%{
Converts rgb image to grayscale by weighted average of channels.

Inputs:
1. rgb - m-by-n-by-3 double array in [0.0, 1.0].
2. weights - (optional) 3-element real, finite, double vector. Default is all
    ones.

Outputs:
1. gy - m-by-n double array in [0.0, 1.0] representing desaturated version of
    rgb.
%}

if nargin < 2
    weights = ones(1, 1, 3);
end

assert(isa(rgb, "double"));
assert(ndims(rgb) == 3);
assert(size(rgb, 3) == 3);

assert(isa(weights, "double"));
assert(isreal(weights));
assert(all(isfinite(weights)));
assert(numel(weights) == 3);

sz = size(rgb);

weights = reshape(weights, [1 1 3]);
rgb = rgb .* weights;
r = rgb(:, :, 1);
g = rgb(:, :, 2);
b = rgb(:, :, 3);
gy = rescale(r + g + b);

assert(isa(gy, "double"));
assert(ismatrix(gy));
assert(all(size(gy) == sz(1:2)));

end

