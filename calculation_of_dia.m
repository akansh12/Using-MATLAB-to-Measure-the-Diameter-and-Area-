%Measuring objects within an image or frame
%Give a input as a string of file name
%Use function named calculation_of_dia

function calculation_of_dia(A)
% Importing Image to MATLAB for Pre-processing
figure(1);
obj=imread(A);
imshow(obj);

% Segmenting Image into Different Colors
%Divide image 'obj' into its RGB intensities
red=obj(:,:,1);
green=obj(:,:,2);
blue=obj(:,:,3);

figure(2)
subplot(221);imshow(obj);title('Original image');
subplot(222);imshow(red);title('Red segment of original image');
subplot(223);imshow(green);title('Green segment of original image');
subplot(224);imshow(blue);title('Blue segment of original image');

% Tresholding the image 
% First compare which image ismore suitable for thersholding 
% For this case we are using Green segment
figure(3);
level=0.47;
bw2g= im2bw(green,level);
subplot(221);imshow(bw2g);title('Green plane Threshold');

%Tresholding the blue component also
level=0.37;
bw2b= im2bw(blue,level);
subplot(222);imshow(bw2b);title('Blue plane Threshold');


%Remove noise
%To remove disturbance we perform following operation
C=(bw2g & bw2b);
D=(bw2g & ~C);
imshow(D);

%Fill any holes
fill=imfill(D,'holes');
subplot(223);imshow(fill);title('Holes filled');

%Remove any blobs
clear = imclearborder(fill);
subplot(224);imshow(clear);

%Remove small blobs of pixel less than 7 
figure(4)
se=strel('disk',7);
open=imopen(fill,se);
imshow(open);

% Measureing the distance
diameter = regionprops(open,'MajorAxisLength');
disp(diameter);
Area=regionprops(open,'Area');
disp(Area);

%show result
figure(5)
imshow(obj);
d=imdistline;


end

