function count = histogram(img,normalize)
% histogram -
%   Calculates the histogram of the grayscale image.
% 
% Input parameters -
%   img - 8-bit grayscale image for which you need to find the histogram
%   normalize - If 1 then the histogram will be converted to a probability distribution such that the sum of probability of all pixel values will be 1. For any value other than 1, this normalization is not performed.
% 
% Usage - 
% count = histogram(img,0)
%   Count the number of pixels with intensity ranging from 0 to 255. The counts is not normalized and describes the exact number of pixels with a certain intensity value.
% count = histogram(img,1)
%   Counts are normalized to a probability density function. The sum of all the elements of count vector in this case will be 1.
%
% Returns - 
%   A vector of length 256 (representing different grayscale values) with the count/probability of each grayscale value.
    [row,col] = size(img);
    count = zeros(1,256);
    for r = 1:row
        for c = 1:col
            count(img(r,c)+1) = count(img(r,c)+1)+1;
        end
    end
    if (normalize == 1)
        count = 1.0*count/(row*col);
    end
end
