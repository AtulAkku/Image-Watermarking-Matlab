% Load the original image and the watermark image
original_image = imread('images\esteban-bonilla-cJBezX84KWA-unsplash.jpg');
watermark_image = imread('watermark3.jpg');

% Get the size of the images
[Mo, No, ~] = size(original_image);
[Mw, Nw, ~] = size(watermark_image);

% Set wavelet type
waveletType = 'sym15';

% Resize the watermark image to match the original image size
watermark_image = imresize(watermark_image, [Mo, No]);

% Define the scaling factor for the watermark
alpha = 0.1;

% Initialize variables
psnr_values = zeros(1, 3);
mse_values = zeros(1, 3);

% Loop over each color channel (Red, Green, Blue)
for channel = 1:3
    % Apply DWT to the original image and the watermark image for the current channel
    [cA1, cH1, cV1, cD1] = dwt2(original_image(:,:,channel), waveletType);
    [cA2, cH2, cV2, cD2] = dwt2(watermark_image(:,:,channel), waveletType);

    % Add the watermark to the original image in the LL subband
    cA1 = cA1 + alpha * cA2;

    % Reconstruct the watermarked image using IDWT
    watermarked_image(:,:,channel) = idwt2(cA1, cH1, cV1, cD1, waveletType, [Mo, No]);

    % Convert images to uint8 for calculations
    watermarked_image_double_channel = im2double(watermarked_image(:,:,channel));
    original_image_double_channel = im2double(original_image(:,:,channel));

    % Add salt and pepper noise with desired density
    density = 0.01;  % Adjust this value
    noise_image_channel = imnoise(watermarked_image_double_channel, 'salt & pepper', density);

    % Apply median filter to remove isolated noise
    noise_image_channel = medfilt2(noise_image_channel);

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
fprintf('Salt & Pepper Noise Parameters:\n');
fprintf('Density: %f\n', density);
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
