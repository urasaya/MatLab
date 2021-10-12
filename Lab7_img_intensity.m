%% Lab 7 Measure the intensity of light from the image
%% 
% Preallocation the variable
inten_tot = [];
% Define the variable for image filename
file = 'Intensity'; 
% Open figure
figure;

% Position the subplot in the left in the imgae and the right for the plot
subplot(1,2,1);
subplot(1,2,2); h = animatedline; axis([0 17 190 250]);

% Loop for function for all 16 images
for i = 1:1:16 
    disp(i); % Display loop number
    % Declare filename
    %filename = [file, num2str(i, '%02d'), '.jpg'];
    %im = imread(filename);
    cam = webcam('HD WebCam');
    im = snapshot(cam);
    subplot(1,2,1); hold on; imshow(im);
    
    % Draw regtangle ROI
    rectangle('Position',[117,300,300,300],'EdgeColor','y',...
    'LineWidth',3)
    % Find averge intensity
    inten = mean2(im(36:75, 118:157));
    subplot(1,2,2); addpoints(h, i, inten)
    % Using vertical cat to keep all intensity in 'inten_tot' 
    inten_tot = vertcat(inten_tot, inten);
    % Delay time for 1 second
    pause(1);
end

% Display all the plot again
figure; plot(inten_tot);