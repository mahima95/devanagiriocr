function [ X , I ] = detectMatras2( I )
%DETECTMATRAS2 Summary of this function goes here
%   Detailed explanation goes here

X=0;

t3=imread('3.png');
t4=imread('6.png');

I=imresize(I,[30,30]);
I2=I;
I3=I;

%%figure,imshow(I);

I2(9:30,7:30)=1;
c3=corr2(I2,t3);

I3(9:30,1:25)=1;
%%figure,imshow(I3);
c4=corr2(I3,t4);



t1=imread('t1.png');
t2=imread('t3.png');

c1=normxcorr2(t1,I);
c2=normxcorr2(t2,I);
c1=c1>0.7;
c2=c2>0.6;


if sum(sum(c1))>0
    X=1; %%2matras
    I=I(10:30,:);
elseif sum(sum(c2))>0
    X=2; %%1matra
    I=I(10:30,:);
elseif c3>0.5 
    X=3; %%choti ii
    I=I(9:30,7:30);
elseif c4>0.5
    X=4; %%badi ii
    I=I(9:30,1:25);
end

    
end

