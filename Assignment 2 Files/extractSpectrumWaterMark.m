function similarityScore = extractSpectrumWaterMark(markedImage, image, N, alpha, key)
% Input:
%     markedImage: the image containing water mark
%     image: the original reference image
%     N: identify N largest DCT coefficients
%     alpha: embedding strengh
%     key: key to generate random gaussian water mark
% Return:
%     similarityScore: the similarity between extracted water mark
%                      and original water mark

    % Get DCT of both original and water marked image.
    markedImage = dct2(markedImage);
    markedImage = reshape(markedImage, 1, []);
    image = dct2(image);
    image = reshape(image, 1, []);
    
    % Get index in descending order of original image coefficients. 
    [~, order] = sort(image, 'descend');
    
    % Seed the random number generator with the user specified key.
    rng(key);
    % Generate i.i.d. Gaussian watermark with mean = 0 and variance = 1.
    oriWmk = randn(N, 1);
    
    waterMark = zeros(N, 1);
    for i = 1 : N
        % Extracting water mark.
        waterMark(i) = (1 / alpha) * ...
                        (markedImage(order(i+1)) / image(order(i+1)) - 1);
    end
    
    % Calculating similarity score. 
    similarityScore = waterMark' * oriWmk / sqrt(waterMark' * waterMark);

end

