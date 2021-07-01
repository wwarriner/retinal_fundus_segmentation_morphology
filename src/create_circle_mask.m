function mask = create_circle_mask(sz, radius, center)
%{
Draws a circle in image coordinates. Origin is top-left corner of image. Values
in the circle are true, otherwise false. Includes points on the circle itself,
i.e. comparison is less-equal.

Inputs:
1. sz - size of output image.
2. radius - radius of circle.
3. center - (optional) center of circle. Default is mid-point implied by sz.

Outputs:
1. mask - logical image containing circular mask
%}

assert(isnumeric(sz));
assert(numel(sz) == 2 | numel(sz) == 3)
assert(all(fix(sz) == sz));
if numel(sz) == 2
    sz = [sz 1];
end

assert(isnumeric(radius));
assert(isscalar(radius));
assert(0 <= radius);

if nargin < 3
    center = sz(1:2) ./ 2;
end
assert(isnumeric(center));
assert(numel(center) == 2);

R = radius;
C = center;

[X, Y] = meshgrid(1 : sz(2), 1 : sz(1));
X = X - C(2);
Y = Y - C(1);
mask = X.^2 + Y.^2 <= R.^2;
mask = repmat(mask, [1 1 sz(3)]);

assert(islogical(mask));
assert(all(size(mask) == sz));

end

