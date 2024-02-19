% Load the original image and the watermark image
original_image = imread('your-image~1.jpg');
colored_original = original_image;
watermark_image = imread('watermark3.jpg');

% Convert the images to grayscale and double
original_image = im2double(rgb2gray(original_image));
watermark_image = im2double(rgb2gray(watermark_image));

% Get the size of the images
[Mo, No] = size(original_image);

% Resize the watermark image to match the original image size
watermark_image = imresize(watermark_image, [Mo, No]);

% Apply DWT to the original image and the watermark image
[cA1, cH1, cV1, cD1] = dwt2(original_image, 'haar');
[cA2, cH2, cV2, cD2] = dwt2(watermark_image, 'haar');

% Define the scaling factor for the watermark
alpha = 0.1;

% Add the watermark to the original image in the LL subband
cA1 = cA1 + alpha * cA2;

% Reconstruct the watermarked image using IDWT
watermarked_image = idwt2(cA1, cH1, cV1, cD1, 'haar', [Mo, No]);

% Convert the watermarked image to uint8
watermarked_image = uint8(watermarked_image * 255);

% Simulate Gaussian noise
sigma = 0.02; % Adjust the standard deviation as needed
watermarked_image_with_gaussian = imnoise(watermarked_image, 'gaussian', 0, sigma);

% Simulate Salt and Pepper noise
density = 0.02; % Adjust the density as needed
watermarked_image_with_salt_and_pepper = imnoise(watermarked_image, 'salt & pepper', density);

% Simulate Poisson noise
watermarked_image_with_poisson = imnoise(watermarked_image, 'poisson');

% Display the images
figure;

subplot(2, 3, 1);
imshow(colored_original);
title('Original Image');

subplot(2, 3, 2);
imshow(watermarked_image);
title('Watermarked Image');

subplot(2, 3, 3);
imshow(watermarked_image_with_gaussian);
title('Watermarked Image with Gaussian Noise');

subplot(2, 3, 4);
imshow(watermarked_image_with_salt_and_pepper);
title('Watermarked Image with Salt and Pepper Noise');

subplot(2, 3, 5);
imshow(watermarked_image_with_poisson);
title('Watermarked Image with Poisson Noise');

subplot(2, 3, 6);
text(0.1, 0.5, sprintf('PSNR: %.6f dB\nMSE: %.6f', psnr_value, mse), 'FontSize', 10);
axis off;
