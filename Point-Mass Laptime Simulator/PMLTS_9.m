nr = numel(r);
scale_factor = 1000/nr;
scaledX = X.*scale_factor;
scaledY = Y.*scale_factor;
scaledZ = Z.*scale_factor;
sanity_check = sqrt(diff(scaledX(:)).^2 + diff(scaledY(:)).^2 + diff(scaledZ(:)).^2);
l_new = sum(sanity_check);
r_new = r.*(1/scale_factor);
track = 1 ./ r_new;
track = track.';
track = abs(track);
small_apex = r_new(apex);
apexX = scaledX(apex);
apexY = scaledY(apex);
apexZ = scaledZ(apex);
deltaX = 1 * scale_factor;

%% University of Edinburgh Formula Student
% Point-Mass Laptime Simulator
% Paul Wang, Vehicle Dynamics
% Fall 2024

%% Overall attributes:
clear
deltaX = 1;

%% Car Attributes
% Reads the file, sets variables
filetable = readtable("Vehicle Profile for PM-LTS.xlsx"); 
file = table2array(filetable(:,2));

% Read vehicle profile (column 2 = values)
%filetable = readtable("Vehicle_Parameters_and_Pickup_Points.xlsx");
%file = table2array(filetable(:,2));

% Parameters
%Front_Motion_Ratio = file(3); % Spring motion / wheel centre motion (-)
%Rear_Motion_Ratio = file(4); % Spring motion / wheel centre motion (-)
% Track_Width = file(5); % Track width (m)
% Wheelbase = file(6); % Wheelbase (m)
% Sprung_Mass = file(8); % Sprung mass (kg)
% Front_Unsprung_Mass = file(9); % Front unsprung mass (axle total) (kg)
% Rear_Unsprung_Mass = file(10); % Rear unsprung mass (axle total) (kg)
% Centre_of_Gravity_X = file(11); % Vehicle CG, X (m)
% Centre_of_Gravity_Y = file(12); % Vehicle CG, Y (m)
% Centre_of_Gravity_Z = file(13); % Vehicle CG, Z (m)
% Sprung_Mass_Centre_X = file(14); % Sprung mass centre, X (m)
% Sprung_Mass_Centre_Y = file(15); % Sprung mass centre, Y (m)
% Sprung_Mass_Centre_Z = file(16); % Sprung mass centre, Z (m)
% Front_Unsprung_Mass_Centre_X = file(17); % Front unsprung mass centre, X (m)
% Front_Unsprung_Mass_Centre_Y = file(18); % Front unsprung mass centre, Y (m)
% Front_Unsprung_Mass_Centre_Z = file(19); % Front unsprung mass centre, Z (m)
% Rear_Unsprung_Mass_Centre_X = file(20); % Rear unsprung mass centre, X (m)
% Rear_Unsprung_Mass_Centre_Y = file(21); % Rear unsprung mass centre, Y (m)
% Rear_Unsprung_Mass_Centre_Z = file(22); % Rear unsprung mass centre, Z (m)
% Tyre_Rate = file(23); % Vertical tyre stiffness (N/m)
% Front_Spring_Stiffness = file(24); % Front spring rate (N/m)
% Rear_Spring_Stiffness = file(25); % Rear spring rate (N/m)
% Tyre_Pressure = file(26); % Tyre pressure (psi)
% 
% % Suspension pickup points [x y z], mm -> m
% FRONT_INTOPLEFTFRONT = file(27:29)' / 1000;
% FRONT_INTOPLEFTAFT = file(30:32)' / 1000;
% FRONT_INBOTLEFTFRONT = file(33:35)' / 1000;
% FRONT_INBOTLEFTAFT = file(36:38)' / 1000;
% FRONT_INTOPRIGHTFRONT = file(39:41)' / 1000;
% FRONT_INTOPRIGHTAFT = file(42:44)' / 1000;
% FRONT_INBOTRIGHTFRONT = file(45:47)' / 1000;
% FRONT_INBOTRIGHTAFT = file(48:50)' / 1000;
% FRONT_OUTTOPLEFT = file(51:53)' / 1000;
% FRONT_OUTBOTLEFT = file(54:56)' / 1000;
% FRONT_OUTTOPRIGHT = file(57:59)' / 1000;
% FRONT_OUTBOTRIGHT = file(60:62)' / 1000;
% FRONT_LEFTCONTACTPATCH = file(63:65)' / 1000;
% FRONT_RIGHTCONTACTPATCH = file(66:68)' / 1000;
% REAR_INTOPLEFTFRONT = file(69:71)' / 1000;
% REAR_INTOPLEFTAFT = file(72:74)' / 1000;
% REAR_INBOTLEFTFRONT = file(75:77)' / 1000;
% REAR_INBOTLEFTAFT = file(78:80)' / 1000;
% REAR_INTOPRIGHTFRONT = file(81:83)' / 1000;
% REAR_INTOPRIGHTAFT = file(84:86)' / 1000;
% REAR_INBOTRIGHTFRONT = file(87:89)' / 1000;
% REAR_INBOTRIGHTAFT = file(90:92)' / 1000;
% REAR_OUTTOPLEFT = file(93:95)' / 1000;
% REAR_OUTBOTLEFT = file(96:98)' / 1000;
% REAR_OUTTOPRIGHT = file(99:101)' / 1000;
% REAR_OUTBOTRIGHT = file(102:104)' / 1000;
% REAR_LEFTCONTACTPATCH = file(105:107)' / 1000;
% REAR_RIGHTCONTACTPATCH = file(108:110)' / 1000;

