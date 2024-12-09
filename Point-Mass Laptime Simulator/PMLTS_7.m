%% University of Edinburgh Formula Student
% Point-Mass Laptime Simulator
% Paul Wang, Vehicle Dynamics
% Fall 2024

%% Track attributes:
clear
deltaX = 1;

filename = "Tracks\Mini_Spa_Francorchamps.mat";
% filename = "Tracks\100m Acceleration.mat";
% filename = "Tracks\FSUK Skidpad.mat";
% filename = "Tracks\Mini_Donington_Park.mat";

load(filename, "track")

% track = [track track];
% track = [track track];
% track = [track track];

%% Car Attributes
filetable = readtable("Vehicle Profile for PM-LTS.xlsx");
file = table2array(filetable(:,2));

Mass = file(1);
Cdrag = file(2);
Clift = file(3);
Area = file(4);
rho = file(5);
Rrack = file(6);
EngTorque = file(7);
TyreRadius = file(8);
Ddisc = file(9);
Hpad = file(10);
MuPad = file(11);
Npist = file(12);
Dpist = file(13);
Dmast = file(14);
Rpedal = file(15);
Croll = file(16);
CFlong = file(17);
CFlat = file(18);
Dmux = file(19);
Dmuy = file(19);
powerSlope = file(20);
CF = file(21);
CR = file(22);
df = file(23)/100;
L = file(24);
BatteryCap = file(25);
BatteryEff = file(26);
GearboxRatio = file(27);
factor_drive = file(28);
factor_aero = file(29);
driven_wheels = file(30);
braking_wheels = file(31);


TyreRadius = TyreRadius/(39.37*2);
% PowerLimitAcc = (driven_wheels*12*EngTorque)/(2*pi*TyreRadius*Mass);
PowerLimitAcc = (driven_wheels * GearboxRatio * EngTorque) / (Mass * TyreRadius);


%% GGV
trackIncl = 0;
trackBank = 0;



vMax = 10000;
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
    ay_max = (1/Mass) * (CFlat + Dmuy*((Mass*9.81/braking_wheels)  -  (-1 * FzMass(Mass, trackIncl, trackBank)   -  Aero_Df)/braking_wheels)) * (-1 * FzMass(Mass, trackIncl, trackBank)   -  Aero_Df);
    % max long acc available from tyres
    ax_tyre_max_acc = (1/Mass) * (CFlong + Dmux*( (Mass*9.81/braking_wheels) - Wd)) * Wd * driven_wheels;
    % max long dec available from tyres
    ax_tyre_max_dec = (-1/Mass) * (CFlong + Dmux*( (Mass*9.81/braking_wheels) - (-1 * FzMass(Mass, trackIncl, trackBank) - Aero_Df)/braking_wheels)) * (-1 * FzMass(Mass, trackIncl, trackBank) - Aero_Df);
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
% hold on
% subplot(2,3,1);
% title('GGV Map')
% render_size = 60;
% surf(GGV(1:render_size,:,2),GGV(1:render_size,:,1),GGV(1:render_size,:,3))
% grid on
% xlabel('Lat acc [m/s^2]')
% ylabel('Long acc [m/s^2]')
% zlabel('Speed [m/s]')
% view(105,15)
% set(gca,'DataAspectRatio',[1 1 1])
% cbar = colorbar ;
% set(get(cbar,'Title'),'String','Speed [m/s]')



%% Track configs:
% Identifies all corners on the track, sorts them into ascending order, and
% trunkates the matrix.

corners = track(1,:);
corners(corners<=0) = NaN;
[out, idx] = sort(corners);
corners = [rmmissing(out); idx(1:length(rmmissing(out)))];



% -----------------------
%% Velocity Calculations:
% -----------------------
% Creates empty arrays to store minimum speed values for each segment of track
acceleration_speed = zeros(2,length(track));
deceleration_speed = zeros(2,length(track));
braking_force = zeros(2, length(track));


% Standing Start:
% acceleration_speed(1) = 0.01;


