clear;
addpath('./lib');
pkg load image

# READING AND PROCESSING BITMAP IMAGE
%img = imread('charact2.bmp');
%img = img(:,:,1);

%scaleImg4 = imresize(img,[200,400],method='bicubic');
%scaleImg = imageScale(rand(20,20),targetRow=50,targetCol=100,method='bicubic');

%imgStretch = stretchContrast(img);
%[imgEq,histEq] = histogramEqualize(img);
%hist = histogram(img);
%[bImg1,th1] = threshold(img,method="median");
%[bImg2,th2] = threshold(img,method="mean");
%[bImg3,th3] = threshold(img,method="otsu");
%[bImg4,th4] = threshold(img,method="maxentropy");

%imwrite(img)

%count = histogram(img,normalize=0);
%[imgHistEq,histEq] = histogramEqualize(img);
%subplot(2,2,1), imshow(img);
%subplot(2,2,2), imshow(imgHistEq);
%subplot(2,2,3), bar(0:255,count);
%subplot(2,2,4), bar(0:255,histEq);

%PROCESSING METHODS FOR IMAGE 2
%1. READ AND DISPLAY THE TEXT IMAGE
textImg = fileread('charact1.txt');
img = textTOascii(textImg);
imgStretch = stretchContrast(img);
[row,col] = size(img);
%DISPLAY IMAGES HERE

% 2. THRESHOLD THE IMAGE USING THE MEAN INTENSITY VALUE
[bImg,th] = threshold(imgStretch,method='mean');
%DISPLAY IMAGES HERE

% 3. SEGMENT ALL THE PARTICLES FORM ORIGINAL IMAGE
[labelImg,numLabel,boundingBox] = particleBoundingBox(bImg);
%DISPLAY IMAGES HERE

% 4. ROTATE THE CHARACTERS ABOUT THEIR CENTER BY -90 DEGREES
newImg_rot_90 = zeros(row,col,'uint8');
for label = 1:numLabel
    cropImg = imgStretch(boundingBox(label).rMin:boundingBox(label).rMax,boundingBox(label).cMin:boundingBox(label).cMax);
    rotCropImg = imageRotate(cropImg,angle=-90,method='nearestNeighbor');
    [rowCrop,colCrop] = size(cropImg);
    [rowRotCrop,colRotCrop] = size(rotCropImg);
    startRow = int32(boundingBox(label).rMin + (boundingBox(label).rMax-boundingBox(label).rMin)/2 - rowRotCrop/2);
    startCol = int32(boundingBox(label).cMin + (boundingBox(label).cMax-boundingBox(label).cMin)/2 - colRotCrop/2);
    newImg_rot_90(startRow:startRow+rowRotCrop-1,startCol:startCol+colRotCrop-1) = rotCropImg;
endfor
%DISPLAY IMAGES HERE

% 5. ROTATE THE CHARACTERS ABOUT THEIR CENTER BY 35 DEGREES
newImg_rot35 = zeros(row,col,'uint8');
for label = 1:numLabel
    cropImg = imgStretch(boundingBox(label).rMin:boundingBox(label).rMax,boundingBox(label).cMin:boundingBox(label).cMax);
    rotCropImg = imageRotate(cropImg,angle=35,method='bilinear');
    [rowCrop,colCrop] = size(cropImg);
    [rowRotCrop,colRotCrop] = size(rotCropImg);
    startRow = int32(boundingBox(label).rMin + (boundingBox(label).rMax-boundingBox(label).rMin)/2 - rowRotCrop/2);
    startCol = int32(boundingBox(label).cMin + (boundingBox(label).cMax-boundingBox(label).cMin)/2 - colRotCrop/2);
    newImg_rot35(startRow:startRow+rowRotCrop-1,startCol:startCol+colRotCrop-1) = rotCropImg;
endfor
%DISPLAY IMAGES HERE

% 6. FIND THE OUTLINE OF SEGMENTED CHARACTERS
bImgBdry = boundary(bImg);
%DISPLAY IMAGES HERE

% 7. FIND THE SKELETON OF SEGMENTED CHARACTERS
bImgSkeleton = skeleton(bImg);
% DISPLAY IMAGES HERE

% 8. SCALE AND DISPLAY CHARACTERS 1A2B3C IN SEQUENCE
targetRow = 0;
for label = 1:numLabel
    if ((boundingBox(label).rMax-boundingBox(label).rMin+1)>targetRow)
        targetRow = boundingBox(label).rMax-boundingBox(label).rMin+1;
    endif
endfor
finalImg = [];
for label = {2,1,4,3,6,5}
    cropImg = imgStretch(boundingBox(label{1}).rMin:boundingBox(label{1}).rMax,boundingBox(label{1}).cMin:boundingBox(label{1}).cMax);
    targetCol = int32((boundingBox(label{1}).cMax-boundingBox(label{1}).cMin+1)*targetRow/(boundingBox(label{1}).rMax-boundingBox(label{1}).rMin+1));
    cropImgScale = imageScale(cropImg,targetRow=targetRow,targetCol=targetCol,method='bilinear');
    finalImg = [finalImg cropImgScale];
endfor
%DISPLAY IMAGES HERE

subplot(2,4,1), imshow(img)
subplot(2,4,2), imshow(imgStretch)
subplot(2,4,3), imshow(bImg)
subplot(2,4,4), imshow(newImg_rot_90)
subplot(2,4,5), imshow(newImg_rot35)
subplot(2,4,6), imshow(bImgBdry)
subplot(2,4,7), imshow(bImgSkeleton)
subplot(2,4,8), imshow(finalImg)

% PARTICLE LABELS FOR CORRESPONDING ALPHABETS AND DIGITS
%1 - A
%2 - 1
%3 - B
%4 - 2
%5 - C
%6 - 3
