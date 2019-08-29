function count = histogram(img,normalize=0)
    printf("Calculating the histogram of image");
    [row,col] = size(img);
    count = zeros(1,256);
    for r = 1:row;
        for c = 1:col;
            count(img(r,c)+1) = count(img(r,c)+1)+1;
        endfor
    endfor
    if (normalize == 1);
        count = 1.0*count/(row*col);
    endif
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


