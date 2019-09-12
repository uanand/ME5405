clear;
addpath('./lib');

# READING AND PROCESSING BITMAP IMAGE
img = imread('charact2.bmp');
img = img(:,:,1);
count = histogram(img,normalize=0);
[imgHistEq,histEq] = histogramEqualize(img);
subplot(2,2,1), imshow(img);
subplot(2,2,2), imshow(imgHistEq);
subplot(2,2,3), bar(0:255,count);
subplot(2,2,4), bar(0:255,histEq);

# READING AND PROCESSING TEXT IMAGE
%textImg = fileread('charact1.txt');
%img = textTOascii(textImg);
%%imwrite(img,'test.png');
%imgStretch = stretchContrast(img);
%imwrite(imgStretch, 'test2.png');
%%imshow(img);
