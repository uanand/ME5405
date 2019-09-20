clear;
addpath('./lib');

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

# READING AND PROCESSING TEXT IMAGE
textImg = fileread('charact1.txt');
img = textTOascii(textImg);
rotImg = imageRotate(img,angle=30);
%scaleImg1 = imageScale(img,targetRow=100,targetCol=150,method='nearestNeighbor');
%scaleImg2 = imageScale(img,targetRow=100,targetCol=150,method='bilinear');
%scaleImg3 = imageScale(img,targetRow=100,targetCol=150,method='bicubic');
%scaleImg4 = imresize(img,[100,150],method='bilinear');
%scaleImg5 = imresize(img,[100,150],method='bicubic');
%subplot(3,2,1), imshow(img);
%subplot(3,2,2), imshow(scaleImg1);
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
