function [labelImg,numLabel] = label(bImg)
    printf("Labeling particles based on 8-connectivity.\n");
    [row,col] = size(bImg);
    labelImg = zeros(row,col,"int32");
    numLabel = 0;
    for r = 1:row
        for c = 1:col
            if (bImg(r,c)==1)
                if ((r>1 && r<row) && (c>1 && c<col))
                    nearLabel = max([labelImg(r-1,c-1),labelImg(r-1,c),labelImg(r-1,c+1),labelImg(r,c-1),labelImg(r,c),labelImg(r,c+1),labelImg(r+1,c-1),labelImg(r+1,c),labelImg(r+1,c+1)]);
                    allLabels = unique([labelImg(r-1,c-1),labelImg(r-1,c),labelImg(r-1,c+1),labelImg(r,c-1),labelImg(r,c),labelImg(r,c+1),labelImg(r+1,c-1),labelImg(r+1,c),labelImg(r+1,c+1)]);
                elseif ((r==1) && (c>1 && c<col))
                    nearLabel = max([labelImg(r,c-1),labelImg(r,c),labelImg(r,c+1),labelImg(r+1,c-1),labelImg(r+1,c),labelImg(r+1,c+1)]);
                    allLabels = unique([labelImg(r,c-1),labelImg(r,c),labelImg(r,c+1),labelImg(r+1,c-1),labelImg(r+1,c),labelImg(r+1,c+1)]);
                elseif ((r==row) && (c>1 && c<col))
                    nearLabel = max([labelImg(r-1,c-1),labelImg(r-1,c),labelImg(r-1,c+1),labelImg(r,c-1),labelImg(r,c),labelImg(r,c+1)]);
                    allLabels = unique([labelImg(r-1,c-1),labelImg(r-1,c),labelImg(r-1,c+1),labelImg(r,c-1),labelImg(r,c),labelImg(r,c+1)]);
                elseif ((r>1 && r<row) && (c==1))
                    nearLabel = max([labelImg(r-1,c),labelImg(r,c),labelImg(r+1,c),labelImg(r-1,c+1),labelImg(r,c+1),labelImg(r+1,c+1)]);
                    allLabels = unique([labelImg(r-1,c),labelImg(r,c),labelImg(r+1,c),labelImg(r-1,c+1),labelImg(r,c+1),labelImg(r+1,c+1)]);
                elseif ((r>1 && r<row) && (c==col))
                    nearLabel = max([labelImg(r-1,c-1),labelImg(r,c-1),labelImg(r+1,c-1),labelImg(r-1,c),labelImg(r,c),labelImg(r+1,c)]);
                    allLabels = unique([labelImg(r-1,c-1),labelImg(r,c-1),labelImg(r+1,c-1),labelImg(r-1,c),labelImg(r,c),labelImg(r+1,c)]);
                elseif (r==1 && c==1)
                    nearLabel = max([labelImg(r,c),labelImg(r,c+1),labelImg(r+1,c),labelImg(r+1,c+1)]);
                    allLabels = unique([labelImg(r,c),labelImg(r,c+1),labelImg(r+1,c),labelImg(r+1,c+1)]);
                elseif (r==1 && c==col)
                    nearLabel = max([labelImg(r,c-1),labelImg(r,c),labelImg(r+1,c-1),labelImg(r+1,c)]);
                    allLabels = unique([labelImg(r,c-1),labelImg(r,c),labelImg(r+1,c-1),labelImg(r+1,c)]);
                elseif (r==row && c==1)
                    nearLabel = max([labelImg(r-1,c),labelImg(r-1,c+1),labelImg(r,c),labelImg(r,c+1)]);
                    allLabels = unique([labelImg(r-1,c),labelImg(r-1,c+1),labelImg(r,c),labelImg(r,c+1)]);
                elseif (r==row && c==col)
                    nearLabel = max([labelImg(r-1,c-1),labelImg(r-1,c),labelImg(r,c-1),labelImg(r,c)]);
                    allLabels = unique([labelImg(r-1,c-1),labelImg(r-1,c),labelImg(r,c-1),labelImg(r,c)]);
                endif
                if (nearLabel>0)
                    labelImg(r,c) = nearLabel;
                else
                    numLabel = numLabel+1;
                    labelImg(r,c) = numLabel;
                endif
            endif
        endfor
    endfor
    
    for r = 1:row
        for c = 1:col
            
        endfor
    endfor
endfunction
