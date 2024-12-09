% straight1length = 100;
% track2 = zeros(2, ((straight1length/deltaX)+1));
% track = abs(1 ./ track2);
% track(1,1) = 0.01;
% track(1,101) = 0.01;
% 
% save("Tracks/100m Acceleration", "track")


% radius = 7.6250;
% C = round(radius*2*pi);
% track = ones(2, 2*C+1);
% track(1, 1:C) = radius;
% track(1,49) = inf;
% track(1, 50:97) = radius;
% 
% save("Tracks/FSUK Skidpad", "track")


% % load("Tracks\OpenTRACK_Spa-Francorchamps_Closed_Forward.mat", "r")
% % load("Tracks\OpenTRACK_FSAE Skidpad_Closed_Forward.mat", "r")
% load("Tracks\OpenTRACK_Donington Park_Closed_Forward.mat", "r")
% track = abs(1 ./ r');
% % 
% % track = abs(track / 9.125);
% % track = abs(track * 7.6250);
% 
% 
% 
% track = abs(track * 0.05);
% track(1:2:end) = [];
% track(1:2:end) = [];
% track(1:2:end) = [];
% track(1:2:end) = [];
% track(1:2:end) = [];
% 
% save("Tracks/Mini_Donington_Park", "track")