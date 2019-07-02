function [ h_circle ] = newCircle( h_line )

   pt_center = [h_line.XData(2) h_line.YData(2)];
   h_circle = viscircles(pt_center, 0.005);

end

