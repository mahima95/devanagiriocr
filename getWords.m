function [ words , word_count ] = getWords(I)
%GETWORDS Summary of this function goes here
%   Returns the image of words and the wordcount found in a single line

%% getting size of image
[rows,cols]=size(I);

%% plotting vertical histogram
v_hist=zeros(1,cols);
for i=1:cols
    for j=1:rows
        if(I(j,i)==0)
            v_hist(i)=v_hist(i)+1;
        end
    end
end

%% seperating words
word_count=1;
start_col=1;
current_col=1;
while(current_col<=cols)
    if(v_hist(current_col)==0 && current_col-start_col>3)
        end_col=current_col;
        words(word_count)={I(:,start_col:end_col)};
        word_count=word_count+1;
        start_col=end_col+1;
    end
    if(current_col==cols && current_col-start_col>3)
        words(word_count)={I(:,start_col:cols)};
    end
    if(v_hist(current_col)==0)
        start_col=current_col;
    end
    current_col=current_col+1;
end

%% testing seperated words
%%for i=1:length(words)
    %%figure,imshow(words{i});
%%end


end

