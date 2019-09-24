function [bImgSkeleton] = skeleton(bImg)
    printf('Finding out the skeleton for all the binary objects in image\n')
    [labelImg,numLabel] = bwlabel(bImg);
    numLabel
endfunction
