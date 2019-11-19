function imgStretch = stretchContrast(img)
% stretchContrast - enhance the image by stretching the grayscale intensity values linearly between 0 and 255.
% 
% Input parameters -
%   img - 8-bit grayscale image for which you wish to do contrast stretching
% 
% Usage -
% imgStretch = stretchContrast(img)
%   Let's assume that the minimum and maximum grayscale intensity value are 100 and 200 respectively. A linear map is calculated which resets the intensity of image by mapping 100 to 0, 200 to 255, and all the intermediate values are linearly spaced. This increases the contrast between the dark and bright regions. 
%
% Returns -
%   Enhanced image. The stretched contrast image having the same size as input image is returned.
    [row,col] = size(img);
    intensityMin = 255; intensityMax = 0;
    for r = 1:row
        for c = 1:col
            if (img(r,c)>intensityMax)
                intensityMax = img(r,c);
            end
            if (img(r,c)<intensityMin)
                intensityMin = img(r,c);
            end
        end
    end
    
    alpha = 255.0/double(intensityMax-intensityMin);
    beta = -alpha*double(intensityMin);
    imgStretch = zeros(row,col,"uint8");
    for r = 1:row
        for c = 1:col
            imgStretch(r,c) = round(alpha*double(img(r,c)) + beta);
            if (imgStretch(r,c)>255)
                imgStretch(r,c) = 255;
            end
            if (imgStretch(r,c)<0)
                imgStretch(r,c) = 0;
            end
        end
    end
end
