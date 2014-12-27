%  Declaration
%  ------------
%  Date: 2014 / 12 / 1
%  Author: WU Tongshuang, 40782306

% initialization

clc;

addpath('ROIfeature');

clear all; 
name = dir('ROIfeature/*');

Nfeature = 8;
uniqueWordNum = 0;
repeatTime = 20;
wordNum = uniqueWordNum * repeatTime;
Ndata_word = [];
Data = [];

for num = 1 : length(name)
    if name(num).name(1) ~= '.'
        uniqueWordNum = uniqueWordNum + 1;
        fileName = strcat('ROIfeature/', name(num).name);
        fileName = strcat(fileName, '/*.mat');
        files = dir(fileName);
        Ndata_word = [Ndata_word;size(files,1)/2];
        curData = cell(size(files,1)/2,1);
        i = 1;
        for file = files'
            if (file.name(1)) ~= '.'
                curData{i} = load(file.name);
                i = i + 1;
            end
        end
        Data = [Data;curData];
    end
end
Ndata = sum(Ndata_word);