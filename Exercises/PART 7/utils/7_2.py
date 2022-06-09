from pandas import read_csv
from numpy import array
import numpy as np
import matplotlib.pyplot as plt
from sklearn import linear_model

min_trust = 37500



data = read_csv("7_2.csv", sep=",")
print(data.head())
acc_z, pwm_m1_pwm, pwm_m2_pwm, pwm_m3_pwm, pwm_m4_pwm = data["acc.z"], data["pwm.m1_pwm"], data["pwm.m2_pwm"], data["pwm.m3_pwm"], data["pwm.m4_pwm"]
acc_z, pwm_m1_pwm, pwm_m2_pwm, pwm_m3_pwm, pwm_m4_pwm = array(acc_z), array(pwm_m1_pwm), array(pwm_m2_pwm), array(pwm_m3_pwm), array(pwm_m4_pwm)
outliers = (pwm_m1_pwm < min_trust) | (pwm_m2_pwm < min_trust) | (pwm_m3_pwm < min_trust) | (pwm_m4_pwm < min_trust)
inliers = outliers == False
print(len(acc_z))

acc_z, pwm_m1_pwm, pwm_m2_pwm, pwm_m3_pwm, pwm_m4_pwm = acc_z[inliers], pwm_m1_pwm[inliers], pwm_m2_pwm[inliers], pwm_m3_pwm[inliers], pwm_m4_pwm[inliers]
pwm_full = array([pwm_m1_pwm, pwm_m2_pwm, pwm_m3_pwm, pwm_m4_pwm])
pwm_mean = pwm_full.mean(axis=0)
pwm_std = pwm_full.std(axis=0)
print(len(acc_z))
print(len(pwm_mean))
print(pwm_std)

plt.plot(acc_z, pwm_mean, "b.")
plt.show()

x, y = acc_z.reshape(-1, 1), pwm_mean.reshape(-1, 1)

lr = linear_model.LinearRegression()
lr.fit(x, y)
line_X = np.arange(x.min(), x.max(), step=0.01)[:, np.newaxis]
line_y = lr.predict(line_X)
plt.scatter(x,y, marker='.')
plt.plot(line_X, line_y, color='cornflowerblue', linewidth=1, label='Line')
plt.legend(loc='lower right')
plt.xlabel("Input")
plt.ylabel("Response")
print("\n", f"Parameters: a={lr.coef_[0][0]}, b={lr.intercept_[0]}", sep="\n")
plt.show()

