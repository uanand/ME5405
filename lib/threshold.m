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
        th = double(th/(row*col));
        for r = 1:row;
            for c = 1:col;
                if (img(r,c)>th)
                    bImg(r,c) = 1;
                endif;
            endfor;
        endfor;
    elseif (strcmp(method,"median"))
        vectorImg = reshape(img,1,row*col);
        th = median(vectorImg);
        for r = 1:row
            for c = 1:col
                if (img(r,c)>th)
                    bImg(r,c) = 1;
                endif;
            endfor;
        endfor;
    elseif (strcmp(method,"otsu"))
        classVariance = 1e10;
        hist = histogram(img);
        for intensity = 0:255
            weightLower = 0;
            meanLower = 0;
            meanLower2 = 0;
            weightUpper = 0;
            meanUpper = 0;
            meanUpper2 = 0;
            for iLower = 0:intensity
                weightLower = weightLower + hist(iLower+1);
                meanLower = meanLower + iLower*hist(iLower+1);
                meanLower2 = meanLower2 + iLower^2*hist(iLower+1);
            endfor
            for iUpper = intensity+1:255
                weightUpper = weightUpper + hist(iUpper+1);
                meanUpper = meanUpper + iUpper*hist(iUpper+1);
                meanUpper2 = meanUpper2 + iUpper^2*hist(iUpper+1);
            endfor
            if (weightLower>0 && weightUpper>0)
                meanLower = meanLower/weightLower;
                meanLower2 = meanLower2/weightLower;
                varLower = meanLower2-meanLower^2;
                weightLower = weightLower/double(row*col);
                meanUpper = meanUpper/weightUpper;
                meanUpper2 = meanUpper2/weightUpper;
                varUpper = meanUpper2-meanUpper^2;
                weightUpper = weightUpper/double(row*col);
                variance = weightLower*varLower + weightUpper*varUpper;
                if (variance<classVariance)
                    classVariance = variance;
                    th = intensity;
                endif
            endif
        endfor
        for r = 1:row
            for c = 1:col
                if (img(r,c)>th)
                    bImg(r,c) = 1;
                endif;
            endfor;
        endfor;
        
        
    %%%elseif (strcmp(method,"maxentropy"))
        %%%do something;
    %%else
        %%printf("The method you entered is not valid. Please choose 1 of the following - constant, mean, median, otsu, maxentropy\n")
    endif
endfunction
