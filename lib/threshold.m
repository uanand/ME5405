function [bImg,th] = threshold(img,method="mean",th=0)
    printf("Binarizing the image based on the selected threshold method\n");
    [row,col] = size(img);
    bImg = zeros(row,col,"uint8");
    
    if (strcmp(method,"constant"))
        for r = 1:row;
            for c = 1:col;
                if (img(r,c)>th)
                    bImg(r,c) = 1;
                endif;
            endfor;
        endfor;
    elseif (strcmp(method,"mean"))
        th = 0;
        for r = 1:row;
            for c = 1:col;
                th = th+double(img(r,c));
            endfor
        endfor
        th = double(th/(row*col))
        for r = 1:row;
            for c = 1:col;
                if (img(r,c)>th)
                    bImg(r,c) = 1;
                endif;
            endfor;
        endfor;
    elseif (strcmp(method,"median"))
        vectorImg = reshape(img,1,row*col);
        th = median(vectorImg)
        for r = 1:row
            for c = 1:col
                if (img(r,c)>th)
                    bImg(r,c) = 1;
                endif;
            endfor;
        endfor;
    %%%elseif (strcmp(method,"otsu"))
        %%%do someting
    %%%elseif (strcmp(method,"maxentropy"))
        %%%do something;
    %%else
        %%printf("The method you entered is not valid. Please choose 1 of the following - constant, mean, median, otsu, maxentropy\n")
    endif
endfunction
