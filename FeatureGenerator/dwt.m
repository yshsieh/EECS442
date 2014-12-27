function [ output_img ] = dwt( Input_Image )
%DWT Summary of this function goes here
%   Detailed explanation goes here
 
%Red Component of Colour Image
Red_Input_Image=Input_Image(:,:,1);
%Green Component of Colour Image
Green_Input_Image=Input_Image(:,:,2);
%Blue Component of Colour Image
Blue_Input_Image=Input_Image(:,:,3);
 
%Apply Two Dimensional Discrete Wavelet Transform
[LLr,LHr,HLr,HHr]=dwt2(Red_Input_Image,'haar');
[LLg,LHg,HLg,HHg]=dwt2(Green_Input_Image,'haar');
[LLb,LHb,HLb,HHb]=dwt2(Blue_Input_Image,'haar');
 
First_Level_Decomposition(:,:,1)=[LLr,LHr;HLr,HHr];
First_Level_Decomposition(:,:,2)=[LLg,LHg;HLg,HHg];
First_Level_Decomposition(:,:,3)=[LLb,LHb;HLb,HHb];
First_Level_Decomposition=uint8(First_Level_Decomposition);




output_img = First_Level_Decomposition;
end

