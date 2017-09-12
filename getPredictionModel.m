clear all;
clc;
%% loading dataset
load test_output_test.mat
load test_data_test.mat

X=X';
Y=Y';

%% train a pattern dectection network with 4 hidden layers
net=patternnet([500,250,125,65]);
[net,tr]=train(net,X,Y);
save('nnmodel.mat','net');