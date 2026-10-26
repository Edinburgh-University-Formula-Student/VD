%%%%%%%%% Tyre Force Calculator and Yaw Moment Generator Program %%%%%%%%%%
%%%%%% To be integrated with laptime simulator for evaluating handing %%%%%
%%%%%%% performance and conrol
% July 2026
% Ubaida Friekh, VD

%%% This program makes use of ISO 8855 coordinate axis convention, which
%%% defines the following:
% X forward positive
% Y left positive
% Z up positive
% Inclination angle positive for the top of the wheel leaning to the right
% Slip angle right turn positive (velocity vector left of heading)
% Steer angle left turn positive (counterclockwise steer)
% Roll, pitch and yaw follow the right hand rule --> Pitch & Yaw CCW
% positive, Roll CW positive

g = 9.81; % m/s^2

% Parameter Definitions
Front_Lift_Coefficient = 1.5;
Rear_Lift_Coefficient = 1.8;
%%% Lift Coefficients depend on body slip angle and may be changed to
%%% account for this

% Front and rear motion ratios are functions of wheel travel but are taken
% as constants here. Defined as the ratio of spring motion to wheel centre
% motion.
Front_Motion_Ratio = 0.7;
Rear_Motion_Ratio = 0.7;

% Vehicle Dimensions
Track_Width = 1.00; %m
Wheelbase = 1.54; %m
Vehicle_Frontal_Area = 1.2; % m^2 - placeholder

% Mass Centre Coordinates and weights
Sprung_Mass = 240.465; %kg
Front_Unsprung_Mass = 20.335; %kg
Rear_Unsprung_Mass = 19.76; %kg
Vehicle_Mass = Sprung_Mass + Front_Unsprung_Mass + Rear_Unsprung_Mass; %kg

Centre_of_Gravity = [-0.811 0.500 0.280]; %m [0.811 0.500 0.280] Standard
Sprung_Mass_Centre = [-0.7985 0.50183 0.2732]; %m
Front_Unsprung_Mass_Centre = [-0.00047121 0.500 0.2656]; %m
Rear_Unsprung_Mass_Centre = [-1.5588 0.500 0.2908]; %m

Vehicle_Weight = Vehicle_Mass*9.81; %N
Sprung_Weight = Sprung_Mass*9.81; %N
Front_Unsprung_Weight = Front_Unsprung_Mass*9.81; %N
Rear_Unsprung_Weight = Rear_Unsprung_Mass*9.81; %N

%%% Suspension Stiffnesses
Tyre_Rate = 200000; %N/m Acquired from MFEVAL Magic Formula function for the tyre used in this simulation and kept constant
Front_Spring_Stiffness = 70000; %NM ROBERTO VALUE
Rear_Spring_Stiffness = 30000; %NM ROBERTO VALUE

%%% Test limits
Operating_Velocities = linspace(15,15,1); % m/s
deltas = linspace(-20,20,41); %deg
betas = linspace(-8,8,33); %deg
Longitudinal_Accelerations = (0); %m/s^2

addpath('C:\FS\EUFS Internship\MATLAB Programs\Yaw_Moment_Diagram_Program\EUFS_Tyre_Force_Calculator_Simulation\MFeval\MFeval');

%%% Tire Specific Parameters
tire = mfeval.readTIR('C:\FS\EUFS Internship\MATLAB Programs\Yaw_Moment_Diagram_Program\Edinburgh-University-Formula-Student VD main Tyre Simulation\Tire Models\16x7.5-10-7.tir');
Pressure = 10; %psi
Pressure = Pressure * 6894.76; % Pa - conversion factor

Number_of_Rows = numel(Operating_Velocities) * numel(deltas) * numel(betas) * numel(Longitudinal_Accelerations);
results = zeros(Number_of_Rows,10); %%% Results in the form [V Delta Beta Ay Ax N FL FR RL RR]

max_Iteration = 10000;
row = 0;

initial_Guess = 0.2;
tol = 0.001;
relax = 0.1;

