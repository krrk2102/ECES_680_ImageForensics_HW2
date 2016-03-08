function markedImage = embedBit(image, watermark, n)
% Input:
%     image: the original image to be marked.
%     watermark: the image to be embedded into n least significant 
%                bits of the original image.
%     n: n: the n least significant bits to process.
% Return:
%     markedImage: the output image with watermark. 

    markedImage = uint8(zeros(size(image)));
    % Processing 2 masks for original image and watermark.
    waterMarkMask = uint8(0);
    for i = 9 - n : 8
        % Watermark mask should save n most significant bits of the mark. 
        waterMarkMask = bitor(waterMarkMask, uint8(bitshift(1, i - 1)));
    end
    imageMask = uint8(0);
    for i = n + 1 : 8
        % Original image mask erase n least significant bits of it. 
        imageMask = bitor(imageMask, uint8(bitshift(1, i - 1)));
    end
    
    for i = 1 : size(image, 1)
        for j = 1 : size(image, 2)
            % Get most significant bits of watermark.
            watermark(i, j) = bitand(watermark(i, j), waterMarkMask);
            % Move bits to the right. 
            watermark(i, j) = bitshift(watermark(i, j), n - 8);
            % Remove least significant bits of original image.
            image(i, j) = bitand(image(i, j), imageMask);
            % Combine original image and watermark. 
            markedImage(i, j) = bitor(image(i, j), watermark(i, j));
        end
    end

end

