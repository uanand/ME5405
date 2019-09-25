function [bImgSkeleton] = skeleton(bImg)
    [row,col] = size(bImg);
    skeletonImg0 = bImg; skeletonImg0(1,:) = 0; skeletonImg0(row,:) = 0; skeletonImg0(:,1) = 0; skeletonImg0(:,col) = 0;
    skeletonImg1 = skeletonImg0;
    flag = 0;
    while (flag==0)
        skeletonImg1 = runKernel1(skeletonImg1);
        skeletonImg1 = runKernel2(skeletonImg1);
        skeletonImg1 = runKernel3(skeletonImg1);
        skeletonImg1 = runKernel4(skeletonImg1);
        skeletonImg1 = runKernel5(skeletonImg1);
        skeletonImg1 = runKernel6(skeletonImg1);
        skeletonImg1 = runKernel7(skeletonImg1);
        skeletonImg1 = runKernel8(skeletonImg1);
        if (isequal(skeletonImg0,skeletonImg1))
            flag = 1;
        else
            skeletonImg0 = skeletonImg1;
        endif
    endwhile
    bImgSkeleton = skeletonImg0;
endfunction

function bImg2 = runKernel1(bImg)
    [row,col] = size(bImg);
    bImg2 = bImg;
    for r = 2:row-1
        for c = 2:col-1
            if (bImg(r,c)==1)
                if (bImg(r-1,c-1)==0 && ...
                    bImg(r-1,c)==0   && ...
                    bImg(r-1,c+1)==0 && ...
                    bImg(r+1,c-1)==1 && ...
                    bImg(r+1,c)==1   && ...
                    bImg(r+1,c+1)==1)
                        bImg2(r,c) = 0;
                endif
            endif
        endfor
    endfor
endfunction

function bImg2 = runKernel2(bImg)
    [row,col] = size(bImg);
    bImg2 = bImg;
    for r = 2:row-1
        for c = 2:col-1
            if (bImg(r,c)==1)
                if (bImg(r-1,c)==0 && ...
                    bImg(r-1,c+1)==0   && ...
                    bImg(r,c+1)==0 && ...
                    bImg(r,c-1)==1 && ...
                    bImg(r+1,c-1)==1   && ...
                    bImg(r+1,c)==1)
                        bImg2(r,c) = 0;
                endif
            endif
        endfor
    endfor
endfunction

function bImg2 = runKernel3(bImg)
    [row,col] = size(bImg);
    bImg2 = bImg;
    for r = 2:row-1
        for c = 2:col-1
            if (bImg(r,c)==1)
                if (bImg(r-1,c+1)==0 && ...
                    bImg(r,c+1)==0   && ...
                    bImg(r+1,c+1)==0 && ...
                    bImg(r-1,c-1)==1 && ...
                    bImg(r,c-1)==1   && ...
                    bImg(r+1,c-1)==1)
                        bImg2(r,c) = 0;
                endif
            endif
        endfor
    endfor
endfunction

function bImg2 = runKernel4(bImg)
    [row,col] = size(bImg);
    bImg2 = bImg;
    for r = 2:row-1
        for c = 2:col-1
            if (bImg(r,c)==1)
                if (bImg(r-1,c-1)==1 && ...
                    bImg(r-1,c)==1   && ...
                    bImg(r,c-1)==1 && ...
                    bImg(r,c+1)==0 && ...
                    bImg(r+1,c+1)==0   && ...
                    bImg(r+1,c)==0)
                        bImg2(r,c) = 0;
                endif
            endif
        endfor
    endfor
endfunction

function bImg2 = runKernel5(bImg)
    [row,col] = size(bImg);
    bImg2 = bImg;
    for r = 2:row-1
        for c = 2:col-1
            if (bImg(r,c)==1)
                if (bImg(r-1,c-1)==1 && ...
                    bImg(r-1,c)==1   && ...
                    bImg(r-1,c+1)==1 && ...
                    bImg(r+1,c-1)==0 && ...
                    bImg(r+1,c)==0   && ...
                    bImg(r+1,c+1)==0)
                        bImg2(r,c) = 0;
                endif
            endif
        endfor
    endfor
endfunction

function bImg2 = runKernel6(bImg)
    [row,col] = size(bImg);
    bImg2 = bImg;
    for r = 2:row-1
        for c = 2:col-1
            if (bImg(r,c)==1)
                if (bImg(r-1,c)==1 && ...
                    bImg(r-1,c+1)==1   && ...
                    bImg(r,c+1)==1 && ...
                    bImg(r,c-1)==0 && ...
                    bImg(r+1,c-1)==0   && ...
                    bImg(r+1,c)==0)
                        bImg2(r,c) = 0;
                endif
            endif
        endfor
    endfor
endfunction

function bImg2 = runKernel7(bImg)
    [row,col] = size(bImg);
    bImg2 = bImg;
    for r = 2:row-1
        for c = 2:col-1
            if (bImg(r,c)==1)
                if (bImg(r-1,c+1)==1 && ...
                    bImg(r,c+1)==1   && ...
                    bImg(r+1,c+1)==1 && ...
                    bImg(r-1,c-1)==0 && ...
                    bImg(r,c-1)==0   && ...
                    bImg(r+1,c-1)==0)
                        bImg2(r,c) = 0;
                endif
            endif
        endfor
    endfor
endfunction

function bImg2 = runKernel8(bImg)
    [row,col] = size(bImg);
    bImg2 = bImg;
    for r = 2:row-1
        for c = 2:col-1
            if (bImg(r,c)==1)
                if (bImg(r-1,c-1)==0 && ...
                    bImg(r-1,c)==0   && ...
                    bImg(r,c-1)==0 && ...
                    bImg(r,c+1)==1 && ...
                    bImg(r+1,c+1)==1   && ...
                    bImg(r+1,c)==1)
                        bImg2(r,c) = 0;
                endif
            endif
        endfor
    endfor
endfunction
