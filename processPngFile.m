clear;
addpath('./lib');
pkg load image

% 1. READING AND PROCESSING BITMAP IMAGE
img = imread('charact2.bmp');
img = img(:,:,1);
imgStretch = stretchContrast(img);
[row,col] = size(img);
imshow(img); input('Press enter to continue');

% 2. THRESHOLD THE IMAGE USING THE MEAN INTENSITY VALUE
imgBlur_6 = imsmooth(img,'Gaussian',6);
imgBlur_1 = imsmooth(img,'Gaussian',1);
[bImg_6,th_6] = threshold(imgBlur_6,'otsu');
[bImg_1_adaptive,th_1_adaptive] = thresholdAdaptive(imgBlur_1,'mean',45);
bImg = and(bImg_6,bImg_1_adaptive);
bImg = binaryMorphology(bImg,'open',5);
bImg = binaryMorphology(bImg,'close',3);
bImg = particleAreaFilter(bImg,1000,1e10);
[labelImg,numLabel] = bwlabel(bImg,8);
props = regionProps(labelImg);
width = [];
for label = 1:numLabel
    width = [width props(label).Width];
end
medianWidth = median(width);
stdWidth = std(width);
for label = 1:numLabel
    if (props(label).Width > medianWidth+stdWidth)
        bImg(props(label).BoundingBox(1):props(label).BoundingBox(2),props(label).Centroid(2)-1:props(label).Centroid(2)+1) = 0;
    end
end
imshow(bImg); input('Press enter to continue');

% 3. SEGMENT ALL THE PARTICLES FORM ORIGINAL IMAGE
[labelImg,numLabel] = bwlabel(bImg,8);
props = regionProps(labelImg);
for label = 1:numLabel
    cropImg = img(props(label).BoundingBox(1):props(label).BoundingBox(2),props(label).BoundingBox(3):props(label).BoundingBox(4));
    imshow(cropImg); input('Press enter to continue');
end

% 4a. ROTATE THE CHARACTERS ABOUT THEIR CENTER BY -90 DEGREES
newImg_rot_90_a = zeros(row,col,'uint8');
for label = 1:numLabel
    cropImg = img(props(label).BoundingBox(1):props(label).BoundingBox(2),props(label).BoundingBox(3):props(label).BoundingBox(4));
    rotCropImg = imageRotate(cropImg,angle=-90,method='nearestNeighbor');
    [rowCrop,colCrop] = size(cropImg);
    [rowRotCrop,colRotCrop] = size(rotCropImg);
    startRow = int32(props(label).Centroid(1) - rowRotCrop/2);
    startCol = int32(props(label).Centroid(2) - colRotCrop/2);
    newImg_rot_90_a(startRow:startRow+rowRotCrop-1,startCol:startCol+colRotCrop-1) = rotCropImg;
end
imshow(newImg_rot_90_a); input('Press enter to continue');

% 4b. ROTATE THE CHARACTERS ABOUT THEIR CENTER BY -90 DEGREES AND PLACE THE OBJECT SO THAT THEY DO NOT OVERLAP ON ONE ANOTHER
newImg_rot_90_b = zeros(row,int32(1.5*col),'uint8');
for label = 1:numLabel
    cropImg = img(props(label).BoundingBox(1):props(label).BoundingBox(2),props(label).BoundingBox(3):props(label).BoundingBox(4));
    rotCropImg = imageRotate(cropImg,angle=-90,method='nearestNeighbor');
    [rowCrop,colCrop] = size(cropImg);
    [rowRotCrop,colRotCrop] = size(rotCropImg);
    startRow = int32(props(label).Centroid(1) - rowRotCrop/2);
    startCol = int32(props(label).Centroid(2) - colRotCrop/2);
    flag = 0;
    while(flag==0)
        if (length(unique(newImg_rot_90_b(startRow:startRow+rowRotCrop-1,startCol:startCol+colRotCrop-1))) > 1)
            startCol += 50;
        else
            newImg_rot_90_b(startRow:startRow+rowRotCrop-1,startCol:startCol+colRotCrop-1) = rotCropImg;
            flag = 1;
        end
    end
end
imshow(newImg_rot_90_b); input('Press enter to continue');

