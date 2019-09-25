function rotImg = imageRotate(img,theta,method='nearestNeighbor')
    [row,col] = size(img);
    theta = theta*pi/180;
    
    rRotMin=row; rRotMax=0; cRotMin=col; cRotMax=0;
    for r = 1:row-1:row
        for c = 1:col-1:col
            rRot = round(cos(theta)*double(r) - sin(theta)*double(c));
            cRot = round(sin(theta)*double(r) + cos(theta)*double(c));
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
            r1 =  cos(theta)*double(rRot) + sin(theta)*double(cRot);
            c1 = -sin(theta)*double(rRot) + cos(theta)*double(cRot);
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