% Necessary
Mass = file(1); % Mass (kg)
C_Drag = file(2); % Drag Coefficient (Coefficient)
C_Lift = file(3); % Downforce Coefficient (Coefficient)
Area = file(4); % Aero Surfaces Area (m^2)
Rho = file(5); % Air Density (kg/m^3)
C_Roll = file(16); % Rolling Resistence Coefficient (Coefficient)
CF_Long = file(17); % Longitudinal Friction From Tyres (Coefficient)
CF_Lat = file(18); % Lateral Friction From Tyres (Coefficient)
D_mux = file(19); % Rate Of Lateral Friction Lost From Normal Force (Coefficient)
D_muy = file(19); % Rate Of Longitudinal Friction Lost From Normal Force (Coefficient)
Gearbox_Ratio = file(27); % Motor Gearbox Ratio (Ratio)
Factor_Drive = file(28); % Factor Drive (Set To 1)
Factor_Aero = file(29); % Factor Aero (Set To 1)
Driven_Wheels = file(30); % Wheels Driven (Number Of)
Braking_Wheels = file(31); % Wheels Braking (Number Of)
Engine_Torque = file(7); % Maximum Engine Torque (nm)
Tyre_Radius = file(8); % Wheel Diameter (Inches)

% Braking Force
Disc_Diameter = file(9); % Brake Disc Outer Diameter (m)
Disc_Pad_Height = file(10); % Brake Pad Height (m)
Disc_Pad_Mu = file(11); % Brake Pad Friction (Coefficient)
Number_Pistons = file(12); % Number of Caliper Pistons
Diameter_Pistons = file(13); % Caliper Piston Diamter (m)
Diameter_Mast = file(14); % Master Braking Cylinder Diameter
Pedal_Ratio = file(15); % Pedal Length/Activation Ratio (m)

% Energy Draw & Battery Drain
Power_Slope = file(20); % Amount of Power Draw From Motor For a given RPM, Only Applicable to EVs (kW/rpm)
Peak_Power = file(21);
Rev_Limit = file(22);
Battery_Capacity = file(25); % Total Battery Capacity (Wh)
Battery_Efficency = file(26); % Battery Efficency (%)

% Calculations
Tyre_Radius = Tyre_Radius/(39.37*2); % Converts Tyre Diameter to Radius
%PowerLimitAcc = Gearbox_Ratio * Engine_Torque / (Mass * Tyre_Radius); % Calculates The Maximum Acceleration Available From Motor And Given Wheel Size

