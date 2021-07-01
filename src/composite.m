function image = composite(image, mask, color, alpha)
%{
Alpha composites a logical mask onto an image. Any region not masked is left
unchanged.

Inputs:
1. image - m-by-n-by-c rgb, grayscale, or binary image of any type.
2. mask - m-by-n logical mask image.
3. color - 3 vector of doubles in [0.0, 1.0] representing an RGB color.
4. alpha - scalar double in [0.0, 1.0] representing the alpha level of the mask.

Output:
1. image - m-by-n-by-c image of same class as input, with mask composited.
%}

assert(isnumeric(image) | islogical(image));
t = class(image);
sz = size(image, 1:2);
im_sz = size(image);

assert(islogical(mask));
assert(ismatrix(mask));
assert(all(size(mask) == sz));

assert(isa(color, "double"));
assert(numel(color) == 3);
assert(all(0.0 <= color));
assert(all(color <= 1.0));

assert(isa(alpha, "double"));
assert(isscalar(alpha));
assert(0.0 <= alpha);
assert(alpha <= 1.0);

mask_rgb = im2double(mask);
mask_rgb = repmat(mask_rgb, [1 1 3]);
mask_rgb = mask_rgb .* reshape(color, [1 1 3]);
mask = logical(mask_rgb);

ai = 1.0;
am = alpha;
a0 = am + ai .* (1 - am);
c0 = image;
c0(mask) = mask_rgb(mask) .* am + image(mask) .* ai .* (1 - am);
c0 = c0 ./ a0;
image = c0;

assert(strcmp(class(image), t));
assert(all(size(image) == im_sz));

end