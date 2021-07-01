function [im, keep] = preprocess(im, opts)

assert(isnumeric(im));
assert(size(im, 3) == 3);
sz = size(im, 1:2);

assert(isstruct(opts));
assert(isfield(opts, "radius"));
assert(isfield(opts, "desaturate_weights"));

im = im2double(im);
im = rescale(im);
keep = create_circle_mask(size(im), opts.radius);
im(~keep) = 0.0;
im = desaturate(im, opts.desaturate_weights);
keep = keep(:, :, 1);

assert(isnumeric(im));
assert(ismatrix(im));
assert(all(size(im) == sz));

assert(islogical(keep));
assert(ismatrix(keep));
assert(all(size(keep) == sz));

end

