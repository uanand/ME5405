function img = textTOascii(text)
    [~,numElements] = size(text);
    listImg = [];
    for c = 1:numElements
        char = toascii(text(c));
        if !(char==10 || char==13)
            listImg = [listImg,char];
        endif
    endfor
    [~,numElements] = size(listImg);
    row=64; col=64;
    img = zeros(row,col,'uint8');
    for r = 1:row
        for c = 1:col
            img(r,c) = listImg((r-1)*col + c);
        endfor
    endfor
endfunction