% EMRAX 228 CC – peak torque (red dotted), digitised from datasheet
rpm_pts = [0     1000  2000  3000  3500  4000  4200  4400  4600  4800  5000  5200  5400  5500];
T_peak  = [230.3 230.3 230.3 230.0 229.2 228.8 228.4 227.9 226.4 224.0 221.6 218.5 216.0 214.7];

Rev_Limit = rpm_pts(end);

%% GGV Calculations
Track_Incl = 0; % Track Inclination
Track_Bank = 0; % Track Bank, can be used as an array with array indexing
vMax = 50; % Maximum velocity, needs to exceed vehicle top speed in order to account for braking
N = 45; % Resolution of GGV plot length and width-wise
dv = 0.5; % Resolution of the GGV plot heightwise
v = (0:dv:vMax)';

if v(end)~=vMax % Defines the array
    v = [v;vMax];
end

GGV = zeros(length(v),2*N-1,3); % Defines the GGV matrix

% GGV Looping Per Velocity
for i=1:length(v)
    Aero_Downforce = (0.5 * Rho * Area * C_Lift * v(i)^2); % Aero Downforce (Total Force) (Affected by Velocity)
    Aero_Drag = (0.5 * Rho * Area * C_Drag * v(i)^2); % Aero Drag (Total Forces) (Affected by Velocity)
    Roll_Drag = C_Roll * abs(-1*(-1* Mass * 9.81 * cosd(Track_Incl) * cosd(Track_Bank)) - Aero_Downforce); % Rolling Drag (Total Force) (Affected by Velocity)
    WeightOnDriven = (Factor_Drive * -1*((-1* Mass * 9.81 * cosd(Track_Incl) * cosd(Track_Bank))) +  (-Factor_Aero*Aero_Downforce)) / Driven_Wheels; % Normal Forces On Driven Wheels (Affected by Velocity)
    ax_drag = (Aero_Drag + Roll_Drag + (Mass * 9.81 * sin(Track_Incl)))/Mass; % Total Drag Forces, in Acceleration form
    ay_max = (1/Mass) * (CF_Lat + D_muy*((Mass*9.81/Braking_Wheels)  -  (-1 * (-1* Mass * 9.81 * cosd(Track_Incl) * cosd(Track_Bank))   -  Aero_Downforce)/Braking_Wheels)) * (-1 * (-1* Mass * 9.81 * cosd(Track_Incl) * cosd(Track_Bank))   -  Aero_Downforce); % Maximum Lateral Acceleration Available From Tyres
    ax_tyre_max_acc = (1/Mass) * (CF_Long + D_mux*( (Mass*9.81/Braking_Wheels) - WeightOnDriven)) * WeightOnDriven * Driven_Wheels; % Maximum Longitudinal Acceleration Available From Tyres
    ax_tyre_max_dec = (-1/Mass) * (CF_Long + D_mux*( (Mass*9.81/Braking_Wheels) - (-1 * (-1* Mass * 9.81 * cosd(Track_Incl) * cosd(Track_Bank)) - Aero_Downforce)/Braking_Wheels)) * (-1 * (-1* Mass * 9.81 * cosd(Track_Incl) * cosd(Track_Bank)) - Aero_Downforce); % Maximum Longitudinal Deceleration Available From Tyres


% Compute maximum acceleration available from motor at a given velocity

wheel_rpm = ((v(i)/Tyre_Radius)*60)/(2*pi);
motor_rpm = wheel_rpm*Gearbox_Ratio;

if motor_rpm > Rev_Limit
    motor_Torque = 0;
else 
    motor_Torque = min(interp1(rpm_pts,T_peak,motor_rpm),(Peak_Power*1000/max(motor_rpm*2*pi/60,1)));
