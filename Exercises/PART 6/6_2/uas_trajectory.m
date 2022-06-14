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
clear
clc

% Trajectory generation

knots = [0 5];
waypoints = cell(1,2);
waypoints{1} = [0 ; 0 ; 1];
waypoints{2} = [9 ; 9 ; 1];
% Fix this...
%order = 7;
%corridors.times = [2 2.5 3];
%corridors.x_lower = [6 8 8];
%corridors.x_upper = [10 10 10];
%corridors.y_lower = [-1 -1 -1];
%corridors.y_upper = [1 1 3];
%corridors.z_lower = [0 0 0];
%corridors.z_upper = [2 2 2];
order = 11;
corridors.times = [1.5 2 2.5 3.25];
corridors.x_lower = [0.5 8.65 8.65 8.65];
corridors.x_upper = [8.5 9.35 9.35 9.35];
corridors.y_lower = [-0.35 -0.35 -0.35 0.5];
corridors.y_upper = [0.25 0.25 0.25 8.5];
corridors.z_lower = [0.5 0.5 0.5 0.5];
corridors.z_upper = [1.5 1.5 1.5 1.5];
% ...until here
make_plots = true;

poly_traj = uas_minimum_snap(knots, order, waypoints, corridors, make_plots);

route = [0 0 1 ; 9 0 1 ; 9 9 1]; % Original: 6.4

% route = [0 0 1; 1 0 1; 2 0 1; 3 0 1; 4 0 1; 5 0 1; 6 0 1; 7 0 1; 8 0 1; 9 0 1; 9 1 1; 9 2 1; 9 3 1; 9 4 1; 9 5 1; 8 5 1; 7 5 1; 7 6 1; 7 7 1; 6 7 1; 5 7 1; 5 6 1; 5 5 1; 4 5 1; 3 5 1];
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

