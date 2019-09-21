function bImgBdry = boundary(bImg)
    printf("Finding the boundary of binary image\n");
    [row,col] = size(bImg);
    bImgErode = zeros(row,col,'logical');
    bImgBdry = zeros(row,col,'logical');
    for r = 2:row-1
        for c = 2:col-1
            %product = bImg(r-1,c-1)*bImg(r-1,c)*bImg(r-1,c+1)*bImg(r,c-1)*bImg(r,c)*bImg(r,c+1)*bImg(r+1,c-1)*bImg(r+1,c)*bImg(r+1,c+1);
            product = bImg(r-1,c)*bImg(r,c-1)*bImg(r,c)*bImg(r,c+1)*bImg(r+1,c);
            if (product == 1)
                bImgErode(r,c) = 1;
            endif
        endfor
    endfor
    for r = 1:row
        for c = 1:col
            if (bImg(r,c)==1 && bImgErode(r,c)==0)
                bImgBdry(r,c) = 1;
            endif
        endfor
    endfor
endfunction