% For each corner (starting with the slowest corner), the maximum 
% acceleration velocities for the rest of the track is calculated, allowing 
% "unrestricted" acceleration. If a slower needed velocity for a track 
% segment is found, the velocity value for that segment is overwritten. 
% The process for Deceleration is identical, but starting from the slowest
% corner going backwards around the track.
for i=1:length(corners)
    target_index = corners(2,i);

    for j=1:length(track)

        % Code for looping (closed) track configuration
        if target_index-j >= 0, dec_index = target_index - j + 1; else, dec_index = length(track) - (j-target_index) + 1; end
        if target_index+j <= length(track) + 1, acc_index = target_index + j - 1; else, acc_index = j + target_index - length(track) - 1; end


        % Code to ensure array-out-of-bounds errors are caught
        if dec_index == length(track), next_index = 1; else, next_index = dec_index + 1; end
        if acc_index == 1, previous_index = length(track); else, previous_index = acc_index - 1; end


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

        top_speed = 100;

        if GGVdecIndex >= top_speed
            axDec = 0;
            ayDec = 0;
        else
            axDec = abs(GGV(GGVdecIndex, LongitudinalDecel, 1));
            ayDec = abs(GGV(GGVdecIndex, LateralIndexPositive, 2));
        end

        % Set the acceleration from the GGV map
        
        
        axAcc = abs(GGV(GGVaccIndex, LongitudinalAccel, 1));
        ayAcc = abs(GGV(GGVaccIndex, LateralIndexPositive, 2));

        % disp("Velocity: " + (deceleration_speed(1, next_index)) + "GGV Index: " + GGVdecIndex + " Ay: " + ay)

        braking_force(1, dec_index) = axDec * Mass;

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% DECELERATION
        if track(1,dec_index) == inf || track(1,dec_index) == 0 % During Straights
            new_dec = sqrt((deceleration_speed(1, next_index)^2) + 2 * axDec * deltaX); % "Unrestricted" deceleration

            if old_decel == 0 % Slowest corner condition, first time calculation
                deceleration_speed(1,dec_index) = new_dec;
            elseif new_dec < old_decel
                deceleration_speed(1,dec_index) = new_dec; % Update speed if a new minimum speed is required
            end 

            
        else % During Corners
            apex_decel = sqrt(ayDec * track(1, dec_index)); % Maximum cornering speed given from radius and ay
            
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


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% ACCELERATION
        if track(1,acc_index) == inf || track(1,dec_index) == 0 % During Straights
            new_acc = sqrt((acceleration_speed(1, previous_index)^2) + 2 * axAcc * deltaX); % "Unrestricted" deceleration

            if old_accel == 0 % Slowest corner condition, first time calculation
                acceleration_speed(1,acc_index) = new_acc;
            elseif new_acc < old_accel
                acceleration_speed(1,acc_index) = new_acc; % Update speed if a new minimum speed is required
            end 

            
        else % DURING CORNERS
            apex_accel = sqrt(ayAcc * track(1, acc_index)); % Maximum cornering speed given from radius and ay

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
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    end % Calculations of the entire track given a corner

    
end % Corner looper

% deceleration_speed = inf;

%% Final Time Calculations:
isAccelerating = zeros(1, length(acceleration_speed));
for i=1:length(acceleration_speed)
    if acceleration_speed(1,i) <= deceleration_speed(1,i)
        isAccelerating(1,i) = 1;
    end
end

final_speed = min(acceleration_speed,deceleration_speed); % T6akes the slowest speed required for each given track segment
times = deltaX ./ final_speed; % Assumes constant track mesh spacing
times(:,1) = []; % stores precise time values in a Matrix
total_time = sum(times, 2);
Skipad_time = sum(times(1,1:58), 2)
total_time(2,:) = []


% deceleration_speed = inf;

%% Plotting:
% subplot(2,3,2)
hold on
plot(acceleration_speed(1,:))
plot(deceleration_speed(1,:))
plot(final_speed(1,:))
titleText = strcat('Final Time =  ', " ", num2str(floorDiv(total_time,60)),":", num2str(mod(total_time, 60)));
title(titleText)
filename = extractAfter(filename,"Tracks\");
filename = extractBefore(filename, ".mat");
filename = strrep(filename, '_', ' ');
subtitle(filename)
xlabel('Distance Through Lap (m)') 
xlim([1 length(track)])
ylabel('Forward Velocity (m/s)') 
legend({'Accelerating','Braking', 'Final Speed'},'Location','northeast')



% %% Kinetic Energy
% kinetic_energy = 0.5 * Mass * final_speed .^ 2;
% subplot(2,3,3)
% hold on
% plot(kinetic_energy(1,:))
% title("Kinetic Energy vs Distance Through Lap")
% xlim([1 length(track)])
% xlabel('Distance Through Lap (m)') 
% ylabel('Kinetic Energy (J)') 


%% Power Loss

% Total_Power = Joules
% RPM = 
% Voimsus = kW 

% RPM = 0.105 1/s
% kW = 1000 J/s

% kinetic_energy = kinetic_energy * (BatteryEff / 100);

% Total_Power = BatteryCap * 3600 * 90/100; % Watthours * 3600 * 90% operable = Joules
Total_Power = BatteryCap;
Max_Power = Total_Power;
voimsus = zeros(1, length(kinetic_energy));
timeAccelerating = isAccelerating(1:length(times)) .* times(1,:);
RPM = zeros(1, length(timeAccelerating));
Power_over_time = zeros(1, length(timeAccelerating));

% currentTimeInterval = 0;
% for i=1:length(timeAccelerating)
%     RPM(1,i) = GearboxRatio * final_speed(1,i) * (60/(2*pi*TyreRadius));
% 
%     if timeAccelerating(1,i) ~= 0
%         currentTimeInterval = currentTimeInterval + timeAccelerating(1,i);
%     else
% 
%         Total_Power = Total_Power - ((RPM(1,i) * powerSlope) * 1000 * currentTimeInterval * (1/3600));
% 
%         currentTimeInterval = 0;
%     end
% 
%     Power_over_time(1,i) = Total_Power;
% 
% end

for i=1:length(timeAccelerating)
    RPM(1,i) = GearboxRatio * final_speed(1,i) * (60/(2*pi*TyreRadius));
    Total_Power = Total_Power - ((RPM(1,i) * powerSlope) * 1000 * timeAccelerating(1,i) * (1/3600));
    Power_over_time(1,i) = Total_Power;
end
Power_over_time = 100 * Power_over_time / Max_Power;

% subplot(2,3,6)
% hold on
% 
% plot(timeAccelerating(1,:))
% title("timeaccelerating vs Distance Through Lap")
% xlabel('Distance Through Lap (m)') 
% ylabel('timeaccelerating') 

% gearboxratio * final_speed * 1/tyreradius
% ratio * m/s * 1/m = 1/s

% for i=1:length(kinetic_energy)
%     RPM(1,i) = GearboxRatio * final_speed(1,i) * (60/(2*pi*TyreRadius));
%     % Total_Power = Total_Power - (isAccelerating(1,i) .* (RPM(1,i) * powerSlope) * 1000 * 0.105); %* (200-BatteryEff)/100);
%     Power_over_time(1,i) = Total_Power;
%     voimsus(1,i) = RPM(1,i) * powerSlope;
%     % Total_Power = Total_Power - (isAccelerating(1,i) * 3.7233 .* final_speed(1,i) * (200-BatteryEff)/100);
% 
% 
% 
% end

