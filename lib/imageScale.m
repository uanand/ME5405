function scaleImg = imageScale(img,targetRow,targetCol,method='nearestNeighbor')
    printf("Image scaling using the selected method\n");
    [row,col] = size(img);
    scaleImg = zeros(targetRow,targetCol,"uint8");
    if (method=='nearestNeighbor')
        for r = 1:targetRow
            for c = 1:targetCol
                sourceR = max(int32(1),int32(round(double(r)/double(targetRow)*double(row))));
                sourceC = max(int32(1),int32(round(double(c)/double(targetCol)*double(col))));
                scaleImg(r,c) = img(sourceR,sourceC);
            endfor
        endfor
    endif
endfunction
