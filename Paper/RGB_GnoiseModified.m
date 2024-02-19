% Load the original image and the watermarked image
original_image = imread('images\esteban-bonilla-cJBezX84KWA-unsplash.jpg');
watermark_image = imread('watermark3.jpg');
watermarked_image = imread('watermarked_image.jpg');  % Assuming the watermarked image is saved as watermarked_image.jpg
% Get the size of the images
[Mo, No, ~] = size(original_image);
[Mw, Nw, ~] = size(watermarked_image);
% Ensure image sizes match
if Mo ~= Mw || No ~= Nw
    error('Original image and watermarked image sizes do not match.');
end
% Initialize variables
psnr_values = zeros(1, 3);
mse_values = zeros(1, 3);
% Loop over each color channel (Red, Green, Blue)
for channel = 1:3
    % Convert images to double for calculations
    watermarked_image_double_channel = im2double(watermarked_image(:,:,channel));
    original_image_double_channel = im2double(original_image(:,:,channel));
    % Calculate Gaussian noise with desired mean and standard deviation
    mean_noise = 0.02;  % Adjust this value
    std_noise = 0.01;  % Adjust this value
    noise_image_channel = imnoise(watermarked_image_double_channel, 'gaussian', mean_noise, std_noise);
    % Add noise to the watermarked image
    watermarked_image_double_channel = watermarked_image_double_channel + noise_image_channel;
    % Convert back to uint8 for display
    watermarked_image_channel = uint8(watermarked_image_double_channel * 255);
    watermarked_image(:,:,channel) = watermarked_image_channel;
    % Calculate MSE and PSNR
    mse_values(channel) = sum(sum((original_image_double_channel - watermarked_image_double_channel).^2)) / (Mo * No);
    max_pixel_value = 255;
    psnr_values(channel) = 10 * log10((max_pixel_value^2) / mse_values(channel));
end
% Display results
fprintf('==========================\n');
fprintf('Gaussian Noise Parameters:\n');
fprintf('Mean: %f\n', mean_noise);
fprintf('Standard Deviation: %f\n', std_noise);
fprintf('==========================\n');

fprintf('Red Channel:\n');
fprintf('MSE: %f, PSNR: %f dB\n', mse_values(1), psnr_values(1));
fprintf('Green Channel:\n');
fprintf('MSE: %f, PSNR: %f dB\n', mse_values(2), psnr_values(2));
fprintf('Blue Channel:\n');
fprintf('MSE: %f, PSNR: %f dB\n', mse_values(3), psnr_values(3));

% Display images
figure;
subplot(1, 4, 1);
imshow(original_image);
title('Original Image');
subplot(1, 4, 2);

imshow(watermark_image);
title('Watermark Image');
subplot(1, 4, 3);
imshow(watermarked_image);
title('Watermarked Image with Noise');
subplot(1, 4, 4);
text(0.1, 0.5, sprintf('Red - PSNR: %.6f dB\nGreen - PSNR: %.6f dB\nBlue - PSNR: %.6f dB\n', ...
    psnr_values(1), psnr_values(2), psnr_values(3)), 'FontSize', 10);
axis off;
