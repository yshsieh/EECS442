function [ ratio ] = getTeethAppearance( img1 )
%GETTEETHAPPEARANCE Summary of this function goes here
%   Detailed explanation goes here

%Lab = colorspace('RGB->Lab',img1);
%Luv = colorspace('RGB->Luv',img1);

%Ua = mean2(Lab(:,:,2));
%Oa = std2(Lab(:,:,2));
%Uu = mean2(Luv(:,:,2));
%Ou = std2(Luv(:,:,2));

%num = sum(sum((Lab(:,:,2)<=(Ua-Oa)) | (Luv(:,:,2)<=(Uu-Ou))));
denum = size(img1,1)*size(img1,2);
%ratio = num/denum;

threshold = 150;
white = 0;
for i = 1:size(img1,1),
    for j = 1:size(img1,2),
        if ((img1(i,j,1) > threshold) & (img1(i,j,2) > threshold) & (img1(i,j,3) > threshold))
            white = white + 1;
        end
    end
end

ratio = white/denum;