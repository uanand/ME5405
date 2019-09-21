function [bImg,th] = threshold(img,method="mean",th=0)
    printf("Binarizing the image based on the selected threshold method\n");
    [row,col] = size(img);
    bImg = zeros(row,col,"logical");
    
    if (strcmp(method,"constant"))
        for r = 1:row;
            for c = 1:col;
                if (img(r,c)>th)
                    bImg(r,c) = 1;
                endif;
            endfor;
        endfor;
    elseif (strcmp(method,"mean"))
        th = 0;
        for r = 1:row;
            for c = 1:col;
                th = th+double(img(r,c));
            endfor
        endfor
        th = double(th/(row*col));
        for r = 1:row;
            for c = 1:col;
                if (img(r,c)>th)
                    bImg(r,c) = 1;
                endif;
            endfor;
        endfor;
    elseif (strcmp(method,"median"))
        vectorImg = reshape(img,1,row*col);
        th = median(vectorImg);
        for r = 1:row
            for c = 1:col
                if (img(r,c)>th)
                    bImg(r,c) = 1;
                endif;
            endfor;
        endfor;
    elseif (strcmp(method,"otsu"))
        classVariance = 1e10;
        hist = histogram(img);
        for intensity = 0:255
            w1 = 0;
            m1 = 0;
            m1_2 = 0;
            w2 = 0;
            m2 = 0;
            m2_2 = 0;
            for i1 = 0:intensity
                w1 = w1 + hist(i1+1);
                m1 = m1 + i1*hist(i1+1);
                m1_2 = m1_2 + i1^2*hist(i1+1);
            endfor
            for i2 = intensity+1:255
                w2 = w2 + hist(i2+1);
                m2 = m2 + i2*hist(i2+1);
                m2_2 = m2_2 + i2^2*hist(i2+1);
            endfor
            if (w1>0 && w2>0)
                m1 = m1/w1;
                m1_2 = m1_2/w1;
                var1 = m1_2-m1^2;
                w1 = w1/double(row*col);
                m2 = m2/w2;
                m2_2 = m2_2/w2;
                var2 = m2_2-m2^2;
                w2 = w2/double(row*col);
                variance = w1*var1 + w2*var2;
                if (variance<classVariance)
                    classVariance = variance;
                    th = intensity;
                endif
            endif
        endfor
        for r = 1:row
            for c = 1:col
                if (img(r,c)>th)
                    bImg(r,c) = 1;
                endif;
            endfor;
        endfor;
    elseif (strcmp(method,"maxentropy"))
        entropy = -1e10;
        prob = histogram(img,normalize=1);
        P_s = zeros(256);
        H_s = zeros(256);
        phi_s = zeros(256);
        H_n = 0;
        for s = 0:255
            if (prob(s+1)>0)
                H_n = H_n-prob(s+1)*log(prob(s+1));
            endif
        endfor
        for s = 0:255
            for i = 0:s
                if (prob(i+1)>0)
                    P_s(s+1) = P_s(s+1)+prob(i+1);
                    H_s(s+1) = H_s(s+1)-prob(i+1)*log(prob(i+1));
                endif
            endfor
            if (P_s(s+1)>0 && P_s(s+1)<1)
                phi_s = log(P_s(s+1)*(1-P_s(s+1))) + H_s(s+1)/P_s(s+1) + (H_n-H_s(s+1))/(1-P_s(s+1));
                if (phi_s>entropy)
                    th = s;
                    entropy = phi_s;
                endif
            endif
        endfor
        for r = 1:row
            for c = 1:col
                if (img(r,c)>th)
                    bImg(r,c) = 1;
                endif;
            endfor;
        endfor;
    else
        printf("The method you entered is not valid. Please choose 1 of the following - constant, mean, median, otsu, maxentropy\n")
    endif
endfunction
