function count = histogram(img,normalize=0)
    [row,col] = size(img);
    count = zeros(1,256);
    for r = 1:row;
        for c = 1:col;
            count(img(r,c)+1) = count(img(r,c)+1)+1;
        endfor
    endfor
    if (normalize == 1);
        count = 1.0*count/(row*col);
    endif
endfunction
