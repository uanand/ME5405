function [labelImg,numLabel,boundingBox] = particleBoundingBox(bImg)
    [row,col] = size(bImg);
    [labelImg,numLabel] = bwlabel(bImg);
    for label = 1:numLabel
        boundingBox(label).rMin = row;
        boundingBox(label).rMax = 1;
        boundingBox(label).cMin = col;
        boundingBox(label).cMax = 1;
    endfor
    for r = 1:row
        for c = 1:col
            if (labelImg(r,c)>0)
                label = labelImg(r,c);
                if (boundingBox(label).rMin>r)
                    boundingBox(label).rMin = r;
                endif
                if (boundingBox(label).rMax<r)
                    boundingBox(label).rMax = r;
                endif
                if (boundingBox(label).cMin>c)
                    boundingBox(label).cMin = c;
                endif
                if (boundingBox(label).cMax<c)
                    boundingBox(label).cMax = c;
                endif
            endif
        endfor
    endfor
endfunction
