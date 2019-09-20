function img = imageRotate(img,angle,point='centre',interpolation='nearestneighbor')
    printf("Rotating the image.\n")
    angle = angle*pi/180;
    [row,col] = size(img);
    if (strcmp(point,'centre'))
        %point = [int32(row/2),int32(col/2)];
        r0 = int32(row/2); c0 = int32(col/2);
    else
        r0 = int32(point(1)); c0 = int32(point(2));
    endif
    for r = 1:10
        for c = 1:5
            r1 = cos(angle)*double(r-r0) - sin(angle)*double(c-c0) + double(r0);
            c1 = sin(angle)*double(r-r0) + cos(angle)*double(c-c0) + double(c0);
            printf("%d\t%d\t%f\t%f\n",r,c,r1,c1);
        endfor
    endfor
    
    
endfunction
