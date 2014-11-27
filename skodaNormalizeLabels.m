function stdLabels = skodaNormalizeLabels(labels)
%NORMALIZELABELS Label normalization
%   Replace a given skoda activity label with normalized value
stdLabels = labels;
for i=1:length(labels)
    switch labels(i,1)
        case 32
            stdLabels(i,1) = 1;
        case 48
            stdLabels(i,1) = 2;
        case 49
            stdLabels(i,1) = 3;
        case 50
            stdLabels(i,1) = 4;
        case 51
            stdLabels(i,1) = 5;
        case 52
            stdLabels(i,1) = 6;
        case 53
            stdLabels(i,1) = 7;
        case 54
            stdLabels(i,1) = 8;
        case 55
            stdLabels(i,1) = 9;
        case 56
            stdLabels(i,1) = 10;
        case 57
            stdLabels(i,1) = 11;
        otherwise
            disp('unknown label encountered');
    end
end

end
