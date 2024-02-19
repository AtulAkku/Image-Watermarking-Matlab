% Step 1: Read HDR image and watermark image
rgbImage = hdrread('sunset.hdr');
Watertm = imread('watermark.png');

% Step 2: Apply DWT to HDR Image
[h_LL, h_LH, h_HL, h_HH] = dwt2(rgbImage, 'sym4');

% Step 3: Create new image (Img) from h_LL
Img = idwt2(h_LL, h_LH, h_HL, h_HH, 'sym4', size(rgbImage));

% Step 4: Single Value Decomposition on RGB Channels
[U_r, S_r, V_r] = svd(Img(:, :, 1));
[U_g, S_g, V_g] = svd(Img(:, :, 2));
[U_b, S_b, V_b] = svd(Img(:, :, 3));

% Step 5: Apply DWT to Watermark Image
[w_LL, w_LH, w_HL, w_HH] = dwt2(double(Watertm), 'sym4');

% Step 6: Create new image (img_watermark) from w_LL
img_watermark = idwt2(w_LL, w_LH, w_HL, w_HH, 'sym4', size(Watertm));

% Step 7: Repeat DWT on img_watermark
[w_LL, w_LH, w_HL, w_HH] = dwt2(double(img_watermark), 'sym4');

% Step 8: Modify Watermark Image (S_imgr1 + (0.10 * S_imgr2))
modified_watermark = w_LL + 0.1 * w_LH;

% Step 9: Combine Watermark Channels
watermarkimg = cat(3, modified_watermark, w_HL, w_HH);

% Step 10: Apply SVD on Watermarking (channel-wise)
[U_w_r, S_w_r, V_w_r] = svd(watermarkimg(:, :, 1));
[U_w_g, S_w_g, V_w_g] = svd(watermarkimg(:, :, 2));
[U_w_b, S_w_b, V_w_b] = svd(watermarkimg(:, :, 3));

% Combine singular values (you may need to adjust this based on your specific requirements)
S_w_combined = cat(3, S_w_r, S_w_g, S_w_b);

% Assuming alpha is defined
alpha = 0.1;

% Step 11: Apply DWT to Watermarked Image (separately on each channel)
watermarked_LL = dwt2(rgbImage(:, :, 1) + alpha * S_w_r, 'sym4');
watermarked_LH = dwt2(rgbImage(:, :, 2) + alpha * S_w_g, 'sym4');
watermarked_HL = dwt2(rgbImage(:, :, 3) + alpha * S_w_b, 'sym4');

% Combine the watermarked channels
watermarked_image = cat(3, watermarked_LL, watermarked_LH, watermarked_HL);

% Step 12: Apply Inverse DWT to Get Final Result
final_result = idwt2(watermarked_image(:, :, 1), watermarked_image(:, :, 2), watermarked_image(:, :, 3), [], 'sym4', size(rgbImage));

% Display the final result
imshow(final_result);

% Save the watermarked HDR image
hdrwrite(final_result, 'watermarked_hdr_image.hdr');