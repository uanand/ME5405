function [bImg,th] = thresholdAdaptive(img,method="mean",kernelSize=3)
    [row,col] = size(img);
    bImg = zeros(row,col,"logical");
    th = zeros(row,col);
    
    if (mod(kernelSize,2))
        for r = floor(kernelSize/2)+1:row-floor(kernelSize/2)
            for c = floor(kernelSize/2)+1:col-floor(kernelSize/2)
                cropImg = img(r-floor(kernelSize/2):r+floor(kernelSize/2),c-floor(kernelSize/2):c+floor(kernelSize/2));
                cropImg = cropImg(:);
                th(r,c) = mean(cropImg);
                if (img(r,c)>th(r,c))
                    bImg(r,c) = 1;
                endif
            endfor
        endfor
    else
        printf("Value of kernelSize should be an odd number\n")
    endif
endfunction
