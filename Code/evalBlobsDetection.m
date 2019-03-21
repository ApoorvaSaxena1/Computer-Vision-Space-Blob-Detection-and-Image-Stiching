% Evaluation code for image stitching
% Your goal is to implement image stitching with RANSAC 
%
% This code is part of:
%
%   CMPSCI 670: Computer Vision
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji

imageName = 'butterfly.jpg';
numBlobsToDraw = 500;
imName = imageName(1:end-4);

dataDir = fullfile('..','data','blobs');
im = imread(fullfile(dataDir, imageName));


%% Implement the code to detect blobs here
blobs = detectBlobs(im);

%% Draw blobs on the image
drawBlobs(im, blobs, numBlobsToDraw);
title('Blob detection');