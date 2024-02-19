% Load the original image and the watermark image
original_image = imread('your-image~1.jpg');
colored_original = original_image;
watermark_image = imread('watermark2.jpg');

% Convert the images to grayscale and double
original_image = im2double(rgb2gray(original_image));
watermark_image = im2double(rgb2gray(watermark_image));

% Get the size of the images
[Mo, No] = size(original_image);
[Mw, Nw] = size(watermark_image);

% Resize the watermark image to match the original image size
watermark_image = imresize(watermark_image, [Mo, No]);

% Apply DWT to the original image and the watermark image
[cA1, cH1, cV1, cD1] = dwt2(original_image, 'haar');
[cA2, cH2, cV2, cD2] = dwt2(watermark_image, 'haar');

% Define the scaling factor for the watermark
alpha = 0.5;

% Add the watermark to the original image in the LL subband
cA1 = cA1 + alpha * cA2;

% Reconstruct the watermarked image using IDWT
watermarked_image = idwt2(cA1, cH1, cV1, cD1, 'haar', [Mo, No]);

% Convert the watermarked image to uint8
watermarked_image = uint8(watermarked_image * 255);

imwrite(watermarked_image,'watermarked_image.jpg');

% Convert watermarked_image to double before calculating MSE
watermarked_image_double = im2double(watermarked_image);

% Calculate MSE
mse = sum(sum((original_image - watermarked_image_double).^2)) / (Mo * No);

% Calculate PSNR
max_pixel_value = 255;  % Assuming 8-bit images
psnr_value = 10 * log10((max_pixel_value^2) / mse);

fprintf('MSE: %f\n', mse);
fprintf('PSNR: %f dB\n', psnr_value);

% Display the original image (with color), the watermark image, and the watermarked image
subplot(1, 4, 1);
imshow(original_image);  % Use the original image before conversion to grayscale
title('Original Image');

subplot(1, 4, 2);
imshow(watermark_image);
title('Watermark Image');

subplot(1, 4, 3);
imshow(watermarked_image);
title('Watermarked Image');

% Display PSNR and MSE
subplot(1, 4, 4);
text(0.1, 0.5, sprintf('PSNR: %.6f dB\nMSE: %.6f', psnr_value, mse), 'FontSize', 10);
axis off;