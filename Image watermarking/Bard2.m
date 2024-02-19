% Read the image and watermark
original_image = imread('your-image~1.jpg');
watermark = imread('watermark.png');

% Convert the images to grayscale if necessary
if size(original_image, 3) > 1
  original_image = rgb2gray(original_image);
end

% Ensure compatible data types
original_image = im2uint8(original_image);
watermark = im2uint8(watermark);

% Resize the watermark to match high-frequency subband size
[HH, ~, ~, ~] = dwt2(original_image, 'haar');
watermark = imresize(watermark, size(HH));

% Convert scaling factor to a double for non-integer addition
alpha = double(0.3); % Weighting factor for the watermark

[HH, LH, HL, LL] = dwt2(original_image, 'haar');
HH = HH * alpha;
watermarked_HH = HH + watermark;
%watermarked_HH = HH + alpha .* watermark;
[watermarked_image, scaling_factor] = idwt2(watermarked_HH, LH, HL, LL, 'haar');

% Show the original, watermark, and watermarked images
figure(1);
subplot(1,3,1);
imshow(original_image);
title('Original Image');
subplot(1,3,2);
imshow(watermark);
title('Watermark');
subplot(1,3,3);
imshow(watermarked_image);
title('Watermarked Image');

% Extract the watermark from the watermarked image (optional)
[~, ~, ~, extracted_watermark] = dwt2(watermarked_image, 'haar');

% Option 1: Normalize alpha and divide element-wise
% alpha_array = ones(size(extracted_watermark)) * alpha;
% extracted_watermark = extracted_watermark ./ alpha_array;

% Option 2: Divide by alpha within DWT call (adjust as needed)
extracted_watermark = extracted_watermark / alpha;

figure(2);
imshow(extracted_watermark);
title('Extracted Watermark');