% Power_over_time = 100 * Power_over_time / Max_Power;

% subplot(2,3,4)
% hold on
% plot(Power_over_time(1,:))
% grid on
% xlim([1 length(track)])
% % ylim([0 100])
% title("Power Loss vs Distance Through Lap")
% xlabel('Distance Through Lap (m)') 
% ylabel('Power Remaining (%)') 
% 
% subplot(2,3,6)
% hold on
% 
% plot(RPM(1,:))
% title("RPM vs Distance Through Lap")
% xlabel('Distance Through Lap (m)') 
% ylabel('RPM') 

% subplot(2,3,5)
% plot(voimsus(1,:))
% title("Voimsus vs Distance Through Lap")
% xlabel('Distance Through Lap (m)') 
% ylabel('Voimsus [kW]') 

%% Braking Force
% AMast = (pi * Dmast^2)/4;
% APist = (Npist * pi * Dpist^2)/4;
% 
% Phi = (2 * AMast/Rpedal);
% Beta = (0.25 * (TyreRadius/(0.5 * Ddisc - 0.5 * Hpad)) * (1/MuPad) * (1/APist) );
% 
% Pedal_Force = Phi * Beta * braking_force * (1/9.81);
% Pedal_Force = Pedal_Force .* (isAccelerating == 0);
% Pedal_Force(Pedal_Force==0) = NaN;
% 
% subplot(2,3,5)
% plot(Pedal_Force(1,:))
% 
% title("Braking Force vs Distance Through Lap")
% xlim([1 length(track)])
% xlabel('Distance Through Lap (m)') 
% ylabel('Braking Force (kgF)') 

%% Steering Angle

% direction = sign(r');
% direction(1:2:end) = [];
% direction(1:2:end) = [];
% direction(1:2:end) = [];
% direction(1:2:end) = [];
% direction(1:2:end) = [];
% 
% a = (1-df)*L;
% b = -df*L;
% LeftMatrix = 2*[CF,CF+CR;CF*a,CF*a+CR*b];
% InverseLeftMatrix = inv(LeftMatrix);
% 
% 
% Steering_Angle =  InverseLeftMatrix(1,1) * Mass * (final_speed(1,:) .^2 .* track);
% Steering_Angle(1,:) = Steering_Angle(1,:) + 9.81 * Mass * InverseLeftMatrix(1,1);
% Steering_Angle(isinf(Steering_Angle)) = 0;
% Steering_Angle(1,:) = mod(Steering_Angle(1,:), pi/2) .* direction * 180/pi;
% 
% Slip_Angle =  InverseLeftMatrix(2,1) * Mass * (final_speed(1,:) .^2 .* track);
% Slip_Angle(1,:) = Slip_Angle(1,:) + 9.81 * Mass * InverseLeftMatrix(2,1);
% Slip_Angle(isinf(Slip_Angle)) = 0;
% Slip_Angle(1,:) = mod(Slip_Angle(1,:), pi/2) .* direction * 180/pi;
% 
% subplot(2,3,5)
% hold on
% yyaxis left
% plot(Steering_Angle(1,:))
% ylabel('Steering Angle (°)') 
% yyaxis right
% plot(Slip_Angle(1,:), ":")
% title("Steering Angle & Slip Angle vs Distance Through Lap")
% xlabel('Distance Through Lap (m)') 
% ylabel('Slip Angle (°)') 
% hold off
% Car size:
% 580mm
% 520mm


sum(times(1,88:100))



