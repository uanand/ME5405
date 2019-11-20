function img = textTOascii(text)
% textTOascii -
%   Function to transform the text string into an image using ASCII encoding.
% 
% Input parameters -
%   text - a text string which can be generated by reading a text file.
%
% Usage -
% img = textTOascii(text)
%   A string is required as input
%   The function works well only for the specific text image in the project. It ignores the characters corresponding to new line and return key and makes an vector of all the other character by encoding them in the corresponding ASCII value. Finally this vector is reshaped into a 64x64 matrix.
%
% Returns -
%   img - a 64x64 grayscale image with 255 allowed grayscale levels ranging from 0-255 
    [~,numElements] = size(text);
    listImg = [];
    for c = 1:numElements
        char = double(text(c));
        if not(char==10 || char==13)
            listImg = [listImg,char];
        end
    end
    [~,numElements] = size(listImg);
    row=64; col=64;
    img = zeros(row,col,'uint8');
    for r = 1:row
        for c = 1:col
            img(r,c) = listImg((r-1)*col + c);
        end
    end
end
