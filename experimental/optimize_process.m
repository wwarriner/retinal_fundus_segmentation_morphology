function opts = optimize_process(im, opts)

x0 = opts_to_vec(opts);
[lb, ub] = bounds();
%x = fminsearchbnd(@(x)cost(im, x, opts), x0, lb, ub);
x = ga(@(x)cost(im, x, opts), numel(x0), [], [], [], [], lb, ub);
opts = append_vec_to_opts(x, opts);

end


function [lb, ub] = bounds()

lb = [-1 -1 -1 1 1 -1.0 0];
ub = [1 1 1 25 201 1.0 21];

end


function opts = append_vec_to_opts(x, opts)

opts.desaturate_weights = [x(1) x(2) x(3)];
opts.medfilt = round([x(4) x(4)]);
opts.adaptthresh_window_size = round(x(5));
opts.adaptthresh_t = x(6);
opts.close_radius = round(x(7));

end


function x = opts_to_vec(opts)

%x(1:3) = opts.desaturate_weights;
x(4) = opts.medfilt(1);
x(5) = opts.adaptthresh_window_size;
x(6) = opts.adaptthresh_t;
x(7) = opts.close_radius;

end


function value = cost(im, x, opts)

opts = append_vec_to_opts(x, opts);

[im, keep] = preprocess(im, opts);
im = process(im, opts);
im = post_process(im, keep, opts);

area = sum(im, "all");

b = bwboundaries(im, 8, "holes");
length = 0;
for i = 1 : numel(b)
    boundary = b{i};
    d = diff(boundary, 1);
    d = abs(d);
    d = sum(d, 2);
    d = sqrt(d);
    length = length + sum(d);
end

closed = imclose(im, strel("disk", 10));
closed = imcomplement(im & imcomplement(closed));
thickness = max(bwdist(closed), [], "all");

value = length * thickness / area;

end