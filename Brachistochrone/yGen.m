function [output] = yGen(funcType, input)
    switch funcType
        case 1
            output = -input;
        case 2
            output = -sqrt(100-(input-10).^2);
        otherwise
            output = -input;
    end
end
