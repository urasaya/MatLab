%% Lab 6 Using function regionProps for analyzing image properties

%%

% Read sample image
A = imread('Parts00.png');
figure; imshow(A);

% Convert image to binary image, based on threshold แปลงเป็นขาวดำ
A = im2bw(A,0.5);

% Remove small objects from binary image ลบวัตถุขอบๆออก
%%A = bwareaopen(A,50);
e = imcomplement(A);

% Find connected components in binary image 
%%CC = bwconncomp(e);

% Measure properties of image regions
data = regionprops(e,'all');

% Concatenate all the areas into an array. 
AllArea = vertcat(data.Area);

%========================================
%==== Apply threshold on area here ====


AboveAreaIndices1 = find(AllArea == 7349);
AboveAreaIndices2 = find(AllArea == 1817);
AboveAreaIndices3 = find(AllArea == 7850);
AboveAreaIndices4 = find(AllArea > 19509);


% Same for centroids...for display purposes
AllCentroids = vertcat(data.Centroid);


%Display original and thresholded objects. 
figure; imshow(e);

hold on

% Creates a scatter plot with circles at the locations specified by the vectors x and y. T
%scatter(AllCentroids(:,1),AllCentroids(:,2),40,'b','filled');
scatter(AllCentroids(AboveAreaIndices1,1),AllCentroids(AboveAreaIndices1,2),50,'r','filled');
scatter(AllCentroids(AboveAreaIndices2,1),AllCentroids(AboveAreaIndices2,2),50, [ 0.9100 0.4100 0.1700] ,'filled');
scatter(AllCentroids(AboveAreaIndices3,1),AllCentroids(AboveAreaIndices3,2),50,'g','filled');
scatter(AllCentroids(AboveAreaIndices4,1),AllCentroids(AboveAreaIndices4,2),50,'b','filled');




