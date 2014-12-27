%  Declaration
%  ------------
%  Date: 2014 / 12 / 1
%  Author: WU Tongshuang, 40782306

% initialization

clc;

addpath('orignFeature');

Nfeature = 3;
uniqueWordNum = 149;
repeatTime = 28;
wordNum = uniqueWordNum * repeatTime;
Data = [];

for i = 2:uniqueWordNum+1
    s = ['Data_word' int2str(i) '=[]'];
    eval(s);
end

files = dir('orignFeature/*.txt');
Ndata_word = zeros(uniqueWordNum,1);
for file = files'
    if (file.name(1)) ~= '.'
        curRawData = load(file.name);
        for curWordNum = 2:uniqueWordNum+1
            if (~isempty(curRawData(curRawData(:,1)==curWordNum)))
            curWord = mat2cell(curRawData(curRawData(:,1)==curWordNum,2:4));
            Ndata_word(curWordNum-1) = Ndata_word(curWordNum-1) + 1;
            s = ['Data_word' int2str(curWordNum)...
                    '=[Data_word' int2str(curWordNum) '; curWord]'];
            eval(s);
            end
        end
    end
end
Ndata = sum(Ndata_word);

for i = 2:uniqueWordNum+1
    s = ['Data = [Data;Data_word' int2str(i) ']'];
    eval(s);
end
