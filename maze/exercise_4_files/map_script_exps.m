close all
clear all
clc
exps = 0;
exps_g = 0;
lens = 0;
lens_g = 0;
solved = 0;
for k = 1:10
    %% Setup the map 
    % Define the map size
    max_x = 70;
    max_y = 70;
    map = zeros(max_x, max_y);
    
    % Generate random obstacles. A 1 in the map is regarded as
    % an obstacle
    obs_per = 0.3;
    for x = 1:max_x
        for y = 1:max_y
            if rand > 1 - obs_per
                map(x,y) = 1;
            end
        end
    end
    
    % Define the starting and end position
    start = [10, 10];
    end_ = [60, 60];
    
    % Make sure the start and end is not an obstacle
    map(start(1),start(2)) = 0;
    map(end_(1),end_(2)) = 0;
    
    %% Run the algorithm to optain the route
    [ route, expanded ] = astar_2d(map, start, end_);
    [ route2, expanded2 ] = greedy_2d(map, start, end_);
    if length(route) ~= 1
        solved = solved + 1;
        exps = exps + expanded;
        lens = lens + length(route);
        exps_g = exps_g + expanded2;
        lens_g = lens_g + length(route2);
        "avg exps"
        exps/solved
        lens/solved
        "avg exps2"
        exps_g/solved
        lens_g/solved
    end 
    solved/k
end


%% Draw the map
% Draw a figure to show the map and process
hold off
figure(1)
% Mark the start with green
scatter(start(1)-0.5, start(2)-0.5, [], [0,1,0])
hold on

% Mark the end with red
scatter(end_(1)-0.5, end_(2)-0.5, [], [1,0.6,0])
hold on

% Mark the obstacles with blue 
for x = 1:max_x
    for y = 1:max_y
        if map(x,y) == 1
            scatter(x-0.5, y-0.5, [], [0,0,1])
            hold on
        end
    end
end

% Set the axes
axis([0 max_x 0 max_y])
% Make the grid lines more visible
ax = gca;
ax.GridAlpha = 1.0;
grid on
set(gca, 'xtick', [0:1:max_x])
set(gca, 'ytick', [0:1:max_y])

% Draw the route
pause on;
for i = 2:length(route)
    plot([route(i-1,1)-0.5,route(i,1)-0.5], ...
         [route(i-1,2)-0.5,route(i,2)-0.5], ...
         'color',[0,0,0],'linewidth',5)
    hold on
    pause(0.1)
    route(i,:)
end
hold off