%%% Suspension geometry for each state is defined based on pre-populated
%%% lookup table which relates each lateral+longitudinal acceleration
%%% combination to roll and pitch angles based on roll and pitch stiffness

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Obtain Result Matrix for Yaw Moment Diagram %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for iv = 1:numel(Operating_Velocities) % Sweep across all operational velocities
    Velocity = Operating_Velocities(iv);

    for iax = 1:numel(Longitudinal_Accelerations)
        Longitudinal_Acceleration = Longitudinal_Accelerations(iax);

        for id = 1:numel(deltas) % Sweep across all operating steering angles
            delta = deltas(id)*pi/180; % Convert steer angle in sweep to radians

            for ib = 1:numel(betas) % Sweep across all physical body slip angles
                beta = betas(ib)*pi/180; % Convert sideslip angle in sweep to radians

                Lateral_Acceleration = initial_Guess;
                row = row + 1

                for k = 1:max_Iteration
                    %%% We are currently on a given Lateral Acceleration
                    %%% guess, the first thing I will do is find the id
                    %%% within the struct array that corresponds to the
                    %%% geometry closest to our chosen acceleration guess
                    [min_diff , idx] = min(abs([states.Ay]-Lateral_Acceleration)); % Gives idx, the position in the struct array corresponding to the closest Ay to the guess
                    coords = states(idx).pickups; % Assigns A-arm pickup coordinates to array coords for roll centre computation
                    Contact_Patches = states(idx).contact_patches;

                    Front_Left_Contact_Patch = Contact_Patches(1,:);
                    Front_Right_Contact_Patch = Contact_Patches(2,:);
                    Rear_Left_Contact_Patch = Contact_Patches(3,:);
                    Rear_Right_Contact_Patch = Contact_Patches(4,:);

                    %%% Linear interpolation to find true geometry corresponding to acceleration guess

                    Roll_Angle = interp1([states.Ay],[states.roll],Lateral_Acceleration) *pi/180; %%% Acquire roll angle through interpolation to obtain inclination angle

                    FL_camber = interp1([states.Ay],[states.FL_camber],Lateral_Acceleration) * pi/180;
                    FR_camber = interp1([states.Ay],[states.FR_camber],Lateral_Acceleration) * pi/180;
                    RL_camber = interp1([states.Ay],[states.RL_camber],Lateral_Acceleration) * pi/180;
                    RR_camber = interp1([states.Ay],[states.RR_camber],Lateral_Acceleration) * pi/180;

                    FL_Toe = interp1([states.Ay],[states.FL_toe],Lateral_Acceleration) * pi/180;
                    FR_Toe = interp1([states.Ay],[states.FR_toe],Lateral_Acceleration) * pi/180;
                    RL_Toe = interp1([states.Ay],[states.RL_toe],Lateral_Acceleration) * pi/180;
                    RR_Toe = interp1([states.Ay],[states.RR_toe],Lateral_Acceleration) * pi/180;

                    Front_Roll_Centre_Height = interp1([states.Ay],[states.F_Roll_Centres],Lateral_Acceleration);
                    Rear_Roll_Centre_Height = interp1([states.Ay],[states.R_Roll_Centres],Lateral_Acceleration);

                    Sprung_Centre_Perpendicular_NRA = define_Roll_Axis_Distance(Front_Roll_Centre_Height, ...
                        Rear_Roll_Centre_Height,Sprung_Mass_Centre(1),Sprung_Mass_Centre(3),Wheelbase);

                    Front_Roll_Rate = (Front_Spring_Stiffness*Front_Motion_Ratio^2*Track_Width^2*Tyre_Rate)/(2*(Front_Spring_Stiffness*Front_Motion_Ratio^2+Tyre_Rate)); %Nm/rad
                    Rear_Roll_Rate  = (Rear_Spring_Stiffness*Rear_Motion_Ratio^2*Track_Width^2*Tyre_Rate)/(2*(Rear_Spring_Stiffness*Rear_Motion_Ratio^2+Tyre_Rate)); %Nm/rad

                    Vertical_Wheel_Loads = Compute_Vertical_Wheel_Loads_Aero(Velocity,Vehicle_Weight,Centre_of_Gravity, Wheelbase, Track_Width, ...
                        Lateral_Acceleration, Longitudinal_Acceleration, Sprung_Weight, Sprung_Mass_Centre, ...
                        Front_Unsprung_Weight,Rear_Unsprung_Weight,Front_Unsprung_Mass_Centre,Rear_Unsprung_Mass_Centre,...
                        Front_Roll_Centre_Height, Rear_Roll_Centre_Height, Sprung_Centre_Perpendicular_NRA, ...
                        Front_Roll_Rate, Rear_Roll_Rate, Front_Lift_Coefficient, Rear_Lift_Coefficient,Vehicle_Frontal_Area);

                    for i = 1:numel(Vertical_Wheel_Loads)
                        if Vertical_Wheel_Loads(i) < 0;
                            Vertical_Wheel_Loads(i) = 0; %N - correction for unphysical lifting of inside wheels at the extremes
                        end
                    end

                    disp(Vertical_Wheel_Loads)

                    Yaw_Rate = Lateral_Acceleration*g/Velocity;

                    %%% Slip angle calculation assumes toe is clockwise
                    %%% positive, if toe is defined according to FSAE
                    %%% convention of inwards positive, different
                    %%% adjustments will need to be made per-wheel
                    FL_Slip_Angle = beta + Centre_of_Gravity(1)*Yaw_Rate/Velocity - delta - FL_Toe;
                    FR_Slip_Angle = beta + Centre_of_Gravity(1)*Yaw_Rate/Velocity - delta - FR_Toe;
                    RL_Slip_Angle = beta - (Wheelbase-Centre_of_Gravity(1))*Yaw_Rate/Velocity - RL_Toe;
                    RR_Slip_Angle = beta - (Wheelbase-Centre_of_Gravity(1))*Yaw_Rate/Velocity - RR_Toe;

                    Slip_Angles_deg = [FL_Slip_Angle FR_Slip_Angle RL_Slip_Angle RR_Slip_Angle]*180/pi;

                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %%% Inclination angle calculation from camber angles %%%
                    FL_Inclination_Angle = Roll_Angle - FL_camber;
                    FR_Inclination_Angle = FR_camber + Roll_Angle;
                    RL_Inclination_Angle = Roll_Angle - RL_camber;
                    RR_Inclination_Angle = RR_camber + Roll_Angle;
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                    %%% Store Magic Formula parameters as 1x4 vectors
                    %%% (corresponding to four wheel loads)
                    Slip_Ratios = zeros(4,1); % Longitudinal Slip Ratios
                    Slip_Angles = [FL_Slip_Angle ; FR_Slip_Angle ; RL_Slip_Angle ; RR_Slip_Angle]; % Slip angles
                    Inclination_Angles = [FL_Inclination_Angle ; FR_Inclination_Angle ; RL_Inclination_Angle ; RR_Inclination_Angle]; % Inclination Angles
                    phit = ((Lateral_Acceleration*g)/(Velocity^2))*ones(4,1); % Turn slips, taken as 0 (i.e. infinite turn radius) as an initial approximation
                    Vx = Velocity.*ones(4,1); % Longitudinal Velocity, taken as equal for all wheels
                    P = Pressure.*ones(4,1); % Pressure in Pascals

                    %%% Call Magic Formula Function for four tyre loads
                    out = mfeval(tire,[Vertical_Wheel_Loads,Slip_Ratios,Slip_Angles,Inclination_Angles,phit,Vx,P],111);

                    %%% Store longitudinal and lateral forces
                    Longitudinal_Wheel_Forces = out(:,1);
                    Lateral_Wheel_Forces = out(:,2);

                    FL_Lateral_Force = Lateral_Wheel_Forces(1);  FR_Lateral_Force = Lateral_Wheel_Forces(2);
                    RL_Lateral_Force = Lateral_Wheel_Forces(3);  RR_Lateral_Force = Lateral_Wheel_Forces(4);

                    Total_Lateral_Force = (FL_Lateral_Force + FR_Lateral_Force) * cos(delta) + RL_Lateral_Force + RR_Lateral_Force;
                    Ay_New = Total_Lateral_Force/(Vehicle_Mass*g);

                    if isnan(Ay_New)
                        disp('Ay is not a number')
                        break
                    end

                    if abs(Ay_New-Lateral_Acceleration) < tol
                        Lateral_Acceleration = Ay_New;
                        [min_diff , idx] = min(abs([states.Ay]-Lateral_Acceleration)); % Gives idx, the position in the struct array corresponding to the closest Ay to the guess
                        coords = states(idx).pickups; % Assigns A-arm pickup coordinates to array coords for roll centre computation
                        Contact_Patches = states(idx).contact_patches;

                        Front_Left_Contact_Patch = Contact_Patches(1,:);
                        Front_Right_Contact_Patch = Contact_Patches(2,:);
                        Rear_Left_Contact_Patch = Contact_Patches(3,:);
                        Rear_Right_Contact_Patch = Contact_Patches(4,:);

                        Roll_Angle = interp1([states.Ay],[states.roll],Lateral_Acceleration) *pi/180; %%% Acquire roll angle through interpolation to obtain inclination angle

                        FL_camber = interp1([states.Ay],[states.FL_camber],Lateral_Acceleration) * pi/180;
                        FR_camber = interp1([states.Ay],[states.FR_camber],Lateral_Acceleration) * pi/180;
                        RL_camber = interp1([states.Ay],[states.RL_camber],Lateral_Acceleration) * pi/180;
                        RR_camber = interp1([states.Ay],[states.RR_camber],Lateral_Acceleration) * pi/180;

                        FL_Toe = interp1([states.Ay],[states.FL_toe],Lateral_Acceleration) * pi/180;
                        FR_Toe = interp1([states.Ay],[states.FR_toe],Lateral_Acceleration) * pi/180;
                        RL_Toe = interp1([states.Ay],[states.RL_toe],Lateral_Acceleration) * pi/180;
                        RR_Toe = interp1([states.Ay],[states.RR_toe],Lateral_Acceleration) * pi/180;

                        Front_Roll_Centre_Height = interp1([states.Ay],[states.F_Roll_Centres],Lateral_Acceleration);
                        Rear_Roll_Centre_Height = interp1([states.Ay],[states.R_Roll_Centres],Lateral_Acceleration);

                        Sprung_Centre_Perpendicular_NRA = define_Roll_Axis_Distance(Front_Roll_Centre_Height, ...
                            Rear_Roll_Centre_Height,Sprung_Mass_Centre(1),Sprung_Mass_Centre(3),Wheelbase);

                        Front_Roll_Rate = (Front_Spring_Stiffness*Front_Motion_Ratio^2*Track_Width^2*Tyre_Rate)/(2*(Front_Spring_Stiffness*Front_Motion_Ratio^2+Tyre_Rate)); %Nm/rad
                        Rear_Roll_Rate  = (Rear_Spring_Stiffness*Rear_Motion_Ratio^2*Track_Width^2*Tyre_Rate)/(2*(Rear_Spring_Stiffness*Rear_Motion_Ratio^2+Tyre_Rate)); %Nm/rad

                        Vertical_Wheel_Loads = Compute_Vertical_Wheel_Loads_Aero(Velocity,Vehicle_Weight,Centre_of_Gravity, Wheelbase, Track_Width, ...
                            Lateral_Acceleration, Longitudinal_Acceleration, Sprung_Weight, Sprung_Mass_Centre, ...
                            Front_Unsprung_Weight,Rear_Unsprung_Weight,Front_Unsprung_Mass_Centre,Rear_Unsprung_Mass_Centre,...
                            Front_Roll_Centre_Height, Rear_Roll_Centre_Height, Sprung_Centre_Perpendicular_NRA, ...
                            Front_Roll_Rate, Rear_Roll_Rate, Front_Lift_Coefficient, Rear_Lift_Coefficient,Vehicle_Frontal_Area);

                        for i = 1:numel(Vertical_Wheel_Loads)
                            if Vertical_Wheel_Loads(i) < 0;
                                Vertical_Wheel_Loads(i) = 0; %N - correction for unphysical lifting of inside wheels at the extremes
                            end
                        end

                        Yaw_Rate = Lateral_Acceleration*g/Velocity;

                        %%% Slip angle calculation assumes toe is clockwise
                        %%% positive, if toe is defined according to FSAE
                        %%% convention of inwards positive, different
                        %%% adjustments will need to be made per-wheel
                        FL_Slip_Angle = beta + Centre_of_Gravity(1)*Yaw_Rate/Velocity - delta - FL_Toe;
                        FR_Slip_Angle = beta + Centre_of_Gravity(1)*Yaw_Rate/Velocity - delta - FR_Toe;
                        RL_Slip_Angle = beta - (Wheelbase-Centre_of_Gravity(1))*Yaw_Rate/Velocity - RL_Toe;
                        RR_Slip_Angle = beta - (Wheelbase-Centre_of_Gravity(1))*Yaw_Rate/Velocity - RR_Toe;

                        Slip_Angles_deg = [FL_Slip_Angle FR_Slip_Angle RL_Slip_Angle RR_Slip_Angle]*180/pi;

                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        %%% Inclination angle calculation from camber angles %%%
                        FL_Inclination_Angle = Roll_Angle - FL_camber;
                        FR_Inclination_Angle = FR_camber + Roll_Angle;
                        RL_Inclination_Angle = Roll_Angle - RL_camber;
                        RR_Inclination_Angle = RR_camber + Roll_Angle;
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                        %%% Store Magic Formula parameters as 1x4 vectors
                        %%% (corresponding to four wheel loads)
                        Slip_Ratios = zeros(4,1); % Longitudinal Slip Ratios
                        Slip_Angles = [FL_Slip_Angle ; FR_Slip_Angle ; RL_Slip_Angle ; RR_Slip_Angle]; % Slip angles
                        Inclination_Angles = [FL_Inclination_Angle ; FR_Inclination_Angle ; RL_Inclination_Angle ; RR_Inclination_Angle]; % Inclination Angles
                        phit = ((Lateral_Acceleration*g)/(Velocity^2))*ones(4,1); % Turn slips, taken as 0 (i.e. infinite turn radius) as an initial approximation
                        Vx = Velocity.*ones(4,1); % Longitudinal Velocity, taken as equal for all wheels
                        P = Pressure.*ones(4,1); % Pressure in Pascals

                        %%% Call Magic Formula Function for four tyre loads
                        out = mfeval(tire,[Vertical_Wheel_Loads,Slip_Ratios,Slip_Angles,Inclination_Angles,phit,Vx,P],111);

                        %%% Store longitudinal and lateral forces
                        Longitudinal_Wheel_Forces = out(:,1);
                        Lateral_Wheel_Forces = out(:,2);
                        TyreRate = out(:,25)

                        break % k loop (lateral acceleration loop)
                    else
                        Lateral_Acceleration = Lateral_Acceleration + relax*(Ay_New-Lateral_Acceleration);
                    end

                end % k (lateral acceleration loop)

                FL_Lateral = Lateral_Wheel_Forces(1)
                FR_Lateral = Lateral_Wheel_Forces(2)
                RL_Lateral = Lateral_Wheel_Forces(3)
                RR_Lateral = Lateral_Wheel_Forces(4)

                Yaw_Moment = (FL_Lateral + FR_Lateral)*Centre_of_Gravity(1) * cos(delta)...
                    + (FR_Lateral - FL_Lateral) * sin(delta) * Track_Width/2 ...
                    - (RL_Lateral + RR_Lateral) * (Wheelbase - Centre_of_Gravity(1));

                results(row,:) = [Velocity Longitudinal_Acceleration deltas(id) betas(ib) Lateral_Acceleration Yaw_Moment FL_Lateral FR_Lateral RL_Lateral RR_Lateral];
                disp(results(row,:))

            end % ib

        end % id

    end % iax