% 5a. ROTATE THE CHARACTERS ABOUT THEIR CENTER BY 35 DEGREES
newImg_rot35_a = zeros(row,col,'uint8');
for label = 1:numLabel
    cropImg = img(props(label).BoundingBox(1):props(label).BoundingBox(2),props(label).BoundingBox(3):props(label).BoundingBox(4));
    rotCropImg = imageRotate(cropImg,angle=35,method='nearestNeighbor');
    [rowCrop,colCrop] = size(cropImg);
    [rowRotCrop,colRotCrop] = size(rotCropImg);
    startRow = int32(props(label).Centroid(1) - rowRotCrop/2);
    startCol = int32(props(label).Centroid(2) - colRotCrop/2);
    newImg_rot35_a(startRow:startRow+rowRotCrop-1,startCol:startCol+colRotCrop-1) = rotCropImg;
end
imshow(newImg_rot35_a); input('Press enter to continue');

% 5b. ROTATE THE CHARACTERS ABOUT THEIR CENTER BY 35 DEGREES AND PLACE THE OBJECT SO THAT THEY DO NOT OVERLAP ON ONE ANOTHER
newImg_rot35_b = zeros(row,int32(1.6*col),'uint8');
for label = 1:numLabel
    cropImg = img(props(label).BoundingBox(1):props(label).BoundingBox(2),props(label).BoundingBox(3):props(label).BoundingBox(4));
    rotCropImg = imageRotate(cropImg,angle=35,method='nearestNeighbor');
    [rowCrop,colCrop] = size(cropImg);
    [rowRotCrop,colRotCrop] = size(rotCropImg);
    startRow = int32(props(label).Centroid(1) - rowRotCrop/2);
    startCol = int32(props(label).Centroid(2) - colRotCrop/2);
    flag = 0;
    while(flag==0)
        if (length(unique(newImg_rot35_b(startRow:startRow+rowRotCrop-1,startCol:startCol+colRotCrop-1))) > 1)
            startCol += 20;
        else
            newImg_rot35_b(startRow:startRow+rowRotCrop-1,startCol:startCol+colRotCrop-1) = rotCropImg;
            flag = 1;
        end
    end
end
imshow(newImg_rot35_b); input('Press enter to continue');

% 6. FIND THE OUTLINE OF SEGMENTED CHARACTERS
bImgBdry = boundary(bImg);
imshow(bImgBdry); input('Press enter to continue');

% 7. FIND THE SKELETON OF SEGMENTED CHARACTERS
bImgSkeleton = skeleton(bImg);
imshow(bImgSkeleton); input('Press enter to continue');

% 8. SCALE AND DISPLAY CHARACTERS 7M2HD44780A00 IN SEQUENCE
targetRow = 0;
for label = 1:numLabel
    if (props(label).Height>targetRow)
        targetRow = props(label).Height;
    end
end
finalImg = [];
for label = {4,7,8,1,2,3,5,6,9,10,11,12,13}
    cropImg = img(props(label{1}).BoundingBox(1):props(label{1}).BoundingBox(2),props(label{1}).BoundingBox(3):props(label{1}).BoundingBox(4));
    targetCol = int32(props(label{1}).Width * targetRow / props(label{1}).Height);
    cropImgScale = imageScale(cropImg,targetRow,targetCol,'bilinear');
    finalImg = [finalImg cropImgScale];
end
imshow(finalImg); input('Press enter to continue');

subplot(2,4,1), imshow(img)
subplot(2,4,2), imshow(imgStretch)
subplot(2,4,3), imshow(bImg)
subplot(2,4,4), imshow(newImg_rot_90_b)
subplot(2,4,5), imshow(newImg_rot35_b)
subplot(2,4,6), imshow(bImgBdry)
subplot(2,4,7), imshow(bImgSkeleton)
subplot(2,4,8), imshow(finalImg)

% PARTICLE LABELS FOR CORRESPONDING ALPHABETS AND DIGITS
%1 - H
%2 - D
%3 - 4
%4 - 7
%5 - 4
%6 - 7
%7 - M
%8 - 2
%9 - 8
%10 - 0
%11 - A
%12 - 0
%13 - 0
% 7 M 2 H D 4 4 7 8 0 A 0 0
% 4 6 8 1 2 3 5 7 9 10 11 12 13
