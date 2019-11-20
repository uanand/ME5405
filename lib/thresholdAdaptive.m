function [bImg,th] = thresholdAdaptive(img,method,kernelSize)
% thresholdAdaptive -
%   peform local thresholding for smaller square regions in the image. The size of the square region is defined by kernel size.
% 
% Input parameters -
%   img - 8-bit grayscale image which has to be thresholded
%   method - only mean threshold has been implemented now. We plan to implement other thresholding algorithms in the future. Select 'mean' now.
%   kernelSize - should be an odd number. Size of the square structuring element that will be used for local thresholding.
% 
% Usage -
% [bImg,th] = thresholdAdaptive(img,'mean',45);
%   We select a ROI which is 45x45 pixels in size, and the average intensity valiu in ROI is calculated. If the intensity value of the center pixel of ROI is greater than the average it is marked as 1, and 0 otherwise.
%
% Returns -
%   bImg. Binary image after performing local thresholding. It should be noted that the boundary region is always 0.
%   th. The calculated threshold at every pixel based on ROI.
    [row,col] = size(img);
    bImg = zeros(row,col,'logical');
    th = zeros(row,col);
    
    if (mod(kernelSize,2))
        for r = floor(kernelSize/2)+1:row-floor(kernelSize/2)
            for c = floor(kernelSize/2)+1:col-floor(kernelSize/2)
                cropImg = img(r-floor(kernelSize/2):r+floor(kernelSize/2),c-floor(kernelSize/2):c+floor(kernelSize/2));
                cropImg = cropImg(:);
                th(r,c) = mean(cropImg);
                if (img(r,c)>th(r,c))
                    bImg(r,c) = 1;
                end
            end
        end
    else
        printf("Value of kernelSize should be an odd number\n")
    end
end
