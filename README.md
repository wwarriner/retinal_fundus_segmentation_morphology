# Retinal Fundus Segmentation

Retinal fundus photograph segmentation using image analysis and morphology techniques, written in MATLAB.

# Usage

Two entry points are provided.
1. `main.m` - Provide input and output folders, file extension and keyword to   automatically locate and batch-process multiple photos. Uses `segment.m` internally.
2. `segment.m` - Provide rgb image data and opts struct of options to process a single image. See `res/opts.json` for list of options.
