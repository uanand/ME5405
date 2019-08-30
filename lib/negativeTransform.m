function img = negativeTransform(img)
    printf("Inverting the input image");
    [row,col] = size(img);
    for r = 1:row
        for c = 1:col
            img(r,c) = 255-img(r,c);
        endfor
    endfor
endfunction

%function img = asciiTOgrayscale(asciiImg)
    %[row,col] = size(asciiImg);
    %img = zeros(row,col,'uint8');
    %for r = 1:row
        %for c = 1:col
            %img(r,c) = str2ascii(asciiImg(r,c));
        %endfor
    %endfor
%endfunction


%def rotate(img,angle):
%
%
%def otsuThreshold(img):
%
%
%def kapurThreshold(img):


