function [All_feature] = LipFeatureExtraction(ROI_dir)
%input ROI_dir: directory of the ROI frames
%output All_feature: a T X 8 feature matrix where T is the length of the
%ROI frame sequence and 8 is the dimension of feature.

contents = dir([ROI_dir '/*.jpg']); % or whatever the filename extension is
Feature_d = 8;
All_feature = zeros(numel(contents)-1,Feature_d);
for i = 1:numel(contents)-1
  filename1 = contents(i).name;
  filename2 = contents(i+1).name;  
  %read image 
  img1 = imread([ROI_dir '/' filename1]);
  img2 = imread([ROI_dir '/' filename2]);
  
   %extracting features
   [width height] = getLipSize(img1);
   feature(1:2) =  [width height];
   feature(3) = getMutualInfoWithDWT(img1,img2);
   feature(4) = getQualityMeasureWithDWT(img1,img2);
   feature(5) = getFeatureRatioVtoH(img1);
   feature(6) = getEdgeRatioVtoH(img1);
   feature(7) = getTongueAppearance(img1);
   feature(8) = getTeethAppearance(img1);

   All_feature(i,:) = feature;
end
%if (~(exist([ROI_dir '_feature'])==7))
%    mkdir([ROI_dir '_feature']);
%end
%save([WORD '/' ROI_dir],'All_feature');
end

