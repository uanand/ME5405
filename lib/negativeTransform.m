function img = negativeTransform(img)
    printf("Inverting the input image");
    [row,col] = size(img);
    for r = 1:row
        for c = 1:col
            img(r,c) = 255-img(r,c);
        endfor
    endfor
endfunction