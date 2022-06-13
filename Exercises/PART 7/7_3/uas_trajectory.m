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
hoop1 = [2.0104; -2.4099; 1.2134];
hoop2 = [3.3634; -3.7947; 1.2367];
hoop3 = [4.3668; -2.4517; 1.2397];
hoop4 = [3.3678; -1.2525; 1.1876];

% hoop1 = out.hoop1.Data(index);
% hoop2 = out.hoop2.Data(index);
% hoop3 = out.hoop3.Data(index);
% hoop4 = out.hoop4.Data(index);





% Trajectory generation
knots = [0 40];
waypoints = cell(1,2);
center = (hoop1+hoop2+hoop3+hoop4)/4;

% waypoints{2} = (hoop1 + hoop2)/2 + [hoop2(2), hoop2(1), 0];
% waypoints{2} = hoop2;
% waypoints{3} = hoop3;
% waypoints{4} = hoop4;
factor = 0.75;
corner41 = ((hoop4 + hoop1)/2 - center)*(1+factor)+center;
corner12 = ((hoop1 + hoop2)/2 - center)*(1+factor)+center;
corner23 = ((hoop2 + hoop3)/2 - center)*(1+factor)+center;
corner34 = ((hoop3 + hoop4)/2 - center)*(1+factor)+center;
waypoints{1} = corner41;
waypoints{2} = corner41;
order = 13;
error = 0.01;
error2 = 0.05;
starttime = 5;
delta = 5;
corridors.times = starttime + delta*[0 1 2 3 4 5 6];
corridors.x_lower = [hoop1(1)-error corner12(1)-error2 hoop2(1)-error corner23(1)-error2 hoop3(1)-error corner34(1)-error2 hoop4(1)-error];
corridors.x_upper = [hoop1(1)+error corner12(1)+error2 hoop2(1)+error corner23(1)+error2 hoop3(1)+error corner34(1)+error2 hoop4(1)+error];     
corridors.y_lower = [hoop1(2)-error corner12(2)-error2 hoop2(2)-error corner23(2)-error2 hoop3(2)-error corner34(2)-error2 hoop4(2)-error];
corridors.y_upper = [hoop1(2)+error corner12(2)+error2 hoop2(2)+error corner23(2)+error2 hoop3(2)+error corner34(2)+error2 hoop4(2)+error];
corridors.z_lower = [hoop1(3)-error corner12(3)-error2 hoop2(3)-error corner23(3)-error2 hoop3(3)-error corner34(3)-error2 hoop4(3)-error];
corridors.z_upper = [hoop1(3)+error corner12(3)+error2 hoop2(3)+error corner23(3)+error2 hoop3(3)+error corner34(3)+error2 hoop4(3)+error];

% corridors.x_lower = [corner41(1)-error2 hoop1(1)-error corner12(1)-error2 hoop2(1)-error corner23(1)-error2 hoop3(1)-error corner34(1)-error2 hoop4(1)-error corner41(1)-error2];
% corridors.x_upper = [corner41(1)+error2 hoop1(1)+error corner12(1)+error2 hoop2(1)+error corner23(1)+error2 hoop3(1)+error corner34(1)+error2 hoop4(1)+error corner41(1)+error2];     
% corridors.y_lower = [corner41(2)-error2 hoop1(2)-error corner12(2)-error2 hoop2(2)-error corner23(2)-error2 hoop3(2)-error corner34(2)-error2 hoop4(2)-error corner41(2)-error2];
% corridors.y_upper = [corner41(2)+error2 hoop1(2)+error corner12(2)+error2 hoop2(2)+error corner23(2)+error2 hoop3(2)+error corner34(2)+error2 hoop4(2)+error corner41(2)+error2];
% corridors.z_lower = [corner41(3)-error2 hoop1(3)-error corner12(3)-error2 hoop2(3)-error corner23(3)-error2 hoop3(3)-error corner34(3)-error2 hoop4(3)-error corner41(3)-error2];
% corridors.z_upper = [corner41(3)+error2 hoop1(3)+error corner12(3)+error2 hoop2(3)+error corner23(3)+error2 hoop3(3)+error corner34(3)+error2 hoop4(3)+error corner41(3)+error2];



make_plots = true;

poly_traj = uas_minimum_snap(knots, order, waypoints, corridors, make_plots);
