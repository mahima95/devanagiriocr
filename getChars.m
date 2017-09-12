function [ chars , char_count] = getChars(I)
%GETCHARS Summary of this function goes here
%   Returns the image of characters and the number of characters in a
%   single word

%% getting size of image
[rows,cols]=size(I);

%% plotting horizontal histogram
h_hist = zeros(rows,1);
for i=1:rows
    for j=1:cols
        if(I(i,j)==0)
            h_hist(i)=h_hist(i)+1;
        end
    end
end

%% plotting vertical histogram
v_hist=zeros(1,cols);
for i=1:cols
    for j=1:rows
        if(I(j,i)==0)
            v_hist(i)=v_hist(i)+1;
        end
    end
end


[max_val,index]=max(h_hist);

%% getting the row numbers of shirorekha
c=1;
for i=-index+1:ceil(index)
    if(index+i>0 && index+i<length(h_hist)-1 && h_hist(index+i)>max_val-5)
        linekaindex(c)=index+i;
        c=c+1;
    end
end

%% checking limited number of pixels under shirorekha
p_cnt=zeros(1,cols);
for i=1:cols
    index=max(linekaindex);
    for j=index+1:index+((rows-index)/1.5);
        if(I(j,i)==0)
            p_cnt(i)=p_cnt(i)+1;
        end
    end
end


%% breaking the shirorekha
for i=1:cols
    if(p_cnt(i)==0)
        for j=1:length(linekaindex)
            I(linekaindex(j),i)=1;
        end
    end
end


%% image of word with broken characters
%%figure,imshow(I);

%% sepertating chars
char_count=1;
CC=bwconncomp(~I);
S=regionprops(CC);
for i=1:length(S)
    if(S(i).Area>1)
        x=ceil(S(i).BoundingBox(1));
        y=ceil(S(i).BoundingBox(2));
        xlen=floor(S(i).BoundingBox(3)-1);
        ylen=floor(S(i).BoundingBox(4)-1);
        if(xlen*ylen>5)
            chars(char_count)={I(y:y+ylen,x:x+xlen)};
            char_count=char_count+1;
        end
    end
end
char_count=length(chars);

for i=1:length(chars)
    img=chars{i};
    CC2=bwconncomp(~img);
    S2=regionprops(CC2);
    length(S2);
    if(length(S2)>1)
        for j=1:length(S2)
            a(j)=S2(j).Area;
        end
        [m,m_i]=max(a);
        for j=1:length(S2)
            if(j~=m_i)
                x=ceil(S2(j).BoundingBox(1));
                y=ceil(S2(j).BoundingBox(2));
                xlen=floor(S2(j).BoundingBox(3)-1);
                ylen=floor(S2(j).BoundingBox(4)-1);
                for k=x:x+xlen
                    for l=y:y+ylen
                        img(l,k)=1;
                    end
                end
            end
        end
    end
    chars{i}=img;
end

%% testing seperated characters
%%for i=1:length(chars);
    %%size(chars{i})
    %%figure,imshow(chars{i});
    %%waitforbuttonpress
%%end
