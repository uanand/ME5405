clear;
addpath('./lib');

# READING AND PROCESSING BITMAP IMAGE
%img = imread('charact2.bmp');
%img = img(:,:,1);
%count = histogram(img,normalize=0);

# READING AND PROCESSING TEXT IMAGE
textImg = fileread('charact1.txt');
img = textTOascii(textImg);
%imwrite(img,'test.png');
imgStretch = stretchContrast(img);
imwrite(imgStretch, 'test2.png');
%imshow(img);
