function rotImg = imageRotate(img,theta,method)
% imageRotate - Rotates the input image around its centre by theta degrees in counter clockwise direction.
% 
% Input parameters -
%   img - 8-bit grayscale image for which you need to rotate
%   theta - angle of rotation in degrees (counter clockwise)
%   method - inerpolation method that you want to use. Options are 'nearestNeighbor', and 'bilinear'
% 
% Usage -
% rotImg = imageRotate(img,40,'bilinear')
%   Rotates the input image by 40 degrees in the counter clockwise direction using bilinear interpolation method.
% rotImg = imageRotate(img,-90,'nearestNeighbor')
%   Rotates the input image by 90 degrees in the clockwise direction using nearest neightbor interpolation method.
%
% Returns -
%   Rotated image. The size of the rotated image is typically larger than the input image but it depends on the rotation angle.
    [row,col] = size(img);
    theta = theta*pi/180;
    
    rRotMin=row; rRotMax=0; cRotMin=col; cRotMax=0;
    for r = 1:row-1:row
        for c = 1:col-1:col
            rRot = round(cos(theta)*double(r) - sin(theta)*double(c));
            cRot = round(sin(theta)*double(r) + cos(theta)*double(c));
            if (rRot<rRotMin)
                rRotMin = rRot;
            end
            if (rRot>rRotMax)
                rRotMax = rRot;
            end
            if (cRot<cRotMin)
                cRotMin = cRot;
            end
            if (cRot>cRotMax)
                cRotMax = cRot;
            end
        end
    end
    
    rotImg = zeros(rRotMax-rRotMin+1,cRotMax-cRotMin+1,"uint8");
    if (strcmp(method,'nearestNeighbor'))
        padImg = img;
    elseif (strcmp(method,'bilinear'))
        padImg = [img;img(row,:)];
        padImg = [padImg padImg(:,col)];
    end
    for rRot = rRotMin:rRotMax
        for cRot = cRotMin:cRotMax
            r1 =  cos(theta)*double(rRot) + sin(theta)*double(cRot);
            c1 = -sin(theta)*double(rRot) + cos(theta)*double(cRot);
            if (r1>=0.5 && r1<row+0.5 && c1>=0.5 && c1<col+0.5)
                if (strcmp(method,'nearestNeighbor'))
                    rotImg(rRot-rRotMin+1,cRot-cRotMin+1) = padImg(round(r1),round(c1));
                elseif (strcmp(method,'bilinear'))
                    floor_r1 = max(1,floor(r1)); floor_c1 = max(1,floor(c1));
                    rotImg(rRot-rRotMin+1,cRot-cRotMin+1) = ...
                    padImg(floor_r1+0,floor_c1+0)*(floor(r1)+1-r1)*(floor(c1)+1-c1) + ...
                    padImg(floor_r1+0,floor_c1+1)*(floor(r1)+1-r1)*(c1-floor(c1)+0) + ...
                    padImg(floor_r1+1,floor_c1+0)*(r1-floor(r1)+0)*(floor(c1)+1-c1) + ...
                    padImg(floor_r1+1,floor_c1+1)*(r1-floor(r1)+0)*(c1-floor(c1)+0);
                end
            end
        end
    end
end
