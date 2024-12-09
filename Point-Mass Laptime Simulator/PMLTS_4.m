%% University of Edinburgh Formula Student
% Point-Mass Laptime Simulator
% Paul Wang, Vehicle Dynamics
% Fall 2024

%% Track attributes:

deltaX = 1;

track2 = r';
track1 = abs(1 ./ track2);


% %% Car attributes:
% % Defines maximum values
% ax = 27;
% ay = 17;

%% Work in progress: Use "ax" and "ay" variables above


filetable = readtable("Vehicle Profile for PM-LTS.xlsx");
file = table2array(filetable(:,2));

Mass = file(1);
Cdrag = file(2);
Clift = file(3);
Area = file(4);
rho = file(5);
MaxSteering = file(6);
EngTorque = file(7);
TyreD = file(8);
BrakeTorque = file(9);
Croll = file(13);
CFlong = file(14);
CFlat = file(15);
Dmux = file(16);
Dmuy = file(16);
driven_wheels = 2;

% Dmast = 
% Npist = 
% Amast = 



% total = (Mass * -9.81 * sin(trackIncl)) + (0.5 * rho * Area * Cdrag * Velocity^2) + (Croll * abs(FzTotal())) + 4*()



% 
% %Fz
% FzMASS = FzMass(Mass, trackIncl, trackBank); % Done
% FzAERO = FzAero(rho, Area, Clift, Velocity); % Done
% FzONDRIVEN = FzOnDriven(FzMASS, FzAERO); % Done
% 
% %Fx
% FxMASS = FxMass(Mass, trackIncl); % Done
% FxAERO = FxAero(rho, Area, Cdrag, Velocity); % Done
% FxROLL = FxRoll(Croll, FzTOTAL); % Done
% FxTyre_Acc = 4 * (CFlong + ) * FzDrive 
% FxTyre_Dec = (CFlat + ) * FzTOTAL
% 
% % Fy
% FyMASS = FyMass(Mass, trackBank);
% 
% % Fpedal = 
% 
% % Total
% FxTOTAL = FxMASS + min(FxTyre_Acc, FxTyre_Dec) + FxAERO + FxROLL; % = M*ax
% FyTOTAL = FyMASS + min(FyTyre_Acc, FyTyre_Dec); % = M*ay
% FzTOTAL = FzMASS + FzAERO; % = Normal Force


%% GGV
trackIncl = 0;
trackBank = 0;

vMax = 1000;
N = 45;

dv = 0.5 ;
v = (0:dv:vMax)';

if v(end)~=vMax
    v = [v;vMax];
end

GGV = zeros(length(v),2*N-1,3);

