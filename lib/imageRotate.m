function rotImg = imageRotate(img,theta,point='centre',method='nearestNeighbor')
    printf("Rotating the image\n")
    point
    method
    [row,col] = size(img);
    theta = theta*pi/180;
    if (strcmp(point,'centre'))
        r0 = int32(row/2); c0 = int32(col/2);
    else
        r0 = int32(point(1)); c0 = int32(point(2));
    endif
    
    rRotMin=row; rRotMax=0; cRotMin=col; cRotMax=0;
    for r = 1:row-1:row
        for c = 1:col-1:col
            rRot = round(cos(theta)*double(r-r0) - sin(theta)*double(c-c0) + double(r0));
            cRot = round(sin(theta)*double(r-r0) + cos(theta)*double(c-c0) + double(c0));
            if (rRot<rRotMin)
                rRotMin = rRot;
            endif
            if (rRot>rRotMax)
                rRotMax = rRot;
            endif
            if (cRot<cRotMin)
                cRotMin = cRot;
            endif
            if (cRot>cRotMax)
                cRotMax = cRot;
            endif
        endfor
    endfor
    
    rotImg = zeros(rRotMax-rRotMin+1,cRotMax-cRotMin+1,"uint8");
    if (strcmp(method,'nearestNeighbor'))
        padImg = img;
    elseif (strcmp(method,'bilinear'))
        padImg = [img;img(row,:)];
        padImg = [padImg padImg(:,col)];
    elseif (strcmp(method,'bicubic'))
        padImg = img;
        %padImg = [img;img(row,:);img(row-1,:)];
        %padImg = [padImg padImg(:,col) padImg(:,col-1)];
        %padImg = [padImg(2,:); padImg(1,:); padImg];
        %padImg = [padImg(:,2) padImg(:,1) padImg];
    endif
    for rRot = rRotMin:rRotMax
        for cRot = cRotMin:cRotMax
            r1 =  cos(theta)*double(rRot-r0) + sin(theta)*double(cRot-c0) + double(r0);
            c1 = -sin(theta)*double(rRot-r0) + cos(theta)*double(cRot-c0) + double(c0);
            if (r1>=0.5 && r1<row+0.5 && c1>=0.5 && c1<col+0.5)
                if (strcmp(method,'nearestNeighbor'))
                    rotImg(rRot-rRotMin+1,cRot-cRotMin+1) = padImg(round(r1),round(c1));
                elseif (strcmp(method,'bilinear'))
                    floor_r1 = max(1,floor(r1)); floor_c1 = max(1,floor(c1));
                    rotImg(rRot-rRotMin+1,cRot-cRotMin+1) = ...
                    padImg(floor_r1+0,floor_c1+0)*(floor(r1)+1-r1)*(floor(c1)+1-c1) + ...
                    padImg(floor_r1+0,floor_c1+1)*(floor(r1)+1-r1)*(c1-floor(c1)+0) + ...
                    padImg(floor_r1+1,floor_c1+0)*(r1-floor(r1)+0)*(floor(c1)+1-c1) + ...
                    padImg(floor_r1+1,floor_c1+1)*(r1-floor(r1)+0)*(c1-floor(c1)+0);
                elseif (strcmp(method,'bicubic'))
                    rotImg(rRot-rRotMin+1,cRot-cRotMin+1) = padImg(round(r1),round(c1));
                endif
            endif
        endfor
    endfor
endfunction
