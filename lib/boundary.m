function bImg = boundary(bImg)
    printf("Finding the boundary of binary image\n")
    [row,col] = size(img)
    padImg = [img;img(row,:)];
    padImg = [padImg padImg(:,col)];
    
endfunction
