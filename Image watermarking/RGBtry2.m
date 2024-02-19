% Load the original image and the watermark image
original_image = imread('your-image~1.jpg');
watermark_image = imread('watermark3.jpg');

% Get the size of the images
[Mo, No, ~] = size(original_image);
[Mw, Nw, ~] = size(watermark_image);

% Set wavelet type
waveletType = 'haar';

% Resize the watermark image to match the original image size
watermark_image = imresize(watermark_image, [Mo, No]);

% Initialize variables to store PSNR and MSE values for each channel
psnr_values = zeros(1, 3);
mse_values = zeros(1, 3);

% Loop over each color channel (Red, Green, Blue)
for channel = 1:3
    % Apply DWT to the original image and the watermark image for the current channel
    [cA1, cH1, cV1, cD1] = dwt2(original_image(:,:,channel), waveletType);
    [cA2, cH2, cV2, cD2] = dwt2(watermark_image(:,:,channel), waveletType);

    % Define the scaling factor for the watermark
    alpha = 0.1;

    % Add the watermark to the original image in the LL subband
    cA1 = cA1 + alpha * cA2;

    % Reconstruct the watermarked image using IDWT
    watermarked_image(:,:,channel) = idwt2(cA1, cH1, cV1, cD1, waveletType, [Mo, No]);

    % Convert the watermarked image to uint8 for the current channel
    watermarked_image_channel = uint8(watermarked_image(:,:,channel));
    original_image_channel = uint8(original_image(:,:,channel));

    % Convert watermarked_image to double before calculating MSE
    watermarked_image_double_channel = im2double(watermarked_image_channel);
    original_image_double_channel = im2double(original_image_channel);

    % Calculate MSE for the current channel
    mse_values(channel) = sum(sum((original_image_double_channel - watermarked_image_double_channel).^2)) / (Mo * No);

    % Calculate PSNR for the current channel
    max_pixel_value = 255;  % Assuming 8-bit images
    psnr_values(channel) = 10 * log10((max_pixel_value^2) / mse_values(channel));
end

% Display PSNR and MSE for each color channel
fprintf('Red Channel - MSE: %f, PSNR: %f dB\n', mse_values(1), psnr_values(1));
fprintf('Green Channel - MSE: %f, PSNR: %f dB\n', mse_values(2), psnr_values(2));
fprintf('Blue Channel - MSE: %f, PSNR: %f dB\n', mse_values(3), psnr_values(3));

% Display the original image (with color), the watermark image, and the watermarked image
subplot(1, 4, 1);
imshow(original_image);
title('Original Image');

subplot(1, 4, 2);
imshow(watermark_image);
title('Watermark Image');

subplot(1, 4, 3);
imshow(watermarked_image);
title('Watermarked Image');

% Display PSNR and MSE for each color channel
subplot(1, 4, 4);
text(0.1, 0.5, sprintf('Red - PSNR: %.6f dB\nGreen - PSNR: %.6f dB\nBlue - PSNR: %.6f dB\n', ...
    psnr_values(1), psnr_values(2), psnr_values(3)), 'FontSize', 10);
axis off;

noise_image = watermarked_image - original_image;

mean_noise = mean2(noise_image);
std_noise = std2(noise_image);

figure;
imshow(noise_image);
title('Noise Image');

disp(['Noise (Difference between Watermarked and Original):']);
disp(['Mean: ', num2str(mean_noise)]);
disp(['Standard Deviation: ', num2str(std_noise)]);
