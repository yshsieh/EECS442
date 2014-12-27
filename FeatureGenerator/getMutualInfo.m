function [ MutualInfo ] = getMutualInfo( img1,img2 )
%Calculate mutual information between tow images

% resize to 50 x 50
newSize = [50,50];
img1 = imresize(img1,newSize);
img2 = imresize(img2,newSize);

% reshape to column vector
X = double(rgb2gray(img1));
Y = double(rgb2gray(img2));
X = reshape(X,[newSize(1)*newSize(2),1]);
Y = reshape(Y,[newSize(1)*newSize(2),1]);

%normalized to positive integers
matXY(:,1) = X - min(X) +1;
matXY(:,2) = Y - min(Y) +1;

 % joint histogram
H = accumarray(matXY+1, 1);

% normalized joint histogram
H = H./sum(sum(H)); 

% Entropy of Y and X
mar_Y = sum(H,1); 
Hy = - sum(mar_Y.*log2(mar_Y + (mar_Y == 0))); 
mar_X = sum(H,2);
Hx = - sum(mar_X.*log2(mar_X + (mar_X == 0))); 

% joint entropy
Hxy = - sum(sum(H.*log2(H + (H==0)))); 

 % mutual information
MutualInfo = Hx + Hy - Hxy;

end

