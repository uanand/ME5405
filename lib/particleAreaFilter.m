function bImg = particleAreaFilter(bImg,minArea=0,maxArea=1e10)
    [row,col] = size(bImg);
    [labelImg,numLabel] = bwlabel(bImg,8);
    removeLabel = [];
    props = regionProps(labelImg);
    for label = 1:numLabel
        if (props(label).Area<minArea || props(label).Area>maxArea)
            removeLabel = [removeLabel label];
        endif
    endfor
    for r = 1:row
        for c = 1:col
            if (max(labelImg(r,c)==removeLabel))
                bImg(r,c) = 0;
            endif
        endfor
    endfor
endfunction
