clear;
addpath('./lib');
pkg load image;

%1. READ AND DISPLAY THE TEXT IMAGE
textImg = fileread('charact1.txt');
img = textTOascii(textImg);
imgStretch = stretchContrast(img);
[row,col] = size(img);
imshow(img); input('Press enter to continue');

% 2. THRESHOLD THE IMAGE USING THE MEAN INTENSITY VALUE
[bImg,th] = threshold(img,'mean');
imshow(bImg); input('Press enter to continue');

% 3. SEGMENT ALL THE PARTICLES FORM ORIGINAL IMAGE
[labelImg,numLabel] = bwlabel(bImg,8);
props = regionProps(labelImg);
for label = 1:numLabel
    cropImg = img(props(label).BoundingBox(1):props(label).BoundingBox(2),props(label).BoundingBox(3):props(label).BoundingBox(4));
    imshow(cropImg); input('Press enter to continue');
end

% 4. ROTATE THE CHARACTERS ABOUT THEIR CENTER BY -90 DEGREES
newImg_rot_90 = zeros(row,col,'uint8');
for label = 1:numLabel
    cropImg = img(props(label).BoundingBox(1):props(label).BoundingBox(2),props(label).BoundingBox(3):props(label).BoundingBox(4));
    rotCropImg = imageRotate(cropImg,-90,'nearestNeighbor');
    [rowCrop,colCrop] = size(cropImg);
    [rowRotCrop,colRotCrop] = size(rotCropImg);
    startRow = int32(props(label).Centroid(1) - rowRotCrop/2);
    startCol = int32(props(label).Centroid(2) - colRotCrop/2);
    newImg_rot_90(startRow:startRow+rowRotCrop-1,startCol:startCol+colRotCrop-1) = rotCropImg;
end
imshow(newImg_rot_90); input('Press enter to continue');

% 5. ROTATE THE CHARACTERS ABOUT THEIR CENTER BY 35 DEGREES
newImg_rot35 = zeros(row,col,'uint8');
for label = 1:numLabel
    cropImg = img(props(label).BoundingBox(1):props(label).BoundingBox(2),props(label).BoundingBox(3):props(label).BoundingBox(4));
    rotCropImg = imageRotate(cropImg,35,'nearestNeighbor');
    [rowCrop,colCrop] = size(cropImg);
    [rowRotCrop,colRotCrop] = size(rotCropImg);
    startRow = int32(props(label).Centroid(1) - rowRotCrop/2);
    startCol = int32(props(label).Centroid(2) - colRotCrop/2);
    newImg_rot35(startRow:startRow+rowRotCrop-1,startCol:startCol+colRotCrop-1) = rotCropImg;
end
imshow(newImg_rot35); input('Press enter to continue');

% 6. FIND THE OUTLINE OF SEGMENTED CHARACTERS
bImgBdry = boundary(bImg);
imshow(bImgBdry); input('Press enter to continue');

% 7. FIND THE SKELETON OF SEGMENTED CHARACTERS
bImgSkeleton = skeleton(bImg);
imshow(bImgSkeleton); input('Press enter to continue');

% 8. SCALE AND DISPLAY CHARACTERS 1A2B3C IN SEQUENCE
targetRow = 0;
for label = 1:numLabel
    if (props(label).Height>targetRow)
        targetRow = props(label).Height;
    end
end
finalImg = [];
for label = {2,1,4,3,6,5}
    cropImg = img(props(label{1}).BoundingBox(1):props(label{1}).BoundingBox(2),props(label{1}).BoundingBox(3):props(label{1}).BoundingBox(4));
    targetCol = int32(props(label{1}).Width * targetRow / props(label{1}).Height);
    cropImgScale = imageScale(cropImg,targetRow,targetCol,'bilinear');
    finalImg = [finalImg cropImgScale];
end
imshow(finalImg); input('Press enter to continue');

% PLOTTING ALL THE IMAGES TOGETHER
subplot(2,4,1), imshow(img)
subplot(2,4,2), imshow(imgStretch)
subplot(2,4,3), imshow(bImg)
subplot(2,4,4), imshow(newImg_rot_90)
subplot(2,4,5), imshow(newImg_rot35)
subplot(2,4,6), imshow(bImgBdry)
subplot(2,4,7), imshow(bImgSkeleton)
subplot(2,4,8), imshow(finalImg)

% PARTICLE LABELS FOR CORRESPONDING ALPHABETS AND DIGITS
% 1 - A
% 2 - 1
% 3 - B
% 4 - 2
% 5 - C
% 6 - 3
% 1 A 2 B 3 C
% 2 1 4 3 6 5
