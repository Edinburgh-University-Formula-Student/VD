%% University of Edinburgh Formula Student
% Point-Mass Laptime Simulator
% Paul Wang, Vehicle Dynamics
% Fall 2024

%% Track attributes:
clear
deltaX = 1;

load("Tracks\OpenTRACK_Spa-Francorchamps_Closed_Forward.mat")
% load("Tracks\OpenTRACK_FSAE Skidpad_Closed_Forward.mat")
% load("Tracks\OpenTRACK_Donington Park_Closed_Forward.mat")

track2 = r';
track1 = abs(1 ./ track2);
track1 = abs(track1 * 0.05);


track1(1:2:end) = [];
track1(1:2:end) = [];
track1(1:2:end) = [];
track1(1:2:end) = [];
track1(1:2:end) = [];


% straight1length = 100;
% track2 = zeros(2, ((straight1length/deltaX)+1));
% track1 = abs(1 ./ track2);
% track1(1,1) = 1;
% track1(1,2) = 1;


%% Car Attributes
filetable = readtable("Vehicle Profile for PM-LTS.xlsx");
file = table2array(filetable(:,2));

Mass = file(1);
Cdrag = file(2);
Clift = file(3);
Area = file(4);
rho = file(5);
MaxSteering = file(6);
EngTorque = file(7);
TyreRadius = file(8);
BrakeTorque = file(9);
Croll = file(13);
CFlong = file(14);
CFlat = file(15);
Dmux = file(16);
Dmuy = file(16);
factor_drive = file(18);
factor_aero = file(19);
driven_wheels = file(20);
braking_wheels = file(21);


TyreRadius = TyreRadius/(39.37*2);
PowerLimitAcc = driven_wheels*12*EngTorque/(TyreRadius*Mass);

% factor_drive = 1;
% factor_aero = 1;
% driven_wheels = 4;
% braking_wheels = 4;


%% GGV
trackIncl = 0;
trackBank = 0;



vMax = 500;
N = 45;
dv = 0.5;
v = (0:dv:vMax)';

if v(end)~=vMax
    v = [v;vMax];
end

GGV = zeros(length(v),2*N-1,3);


for i=1:length(v)
    % aero forces
    Aero_Df = FzAero(rho, Area, Clift, v(i));
    Aero_Dr = FxAero(rho, Area, Cdrag, v(i));
    % rolling resistance
    Roll_Dr = FxRoll(Croll, -1*FzMass(Mass, trackIncl, trackBank) - Aero_Df);
    % normal load on driven wheels
    Wd = (factor_drive * -1*(FzMass(Mass, trackIncl, trackBank)) +  (-factor_aero*Aero_Df)) / driven_wheels;
    % drag acceleration
    ax_drag = (Aero_Dr + Roll_Dr + FxMass(Mass, trackIncl))/Mass;
    % maximum lat acc available from tyres
    ay_max = (1/Mass) * (CFlat + Dmuy*((Mass*9.81/4)  -  (-1 * FzMass(Mass, trackIncl, trackBank)   -  Aero_Df)/4)) * (-1 * FzMass(Mass, trackIncl, trackBank)   -  Aero_Df);
    % max long acc available from tyres
    ax_tyre_max_acc = (1/Mass) * (CFlong + Dmux*( (Mass*9.81/4) - Wd)) * Wd * driven_wheels;
    % max long dec available from tyres
    ax_tyre_max_dec = (-1/Mass) * (CFlong + Dmux*( (Mass*9.81/4) - (-1 * FzMass(Mass, trackIncl, trackBank) - Aero_Df)/4)) * (-1 * FzMass(Mass, trackIncl, trackBank) - Aero_Df);
    % getting power limit from engine
    ax_power_limit = PowerLimitAcc;


    % Torque is acceleration
    % Power is top speed
    % Assume constant 24 nm of torque   
    % Power is an output, sketch energy over the lap, no impact from battery or voltage or current, torque is constant.  
    % No use to implement battery or power.


    % lat acc vector
    ay = ay_max*cosd(linspace(0,180,N))' ;
    % long acc vector
    ax_tyre_acc = ax_tyre_max_acc*sqrt(1-(ay/ay_max).^2) ; % friction ellipse
    ax_acc = min(ax_tyre_acc,ax_power_limit)+ax_drag ; % limiting by engine power
    ax_dec = ax_tyre_max_dec*sqrt(1-(ay/ay_max).^2)+ax_drag ; % friction ellipse

    % saving GGV map
    GGV(i,:,1) = [ax_acc',ax_dec(2:end)'] ;
    GGV(i,:,2) = [ay',flipud(ay(2:end))'] ;
    GGV(i,:,3) = v(i)*ones(1,2*N-1) ;
