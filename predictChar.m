function [ hindi_code ] = predictChar( I )
%PREDICTCHAR Summary of this function goes here
%   Returns the predicted character by simulating the neural network

%% Extract data from character
X=extractData(I);

%% Loading the trained neural network
load('nnmodel.mat');

%% Simulating the neural network
Ypred=net(X);
[val,label]=max(Ypred);

%% Printing the corresponding UTF-8 value
hindi_code=printChar(label);
end

