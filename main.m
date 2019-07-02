clear
%init
G = 9.8;
pt_start = [0.75 0.75];
x_mass1 = 1;
x_mass2 = 1;
x_length1 = 0.2;
x_length2 = 0.2;

x_angle1 = -pi/4;
x_angle2 = pi/6;
x_step = 0.0001;
x_endTime = 10;
x_stepLen = x_endTime/x_step+1;
t = 0:x_step:x_endTime;
u = zeros(1,x_stepLen);
%u = 5*sin(t);

rv_angle1 = zeros(1,x_stepLen);
rv_angleV1 = zeros(1,x_stepLen);
rv_angleA1 = zeros(1,x_stepLen);
rv_angle2 = zeros(1,x_stepLen);
rv_angleV2 = zeros(1,x_stepLen);
rv_angleA2 = zeros(1,x_stepLen);

rv_angle1(1) = x_angle1;
rv_angle2(1) = x_angle2;

%compute pendulum param
for i = 1:x_stepLen-1
    %expression is too long, so divided into 2 lines
    rv_angleA1(i) = (u(i)*sin(rv_angle2(i)) + x_mass2*G*cos(rv_angle2(i)))*sin(rv_angle2(i)-rv_angle1(i));
    rv_angleA1(i) = (rv_angleA1(i) - x_mass1*G*sin(rv_angle1(i))) / (x_mass1*x_length1);
    rv_angleV1(i+1) = rv_angleA1(i)*x_step + rv_angleV1(i);
    rv_angle1(i+1) = 0.5*rv_angleA1(i)*x_step^2 + rv_angleV1(i)*x_step + rv_angle1(i);
    if rv_angle1(i+1) > pi
        rv_angle1(i+1) = rv_angle1(i+1)-2*pi;
    end
    if rv_angle1(i+1) < -pi
        rv_angle1(i+1) = rv_angle1(i+1)+2*pi;
    end
    
    rv_angleA2(i) = (u(i)*cos(rv_angle2(i)) - x_mass2*G*sin(rv_angle2(i))) / (x_mass2*x_length2);
    rv_angleV2(i+1) = rv_angleA2(i)*x_step + rv_angleV2(i);
    rv_angle2(i+1) = 0.5*rv_angleA2(i)*x_step^2 + rv_angleV2(i)*x_step + rv_angle2(i);
end
%%

%create animation
x_frameTime = 0.05;
h_fig = figure();
h_fig.Position = [400 100 1000 1000];
[h_line1, pt_end1] = newStick(pt_start, x_length1, x_angle1);
[h_line2, pt_end2] = newStick(pt_end1, x_length2, x_angle2);
h_circle1 = newCircle(h_line1);
h_circle2 = newCircle(h_line2);

xlim([0 1.5]);
ylim([0 1.5]);

h_timer = timer;
h_timer.StartDelay = x_frameTime;
%h_timer.StartFcn = @timerStart;
h_timer.TimerFcn = @timerUp;

% for i = 1:x_frameTime/x_step:x_stepLen-1
%     h_timer.UserData = {h_line1 h_circle1 rv_angle1(i) x_length1 h_line2 h_circle2 rv_angle2(i) x_length2};
%     start(h_timer);
%     wait(h_timer);
%     %delete(h_circle);
%     h_circle1 = newCircle(h_line1);
%     h_circle2 = newCircle(h_line2);
% end

for i = 1:x_frameTime/x_step:x_stepLen-1
    tic
    changeStick(h_line1, pt_start, rv_angle1(i), x_length1);
    changeStick(h_line2, [h_line1.XData(2) h_line1.YData(2)], rv_angle2(i), x_length2);
    delete(h_circle1);
    h_circle1 = newCircle(h_line1);
    delete(h_circle2);
    h_circle2 = newCircle(h_line2);
    
    x_remainTime = x_frameTime - toc;
    x_remainTime = round(x_remainTime, 3);
    %disp(x_remainTime);
    if x_remainTime >= 0.001
        h_timer.StartDelay = x_remainTime;
        start(h_timer);
        wait(h_timer);
    end
end


%END