end



% GGV(101,67)
% Row, Column, Layer
% Velocity, Point on ellipse, Long or Lat
% Velocity*2 + 1, 67 for Max Longitudinal Deceleration, 
% 23 for Max Longitudinal Acceleration
% 1 for Max Lateral (negative)
% 45 for Max Lateral (positive)
%% TODO: This needs to be better, it probably doesn't even work right now
LateralIndexPositive = 45;
LateralIndexNegative = 1;
LongitudinalDecel = 67;
LongitudinalAccel = 23;


%% ggv map
hold on
subplot(1,2,1);
title('GGV Map')
render_size = 80;
surf(GGV(1:render_size,:,2),GGV(1:render_size,:,1),GGV(1:render_size,:,3))
grid on
xlabel('Lat acc [m/s^2]')
ylabel('Long acc [m/s^2]')
zlabel('Speed [m/s]')
view(105,15)
set(gca,'DataAspectRatio',[1 1 0.8])
cbar = colorbar ;
set(get(cbar,'Title'),'String','Speed [m/s]')



%% Track configs:
% Identifies all corners on the track, sorts them into ascending order, and
% trunkates the matrix.

corners = track1(1,:);
corners(corners<=0) = NaN;
[out, idx] = sort(corners);
corners = [rmmissing(out); idx(1:length(rmmissing(out)))];



% -----------------------
%% Velocity Calculations:
% -----------------------
% Creates empty arrays to store minimum speed values for each segment of track
acceleration_speed = zeros(2,length(track1));
deceleration_speed = zeros(2,length(track1));


% Standing Start:
% acceleration_speed(1) = 0.1;


