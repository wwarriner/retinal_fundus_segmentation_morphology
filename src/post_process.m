function im = post_process(im, keep, opts)

assert(islogical(im));
assert(ismatrix(im));
sz = size(im);

assert(islogical(keep));
assert(ismatrix(keep));
assert(all(size(keep) == sz));

assert(isstruct(opts));
assert(isfield(opts, "area_open_1"));
assert(isfield(opts, "close_radius"));
assert(isfield(opts, "gauss_radius"));
assert(isfield(opts, "area_open_2"));
assert(isfield(opts, "small_hole_pixels"));

set_border(im, 1, false);

im(~keep) = 0;

im = bwareaopen(im, opts.area_open_1);
im = imclose(im, strel("disk", opts.close_radius));
im = smooth_gaussian(im, opts.gauss_radius);
im = bwareaopen(im, opts.area_open_2);
im = fill_small_holes(im, opts.small_hole_pixels);

assert(islogical(im));
assert(ismatrix(im));
assert(all(size(im) == sz));

end

