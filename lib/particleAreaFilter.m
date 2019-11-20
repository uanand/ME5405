function bImg = particleAreaFilter(bImg,minArea,maxArea)
% particleAreaFilter -
%   Morphological filter to remove connected objects in a binary image which are not within the specified area range.
% 
% Input parameters -
%   bImg - binary image on which you want to apply area filter
%   minArea - the filter removes the connected components with area smaller than this. Area should be in pixels.
%   maxArea - the filter removes the connected components with area larger than this. Area should be in pixels.
% 
% Usage -
% bImg = particleAreaFilter(bImg,100,500)
%   1 binary image is required as input parameter.
%   minArea is set to 100
%   maxArea is set to 500
%   Any connected components with area smaller than 100 or larger than 500 is removed.
% bImg = particleAreaFilter(bImg,100,1e10)
%   Setting maxArea to a very big number (1e10), we can use it as a filter which remove only the small particle (less than 100 pixels big)
%
% Returns -
%   bImg. Returns a binary image with all the connected components not within the desired area removed. 
    [row,col] = size(bImg);
    [labelImg,numLabel] = bwlabel(bImg,8);
    removeLabel = [];
    props = regionProps(labelImg);
    for label = 1:numLabel
        if (props(label).Area<minArea || props(label).Area>maxArea)
            removeLabel = [removeLabel label];
        end
    end
    for r = 1:row
        for c = 1:col
            if (max(labelImg(r,c)==removeLabel))
                bImg(r,c) = 0;
            end
        end
    end
end
