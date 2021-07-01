function im = process(im, opts)

assert(isnumeric(im));
assert(ismatrix(im));
sz = size(im, 1:2);

assert(isstruct(opts));
assert(isfield(opts, "medfilt"));
assert(isfield(opts, "diffuse_iterations"));
assert(isfield(opts, "adaptthresh_window_size"));
assert(isfield(opts, "adaptthresh_t"));

im = adapthisteq(im);
im = medfilt2(im, opts.medfilt);
im = imdiffusefilt(im, "numberofiterations", opts.diffuse_iterations);

im = imtophat(im, strel("disk", 201));
im = imadjust(im);

im = adaptivethreshold(imcomplement(im), opts.adaptthresh_window_size, opts.adaptthresh_t);

assert(islogical(im));
assert(ismatrix(im));
assert(all(size(im) == sz));

end

