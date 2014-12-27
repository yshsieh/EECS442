clc; clear; close all;

%%============================Import files================================%
fileNum = 10;
wordNum = 150;
reader1 = 'Helen';
reader2 = 'Justin';
reader3 = 'Kevin';




w = 0;
% specify reader test to be Henlen 1
pass_percent = zeros(8,1);
readerTest = reader1;
for k = 0:8
    pass = zeros(150,1);
for i = 1:150
%% initialize the matrix
dtwK = 9000 * ones(150,30);

%%specify test word
testFileName = strcat(readerTest,num2str(k));
testFileName = strcat(testFileName, '.txt');
testFile = load(testFileName);
   
index = find(testFile(:,1) == i);
length = size(index,1);
testWord = testFile(index(1):index(length),:);



% specify trainning reader 1
readerTrain = reader1;
for p = 0:8
    trainFileName = strcat(readerTrain,num2str(p));
    trainFileName = strcat(trainFileName, '.txt');
    trainFile = load(trainFileName);
    for j = 1:150
        index = find(trainFile(:,1) == j);
        length = size(index,1);
        trainWord = trainFile(index(1):index(length),:);
        dtwK(j,p+1) = dtw(testWord, trainWord,w);
    end
end





% specify training reader 2
readerTrain = reader2;
for p = 0:9
    trainFileName = strcat(readerTrain,num2str(p));
    trainFileName = strcat(trainFileName, '.txt');
    trainFile = load(trainFileName);
    for j = 2:150
        index = find(trainFile(:,1) == j);
        length = size(index,1);
        trainWord = trainFile(index(1):index(length),:);
        dtwK(j,p+11) = dtw(testWord, trainWord,w);
    end
end




% specify training reader 3

readerTrain = reader3;
for p = 0:9
    trainFileName = strcat(readerTrain,num2str(p));
    trainFileName = strcat(trainFileName, '.txt');
    trainFile = load(trainFileName);
    for j = 1:150
        index = find(trainFile(:,1) == j);
        length = size(index,1);
        trainWord = trainFile(index(1):index(length),:);
        dtwK(j,p+21) = dtw(testWord, trainWord,w);
    end
end
%% compute threshold
judge = dtwK < 200;
result = zeros(150,1);
for q = 1:150
    numIn = sum(judge(q,:));
    result(q)=  numIn;
end
max_index = find(result==max(result(:)));
if(size(max_index,1)==1)
pass(i)= (i==max_index);
end
%% save the matrix
savefile = strcat('Helen_',num2str(k));
savefile = strcat(savefile,'_times_');
savefile = strcat(savefile,num2str(i));
savefile = strcat(savefile,'_word');
save(savefile, 'result', '-ascii');
end
  pass_percent(k+1)= sum(pass(:,1)) / 150;
end