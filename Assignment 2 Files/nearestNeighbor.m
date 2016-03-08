function neighborPos = nearestNeighbor(LUTvals, pos, val)
% Input:
%     LUTvals: look up table
%     pos: the center position starts searching
%     val: ideal binary value
% Return:
%     neighborPos: the position of nearest neighbor
    neighborPos = pos;
    higher = pos + 1;
    lower = pos - 1;
    % Searching to front and end at the same time, while within the table.
    while higher <= size(LUTvals, 2) || lower > 0
        if higher <= size(LUTvals, 2) && LUTvals(higher) == val
            neighborPos = higher;
            break;
        elseif lower > 0 && LUTvals(lower) == val
            neighborPos = lower;
            break;
        end
        higher = higher + 1;
        lower = lower - 1;
    end

end

