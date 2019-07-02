function changeStick( h_line, pt_start, x_angle, x_length )

    x_endX = pt_start(1) + x_length*sin(x_angle);
    x_endY = pt_start(2) - x_length*cos(x_angle);
    h_line.XData(1) = pt_start(1);
    h_line.XData(2) = x_endX;
    h_line.YData(1) = pt_start(2);
    h_line.YData(2) = x_endY;

end

