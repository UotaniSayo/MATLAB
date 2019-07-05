% start: (0,0)

%params
g = 0.98;
step = 0.01;
%goal: (10,-10)
xGoal = 10;
yGoal = 10;
len = xGoal/step + 1;
stopFlag = false;

xArray = 0:step:xGoal;
yArray = yGen(1, xArray);

%calculate arc by step
arcLen = zeros(1, len-1);
for i=1:len-1
    arcLen(i) = sqrt((yArray(i)-yArray(i+1))^2+step^2);
end

%calculate time and horizontal velocity by step
tArray = zeros(1, len-1);
vArray = zeros(1, len);
for i=1:len-1
    %calculate horizontal acceleration
    %acc = g*sin(theta)*cos(theta)
    %sin(theta)=arc/dy, cos(theta)=arc/dx
    acc = g*(yArray(i)-yArray(i+1))/arcLen(i)*step/arcLen(i);
    %judge if step goal can be arrived
    temp = vArray(i)^2+2*acc*step;
    if temp < 0
        stopFlag = true;
        break
    end
    tArray(i) = (sqrt(temp)-vArray(i))/acc;
    vArray(i+1) = vArray(i)+tArray(i)*acc;
end

tAll = sum(tArray);
if not(stopFlag)
    disp(tAll);
else
    disp('Goal cannot be arrived');
end
    
%animation
