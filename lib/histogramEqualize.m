function [imgEq,histEq] = histogramEqualize(img)
% histogramEqualize - Enhances the contrast of the image using histogram equalization method discussed in the lecture notes.
% 
% Input parameters -
%   img - 8-bit grayscale image for which you need to histogram equalization
% 
% Usage -
% [imgEq,histEq] = histogramEqualize(img)
%   Only 1 input grayscale image is required.
%
% Returns -
%   imgEq. The enhanced contrast image generated after performing histogram equalization on the input image.
%   histEq. Histogram of the equalized image.
    [row,col] = size(img);
    imgEq = zeros(row,col,"uint8");
    H = zeros(1,256);
    histCum = zeros(1,256);
    hist = histogram(img,0);
    for i = 1:256;
        totalCount = 0;
        for j = 1:i;
            totalCount = totalCount + hist(j);
        end
        histCum(i+1) = totalCount;
    end
    for r = 1:row;
        for c = 1:col;
            imgEq(r,c) = round(255.0/double(row*col) * double(histCum(img(r,c)+1)));
        end
    end
    histEq = histogram(imgEq,0);
end