for i=1:length(v)
    % disp(FzMass(Mass, trackIncl, trackBank))
    % disp(rho)
    % disp(Area)
    % disp(Clift)
    % disp(v(i))
    % disp(FzAero(rho, Area, Clift, v(i)))
    Fz_Total_Force = ((FzMass(Mass, trackIncl, trackBank) + FzAero(rho, Area, Clift, v(i))));
    % Mass_on_driven * driven_wheels

    % aero forces
    Aero_Downforce_Z = FzAero(rho, Area, Clift, v(i));
    Aero_Drag_X = FxAero(rho, Area, Cdrag, v(i));
    % rolling resistance
    Roll_Drag = FxRoll(Croll, FzMass(Mass, trackIncl, trackBank)); % Weight force without downforce
    % normal load on driven wheels
    Mass_on_driven = FzMass(Mass, trackIncl, trackBank)/driven_wheels; % Weight force without downforce
    % drag acceleration
    ax_drag = (Aero_Drag_X + Roll_Drag + FxMass(Mass, trackIncl))/Mass ; 

    % maximum lat acc available from tyres
    ay_max = (1/Mass) * (CFlat + Dmuy*(FzMass(Mass, trackIncl, trackBank) - (Fz_Total_Force/driven_wheels))) * Fz_Total_Force/driven_wheels;

    % max long acc available from tyres
    ax_tyre_max_acc = (1/Mass) * (CFlong + Dmux*(FzMass(Mass, trackIncl, trackBank) - Fz_Total_Force/driven_wheels)) * Fz_Total_Force;




    % ax_tyre_max_acc = (1/Mass) * (CFlong + Dmux*(FzMass(Mass, trackIncl, trackBank)-Mass_on_driven/4))*Mass_on_driven; %*driven_wheels;
    % ax_tyre_max_dec = -1 * ax_tyre_max_acc;
    % 1/M*(mux+dmx*(Nx-Mass_on_driven))*Mass_on_driven*driven_wheels ;

    % max long dec available from tyres
    ax_tyre_max_dec = (-1/Mass) * (CFlong + Dmux*(FzMass(Mass, trackIncl, trackBank) - Fz_Total_Force/4)) * Fz_Total_Force;




    % ax_tyre_max_dec = (-1/Mass) * (CFlong + Dmux*(FzMass(Mass, trackIncl, trackBank) - Fz_Total_Force)) * Mass_on_driven * driven_wheels;
    % ax_tyre_max_dec = (-1/Mass) * (CFlong + Dmux*(FzMass(Mass, trackIncl, trackBank) - Fz_Total_Force/4)) * (FzMass(Mass, trackIncl, trackBank) + Aero_Downforce_Z);
    % ax_tyre_max_dec = (1/Mass) * (CFlong + Dmux*(FzMass(Mass, trackIncl, trackBank) - Aero_Downforce_Z/4)) * (FzMass(Mass, trackIncl, trackBank) - Aero_Downforce_Z)
    % -1/M*(mux+dmx*(Nx-(Wz-Aero_Downforce_Z)/4))*(Wz-Aero_Downforce_Z) ;

    % % getting power limit from engine
    % ax_power_limit = 1/M*(interp1(vehicle_speed,factor_power*fx_engine,v(i))) ;
    % ax_power_limit = 4*ones(N,1) ;

    % lat acc vector
    ay = ay_max*cosd(linspace(0,180,N))' ;
    % long acc vector
    ax_tyre_acc = ax_tyre_max_acc*sqrt(1-(ay/ay_max).^2) ; % friction ellipse
    % ax_acc = (min(ax_tyre_acc, 10) + ax_drag) ; % limiting by engine power
    ax_acc = ax_tyre_acc + ax_drag;
    ax_dec = ax_tyre_max_dec*sqrt(1-(ay/ay_max).^2) + ax_drag ; % friction ellipse
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
%
% 1 for Max Lateral (negative)
% 45 for Max Lateral (positive)
LateralIndexPositive = 45;
LateralIndexNegative = 1;
LongitudinalDecel = 67;
LongitudinalAccel = 23;

% TestV = 50
% Long = GGV(TestV*2+1, 67)
% Lat = GGV(TestV*2+1, 45, 2)



% 
% for i=1:length(v)
%     % Aero 
%     Aero_Df = FzAero(rho, Area, Clift, v(i));
%     Aero_Dr = FxAero(rho, Area, Cdrag, v(i));
% 
%     % Rolling resistance
%     Fz_Mass = FzMass(Mass, trackIncl, trackBank);
%     Fz_Aero = FzAero(rho, Area, Clift, v(i));
%     Fz_Total_Force = Fz_Aero + Fz_Mass;
% 
%     Roll_Dr = FxRoll(Croll, Fz_Total_Force);
% 
%     % Force on driven
%     Wd = FzOnDriven(Fz_Mass, Fz_Aero);
%     % drag acceleration
%     ax_drag = (Aero_Dr+Roll_Dr+FxMass(Mass, trackIncl))/Mass ;
%     % maximum lat acc available from tyres
%     ay_max = 1/Mass * (CFlat + Dmu*(Fz_Mass - (Fz_Total_Force/4))) * Fz_Total_Force;
%     % max long acc available from tyres
%     ax_tyre_max_acc = 1/Mass * Wd * (CFlong + Dmu*(Fz_Mass - Wd)) * Wd;
%     % max long acc available from tyres
%     ax_tyre_max_dec = -1/Mass * (CFlong + Dmu*(Fz_Mass - Fz_Total_Force/4)) * Fz_Total_Force;
% 
%     % % getting power limit from engine
%     % ax_power_limit = 1/M*(interp1(vehicle_speed,factor_power*fx_engine,v(i))) ;
%     % ax_power_limit = ax_power_limit*ones(N,1) ;
%     % % lat acc vector
%     ay = ay_max*cosd(linspace(0,180,N))' ;
%     % long acc vector
%     ax_tyre_acc = ax_tyre_max_acc*sqrt(1-(ay/ay_max).^2) ; % friction ellipse
%     % ax_acc = min(ax_tyre_acc,ax_power_limit)+ax_drag ; % limiting by engine power
%     ax_acc = ax_tyre_acc + ax_drag ; % limiting by engine power
%     ax_dec = ax_tyre_max_dec*sqrt(1-(ay/ay_max).^2)+ax_drag ; % friction ellipse
%     % saving GGV map
%     GGV(i,:,1) = [ax_acc',ax_dec(2:end)'] ;
%     GGV(i,:,2) = [ay',flipud(ay(2:end))'] ;
%     GGV(i,:,3) = v(i)*ones(1,2*N-1) ;
% end