end
    PowerLimitAcc = (motor_Torque*Gearbox_Ratio)/(Tyre_Radius*Mass);

    ay = ay_max*cosd(linspace(0,180,N))' ; % Creates The Array For Lateral Acceleration
    ax_tyre_acc = ax_tyre_max_acc*sqrt(1-(ay/ay_max).^2) ; % Friction Ellipse For Longitudinal Acceleration

    ax_acc = min(ax_tyre_acc,PowerLimitAcc)+ax_drag ; % Engine Power Limitations
    ax_dec = ax_tyre_max_dec*sqrt(1-(ay/ay_max).^2)+ax_drag ; % Friction Ellipse For Longitudinal Deceleration

    % GGV 3D Matrix
    GGV(i,:,1) = [ax_acc',ax_dec(2:end)'];
    GGV(i,:,2) = [ay',flipud(ay(2:end))'];
    GGV(i,:,3) = v(i)*ones(1,2*N-1);
end

% GGV Indexing
LateralIndexPositive = 1; % -70.06 Y, minimum Long Acceleration, Column 67, Layer 1
LateralIndexNegative = round(N); % 11.64 Y, maximum Long Acceleration, Column 23, Layer 1
LongitudinalDecel = round(3/2 * N); % -78.95 X, minimum Lat Acceleration, Column 45, Layer 2
LongitudinalAccel = round(2/3 * N); % 78.95 X, maximum Lat Acceleration, Column 1, Layer 2


% _______________________________GGV Plot__________________________________
hold on
subplot(2,3,1);
render_size = 60; % Sets the visible size of the GGV plot, does not affect laptimes or GGV calculation
surf(GGV(1:render_size,:,2),GGV(1:render_size,:,1),GGV(1:render_size,:,3))
grid on
xlabel('Lat acc [m/s^2]')
ylabel('Long acc [m/s^2]')
zlabel('Speed [m/s]')
view(105,15)
set(gca,'DataAspectRatio',[1 1 1])
title('GGV Plot')
cbar = colorbar ;
set(get(cbar,'Title'),'String','Speed [m/s]')
% _________________________________________________________________________


% -------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% Competition Simulator %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% -------------------------------------------------------------------------

events = {"Endurance", "Acceleration", "Skidpad"}; % Defines the list of events
eventTimes = zeros(1, length(events));
eventScores = zeros(1, length(events));
eventFastest = zeros(1, length(events));

%% Competition Simulator
% Cycles the simulation 3 times for each FSUK event
for eventNumber=1:length(events)
    
    if eventNumber == 1 % Edurance
        filename = "Tracks\Mini_Spa_Francorchamps.mat";
    elseif eventNumber == 2 % 100m Acceleration
        filename = "Tracks\100m Acceleration.mat";
    elseif eventNumber == 3 % Skidpad
        filename = "Tracks\FSUK Skidpad.mat";
        % filename = "Tracks\Mini_Donington_Park.mat";
    end

    load(filename, "track")

    if eventNumber == 1; EnduranceLength = length(track); end % Only used in graph axis sizing


    % Identifies all corners on the track, sorts them into ascending order, and trunkates the matrix.
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
            % Code for looping the track indexes
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

            top_speed = 100; % Practical top speed setting


            
           GGVdecIndex = min(GGVdecIndex, length(v));
