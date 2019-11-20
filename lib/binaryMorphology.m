function bImg2 = binaryMorphology(bImg,method,kernelSize)
% binaryMorphology -
%   Perform simple morphological operation on binary images.
% 
% Input parameters -
%   bImg - binary image on which the operation needs to be performed
%   method - select one of the following 'erode', 'dilate', 'open', 'close'
%   kernelSize - should be an odd number. Size of the square structuring element that will be used for operation.
% 
% Usage
% bImg2 = binaryMorphology(bImg,'erode',3)
%   This will erode bImg using a kernel which looks like [[1,1,1],[1,1,1],[1,1,1]]
% bImg2 = binaryMorphology(bImg,'open',4)
%   This will generate an error message "Value of kernelSize should be an odd number"
% bImg2 = binaryMorphology(bImg,'open',41)
%   This will open bImg using a square kernel of size 41 pixels.
%
% Returns
%   A new binary image after doing the morphological operations
    [row,col] = size(bImg);
    bImg2 = zeros(row,col,"logical");
    bImgTemp = zeros(row,col,"logical");
    
    if (mod(kernelSize,2))
        if (strcmp(method,'erode'))
            for r = floor(kernelSize/2)+1:row-floor(kernelSize/2)
                for c = floor(kernelSize/2)+1:col-floor(kernelSize/2)
                    cropImg = bImg(r-floor(kernelSize/2):r+floor(kernelSize/2),c-floor(kernelSize/2):c+floor(kernelSize/2));
                    cropImg = cropImg(:);
                    bImg2(r,c) = min(cropImg);
                end
            end
        elseif (strcmp(method,'dilate'))
            for r = floor(kernelSize/2)+1:row-floor(kernelSize/2)
                for c = floor(kernelSize/2)+1:col-floor(kernelSize/2)
                    cropImg = bImg(r-floor(kernelSize/2):r+floor(kernelSize/2),c-floor(kernelSize/2):c+floor(kernelSize/2));
                    cropImg = cropImg(:);
                    bImg2(r,c) = max(cropImg);
                end
            end
        elseif (strcmp(method,'open'))
            for r = floor(kernelSize/2)+1:row-floor(kernelSize/2)
                for c = floor(kernelSize/2)+1:col-floor(kernelSize/2)
                    cropImg = bImg(r-floor(kernelSize/2):r+floor(kernelSize/2),c-floor(kernelSize/2):c+floor(kernelSize/2));
                    cropImg = cropImg(:);
                    bImgTemp(r,c) = min(cropImg);
                end
            end
            for r = floor(kernelSize/2)+1:row-floor(kernelSize/2)
                for c = floor(kernelSize/2)+1:col-floor(kernelSize/2)
                    cropImg = bImgTemp(r-floor(kernelSize/2):r+floor(kernelSize/2),c-floor(kernelSize/2):c+floor(kernelSize/2));
                    cropImg = cropImg(:);
                    bImg2(r,c) = max(cropImg);
                end
            end
        elseif (strcmp(method,'close'))
            for r = floor(kernelSize/2)+1:row-floor(kernelSize/2)
                for c = floor(kernelSize/2)+1:col-floor(kernelSize/2)
                    cropImg = bImg(r-floor(kernelSize/2):r+floor(kernelSize/2),c-floor(kernelSize/2):c+floor(kernelSize/2));
                    cropImg = cropImg(:);
                    bImgTemp(r,c) = max(cropImg);
                end
            end
            for r = floor(kernelSize/2)+1:row-floor(kernelSize/2)
                for c = floor(kernelSize/2)+1:col-floor(kernelSize/2)
                    cropImg = bImgTemp(r-floor(kernelSize/2):r+floor(kernelSize/2),c-floor(kernelSize/2):c+floor(kernelSize/2));
                    cropImg = cropImg(:);
                    bImg2(r,c) = min(cropImg);
                end
            end
        end
    else
        printf("Value of kernelSize should be an odd number\n")
    end
end
