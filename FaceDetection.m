% Create a webcam object
cam = webcam;

% Create a face detector object
faceDetector = vision.CascadeObjectDetector();

% Open the video preview window
preview(cam);

% Capture and process frames in a loop
while true
    % Capture a frame
    img = snapshot(cam);
    
    % Convert the frame to grayscale for face detection
    grayImg = rgb2gray(img);
    
    % Detect faces in the grayscale frame
    bbox = step(faceDetector, grayImg);
    
    % Display the original frame with bounding boxes around the detected faces
    imshow(img);
    hold on;
    for i = 1:size(bbox, 1)
        rectangle('Position', bbox(i, :), 'EdgeColor', 'r', 'LineWidth', 2);
    end
    hold off;
    title('Detected Faces');
    
    % Check for a key press to stop the loop
    if ~ishandle(gcf)
        break;
    end
    
    % Pause for a short time to allow for display
    pause(0.1);
end

% Clean up by closing the webcam object
clear cam;
