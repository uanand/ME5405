clear;
addpath('./lib');

# READING AND PROCESSING BITMAP IMAGE
img = imread('charact2.bmp');
img = img(:,:,1);
%scaleImg1 = imageScale(img,targetRow=200,targetCol=400,method='nearestNeighbor');
%scaleImg2 = imageScale(img,targetRow=200,targetCol=400,method='bilinear');
scaleImg3 = imageScale(img,targetRow=200,targetCol=400,method='bicubic');
scaleImg4 = imresize(img,[200,400],method='bicubic');
%scaleImg = imageScale(rand(20,20),targetRow=50,targetCol=100,method='bicubic');

%imgStretch = stretchContrast(img);
%[imgEq,histEq] = histogramEqualize(img);
%hist = histogram(img);
%[bImg1,th1] = threshold(img,method="median");
%[bImg2,th2] = threshold(img,method="mean");
%[bImg3,th3] = threshold(img,method="otsu");
%[bImg4,th4] = threshold(img,method="maxentropy");
%subplot(2,2,1), imshow(img);
%subplot(2,2,2), imshow(scaleImg1);
%subplot(2,2,3), imshow(scaleImg2);
%subplot(2,2,4), imshow(scaleImg3);
%imwrite(img)

%count = histogram(img,normalize=0);
%[imgHistEq,histEq] = histogramEqualize(img);
%subplot(2,2,1), imshow(img);
%subplot(2,2,2), imshow(imgHistEq);
%subplot(2,2,3), bar(0:255,count);
%subplot(2,2,4), bar(0:255,histEq);

# READING AND PROCESSING TEXT IMAGE
%textImg = fileread('charact1.txt');
%img = textTOascii(textImg);
%[bImg1,th1] = threshold(img,method="median");
%[bImg2,th2] = threshold(img,method="mean");
%[bImg3,th3] = threshold(img,method="otsu");
%[bImg4,th4] = threshold(img,method="maxentropy");
%%imwrite(img,'test.png');
%imgStretch = stretchContrast(img);
%imwrite(imgStretch, 'test2.png');
%%imshow(img);
