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
original_image_uint8 = uint8(original_image * 255);

% Calculate the difference between the watermarked and original images
noise_image = watermarked_image - original_image_uint8;

% Calculate the mean and standard deviation of the noise
mean_noise = mean2(noise_image);
std_noise = std2(noise_image);

noise_image_double = im2double(noise_image);
mean_noise = mean2(noise_image_double);
std_noise = std2(noise_image_double);

% Display the noise statistics
disp(['Noise (Difference between Watermarked and Original):']);
disp(['Mean: ', num2str(mean_noise)]);
disp(['Standard Deviation: ', num2str(std_noise)]);

% Optionally, you can also display the noise image:

figure;
imshow(noise_image);
title('Noise Image');
