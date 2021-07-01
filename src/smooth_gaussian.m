function im = smooth_gaussian(im, window_size)
%{
Smooths binary image boundaries by blurring and thresholding.

Inputs:
1. im - m-by-n logical array representing binary image.
2. window_size - scalar int-like double representing gaussian kernel window
    size.

Output:
1. im - m-by-n logical array with smoothed boundaries.
%}

assert(islogical(im));
assert(ismatrix(im));
sz = size(im);

assert(isnumeric(window_size));
assert(isscalar(window_size));
assert(fix(window_size) == window_size);
assert(0 < window_size);

kernel = ones(window_size) / (window_size .^ 2);
im = conv2(single(im), kernel, "same");
im = 0.5 < im;

assert(islogical(im));
assert(ismatrix(im));
assert(all(size(im) == sz));
    
end

