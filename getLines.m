function [ lines , line_count ] = getLines( I )
%GETLINES Summary of this function goes here
%   Returns the image of the lines and the number of lines found in the
%   image

%% determine size of image
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

%% seperating lines
line_count=1;
start_row=1;
current_row=1;
while(current_row<=rows)
    if(h_hist(current_row)==0 && current_row-start_row>2 && h_hist(current_row-3)==0)
        end_row=current_row;
        lines(line_count)={I(start_row:end_row,:)};
        line_count=line_count+1;
        start_row=end_row+1;
    end 
    if(current_row==rows && current_row-start_row>2)
        lines(line_count)={I(start_row:rows,:)};
    end
    if(h_hist(current_row)==0 && current_row-start_row==1)
        start_row=current_row;
    end
    current_row=current_row+1;
end

line_count=length(lines);

%% testing detected lines
%%for i=1:length(lines)
    %%figure,imshow(lines{i});
%%end

end

