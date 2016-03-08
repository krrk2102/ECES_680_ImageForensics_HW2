function psnr = getPSNR(image1, image2)

    % Calculate PSNR 
    if image1 == image2
        error('Input images must not be the same.');
    end

    diff = image1 - image2;
    psnr = 20 * log10(255/(sqrt(mean(mean(diff.^2)))));

end