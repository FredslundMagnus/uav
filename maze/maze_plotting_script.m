
% This file contains parameters and calculations needed for running
% MatLab with rotorS ROS package for interfacing with a position controlled
% drone

%%
clc;
close all;
clear all;

%%

maze_1;
start = [0, 0];
% end_ = [5,0];
end_ = [3,5];

fig_num = 1;

plot_map(map, fig_num);
plot_start_stop(start, end_, fig_num)

% route = [1 1; 2 1; 3 1; 4 1; 5 1; 6 1];
route = [1 1; 2 1; 3 1; 4 1; 5 1; 6 1; 7 1; 8 1; 9 1; 10 1; 10 2; 10 3; 10 4; 10 5; 10 6; 9 6; 8 6; 8 7; 8 8; 7 8; 6 8; 6 7; 6 6; 5 6; 4 6];

plot_route(route, fig_num);

%%

fig_num = 2;

maze_1_3D;

start = [0 0 0];
% end_ = [5 0 2];
end_ = [3 5 0];

plot_map(map, fig_num, 0);
plot_start_stop(start, end_, fig_num)

% route = [1 1 1; 2 1 2; 3 1 3; 4 1 3; 5 1 3; 6 1 3];
route = [1 1 1; 2 1 1; 3 1 1; 4 1 1; 5 1 1; 6 1 1; 7 1 1; 8 1 1; 9 1 1; 10 1 1; 10 2 1; 10 3 1; 10 4 1; 10 5 1; 10 6 1; 9 6 1; 8 6 1; 8 7 1; 8 8 1; 7 8 1; 6 8 1; 6 7 1; 6 6 1; 5 6 1; 4 6 1];

plot_route(route, fig_num)

