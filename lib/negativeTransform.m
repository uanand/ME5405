function img = negativeTransform(img)
% negativeTransform -
%   Inverts the intensity value of each pixel.
% 
% Input parameters -
%   img - 8-bit grayscale image which you need invert
% 
% Usage -
% img = negativeTransform(img)
%   1 input grayscale image is required as input parameter.
%
% Returns -
%   img. The image is inverted by transforming each pixel's intensity value I to 255-I. The resulting matrix looks like a negative of the original image where the bright features become dark and vice versa.
    [row,col] = size(img);
    for r = 1:row
        for c = 1:col
            img(r,c) = 255-img(r,c);
        end
    end
end
