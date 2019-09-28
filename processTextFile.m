clear;
addpath('./lib');
pkg load image;

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
[labelImg,numLabel] = bwlabel(bImg,8);
props = regionProps(labelImg);
%DISPLAY IMAGES HERE

% 4. ROTATE THE CHARACTERS ABOUT THEIR CENTER BY -90 DEGREES
newImg_rot_90 = zeros(row,col,'uint8');
for label = 1:numLabel
    cropImg = imgStretch(props(label).BoundingBox(1):props(label).rMax,props(label).cMin:props(label).cMax);
    rotCropImg = imageRotate(cropImg,angle=-90,method='nearestNeighbor');
    [rowCrop,colCrop] = size(cropImg);
    [rowRotCrop,colRotCrop] = size(rotCropImg);
    startRow = int32(props(label).BoundingBox(1) + (props(label).rMax-props(label).BoundingBox(1))/2 - rowRotCrop/2);
    startCol = int32(props(label).cMin + (props(label).cMax-props(label).cMin)/2 - colRotCrop/2);
    newImg_rot_90(startRow:startRow+rowRotCrop-1,startCol:startCol+colRotCrop-1) = rotCropImg;
endfor
%DISPLAY IMAGES HERE

% 5. ROTATE THE CHARACTERS ABOUT THEIR CENTER BY 35 DEGREES
newImg_rot35 = zeros(row,col,'uint8');
for label = 1:numLabel
    cropImg = imgStretch(props(label).BoundingBox(1):props(label).rMax,props(label).cMin:props(label).cMax);
    rotCropImg = imageRotate(cropImg,angle=35,method='bilinear');
    [rowCrop,colCrop] = size(cropImg);
    [rowRotCrop,colRotCrop] = size(rotCropImg);
    startRow = int32(props(label)BoundingBox(1) + (props(label).rMax-props(label)BoundingBox(1))/2 - rowRotCrop/2);
    startCol = int32(props(label).cMin + (props(label).cMax-props(label).cMin)/2 - colRotCrop/2);
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
    if ((props(label).rMax-props(label)BoundingBox(1)+1)>targetRow)
        targetRow = props(label).rMax-props(label)BoundingBox(1)+1;
    endif
endfor
finalImg = [];
for label = {2,1,4,3,6,5}
    cropImg = imgStretch(props(label{1})BoundingBox(1):props(label{1}).rMax,props(label{1}).cMin:props(label{1}).cMax);
    targetCol = int32((props(label{1}).cMax-props(label{1}).cMin+1)*targetRow/(props(label{1}).rMax-props(label{1})BoundingBox(1)+1));
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
