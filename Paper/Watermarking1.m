% Load the original image and the watermark image
original_image = imread('images\esteban-bonilla-cJBezX84KWA-unsplash.jpg');
watermark_image = imread('watermark3.jpg');

% Get the size of the images
[Mo, No, ~] = size(original_image);
[Mw, Nw, ~] = size(watermark_image);

waveletType = 'db9';

% Resize the watermark image to match the original image size
watermark_image = imresize(watermark_image, [Mo, No]);

% Apply DWT to each color channel of the original image and the watermark image
for k = 1:3 % Iterate over RGB color channels
    [cA1, cH1, cV1, cD1] = dwt2(original_image(:,:,k), waveletType ); %approximation, horizontal, vertical, diagonal details
    [cA2, cH2, cV2, cD2] = dwt2(watermark_image(:,:,k), waveletType );

    % Define the scaling factor for the watermark
    alpha = 0.1;

    % Add the watermark to the original image in the LL subband
    cA1 = cA1 + alpha * cA2;

    % Reconstruct the watermarked image using IDWT
    watermarked_image(:,:,k) = idwt2(cA1, cH1, cV1, cD1, waveletType , [Mo, No]);
end

% Convert the watermarked image to uint8
watermarked_image = uint8(watermarked_image);

imwrite(watermarked_image,'watermarked_image.jpg');

% Convert watermarked_image to double before calculating MSE
watermarked_image_double = im2double(watermarked_image);
original_image_double = im2double(original_image);

% Calculate MSE
mse = sum(sum(sum((original_image_double - watermarked_image_double).^2))) / (Mo * No * 3);

% Calculate PSNR
max_pixel_value = 255;  % Assuming 8-bit images
psnr_value = 10 * log10((max_pixel_value^2) / mse);

fprintf('MSE: %f\n', mse);
fprintf('PSNR: %f dB\n', psnr_value);

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

% Display PSNR and MSE
subplot(1, 4, 4);
text(0.1, 0.5, sprintf('PSNR: %.6f dB\nMSE: %.6f', psnr_value, mse), 'FontSize', 10);
axis off;
