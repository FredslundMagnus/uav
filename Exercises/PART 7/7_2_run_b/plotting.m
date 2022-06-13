
close all
%refpoint = [4,-3,1];
%updatedref = [1,1,1];
Data = out.position.Data;
time = out.position.Time;
x = Data(:,1);
y = Data(:,2);
z = Data(:,3);
x = x - (refpoint(1))+1;
y = y - refpoint(2) + 1;

%errorx = x - updatedref(1);
%errory = y - updatedref(2);
%errorz = z - updatedref(3);

figure()
hold on 
plot(x,y)
grid on 
xlabel('x')
ylabel('y')
title('x and y plot of hovering')
hold off 

figure()
hold on 
plot(time, x)
grid on 
xlabel('time')
ylabel('x')
title('x over time')
hold off 


figure()
hold on 
plot(time, y)
grid on 
xlabel('time')
ylabel('y')
title('y over time')
hold off

figure()
hold on 
plot(time, z)
grid on 
xlabel('time')
ylabel('z')
title('z over time')
hold off 


figure()
hold on 
plot(time, errorx)
grid on 
xlabel('time')
ylabel('The error of x')
title('The error of x over time')
hold off 

figure()
hold on 
plot(time, errory)
grid on 
xlabel('time')
ylabel('The error of y')
title('The error of y over time')
hold off 

figure()
hold on 
plot(time, errorz)
grid on 
xlabel('time')
ylabel('The error of z')
title('The error of z over time')
hold off 