GGVaccIndex = min(GGVaccIndex, length(v));
axDec = abs(GGV(GGVdecIndex, LongitudinalDecel, 1));
ayDec = abs(GGV(GGVdecIndex, LateralIndexPositive, 2));
axAcc = abs(GGV(GGVaccIndex, LongitudinalAccel, 1));
ayAcc = abs(GGV(GGVaccIndex, LateralIndexPositive, 2));
            GGVaccIndex = min(GGVaccIndex, size(GGV,1)); 
            axAcc = GGV(GGVaccIndex, LongitudinalAccel, 1);
            ayAcc = abs(GGV(GGVaccIndex, LateralIndexPositive, 2));
            braking_force(1, dec_index) = axDec * Mass; % Holds the braking forces to be used later 

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
            if track(1,acc_index) == inf || track(1,acc_index) == 0 % During Straights
                new_acc = sqrt(max(acceleration_speed(1, previous_index)^2 + 2*axAcc*deltaX, 0));

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

    %% Final Time Calculations:
    isAccelerating = zeros(1, length(acceleration_speed));
    for i=1:length(acceleration_speed)
        if acceleration_speed(1,i) <= deceleration_speed(1,i)
            isAccelerating(1,i) = 1; % An array of 0 or 1 values, if the car is accelerating or not
        end
    end

    final_speed = min(acceleration_speed,deceleration_speed); % Takes the slowest speed required for each given track segment
    times = deltaX ./ final_speed; % Assumes constant track mesh spacing
    times(:,1) = []; % stores precise time values in a Matrix

    total_time = sum(times, 2);
    Skipad_time = sum(times(1,1:58), 2); % Measures the exact skidpad time
    total_time(2,:) = [];

    %% Event Calculations
    % Times
    if eventNumber == 3 
        eventTimes(eventNumber) = Skipad_time; % Specifically sets time for skidpad event
    else
        eventTimes(eventNumber) = total_time; % Sets the array index to the time of each event
    end


    % Points
    if eventNumber == 1 %% ENDURANCE
        FastestTimeEndurance = 54.857; % Edith Cowan, 2024
        eventFastest(eventNumber) = FastestTimeEndurance;
        eventTimes(eventNumber) = total_time;
        EndureScore = 95*( ((FastestTimeEndurance * 1.45 / total_time)-1)/((FastestTimeEndurance * 1.45 / FastestTimeEndurance)-1)); % Uses the FSUK 2023 rules, however, the equation is not correct, and requires tweaking.
        eventScores(eventNumber) = EndureScore; % Sets the array index to the points of each event
    elseif eventNumber == 2 %% ACCELERATION
        FastestTimeAcceleration = 4.364; % Basque, 2024
        eventFastest(eventNumber) = FastestTimeAcceleration;
        if total_time <= FastestTimeAcceleration
            AccelScore = 70;
        else
            AccelScore = 70*( ((FastestTimeAcceleration * 1.5 / total_time)-1)/((FastestTimeAcceleration * 1.5 / FastestTimeAcceleration)-1)); % Uses the FSUK 2023 rules, however, the equation is not correct, and requires tweaking.
        end
        eventScores(eventNumber) = AccelScore; % Sets the array index to the points of each event
    elseif eventNumber == 3 %% SKIDPAD
        FastestTimeSkidpad = 5.243; % Coventry, 2024
        eventFastest(eventNumber) = FastestTimeSkidpad;
        if Skipad_time <= FastestTimeSkidpad
            SkidpadScore = 75;
        else
            SkidpadScore = 75*((((FastestTimeSkidpad * 1.25)/Skipad_time)^2 - 1)/0.5625); % Uses the FSUK 2025 rules, however, the equation is not correct, and requires tweaking.
        end
        eventScores(eventNumber) = SkidpadScore; % Sets the array index to the points of each event
    end

    % Velocity 
    % _____________________________________________________________________
    subplot(2,3,2)
    hold on
    plot(final_speed(1,:))
    title("Velocity vs Distance Through Lap")
    xlabel('Distance Through Lap (m)')
    xlim([1 EnduranceLength])
    ylabel('Forward Velocity (m/s)')
    % _____________________________________________________________________


    %% Power Loss
    kinetic_energy = 0.5 * Mass * final_speed .^ 2; % An array that holds the kinetic energy of the car at each point on the track
    Total_Energy = Battery_Capacity; % Does not account for any reserve power wanted
    Max_Energy = Total_Energy; % Holds the first value, aka the max energy of the battery
    voimsus = zeros(1, length(kinetic_energy)); % Holds the energy used at each point on the track, in kW
    timeAccelerating = isAccelerating(1:length(times)) .* times(1,:); % Holds the time spent accelerating for each point on the track, holds 0 if the car is not accelerating
    RPM = zeros(1, length(timeAccelerating)); % RPM of the car at every point on the track
    Energy_over_time = zeros(1, length(timeAccelerating)); % Holds the energy in the battery at each point on the track
    Energy_draw_during_lap = zeros(1, length(timeAccelerating)); % Holds the energy draw at each point on the track, in kW

    for i=1:length(timeAccelerating)
        RPM(1,i) = Gearbox_Ratio * final_speed(1,i) * (60/(2*pi*Tyre_Radius)); % Gearbox Ratio * Speed * Linear Speed to RPM Conversion
        Energy_draw_during_lap(1,i) = ((RPM(1,i) * Power_Slope) * 1000  * (1/3600)); % RPM * Power_slope * kW to Wh Conversion
        Total_Energy = Total_Energy - ((RPM(1,i) * Power_Slope) * 1000 * timeAccelerating(1,i) * (1/3600)); % Subtracts from total time and multiplies by time in order to get energy
        Energy_over_time(1,i) = Total_Energy; % Holds the energy of the battery at every point on the track
        voimsus(1,i) = RPM(1,i) * Power_Slope; % Holds the power usage at every point on the track
    end
    Energy_over_time = 100 * Energy_over_time / Max_Energy; % Converts to percentage of original battery

    % Energy Draw
    % _____________________________________________________________________
    subplot(2,3,4)
    hold on
    plot(Energy_draw_during_lap(1,:))
    title("Energy Draw vs Distance Through Lap")
    xlabel('Distance Through Lap (m)')
    ylabel('Energy Draw (kW)')
    xlim([1 EnduranceLength])
    % _____________________________________________________________________

    % Total Energy
    % _____________________________________________________________________
    subplot(2,3,5)
    hold on
    plot(Energy_over_time(1,:))
    grid on
    xlim([1 EnduranceLength])
    % ylim([0 100]) % Use if you want total battery usage for the y axis
    title("Battery Drain vs Distance Through Lap")
    xlabel('Distance Through Lap (m)')
    ylabel('Energy Remaining (%)')
    % _____________________________________________________________________

    %% Braking Force
    % https://youtu.be/L3BDwC9Wn9A?t=427 for equation help
    AMast = (pi * Diameter_Mast^2)/4;
    APist = (Number_Pistons * pi * Diameter_Pistons^2)/4;

    Phi = (2 * AMast/Pedal_Ratio);
    Beta = (0.25 * (Tyre_Radius/(0.5 * Disc_Diameter - 0.5 * Disc_Pad_Height)) * (1/Disc_Pad_Mu) * (1/APist) );

    Pedal_Force = Phi * Beta * braking_force * (1/9.81);
    Pedal_Force = Pedal_Force .* (isAccelerating == 0);
    Pedal_Force(Pedal_Force==0) = NaN;

    % Braking Force
    % _____________________________________________________________________
    subplot(2,3,6)
    hold on
    plot(Pedal_Force(1,:))
    title("Braking Force vs Distance Through Lap")
    xlim([1 EnduranceLength])
    xlabel('Distance Through Lap (m)')
    ylabel('Braking Force (kgF)')
    % _____________________________________________________________________

end










% -------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% -------------------------------------------------------------------------

% Configures the table with times and points 
df = figure(1);
cnames = {'Time (s)','Points', 'Fastest Time'};
rnames = {'Edurance','Acceleration','Skidpad'};
eventsData = zeros(2,length(events));
eventsData(3,:) = eventFastest;
eventsData(2,:) = eventScores;
eventsData(1,:) = eventTimes;

eventsData = eventsData';

t = uitable(df,'Data',eventsData,...
    'ColumnName',cnames,...
    'RowName',events,...
    'ColumnWidth',{90});

% Event Score
% _________________________________________________________________________
subplot(2,3,3),plot(1)
pos = get(subplot(2,3,3),'position');
delete(subplot(2,3,3))
set(t,'units','normalized')
set(t,'position',pos)

subplot(2,3,2)
legend(events,'Location','northeast')
subplot(2,3,4)
legend(events,'Location','northeast')
subplot(2,3,5)
legend(events,'Location','northeast')
subplot(2,3,6)
legend(events,'Location','northeast')
% _________________________________________________________________________

