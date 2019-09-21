function bImg = boundary(bImg)
    printf("Finding the boundary of binary image\n")
    [row,col] = size(img)
    padImg = [img(1,:);img];
    padImg = [padImg(:,1) padImg];
    padImg = [padImg;padImg(row+1,:)];
    padImg = [padImg padImg(:,col+1)];
    
endfunction
