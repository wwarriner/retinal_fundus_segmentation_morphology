function im = fill_small_holes(im, n)
%{
Fills small background holes in logical image.

Inputs:
1. im - m-by-n logical array representing binary image.
2. n - pixel count of holes to fill. All holes with fewer pixels than n will be
    filled

Outputs:
1. im - m-by-n logical array with holes filled.
%}

assert(islogical(im));
assert(ismatrix(im));
sz = size(im);

assert(isnumeric(n));
assert(isscalar(n));
assert(fix(n) == n);

fill = imfill(im, "holes");
holes = fill & ~im;

big_holes = bwareaopen(holes, n);
small_holes = holes & ~big_holes;

im = im | small_holes;

assert(islogical(im));
assert(ismatrix(im));
assert(all(size(im) == sz));

end