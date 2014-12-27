function [ Qmeasure ] = getQualityMeasure( img1,img2 )
% Measure how different it is between two images 
% Qmeasure value is between [-1,1];

%resize image to 50 x 50
newSize = [50,50];
img1 = imresize(img1,newSize);
img2 = imresize(img2,newSize);

img1 = double(rgb2gray(img1));
img2 = double(rgb2gray(img2));

%N = total number of data points
N = newSize(1)*newSize(2);

%Mean
Xmean = sum(sum(img1))/N;
Ymean = sum(sum(img2))/N;

%Var
X_meanRepmat = repmat(Xmean,newSize(1),newSize(2));
Xvar = sum(sum(((img1- X_meanRepmat).^2)))/(N-1);

Y_meanRepmat= repmat(Ymean,newSize(1),newSize(2),1);
Yvar = sum(sum(((img2- Y_meanRepmat).^2)))/(N-1);

XYvar = sum(sum(((img1- X_meanRepmat).*(img2- Y_meanRepmat))))/(N-1);

Qmeasure = (4*sqrt(XYvar).*Xmean.*Ymean)./((Xvar+Yvar).*(Xmean.^2 + Ymean.^2));
%Qmeasure = (4*XYvar*Xmean*Ymean)/((Xvar+Yvar)*(Xmean^2 + Ymean^2));
end

