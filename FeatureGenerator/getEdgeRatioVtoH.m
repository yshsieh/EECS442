function [ratio] = getEdgeRatioVtoH(img1)

newSize = [500,500];

img1 = imresize(img1,newSize);
img1 = rgb2gray(img1);

Edge_h = edge(img1,'sobel', 'horizontal');
Edge_v = edge(img1,'sobel', 'vertical');

num = sum(sum(abs(double(img1).*Edge_v)));
denum = sum(sum(abs(double(img1).*Edge_h)));

ratio = num/denum;

end