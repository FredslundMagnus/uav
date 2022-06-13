close all;

g = 9.80665 ;
error = 0.05;

pwm = out.pwm.Data;
z_acc = out.Z_acceleration.Data - g;

mask = pwm > 37500 & pwm < 57500 & z_acc < 3 & z_acc > -3;
pwm = pwm(mask);
z_acc = z_acc(mask);
z_diff = max(z_acc) - min(z_acc);
pwm = pwm / 60000;
pwm_diff = max(pwm) - min(pwm);
% pwm = pwm / pwm_diff;

N = 1;
maxDistance = 0.1;

[P, inlierIdx] = fitPolynomialRANSAC([z_acc, pwm], N, maxDistance, "Confidence", 99.99999999);
a = P(1);
b = P(2);

a
b

yRecoveredCurve = polyval(P,z_acc);
figure()
plot(z_acc, yRecoveredCurve)
%scatter(pwm(maks), z_acc(maks))
hold on 
plot(z_acc(inlierIdx), pwm(inlierIdx),'.',z_acc(~inlierIdx), pwm(~inlierIdx),'ro')
grid on 
hold off