end % iv

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Plot Yaw Moment Diagrams %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for iv = 1:numel(Operating_Velocities) % Sweep across all operational velocities
    V = Operating_Velocities(iv);
    figure('Color','w','Position',[100 100 800 550]); ax = gca;
    title(sprintf('C_N Against Lateral Acceleration for V = %.1f m/s',V));
    ylabel('C_N = N/Wl');
    xlabel('Ay');
    grid on;
    hold on;

    %%% Plot constant steering angle lines

    for id = 1:numel(deltas)
        delta = deltas(id);
        delta_line = results(results(:,1) == V & results(:,3) == delta,:);
        C_Na = delta_line(:,6)/(Vehicle_Weight*Wheelbase);
        A_ya = delta_line(:,5);

        plot(ax,A_ya, C_Na,'r', 'LineWidth', 2*(delta==0)+0.5, 'DisplayName', sprintf('Delta = %.1f',delta));

        if id == 1 || delta == 0 || id == numel(deltas)
           [pos,i0] = min(abs(delta_line(:,5)));
           text(ax,delta_line(i0,5)+0.1,delta_line(i0,6)/(Vehicle_Weight*Wheelbase)+0.02,sprintf('\\delta=%.0f\\circ',delta)); %%% Plot descriptive text near the y axis above selected delta curves
        end
    end

    %%% PLot constant body slip angle lines

    for ib = 1:numel(betas)
        beta = betas(ib);
        beta_line = results(results(:,1) == V & results(:,4) == beta & results(:,3) ~= deltas(1) & results(:,3) ~= deltas(numel(deltas)),:);
        C_NB = beta_line(:,6)/(Vehicle_Weight*Wheelbase);
        A_yB = beta_line(:,5);

        %if mod(ib+1,2) == 0
        plot(ax,A_yB, C_NB,'b','LineWidth', 2*(beta==0)+0.5, 'DisplayName', sprintf('Beta = %.1f',beta));
        %end

        if ib == 1 || beta == 0 || ib == numel(betas)
            text(ax,A_yB(end),C_NB(end),sprintf('\\beta=%.0f\\circ',beta));
        end
    end

    x_limit = xlim(ax);
    xlim(ax,x_limit + [-0.12 0.12]*diff(x_limit)); %%% Widen the x axis by 12% in both directions
    yline(ax, 0, 'k-', 'LineWidth', 1);
    hold off;
end