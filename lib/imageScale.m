function scaleImg = imageScale(img,targetRow,targetCol,method='nearestNeighbor')
    printf("Image scaling using the selected method\n");
    [row,col] = size(img);
    scaleImg = zeros(targetRow,targetCol,"uint8");
    if (strcmp(method,'nearestNeighbor'))
        for r = 1:targetRow
            for c = 1:targetCol
                sourceR = max(int32(1),int32(round(double(r)/double(targetRow)*double(row))));
                sourceC = max(int32(1),int32(round(double(c)/double(targetCol)*double(col))));
                scaleImg(r,c) = img(sourceR,sourceC);
            endfor
        endfor
    elseif (strcmp(method,'bilinear'))
        padImg = [img;img(row,:)];
        padImg = [padImg padImg(:,col)];
        for r = 1:targetRow
            for c = 1:targetCol
                sourceR = max(1,double(r)/double(targetRow)*double(row));
                sourceC = max(1,double(c)/double(targetCol)*double(col));
                l = floor(sourceR);
                k = floor(sourceC);
                a = sourceR-l;
                b = sourceC-k;
                scaleImg(r,c) = uint8((1-a)*(1-b)*double(padImg(l,k)) + a*(1-b)*double(padImg(l+1,k)) + (1-a)*b*double(padImg(l,k+1)) + a*b*double(padImg(l+1,k+1)));
            endfor
        endfor
    %elseif (method=='bicubic')
        % do something
    endif
endfunction
