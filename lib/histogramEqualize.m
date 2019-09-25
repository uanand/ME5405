function [imgEq,histEq] = histogramEqualize(img)
    [row,col] = size(img);
    imgEq = zeros(row,col,"uint8");
    H = zeros(1,256);
    histCum = zeros(1,256);
    hist = histogram(img);
    for i = 1:256;
        totalCount = 0;
        for j = 1:i;
            totalCount = totalCount + hist(j);
        endfor
        histCum(i+1) = totalCount;
    endfor
    for r = 1:row;
        for c = 1:col;
            imgEq(r,c) = round(255.0/double(row*col) * double(histCum(img(r,c)+1)));
        endfor
    endfor
    histEq = histogram(imgEq);
endfunction
