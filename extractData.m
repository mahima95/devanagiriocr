function [ X ] = extractData( I )
%EXTRACTDATA Summary of this function goes here
%   Returns the extracted data from the given image


size2=[30,30];
I=imresize(I,size2);
%%skletonization
%%I2=~bwmorph(~I,'skel',inf');
%%I=I2;

%% saving extracted data in the form of a vector
X=reshape(I,[1,900]);
X=double(X);
X=X';
end

