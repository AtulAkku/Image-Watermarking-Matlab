% Read the original image
originalImage = imread('your-image~1.jpg');

% Convert the image to grayscale if it's in color
if size(originalImage, 3) == 3
  originalImage = rgb2gray(originalImage);
end

% Display the original image
figure;
imshow(originalImage);
title('Original Image');

% Load the watermark image
watermarkImage = imread('watermark.png');

% Convert the watermark image to grayscale if it's in color
if size(watermarkImage, 3) == 3
  watermarkImage = rgb2gray(watermarkImage);
end

% Display the watermark image
figure;
imshow(watermarkImage);
title('Watermark Image');

% Apply DWT to the original image
wavelet = 'haar'; % You can choose a different wavelet
level = 2;    % Set the number of decomposition levels

[C, S] = wavedec2(originalImage, level, wavelet);

% Extract the approximation and detail coefficients
[CA, CH, CV, CD] = detcoef2('all', C, S, level);

% Embed the watermark in the high-frequency subbands (e.g., CD)
alpha = 0.1; % Watermark strength, adjust as needed

% Ensure that the watermark image and CD have the same size
watermarkImageResized = imresize(watermarkImage, size(CD));

CD_watermarked = CD + alpha * double(watermarkImageResized);

% Reconstruct the watermarked image
C_watermarked = [CA; CH; CV; CD_watermarked];
watermarkedImage = waverec2(C_watermarked, S, wavelet);

% Display the watermarked image
figure;
imshow(uint8(watermarkedImage)); % Convert back to uint8 for proper display
title('Watermarked Image');

% Save the watermarked image
imwrite(uint8(watermarkedImage), 'watermarked_image.jpg');