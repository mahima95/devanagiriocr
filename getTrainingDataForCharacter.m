%% Select image of chatacter to be added to the dataset 
[filename , pathname] = uigetfile({'*.png';'*.jpg'},'File Selector');
I=imread(strcat(pathname, filename));
figure,imshow(I);
I=im2bw(I,0.9);

%% Input class of the image from user
class=inputdlg('Character class?','Select Character Class');
class=str2num(class{1});

%% Extract data for multiple images of same charcter
[lines,line_count]=getLines(I);
total_words=0;
total_chars=0;
char_counter=0;
for i=1:length(lines)
    [words,word_count]=getWords(lines{i});
    total_words=total_words+word_count;
    for j=1:length(words)
        [chars,char_count]=getChars(words{j});
        total_chars=total_chars+char_count;
        for k=1:length(chars)
            char_counter=char_counter+1;
            X_new(char_counter,:)=extractData(chars{k});
        end
    end
end

%% Add data to dataset
Y_new=zeros(size(X_new,1),36);
for i=1:size(Y_new,1);
    Y_new(i,class)=1;
end

if exist('test_data_test.mat')

load('test_data_test.mat');
X=[X;X_new];
load('test_output_test.mat');
Y=[Y;Y_new];

save('test_data_test.mat','X','-append');
save('test_output_test.mat','Y','-append');

else
    X=X_new;
    Y=Y_new;
    save('test_data_test.mat','X');
    save('test_output_test.mat','Y');
end

msgbox('Successfully added to dataset');
