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
    elseif (strcmp(method,'bicubic'))
         padImg = [img;img(row,:);img(row-1,:)];
         padImg = [padImg padImg(:,col) padImg(:,col-1)];
         padImg = [padImg(2,:); padImg(1,:); padImg];
         padImg = [padImg(:,2) padImg(:,1) padImg];
         size(padImg)
         for r = 1:targetRow
            for c = 1:targetCol
                sourceR = max(1,double(r)/double(targetRow)*double(row));
                sourceC = max(1,double(c)/double(targetCol)*double(col));
                scaleImg(r,c) =  uint8(double(padImg(floor(sourceR)-1+2,floor(sourceC)-1+2))*weight_h3(floor(sourceR)+2,sourceR)*weight_h3(floor(sourceC)+2,sourceC) + ...
                                       double(padImg(floor(sourceR)-1+2,floor(sourceC)-0+2))*weight_h3(floor(sourceR)+2,sourceR)*weight_h3(floor(sourceC)+1,sourceC) + ...
                                       double(padImg(floor(sourceR)-1+2,floor(sourceC)+1+2))*weight_h3(floor(sourceR)+2,sourceR)*weight_h3(floor(sourceC)+0,sourceC) + ...
                                       double(padImg(floor(sourceR)-1+2,floor(sourceC)+2+2))*weight_h3(floor(sourceR)+2,sourceR)*weight_h3(floor(sourceC)-1,sourceC) + ...
                                       ...
                                       double(padImg(floor(sourceR)-0+2,floor(sourceC)-1+2))*weight_h3(floor(sourceR)+1,sourceR)*weight_h3(floor(sourceC)+2,sourceC) + ...
                                       double(padImg(floor(sourceR)-0+2,floor(sourceC)-0+2))*weight_h3(floor(sourceR)+1,sourceR)*weight_h3(floor(sourceC)+1,sourceC) + ...
                                       double(padImg(floor(sourceR)-0+2,floor(sourceC)+1+2))*weight_h3(floor(sourceR)+1,sourceR)*weight_h3(floor(sourceC)+0,sourceC) + ...
                                       double(padImg(floor(sourceR)-0+2,floor(sourceC)+2+2))*weight_h3(floor(sourceR)+1,sourceR)*weight_h3(floor(sourceC)-1,sourceC) + ...
                                       ...
                                       double(padImg(floor(sourceR)+1+2,floor(sourceC)-1+2))*weight_h3(floor(sourceR)+0,sourceR)*weight_h3(floor(sourceC)+2,sourceC) + ...
                                       double(padImg(floor(sourceR)+1+2,floor(sourceC)-0+2))*weight_h3(floor(sourceR)+0,sourceR)*weight_h3(floor(sourceC)+1,sourceC) + ...
                                       double(padImg(floor(sourceR)+1+2,floor(sourceC)+1+2))*weight_h3(floor(sourceR)+0,sourceR)*weight_h3(floor(sourceC)+0,sourceC) + ...
                                       double(padImg(floor(sourceR)+1+2,floor(sourceC)+2+2))*weight_h3(floor(sourceR)+0,sourceR)*weight_h3(floor(sourceC)-1,sourceC) + ...
                                       ...
                                       double(padImg(floor(sourceR)+2+2,floor(sourceC)-1+2))*weight_h3(floor(sourceR)-1,sourceR)*weight_h3(floor(sourceC)+2,sourceC) + ...
                                       double(padImg(floor(sourceR)+2+2,floor(sourceC)-0+2))*weight_h3(floor(sourceR)-1,sourceR)*weight_h3(floor(sourceC)+1,sourceC) + ...
                                       double(padImg(floor(sourceR)+2+2,floor(sourceC)+1+2))*weight_h3(floor(sourceR)-1,sourceR)*weight_h3(floor(sourceC)+0,sourceC) + ...
                                       double(padImg(floor(sourceR)+2+2,floor(sourceC)+2+2))*weight_h3(floor(sourceR)-1,sourceR)*weight_h3(floor(sourceC)-1,sourceC));
                            
                %%for l = -1:2
                    %%for k = -1:2
                        %%intensity += double(padImg(floor(sourceR)+l+1,floor(sourceC)+k+1))*weight_h3(sourceR,sourceR-l)*weight_h3(sourceC,sourceC-k);
                        %%%scaleImg(r,c) = scaleImg(r,c) + padImg(floor(sourceR)+l,floor(sourceC)+k)*weight_h3(sourceR,sourceR-l)*weight_h3(sourceC,sourceC-k);
                    %%endfor
                %%endfor
                %scaleImg(r,c) = uint8(intensity);
            endfor
        endfor
    endif
endfunction

function w = weight_h3(x,y)
    d = abs(x-y);
    if (d<1)
        w = 1-2*d^2+d^3;
    elseif (d>=1 && d<2)
        w = 4-8*d+5*d^2-d^3;
    else
        w = 0;
    endif
endfunction
