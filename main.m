function main(root_folder, out_folder, ext, keyword)
%{
Main entry point for segmentation of retinal fundus photographs. Provide a root
folder of photographs and a keyword of images to look for. The images will be
discovered recursively as those with the appropriate extension, and whose names
contain the given keyword. Outputs will be placed as a sibling folder to the
root folder.

Inputs:
1. root_folder - scalar string representing the folder containing fundus photos.
2. out_folder - (optional) scalar string representing the folder to write to.
    Default is named "out" and is a sibling to root_folder.
3. ext - (optional) scalar string representing file extension of photos. Default
    ".tif". 
4. keyword - (optional) scalar string representing search term for photos. Uses
    contains() on full name and extension to locate. Case insensitive. Default
    behavior is to use all images.

Outputs nothing. Writes images to folder called "out" as sibling folder to input
root_folder. Will create all needed folders to write. Does not delete existing
folder. Output files are .png files.

A folder called "review" is also created in the output folder and contains
overlays of the segmentations on the input images.
%}

if nargin < 2
    out_folder = [];
end

if nargin < 3
    ext = [];
end

if nargin < 4
    keyword = "";
end

root_folder = string(root_folder);
assert(isfolder(root_folder));

if isempty(out_folder)
    out_folder = fullfile(root_folder, "..", "out");
end
out_folder = string(out_folder);
assert(isscalar(out_folder));

if isempty(ext)
    ext = ".tif";
end
if ~startsWith(ext, ".")
    ext = "." + ext;
end
ext = string(ext);
assert(isscalar(ext));

keyword = string(keyword);
assert(isscalar(keyword));

extend_search_path();

contents = get_images(root_folder, ext, keyword);
if isempty(contents)
    warning("no images found in %s/*%s", root_folder, ext);
end

opts = read_opts();

review_folder = fullfile(out_folder, "review");
[~, ~] = mkdir(review_folder);

for i = 1 : height(contents)
    row = contents(i, :);
    in_folder = string(row.folder);
    in_name = string(row.name);
    [~, base_name, ~] = fileparts(in_name);
    im_file = fullfile(in_folder, in_name);
    
    subfolder = erase(in_folder, root_folder);
    subfolder = fullfile(out_folder, subfolder);
    [~, ~] = mkdir(subfolder);
    
    rgb = imread(im_file);
    b = segment(rgb, opts);
    
    out_name = strjoin([base_name, "segment"], "_") + ".png";
    out_file = fullfile(subfolder, out_name);
    imwrite(b, out_file);
    
    CYAN = [0.0 1.0 1.0];
    ALPHA = 0.7;
    overlay = composite(im2double(rgb), b, CYAN, ALPHA);
    review_name = strjoin([base_name, "review"], "_") + ".png";
    review_file = fullfile(review_folder, review_name);
    imwrite(overlay, review_file);
end

end


function contents = get_images(root_folder, ext, keyword)

contents = get_contents(root_folder);
contents = get_files_with_extension(contents, ext);

if keyword ~= ""
    has_keyword = contains(...
        string(contents{:, "name"}), keyword, ...
        "ignorecase", true ...
        );
    contents = contents(has_keyword, :);
end

assert(istable(contents));

end