%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MIT License
% 
% Copyright (c) 2021 David Wuthier (dwuthier@gmail.com)
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialization
close all


% Read hoops
% hoop1 = [2.0104; -2.4099; 1.2134];
% hoop2 = [3.3634; -3.7947; 1.2367];
% hoop3 = [4.3668; -2.4517; 1.2397];
% hoop4 = [3.3678; -1.2525; 1.1876];

%copied from out
hoop1 = transpose([2.38606190681458	-4.21798563003540	1.15600371360779]);
hoop2 = transpose([0.503714740276337	-2.62857151031494	1.22730457782745]);
hoop3 = transpose([2.47366237640381	-0.720248997211456	1.22701871395111]);
hoop4 = transpose([4.27147865295410	-2.54977250099182	1.15684640407562]);


% pos = 50; % 2 sek
% hoop1 = transpose(out.hoop1.Data(pos,:));
% hoop2 = transpose(out.hoop2.Data(pos,:));
% hoop3 = transpose(out.hoop3.Data(pos,:));
% hoop4 = transpose(out.hoop4.Data(pos,:));




% Trajectory generation
waypoints = cell(1,2);
center = (hoop1+hoop2+hoop3+hoop4)/4;

% waypoints{2} = (hoop1 + hoop2)/2 + [hoop2(2), hoop2(1), 0];
% waypoints{2} = hoop2;
% waypoints{3} = hoop3;
% waypoints{4} = hoop4;
factor = 0.75;
corner41 = ((hoop4 + hoop1)/2 - center)*2+center;
corner12 = ((hoop1 + hoop2)/2 - center)*(1+factor)+center;
corner23 = ((hoop2 + hoop3)/2 - center)*(1+factor)+center;
corner34 = ((hoop3 + hoop4)/2 - center)*(1+factor)+center;
waypoints{1} = corner41;
waypoints{2} = corner41;
order = 13;
error = 0.01;
error2 = 0.05;
starttime = 15;
delta = 5;

knots = [0 starttime+delta*7];
z_fix = (1.21766328811646 - 1.44)*2/3;


corridors.times = starttime + delta*[0 1 2 3 4 5 6];
corridors.x_lower = [hoop1(1)-error corner12(1)-error2 hoop2(1)-error corner23(1)-error2 hoop3(1)-error corner34(1)-error2 hoop4(1)-error];
corridors.x_upper = [hoop1(1)+error corner12(1)+error2 hoop2(1)+error corner23(1)+error2 hoop3(1)+error corner34(1)+error2 hoop4(1)+error];     
corridors.y_lower = [hoop1(2)-error corner12(2)-error2 hoop2(2)-error corner23(2)-error2 hoop3(2)-error corner34(2)-error2 hoop4(2)-error];
corridors.y_upper = [hoop1(2)+error corner12(2)+error2 hoop2(2)+error corner23(2)+error2 hoop3(2)+error corner34(2)+error2 hoop4(2)+error];
corridors.z_lower = [hoop1(3)-error corner12(3)-error2 hoop2(3)-error corner23(3)-error2 hoop3(3)-error corner34(3)-error2 hoop4(3)-error]+z_fix;
corridors.z_upper = [hoop1(3)+error corner12(3)+error2 hoop2(3)+error corner23(3)+error2 hoop3(3)+error corner34(3)+error2 hoop4(3)+error]+z_fix;

% corridors.x_lower = [corner41(1)-error2 hoop1(1)-error corner12(1)-error2 hoop2(1)-error corner23(1)-error2 hoop3(1)-error corner34(1)-error2 hoop4(1)-error corner41(1)-error2];
% corridors.x_upper = [corner41(1)+error2 hoop1(1)+error corner12(1)+error2 hoop2(1)+error corner23(1)+error2 hoop3(1)+error corner34(1)+error2 hoop4(1)+error corner41(1)+error2];     
% corridors.y_lower = [corner41(2)-error2 hoop1(2)-error corner12(2)-error2 hoop2(2)-error corner23(2)-error2 hoop3(2)-error corner34(2)-error2 hoop4(2)-error corner41(2)-error2];
% corridors.y_upper = [corner41(2)+error2 hoop1(2)+error corner12(2)+error2 hoop2(2)+error corner23(2)+error2 hoop3(2)+error corner34(2)+error2 hoop4(2)+error corner41(2)+error2];
% corridors.z_lower = [corner41(3)-error2 hoop1(3)-error corner12(3)-error2 hoop2(3)-error corner23(3)-error2 hoop3(3)-error corner34(3)-error2 hoop4(3)-error corner41(3)-error2];
% corridors.z_upper = [corner41(3)+error2 hoop1(3)+error corner12(3)+error2 hoop2(3)+error corner23(3)+error2 hoop3(3)+error corner34(3)+error2 hoop4(3)+error corner41(3)+error2];



make_plots = true;

poly_traj = uas_minimum_snap(knots, order, waypoints, corridors, make_plots);

% Unscaled route
route_unscaled = [3 -3 1; 4 -3 1];

% a and b
a = 0.0932;
b = 0.8231;

% Scaling and Offset
x_scale = 0.65;
y_scale = 0.55;
z_scale = 0.75;

x_offset = 0.3;
y_offset = 0.5;
z_offset = 0.25;

% Make a copy of the route_unscaled
route_scaled = route_unscaled;

% Scale the copy
route_scaled(:,1) = (route_scaled(:,1) - 1) * x_scale + x_offset;
route_scaled(:,2) = (route_scaled(:,2) - 1) * y_scale + y_offset;
route_scaled(:,3) = (route_scaled(:,3) - 1) * z_scale + z_offset;

% Make a copy of the route_scaled
route = route_unscaled;

wall_color = [0.8 0.2 0.2];
sample_time = 4e-2;
publish_rate = 1 * sample_time;
x0 = 36;
y0 = 80;
z0 = 1;
g = 9.80665 ;
mass_drone = 0.68 ;
mass_rod = 0.0;
mass_tip = 0;
mass_total = mass_drone + mass_rod + mass_tip;
stiffness_rod = 100 ;
critical_damping_rod = 2 * sqrt(mass_total * stiffness_rod) ;
stiffness_wall = 100 ;
critical_damping_wall = 2 * sqrt(mass_total * stiffness_wall) ;
inertia_xx = 0.007 ;
inertia_yy = 0.007 ;
inertia_zz = 0.012 ;
arm_length = 0.17 ;
rotor_offset_top = 0.01 ;
motor_constant = 8.54858e-06 ;
moment_constant = 0.016 ;
max_rot_velocity = 838 ;
allocation_matrix = ...
    [1 1 1 1
     0 arm_length 0 -arm_length
     -arm_length 0 arm_length 0
     -moment_constant moment_constant -moment_constant moment_constant] ;
mix_matrix = inv(motor_constant * allocation_matrix) ;
air_density = 1.2041;
drag_coefficient = 0.47;
reference_area = pi * 75e-3^2;

