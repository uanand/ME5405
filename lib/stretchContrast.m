function imgStretch = stretchContrast(img,min=0,max=255)
    printf("Normalizing the contrast for image")
    [row,col] = size(img);
    intensityMin = 255; intensityMax = 0;
    for r = 1:row
        for c = 1:col
            if (img(r,c)>intensityMax)
                intensityMax = img(r,c);
            endif
            if (img(r,c)<intensityMin)
                intensityMin = img(r,c);
            endif
        endfor
    endfor
    
    alpha = 255.0/double(intensityMax-intensityMin);
    beta = -alpha*double(intensityMin);
    imgStretch = zeros(row,col);
    for r = 1:row
        for c = 1:col
            imgStretch(r,c) = round(alpha*double(img(r,c)) + beta);
            if (imgStretch(r,c)>255)
                imgStretch(r,c) = 255;
            endif
            if (imgStretch(r,c)<0)
                imgStretch(r,c) = 0;
            endif
        endfor
    endfor
endfunction
