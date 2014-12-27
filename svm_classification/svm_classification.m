%  Declaration
%  ------------
%  Date: 2014 / 12 / 1
%  Author: WU Tongshuang, 40782306

% initialization
clc;
addpath('libsvm/libsvm-3.19/matlab');
loadData_orign;
% get all the fetures into one big matrix, and do k-means.
% reverse the matrix merging, change big matrix into word matrixs.
% can always change k.

featureCluster = [];
k = 8; % to be modified

for i = 1:Ndata,
    %candi = cell2mat(struct2cell(Data{i}));
    %candi(:,1) = candi(:,1)/480;
    %candi(:,2) = candi(:,2)/640;
    %candi = [candi(:,1)./candi(:,2) candi(:,3:end)];
    cell2mat(Data(i));
    featureCluster = [featureCluster; candi];
end

[stateID, centroid] = kmeans(featureCluster,k);

% the probability will be stored in (wordNum, k*k) matrix:
    % (i,:) represent the ith word (no need to be unique)
    % need to match the labels
    % use 1/3 videos for test
trainState = zeros(wordNum * 3/4, k*k);
trainLabels = zeros(wordNum *3/4, 1);
testState = zeros(wordNum *1/4, k*k);
testLabels = zeros(wordNum *1/4, 1);
%%%%%%%%%
% TODO: MERGE ALL MATRIX INTO FEATURECLUSTER, MARK DOWN THE SEQUENCE
%%%%%%%%%

% split the clustered word in to matrices, one matrix per word
    % (uniqueWordNum, 1)
    % make vector that each entry is a cell for a unique word

%%%%%%%%%
% TODO: FIT STATEID INTO WORDMAT
%%%%%%%%%

countTrain = 1;
countTest  = 1;
curLine = 0;
for i = 1: uniqueWordNum
    for j = 1: repeatTime
        % initialize a state matrix to store the current results
        curState = zeros(k,k);
        %curFeature = cell2mat(struct2cell(Data{Ndata/2 * (i-1) + j}));
        %curFeature(:,1) = curFeature(:,1)/480;
        %curFeature(:,2) = curFeature(:,2)/640;
        %curFeature = [curFeature(:,1)./curFeature(:,2) curFeature(:,3:end)];
        curFeature = cell2mat(Data(repeatTime * (i-1) + j));
        maxLength = size(curFeature,1);
        for p = 1: maxLength -1
            curLine = curLine + 1;
            from = stateID(curLine);
            to = stateID(curLine+1);
            curState(from, to) = curState(from,to)+1;
        end
        % compute the current probability, add to the matrix
        % split up test and train
        % directly use the currently i as the label.
        curState = curState / sum(sum(curState));
        if (mod(j,4) ~= 0)
            trainState(countTrain,:) = reshape(curState, 1,k*k);
            trainLabels(countTrain,:) = i;
            countTrain = countTrain + 1;
        else
            testState(countTest,:) = reshape(curState, 1,k*k);
            testLabels(countTest,:) = i;
            countTest = countTest + 1;
        end
    end
end

%use the features to train the class and test
optstr = sprintf('-t 1');
svmStruct = svmtrain(trainLabels, trainState,optstr);
[predict_label, accuracy, desition] = ...
             svmpredict(testLabels, testState, svmStruct);
