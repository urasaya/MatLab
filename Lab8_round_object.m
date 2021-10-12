%% Lab 8 Lab 8 Identifying Round Objects
file = 'Can';
%% Step 1: Read Image

figure; 
for i=1:6
filename = [file, num2str(i, '%02d'), '.png'];
img = imread(filename);

subplot(1,3,1);imshow(img);

%% Step 2: Threshold the Image
% Convert the image to black and white in order to prepare 
% for boundary tracing using bwboundaries.
bw = im2bw(img,.19);
%bw = imbinarize(I);


%% Step 3: Remove the Noise
% Using morphology functions, remove pixels which do not belong to the objects 
% of interest.
% Remove all object containing fewer than 30 pixels.

bw = bwareaopen(bw,30);

% Fill a gap in the pen's cap.

se = strel('disk',2);
bw = imclose(bw,se);
subplot(1,3,2); imshow(bw);

% Fill any holes, so that regionprops can be used to estimate the area 
% enclosed by each of the boundaries

bw = imfill(bw,'holes');
imshow(bw)

%% Step 4: Find the Boundaries

% Concentrate only on the exterior boundaries. Option 'noholes' will accelerate 
% the processing by preventing bwboundaries from searching for inner contours.

[B,L] = bwboundaries(bw,'noholes');

% Display the label matrix and draw each boundary.
imshow(label2rgb(L,@jet,[.5 .5 .5]))
hold on
for k = 1:length(B)
  boundary = B{k};
  plot(boundary(:,2),boundary(:,1),'w','LineWidth',2)
end

%% Step 5: Determine which Objects are Round

% Estimate each object's area and perimeter. Use these results to form 
% a simple metric indicating the roundness of an object:

% metric = 4π∗area/perimeter^2

stats = regionprops(L,'Area','Centroid');

threshold = 0.897;

% loop over the boundaries
for k = 1:length(B)

  % obtain (X,Y) boundary coordinates corresponding to label 'k'
  boundary = B{k};

  % compute a simple estimate of the object's perimeter
  delta_sq = diff(boundary).^2;    
  perimeter = sum(sqrt(sum(delta_sq,2)));
  
  % obtain the area calculation corresponding to label 'k'
  area = stats(k).Area;
  
  % compute the roundness metric
  metric = 4*pi*area/perimeter^2;
  
  % display the results
  metric_string = sprintf('%2.3f',metric);

  % mark objects above the threshold with a black circle
  if metric > threshold
    subplot(1,3,3); imshow('PASS.jpeg');
  else 
      subplot(1,3,3); imshow('FAIL.jpeg');
  end
  
  text(boundary(1,2)-35,boundary(1,1)+13,metric_string,'Color','y',...
       'FontSize',14,'FontWeight','bold')
  
end
pause(2);
end

