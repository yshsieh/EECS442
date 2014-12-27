clear all; 

%Load data
files1 = dir('./BEACH24/*.mat');
files2 = dir('./DUCK24/*.mat');
Nfeature = 8;
Ndata1 = size(files1,1);
Ndata2 = size(files2,1);
Ndata = Ndata1 + Ndata2;
BeachData = cell(Ndata1,1);
i = 1;
for file = files1'
    BeachData{i} = load(file.name);
    i = i + 1;
end
    
DuckData = cell(Ndata2, 1);
i = 1;
for file = files2'
    DuckData{i} = load(file.name);
    i = i + 1;
end

% Target & Feature data
% Distance Matrix using DTW
Target = [zeros(Ndata1,1)+1; zeros(Ndata2,1)+2 ]; % Label = 1 OR 2
Data = [BeachData; DuckData];
distMatrix = zeros(Ndata);
for i = 1:Ndata,
    candi = cell2mat(struct2cell(Data{i}));
    candi(:,1) = candi(:,1)/480;
    candi(:,2) = candi(:,2)/640;
    candi = [candi(:,1)./candi(:,2) candi(:,3:end)];
    for j = 1:Ndata,
        comp = cell2mat(struct2cell(Data{j}));
        comp(:,1) = comp(:,1)/480;
        comp(:,2) = comp(:,2)/640;
        comp = [comp(:,1)./comp(:,2) comp(:,3:end)];
        distMatrix(i,j) = dtw(candi,comp);
    end
end

%KNN algorithm
%K = ceil(0.6*Ndata);
maxK = 0;
maxGot = zeros(Ndata-1,1);
for K = 1:Ndata-1,
got = 0;
[BB II] = sort(distMatrix,1);
B = BB(2:K+1,:);
I = II(2:K+1,:);    
for j = 1:Ndata,
    classified = mode(Target(I(:,j)));
    if (classified == Target(j)),
        got = got + 1;
    end
end
maxGot(K) = got/Ndata;
end
maxGot

[Y, eigvals] = cmdscale(distMatrix);
Dtriu = distMatrix(find(tril(ones(10),-1)))';
%maxrelerr = max(abs(Dtriu-pdist(Y(:,1:2))))./max(Dtriu);
plot(Y(1:Ndata1,1),Y(1:Ndata1,2),'.r',Y(Ndata1+1:end,1),Y(Ndata1+1:end,2),'.b' )
%plot(Y(Ndata1+1:end,1),Y(Ndata1+1:end,2),'b')

%text(Y(:,1)+25,Y(:,2),cities)
xlabel('Miles')
ylabel('Miles')