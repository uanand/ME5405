function props = regionProps(labelImg)
    [row,col] = size(labelImg);
    numLabel = max(labelImg(:));
    for label = 1:numLabel
        props(label).Area = 0;
        props(label).BoundingBox = [row,1,col,1];
    endfor
    for r = 1:row
        for c = 1:col
            if (labelImg(r,c)>0)
                label = labelImg(r,c);
                props(label).Area++;
                if (props(label).BoundingBox(1)>r)
                    props(label).BoundingBox(1) = r;
                endif;
                if (props(label).BoundingBox(2)<r)
                    props(label).BoundingBox(2) = r;
                endif;
                if (props(label).BoundingBox(3)>c)
                    props(label).BoundingBox(3) = c;
                endif;
                if (props(label).BoundingBox(4)<c)
                    props(label).BoundingBox(4) = c;
                endif;
            endif
        endfor
    endfor
    for label = 1:numLabel
        rCenter = int32(props(label).BoundingBox(1) + (props(label).BoundingBox(2)-props(label).BoundingBox(1))/2);
        cCenter = int32(props(label).BoundingBox(3) + (props(label).BoundingBox(4)-props(label).BoundingBox(3))/2);
        width = props(label).BoundingBox(4)-props(label).BoundingBox(3)+1;
        height = props(label).BoundingBox(2)-props(label).BoundingBox(1)+1;
        props(label).Centroid = [rCenter,cCenter];
        props(label).Width = width;
        props(label).Height = height;
    endfor
endfunction
