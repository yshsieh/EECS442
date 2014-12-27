function [ Q ] = getQualityMeasureWithDWT( img1,img2 )
%Get Quality Measure scale.
%large Q = low simiarity 
% Measure how different it is between two images 
% Qmeasure value is between [-1,1]; 
% Q = 0, larger distortion

%Take DWT decomposition into four sub-band
[LL1,LH1,HL1,HH1]=dwt2(img1,'haar');
[LL2,LH2,HL2,HH2]=dwt2(img2,'haar');

% Average betweem Mutual information of the four sub-bands
Q = ( getQualityMeasure(uint8(LL1),uint8(LL2)) + getQualityMeasure(uint8(LH1),uint8(LH2)) + getQualityMeasure(uint8(HL1),uint8(HL2)) + getQualityMeasure(uint8(HH1),uint8(HH2)) ) / 4; 

end

