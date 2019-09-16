clear;
addpath('./lib');

# READING AND PROCESSING BITMAP IMAGE
%img = imread('charact2.bmp');
%img = img(:,:,1);
%hist = histogram(img);
%[bImg1,th1] = threshold(img,method="median");
%[bImg2,th2] = threshold(img,method="mean");
%[bImg3,th3] = threshold(img,method="otsu");
%[bImg4,th4] = threshold(img,method="maxentropy");
%subplot(1,2,1), imshow(img);
%subplot(1,2,2), imshow(bImg);

%count = histogram(img,normalize=0);
%[imgHistEq,histEq] = histogramEqualize(img);
%subplot(2,2,1), imshow(img);
%subplot(2,2,2), imshow(imgHistEq);
%subplot(2,2,3), bar(0:255,count);
%subplot(2,2,4), bar(0:255,histEq);

# READING AND PROCESSING TEXT IMAGE
textImg = fileread('charact1.txt');
img = textTOascii(textImg);
[bImg1,th1] = threshold(img,method="median");
[bImg2,th2] = threshold(img,method="mean");
[bImg3,th3] = threshold(img,method="otsu");
[bImg4,th4] = threshold(img,method="maxentropy");
%%imwrite(img,'test.png');
%imgStretch = stretchContrast(img);
%imwrite(imgStretch, 'test2.png');
%%imshow(img);
