close all;

g = 9.80665 ;
error = 0.05;

pwm = out.pwm.Data;
z_acc = out.Z_acceleration.Data - g;

mask = pwm > 37500 & pwm < 57500 & z_acc < 3 & z_acc > -3;
pwm = pwm(mask);
z_acc = z_acc(mask);
pwm = pwm / 60000;

N = 1;
maxDistance = 1;
b = -1000;
while((b < -g-error) || (b > -g+error))
    [P, inlierIdx] = fitPolynomialRANSAC([pwm, z_acc], N, maxDistance, "Confidence", 99.99999999);
    a = P(1);
    b = P(2);
end
a
b

yRecoveredCurve = polyval(P,pwm);
figure()
plot(pwm, yRecoveredCurve)
%scatter(pwm(maks), z_acc(maks))
hold on 
plot(pwm(inlierIdx), z_acc(inlierIdx),'.',pwm(~inlierIdx),z_acc(~inlierIdx),'ro')
grid on 
hold off

