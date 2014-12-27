function [ ratio ] = getFeatureRatioVtoH( img1 )
%GETFEATURERATIOVTOH Summary of this function goes here
%   Detailed explanation goes here

newSize = [500,500];

img1 = imresize(img1,newSize);
img1 = rgb2gray(img1);

[LL,LH,HL,HH]=dwt2(img1,'haar');
HL_median = median(reshape(HL,1,size(HL,1)*size(HL,2)));
LH_median = median(reshape(LH,1,size(LH,1)*size(LH,2)));

num = sum(sum((HL_median - std2(HL) <= HL) & (HL_median + std2(HL) <= HL)));
denum = sum(sum((LH_median - std2(LH) <= LH) & (LH_median + std2(LH) <= LH)));
ratio = num/denum;

end

