function scaleImg = imageScale(img,targetRow,targetCol,method)
% imageScale - scale up or down the image by increasing or decreasing the number of rows and columns in the image.
% 
% Input parameters -
%   img - 8-bit grayscale image which you need to scale up or down
%   targetRow - number of rows you want in the final image. This corresponds to the height of the scaled image in pixels.
%   targetCol - number of columns you want in the final image. This corresponds to the width of the scaled image in pixels.
%   method - inerpolation method that you want to use for scaling up or down the images. Options are 'nearestNeighbor', and 'bilinear'
% 
% Usage -
% scaleImg = imageScale(img,100,200,'nearestNeighbor')
%   Let's assume that the input image is 512x512 pixels. This is an example of downscaling. The final scaled image will have 100 rows and 200 columns (100x200 pixels) and will be genereted using nearest neighbor interpolation method.
% scaleImg = imageScale(img,637,512,'bilinear')
%   Let's assume that the input image is 100x200 pixels. This is an example of upscaling. The final scaled image will have 637 rows and 512 columns (637x512 pixels) and will be genereted using bilinear interpolation method.
%
% Returns -
%   Scaled image. The size of the scaled image is defined by the targetRow and targetCol input parameters.
    [row,col] = size(img);
    scaleImg = zeros(targetRow,targetCol,"uint8");
    
    scaleMat = [double(targetRow)/double(row),0;0,double(targetCol)/double(col)];
    invScaleMat = inv(scaleMat);
    
    if (strcmp(method,'nearestNeighbor'))
        padImg = double(img);
    elseif (strcmp(method,'bilinear'))
        padImg = double([img;img(row,:)]);
        padImg = [padImg padImg(:,col)];
    end
    for r = 1:targetRow
        for c = 1:targetCol
            r1 = max(1,invScaleMat(1,1)*r);
            c1 = max(1,invScaleMat(2,2)*c);
            if (strcmp(method,'nearestNeighbor'))
                scaleImg(r,c) = img(round(r1),round(c1));
            elseif (strcmp(method,'bilinear'))
                floor_r1 = max(1,floor(r1)); floor_c1 = max(1,floor(c1));
                scaleImg(r,c) = round(...
                padImg(floor_r1+0,floor_c1+0)*(floor(r1)+1-r1)*(floor(c1)+1-c1) + ...
                padImg(floor_r1+0,floor_c1+1)*(floor(r1)+1-r1)*(c1-floor(c1)+0) + ...
                padImg(floor_r1+1,floor_c1+0)*(r1-floor(r1)+0)*(floor(c1)+1-c1) + ...
                padImg(floor_r1+1,floor_c1+1)*(r1-floor(r1)+0)*(c1-floor(c1)+0));
            end
        end
    end
end
