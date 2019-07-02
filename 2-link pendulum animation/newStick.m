function [ h_line, pt_end ] = newStick( pt_junction, x_length, x_angle )
    %x_angle: rad
    pt_end = zeros(1,2);
    pt_end(1) = pt_junction(1) + x_length*sin(x_angle);
    pt_end(2) = pt_junction(2) - x_length*cos(x_angle);
    h_line = line([pt_junction(1) pt_end(1)], [pt_junction(2) pt_end(2)]);

end

%END
