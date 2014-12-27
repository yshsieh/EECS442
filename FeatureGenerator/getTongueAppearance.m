function [ ratio ] = getTongueAppearance( img1 )
%GETTONGUEAPPEARANCE Summary of this function goes here
%   Detailed explanation goes here

%num = sum(sum(double(img1(:,:,1)/256)));
%denum = size(img1,1)*size(img1,2);

%ratio = num/denum;

Image_red = img1(:,:,1);
BW = im2bw(Image_red, 0.45);
num = sum(sum(BW==0));
denum = size(img1,1)*size(img1,2);

ratio = num/denum;
end

