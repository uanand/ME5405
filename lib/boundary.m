function bImgBdry = boundary(bImg)
% bImgBdry -
%   Finds out the boundary of each object in a binary image.
% 
% Input parameters -
%   bImg - binary image for which you need to find the boundary of the components
% 
% Usage
% bImgBdry = boundary(bImg)
%   To find the boundary, first bImg is eroded using a 3x3 kernel which looks like [[1,1,1],[1,1,1],[1,1,1]].
%   Following this trhe eroded image is subtracted from the original binary image.
%   All the pixels not are not a part of the boundary become 0 and the boundary pixels become 1
%
% Returns
%   A new binary image with all the boundary pixels marked as 1
    [row,col] = size(bImg);
    bImgErode = zeros(row,col,'logical');
    bImgBdry = zeros(row,col,'logical');
    for r = 2:row-1
        for c = 2:col-1
            product = bImg(r-1,c)*bImg(r,c-1)*bImg(r,c)*bImg(r,c+1)*bImg(r+1,c);
            if (product == 1)
                bImgErode(r,c) = 1;
            end
        end
    end
    for r = 1:row
        for c = 1:col
            if (bImg(r,c)==1 && bImgErode(r,c)==0)
                bImgBdry(r,c) = 1;
            end
        end
    end
end
