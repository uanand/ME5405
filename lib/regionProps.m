function props = regionProps(labelImg)
% regionProps -
%   Function to calculate some properties of all connected components. Bounding box, area, centroid, width, and height of each label is stored as a structure datatype.
% 
% Input parameters -
%   labelImg - labeled image with all the different connected components uniquely tagged.
%
% Usage -
% props = regionProps(labelImg)
%   A labeled matrix image is required as input
%   The function scans through all the labels and computer the properties for all of them. If the labelImg has has only zeros, the function will give an error message.
%
% Returns -
%   props. A struture vector of size N, where N is the number of labels in the input labelImg. To access the specific properties of label 10 use props(10).BoundingBox, props(10).Area, props(10).Centroid, props(10).Width, props(10).Height
    [row,col] = size(labelImg);
    numLabel = max(labelImg(:));
    for label = 1:numLabel
        props(label).Area = 0;
        props(label).BoundingBox = [row,1,col,1];
    end
    for r = 1:row
        for c = 1:col
            if (labelImg(r,c)>0)
                label = labelImg(r,c);
                props(label).Area++;
                if (props(label).BoundingBox(1)>r)
                    props(label).BoundingBox(1) = r;
                end;
                if (props(label).BoundingBox(2)<r)
                    props(label).BoundingBox(2) = r;
                end;
                if (props(label).BoundingBox(3)>c)
                    props(label).BoundingBox(3) = c;
                end;
                if (props(label).BoundingBox(4)<c)
                    props(label).BoundingBox(4) = c;
                end;
            end
        end
    end
    for label = 1:numLabel
        rCenter = int32(props(label).BoundingBox(1) + (props(label).BoundingBox(2)-props(label).BoundingBox(1))/2);
        cCenter = int32(props(label).BoundingBox(3) + (props(label).BoundingBox(4)-props(label).BoundingBox(3))/2);
        width = props(label).BoundingBox(4)-props(label).BoundingBox(3)+1;
        height = props(label).BoundingBox(2)-props(label).BoundingBox(1)+1;
        props(label).Centroid = [rCenter,cCenter];
        props(label).Width = width;
        props(label).Height = height;
    end
end
