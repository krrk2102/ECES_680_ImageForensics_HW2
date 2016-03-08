function markedImage = spectrumWaterMark(image, key, N, alpha)
% Input:
%     image: original image
%     key: key to generate random gaussian water mark
%     N: number of N largest DCT coefficients
%     alpha: water mark embedding strength
% Return:
%     markedImage: water marked image

    [numRow, numCol] = size(image);
    % Perform DCT on original image. 
    image = dct2(image);
    image = reshape(image, 1, []);
    markedImage = image;
    
    % Index are recordered in descending order of DCT coefficients.
    [~, order] = sort(reshape(image, 1, []), 'descend');
    
    % Seed the random number generator with the user specified key.
    rng(key);
    % Generate i.i.d. Gaussian watermark with mean = 0 and variance = 1.
    wmk = randn(N, 1);
    
    for i = 1 : N
        % Mark the N highest DCT coefficients excluding DC coefficient. 
        markedImage(order(i+1)) = image(order(i+1)) * ...
                                            (1 + alpha * wmk(i));
    end
    
    markedImage = reshape(markedImage, [numRow numCol]);
    markedImage = uint8(idct2(markedImage));

end
