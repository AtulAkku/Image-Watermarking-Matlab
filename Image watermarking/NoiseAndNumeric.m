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

% Convert the original image to double for noise calculation
original_image_double = im2double(original_image);

% Calculate Gaussian Noise
gaussian_noise = imnoise(watermarked_image, 'gaussian', 0.01);

% Calculate Salt and Pepper Noise
salt_and_pepper_noise = imnoise(watermarked_image, 'salt & pepper', 0.05);

% Calculate Poisson Noise
poisson_noise = imnoise(watermarked_image, 'poisson');

% Display the images and noise
figure;

subplot(2, 3, 1);
imshow(original_image);
title('Original Image');

subplot(2, 3, 2);
imshow(watermarked_image);
title('Watermarked Image');

subplot(2, 3, 3);
imshow(gaussian_noise);
title('Gaussian Noise');

subplot(2, 3, 4);
imshow(salt_and_pepper_noise);
title('Salt & Pepper Noise');

subplot(2, 3, 5);
imshow(poisson_noise);
title('Poisson Noise');

subplot(2, 3, 6);
imshow(colored_original);
title('Original Colored Image');

% Calculate noise statistics
mean_gaussian_noise = mean2(gaussian_noise);
std_gaussian_noise = std2(gaussian_noise);

mean_salt_and_pepper_noise = mean2(salt_and_pepper_noise);
std_salt_and_pepper_noise = std2(salt_and_pepper_noise);

mean_poisson_noise = mean2(poisson_noise);
std_poisson_noise = std2(poisson_noise);

% Display noise statistics
disp(['Gaussian Noise:']);
disp(['Mean: ', num2str(mean_gaussian_noise)]);
disp(['Standard Deviation: ', num2str(std_gaussian_noise)]);

disp(['Salt and Pepper Noise:']);
disp(['Mean: ', num2str(mean_salt_and_pepper_noise)]);
disp(['Standard Deviation: ', num2str(std_salt_and_pepper_noise)]);

disp(['Poisson Noise:']);
disp(['Mean: ', num2str(mean_poisson_noise)]);
disp(['Standard Deviation: ', num2str(std_poisson_noise)]);
