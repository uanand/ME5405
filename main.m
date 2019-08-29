clear;
addpath('./lib');

img = imread('charact2.bmp');
img = img(:,:,1);

count = histogram(img,normalize=0);

