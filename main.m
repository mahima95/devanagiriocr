function [ output ] = main( I )

%% basic preprocessing
BW=im2bw(I,0.9);
%%imshow(BW);

fid=fopen('out.txt','w');

%% seperating lines
[lines,line_count]=getLines(BW);
total_words=0;
total_chars=0;
for i=1:length(lines)
    %% seperating words
    [words,word_count]=getWords(lines{i});
    total_words=total_words+word_count;
    for j=1:length(words)
        %% seperating characters
        [chars,char_count]=getChars(words{j});
        total_chars=total_chars+char_count;
        for k=1:length(chars)
            %%prediction of character
            %%[matra,I]=detectMatras2(chars{k});
            %%matra
            output = predictChar(chars{k});
            fwrite(fid,unicode2native(char(hex2dec(output)),'UTF-8'));
            %%output2=printMatra(matra);
            %%fwrite(fid,unicode2native(char(hex2dec(output2)),'UTF-8'));
            %%waitforbuttonpress;
        end
        fwrite(fid,' ');
    end
end

fclose(fid);