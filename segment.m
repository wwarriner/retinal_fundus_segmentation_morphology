function b = segment(rgb, opts)
%{
Segments an RGB fundus photo. Read opts file from "res/opts.json" using read_opts().

Inputs:
1. rgb - m-by-n-by-c double array in [0.0, 1.0] representing color fundus
    photograph.
2. opts - scalar struct with options listed in "res/opts.json".

Outputs:
1. b - m-by-n logical array representing segmented vessels of rgb.
%}

[gy, keep] = preprocess(rgb, opts);
aa = process(gy, opts);
b = post_process(aa, keep, opts);

end