% bank = 0 ;
% incl = 0 ;
% g = 9.81;
% % lateral tyre coefficients
% dmy = Dmu;
% muy = CFlat ;
% Ny = -Mass*g ;
% % longitudinal tyre coefficients
% dmx = Dmu;
% mux = CFlong ;
% Nx = Mass*g ;
% % normal load on all wheels
% Wz = Mass*g*cosd(bank)*cosd(incl) ;
% % induced weight from banking and inclination
% Wy = -Mass*g*sind(bank) ;
% Wx = Mass*g*sind(incl) ;
% driven_wheels = 4;
% 
% 
% for i=1:length(v)
%     % aero forces
%     Aero_Df = 1/2*rho*Clift*Area*v(i)^2 ;
%     Aero_Dr = 1/2*rho*Cdrag*Area*v(i)^2 ;
%     % rolling resistance
%     Roll_Dr = Croll*abs(Aero_Df+Wz) ;
%     % normal load on driven wheels
%     Wd = (Wz+(1*Aero_Df))/driven_wheels ;
%     % drag acceleration
%     ax_drag = (Aero_Dr+Roll_Dr+Wx)/Mass ;
%     % maximum lat acc available from tyres
%     ay_max = 1/Mass*(muy+dmy*(Ny-(Wz+Aero_Df)/4))*(Wz+Aero_Df) ;
%     % max long acc available from tyres
%     ax_tyre_max_acc = 1/Mass*(mux+dmx*(Nx-Wd))*Wd*driven_wheels ;
%     % max long acc available from tyres
%     ax_tyre_max_dec = -1/Mass*(mux+dmx*(Nx-(Wz+Aero_Df)/4))*(Wz+Aero_Df) ;
%     % getting power limit from engine
%     % ax_power_limit = 1/Mass*(interp1(vehicle_speed,factor_power*fx_engine,v(i))) ;
%     % ax_power_limit = ax_power_limit*ones(N,1) ;
%     % lat acc vector
%     ay = ay_max*cosd(linspace(0,180,N))' ;
%     % long acc vector
%     ax_tyre_acc = ax_tyre_max_acc*sqrt(1-(ay/ay_max).^2) ; % friction ellipse
%     ax_acc = ax_tyre_acc+ax_drag ; % limiting by engine power
%     ax_dec = ax_tyre_max_dec*sqrt(1-(ay/ay_max).^2)+ax_drag ; % friction ellipse
%     % saving GGV map
%     GGV(i,:,1) = [ax_acc',ax_dec(2:end)'] ;
%     GGV(i,:,2) = [ay',flipud(ay(2:end))'] ;
%     GGV(i,:,3) = v(i)*ones(1,2*N-1) ;
% end

% plot(GGV(:,:,1))