% For each corner (starting with the slowest corner), the maximum 
% acceleration velocities for the rest of the track is calculated, allowing 
% "unrestricted" acceleration. If a slower needed velocity for a track 
% segment is found, the velocity value for that segment is overwritten. 
% The process for Deceleration is identical, but starting from the slowest
% corner going backwards around the track.
for i=1:length(corners)
    target_index = corners(2,i);

    for j=1:length(track1)

        % Code for looping (closed) track configuration
        if target_index-j >= 0
            dec_index = target_index - j + 1;
        else
            dec_index = length(track1) - (j-target_index) + 1;
        end
        if target_index+j <= length(track1) + 1
            acc_index = target_index + j - 1;
        else
            acc_index = j + target_index - length(track1) - 1;
        end


        % Code to ensure array-out-of-bounds errors are caught
        if dec_index == length(track1)
            next_index = 1;
        else
            next_index = dec_index + 1;
        end
        if acc_index == 1
            previous_index = length(track1);
        else
            previous_index = acc_index - 1;
        end


        % Stores value for the current velocity mapped to that segment of track
        old_decel = deceleration_speed(1, dec_index);
        old_accel = acceleration_speed(1, acc_index);


        % Set the index to grab from the GGV index
        if (deceleration_speed(1, next_index)) ~= 0
            GGVdecIndex = round((deceleration_speed(1, next_index) * (1/dv) + 1));
        else
            GGVdecIndex = round(old_decel * (1/dv) + 1);
        end
        if (acceleration_speed(1, previous_index)) ~= 0
            GGVaccIndex = round((acceleration_speed(1, previous_index) * (1/dv) + 1));
        else
            GGVaccIndex = round(old_accel * (1/dv) + 1);
        end

        % Set the acceleration from the GGV map
        axDec = abs(GGV(GGVdecIndex, LongitudinalDecel, 1));
        ayDec = abs(GGV(GGVdecIndex, LateralIndexPositive, 2));
        axAcc = abs(GGV(GGVaccIndex, LongitudinalAccel, 1));
        ayAcc = abs(GGV(GGVaccIndex, LateralIndexPositive, 2));



        %% DECELERATION
        if track1(1,dec_index) == inf || track1(1,dec_index) == 0 % During Straights
            new_dec = sqrt((deceleration_speed(1, next_index)^2) + 2 * axDec * deltaX); % "Unrestricted" deceleration

            if old_decel == 0 % Slowest corner condition, first time calculation
                deceleration_speed(1,dec_index) = new_dec;
            elseif new_dec < old_decel
                deceleration_speed(1,dec_index) = new_dec; % Update speed if a new minimum speed is required
            end 

            
        else % During Corners
            apex_decel = sqrt(ayDec * track1(1, dec_index)); % Maximum cornering speed given from radius and ay
            
            if old_decel == 0
                if deceleration_speed(1, next_index) ~= 0
                    deceleration_speed(1, dec_index) = min(apex_decel, sqrt((deceleration_speed(1, next_index)^2) + 2 * axDec * deltaX )); % Determine whether it is possible to acheive maximum apex speed given previous speed, or corner is flat out
                else
                    deceleration_speed(1, dec_index) = apex_decel;
                end
            end
            if apex_decel < old_decel
                deceleration_speed(1, dec_index) = apex_decel; % Set maximum allowable speed for the corner
            end

        end % Deceleration

        %% ACCELERATION
        if track1(1,acc_index) == inf || track1(1,dec_index) == 0 % During Straights
            new_acc = sqrt((acceleration_speed(1, previous_index)^2) + 2 * axAcc * deltaX); % "Unrestricted" deceleration

            if old_accel == 0 % Slowest corner condition, first time calculation
                acceleration_speed(1,acc_index) = new_acc;
            elseif new_acc < old_accel
                acceleration_speed(1,acc_index) = new_acc; % Update speed if a new minimum speed is required
            end 

            
        else % During Corners
            apex_accel = sqrt(ayAcc * track1(1, acc_index)); % Maximum cornering speed given from radius and ay

            if old_accel == 0
                if acceleration_speed(1, previous_index) ~= 0
                    acceleration_speed(1, acc_index) = min(apex_accel, sqrt((acceleration_speed(1, previous_index)^2) + 2 * axAcc * deltaX )); % Determine whether it is possible to acheive maximum apex speed given previous speed, or corner is flat out
                else
                    acceleration_speed(1, acc_index) = apex_accel;
                end
            end
            if apex_accel < old_accel
                acceleration_speed(1, acc_index) = apex_accel; % Set maximum allowable speed for the corner
            end

        end % Deceleration

    end % Calculations of the entire track given a corner

end % Corner looper



%% Final Time Calculations:
final_speed = min(acceleration_speed,deceleration_speed); % T6akes the slowest speed required for each given track segment
times = deltaX ./ final_speed; % Assumes constant track mesh spacing
times(:,1) = []; % stores precise time values in a Matrix
total_time = sum(times, 2);
total_time(2,:) = []



%% Plotting:
hold on
subplot(1,2,2)
hold on
plot(acceleration_speed(1,:))
plot(deceleration_speed(1,:))
plot(final_speed(1,:))
titleText = strcat('Final Time =  ', " ", num2str(floorDiv(total_time,60)),":", num2str(mod(total_time, 60)));
title(titleText)
xlabel('Distance Through Lap (m)') 
ylabel('Forward Velocity (m/s)') 
legend({'Accelerating','Braking', 'Final Speed'},'Location','northeast')
hold off