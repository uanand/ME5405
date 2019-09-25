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

# PROCESSING METHODS FOR IMAGE 2
# READING AND PROCESSING TEXT IMAGE
textImg = fileread('charact1.txt');
img = textTOascii(textImg);
img = stretchContrast(img);
[row,col] = size(img);
[bImg,th] = threshold(img,method='mean');
[labelImg,numLabel,boundingBox] = particleBoundingBox(bImg);
newImg_rot_90 = zeros(row,col,'uint8');
newImg_rot35 = zeros(row,col,'uint8');
for label = 1:numLabel
    cropImg = img(boundingBox(label).rMin:boundingBox(label).rMax,boundingBox(label).cMin:boundingBox(label).cMax);
    rotCropImg = imageRotate(cropImg,angle=90,method='nearestNeighbor');
    subplot(1,2,1), imshow(cropImg)
    subplot(1,2,2), imshow(rotCropImg)
    %[rowCrop,colCrop] = size(cropImg)
    %[rowRotCrop,colRotCrop] = size(rotCropImg)
    %startRow = int32(boundingBox(label).rMin + (boundingBox(label).rMax-boundingBox(label).rMin)/2 - rowRotCrop/2)
    %startCol = int32(boundingBox(label).cMin + (boundingBox(label).cMax-boundingBox(label).cMin)/2 - colRotCrop/2)
    %newImg_rot_90(startRow:startRow+rowRotCrop-1,startCol:startCol+colRotCrop-1) = rotCropImg;
endfor
%for label = 1:numLabel
    %cropImg = img(boundingBox(label).rMin:boundingBox(label).rMax,boundingBox(label).cMin:boundingBox(label).cMax);
    %rotCropImg = imageRotate(cropImg,angle=35,method='bilinear');
    %[rowCrop,colCrop] = size(cropImg);
    %[rowRotCrop,colRotCrop] = size(rotCropImg);
    %startRow = int32(boundingBox(label).rMin + (boundingBox(label).rMax-boundingBox(label).rMin)/2 - rowRotCrop/2);
    %startCol = int32(boundingBox(label).cMin + (boundingBox(label).cMax-boundingBox(label).cMin)/2 - colRotCrop/2);
    %newImg_rot35(startRow:startRow+rowRotCrop-1,startCol:startCol+colRotCrop-1) = rotCropImg;
%endfor

%subplot(2,3,1), imshow(img)
%subplot(2,3,2), imshow(bImg)
%subplot(2,3,3), imshow(newImg_rot_90)
%subplot(2,3,4), imshow(newImg_rot35)
%bImgSkel = bwmorph(bImg,'thin');%'skel-pratt' is not good); %'skel' is not good,
%bImgSkeleton = skeleton(bImg);
%bImgBdry = boundary(bImg);
%[labelImg,numLabel] = label(bImg);
%labelImg = stretchContrast(labelImg);
%bImgSkeleton = skeleton(bImg);
%rotImg1 = imageRotate(img,angle=30,point=[20,50],method='nearestNeighbor');
%rotImg2 = imageRotate(img,angle=30,point=[1,1],method='nearestNeighbor');
%rotImg3 = imageRotate(img,angle=35,point='centre',method='bilinear');
%scaleImg1 = imageScale(img,targetRow=100,targetCol=150,method='nearestNeighbor');
%scaleImg2 = imageScale(img,targetRow=100,targetCol=150,method='bilinear');
%scaleImg3 = imageScale(img,targetRow=100,targetCol=150,method='bicubic');
%scaleImg4 = imresize(img,[100,150],method='bilinear');
%scaleImg5 = imresize(img,[100,150],method='bicubic');
%subplot(2,2,1), imshow(img);
%subplot(2,2,2), imshow(bImg);
%subplot(2,2,3), imshow(bImgSkel);
%subplot(2,2,4), imshow(scaleImg3);
%subplot(1,4,3), imshow(rotImg2);

%subplot(3,2,3), imshow(scaleImg2);
%subplot(3,2,4), imshow(scaleImg4);
%subplot(3,2,5), imshow(scaleImg3);
%subplot(3,2,6), imshow(scaleImg5);
%[bImg1,th1] = threshold(img,method="median");
%[bImg2,th2] = threshold(img,method="mean");
%[bImg3,th3] = threshold(img,method="otsu");
%[bImg4,th4] = threshold(img,method="maxentropy");
%%imwrite(img,'test.png');
%imgStretch = stretchContrast(img);
%imwrite(imgStretch, 'test2.png');
%%imshow(img);


%scaleImg1 = imageScale(img,targetRow=100,targetCol=150,method='nearestNeighbor');
%scaleImg2 = imageScale(img,targetRow=100,targetCol=150,method='bilinear');
%scaleImg3 = imageScale(img,targetRow=100,targetCol=150,method='bicubic');