%% ggv map
hold on
subplot(1,2,1);
title('GGV Map')
render_size = 100;
surf(GGV(1:render_size,:,2),GGV(1:render_size,:,1),GGV(1:render_size,:,3))
% grid on
xlabel('Lat acc [m/s^2]')
ylabel('Long acc [m/s^2]')
zlabel('Speed [m/s]')
% xlim([-ay_max,ay_max])
% ylim([min(GGV(:,:,1),[],'all'),max(GGV(:,:,1),[],'all')])
view(105,15)
% set(gca,'DataAspectRatio',[1 1 0.8])
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
% Note: Potentially useless bottom row

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

        % disp(old_decel)
        % disp(old_accel)

        % disp(old_decel*2+1)
        % disp(old_accel*2+1)


        % disp(round((old_decel * 2 + 1)/accuracy)*accuracy)
        GGVdecIndex = round((old_decel * (1/dv) + 1));
        GGVaccIndex = round((old_accel * (1/dv) + 1));
        % decIndex = 250;
        % accIndex = 250;

        % disp(old_decel)

        
        %% TODO: Fix?
        axDec = abs(GGV(GGVdecIndex, LongitudinalDecel, 1));
        axAcc = abs(GGV(GGVaccIndex, LongitudinalAccel, 1));
        ay = abs(GGV(GGVaccIndex, LateralIndexPositive, 2));

        %%

        % disp("Velocity: " + old_decel + " Index: " + decIndex + " GGV: " + GGV(decIndex, LongitudinalDecel, 3))
        % disp("axDec: " + axDec + " axAcc: " + axAcc + " Ay: " + ay)

        % axDec = 5;
        % axAcc = 5;
        % ay = 5;


        % DECELERATION
        if track1(1,dec_index) == inf% || track1(1,dec_index) == 0 % During Straights
            %% TODO fix Velocity calculations

            new_dec = sqrt((deceleration_speed(1, next_index)^2) + 2 * axDec * deltaX); % "Unrestricted" deceleration
            % disp("new_dec: " + new_dec + " old dec: " + old_decel)

            if old_decel == 0 % Slowest corner condition, first time calculation
                deceleration_speed(1,dec_index) = new_dec;
                % disp("Function exe path: " + j)
            elseif new_dec < old_decel
                %% TODO: Function never called VVV
                deceleration_speed(1,dec_index) = new_dec; % Update speed if a new minimum speed is required
            else
                % disp("Function did not execute: " + j)
                % deceleration_speed(1,dec_index) = new_dec1 ;
            end 

            
        else % During Corners
            % disp(track1(1, dec_index))

            apex_decel = sqrt(ay * track1(1, dec_index)); % Maximum cornering speed given from radius and ay
            
            % disp("Apex_decel: " + apex_decel + " Old_decel: " + old_decel)

            if old_decel == 0
                deceleration_speed(1, dec_index) = min(apex_decel, sqrt((deceleration_speed(1, next_index)^2) + 2 * axDec * deltaX )); % Determine whether it is possible to acheive maximum apex speed given previous speed, or corner is flat out
            elseif apex_decel < old_decel
                %% TODO: Function never called VVV
                deceleration_speed(1, dec_index) = apex_decel; % Set maximum allowable speed for the corner
                % deceleration_speed(1, dec_index) = min(apex_decel, sqrt((deceleration_speed(1, next_index)^2) + 2 * axDec * deltaX ));
            % else
            %     deceleration_speed(1, dec_index) = min(apex_decel, sqrt((deceleration_speed(1, next_index)^2) + 2 * axDec * deltaX ));
            end

        end % Deceleration


        % ACCELERATION  
        if track1(1, acc_index) == inf %|| track1(1,dec_index) == 0 % During Straights
            new_acc = sqrt((acceleration_speed(1, previous_index)^2) + 2 * axAcc * deltaX); % "Unrestricted" acceleration

            if old_accel == 0 % Slowest corner condition, first time calculation
                acceleration_speed(1, acc_index) = new_acc;
            elseif new_acc < old_accel
                %% TODO: Function never called VVV
                acceleration_speed(1, acc_index) = new_acc; % Update speed if a new minimum speed is required
            end

        else % During Corners
            apex_accel = sqrt(ay * track1(1, acc_index)); % Maximum cornering speed given from radius and ay

            if old_accel == 0
                acceleration_speed(1, acc_index) = min(apex_accel, sqrt((acceleration_speed(1, previous_index))^2 + 2 * axAcc * deltaX )); % Determine whether it is possible to acheive maximum apex speed given previous speed, or corner is flat out
            end
            if apex_accel < old_accel
                %% TODO: Function never called VVV
                acceleration_speed(1, acc_index) = apex_accel; % Set maximum allowable speed for the corner
            end

        end % Acceleration

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