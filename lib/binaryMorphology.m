function bImg2 = binaryMorphology(bImg,method,kernelSize=3)
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
                endfor
            endfor
        elseif (strcmp(method,'dilate'))
            for r = floor(kernelSize/2)+1:row-floor(kernelSize/2)
                for c = floor(kernelSize/2)+1:col-floor(kernelSize/2)
                    cropImg = bImg(r-floor(kernelSize/2):r+floor(kernelSize/2),c-floor(kernelSize/2):c+floor(kernelSize/2));
                    cropImg = cropImg(:);
                    bImg2(r,c) = max(cropImg);
                endfor
            endfor
        elseif (strcmp(method,'open'))
            for r = floor(kernelSize/2)+1:row-floor(kernelSize/2)
                for c = floor(kernelSize/2)+1:col-floor(kernelSize/2)
                    cropImg = bImg(r-floor(kernelSize/2):r+floor(kernelSize/2),c-floor(kernelSize/2):c+floor(kernelSize/2));
                    cropImg = cropImg(:);
                    bImgTemp(r,c) = min(cropImg);
                endfor
            endfor
            for r = floor(kernelSize/2)+1:row-floor(kernelSize/2)
                for c = floor(kernelSize/2)+1:col-floor(kernelSize/2)
                    cropImg = bImgTemp(r-floor(kernelSize/2):r+floor(kernelSize/2),c-floor(kernelSize/2):c+floor(kernelSize/2));
                    cropImg = cropImg(:);
                    bImg2(r,c) = max(cropImg);
                endfor
            endfor
        elseif (strcmp(method,'close'))
            for r = floor(kernelSize/2)+1:row-floor(kernelSize/2)
                for c = floor(kernelSize/2)+1:col-floor(kernelSize/2)
                    cropImg = bImg(r-floor(kernelSize/2):r+floor(kernelSize/2),c-floor(kernelSize/2):c+floor(kernelSize/2));
                    cropImg = cropImg(:);
                    bImgTemp(r,c) = max(cropImg);
                endfor
            endfor
            for r = floor(kernelSize/2)+1:row-floor(kernelSize/2)
                for c = floor(kernelSize/2)+1:col-floor(kernelSize/2)
                    cropImg = bImgTemp(r-floor(kernelSize/2):r+floor(kernelSize/2),c-floor(kernelSize/2):c+floor(kernelSize/2));
                    cropImg = cropImg(:);
                    bImg2(r,c) = min(cropImg);
                endfor
            endfor
        endif
    else
        printf("Value of kernelSize should be an odd number\n")
    endif
endfunction
