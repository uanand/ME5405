%clear;
addpath('./lib');
pkg load image

% READING AND PROCESSING BITMAP IMAGE
%img = imread('charact2.bmp');
%img = img(:,:,1);
%[row,col] = size(img);

% SEGMENT THE CHARACTERS IN THE IMAGE
%imgBlur_6 = imsmooth(img,'Gaussian',sigma=6);
%imgBlur_1 = imsmooth(img,'Gaussian',sigma=1);
%[bImg_6,th_6] = threshold(imgBlur_6,method='otsu');
%[bImg_1_adaptive,th_1_adaptive] = thresholdAdaptive(imgBlur_1,method='mean',kernelSize=45);
%bImg = and(bImg_6,bImg_1_adaptive);
%bImg = binaryMorphology(bImg,method='open',kernelSize=5);
%bImg = binaryMorphology(bImg,method='close',kernelSize=3);
%bImg = particleAreaFilter(bImg,minArea=1000);
%[labelImg,numLabel] = bwlabel(bImg,8);
%props = regionProps(labelImg);

width = [];
for label = 1:numLabel
    width = [width props(label).Width];
endfor
medianWidth = median(width);
stdWidth = std(width);
for label = 1:numLabel
    if (props(label).Width > medianWidth+stdWidth)
        bImg(props(label).BoundingBox(1):props(label).BoundingBox(2),props(label).Centroid(2)-1:props(label).Centroid(2)+1) = 0;
    endif
endfor
[labelImg,numLabel] = bwlabel(bImg,8);
props = regionProps(labelImg);

% ROTATE THE CHARACTERS BY -90 DEGRESS
newImg = zeros(row,col,'uint8');


