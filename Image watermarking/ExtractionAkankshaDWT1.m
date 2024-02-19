% Load the watermarked image
watermarked_image = imread('watermarked_image.jpg');

% Convert the watermarked image to grayscale and double
%watermarked_image = im2double(rgb2gray(watermarked_image));

% Apply DWT to the watermarked image
[cA1_wm, cH1_wm, cV1_wm, cD1_wm] = dwt2(watermarked_image, 'haar');

% Extract the watermark from the LL subband
alpha = 0.5;
extracted_watermark = (cA1_wm - cA1) / alpha;

% Resize the extracted watermark to the original size
extracted_watermark = imresize(extracted_watermark, [Mo, No]);

% Convert the extracted watermark to uint8
extracted_watermark = uint8(extracted_watermark * 255);

% Display the extracted watermark
figure;
subplot(1, 2, 1);
imshow(watermarked_image);
title('Original Watermark');

subplot(1, 2, 2);
imshow(extracted_watermark);
title('Extracted Watermark');

% Convert extracted_watermark to double before calculating MSE
extracted_watermark_double = im2double(extracted_watermark);

% Calculate MSE
mse_extraction = sum(sum((watermark_image - extracted_watermark_double).^2)) / (Mo * No);

fprintf('MSE for Watermark Extraction: %f\n', mse_extraction);
