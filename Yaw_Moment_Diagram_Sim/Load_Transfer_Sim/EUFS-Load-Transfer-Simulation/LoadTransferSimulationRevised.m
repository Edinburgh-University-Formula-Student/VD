%%%%%%%%%%%%%%%%%%%% Multiaxial Load Transfer Simulation %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vehicle mass
% Centre of Gravity Height
% Wheelbase
% Trackwidth
% Sprung Mass
% Sprung Mass Centre Height
% Front Sprung Mass
% Front Sprung Mass Height
% Rear Sprung Mass
% Rear Sprung Mass Height
% Horizontal Distance Between Front Wheel Centre and CG
% Horizontal Distance Between Rear Wheel Centre and CG
% Front Wheel Centre to Sprung Mass Horizontal Distance
% Front Spring Stiffness
% Rear Spring Stiffness
% Rear Motion Ratio
% Front Motion Ratio
% Tyre Rate
% Longitudinal Acceleration
% Roll Angle

Zero_Case = false;

% Random parameters
Longitudinal_Acceleration = 0; %g

if Zero_Case == true
    coords = pickup_ts_zero.Data; %m
    roll_angles = roll_ts_zero.Data; %deg
    time = roll_ts_zero.Time; %s
else
    coords = pickup_ts.Data; %m
    roll_angles = roll_ts.Data; %deg
    time = roll_ts.Time; %s
end;

% Vehicle Dimensions
Track_Width = 1.00 %m
Wheelbase = 1.56 %m

% Mass Centre Coordinates and weights
Sprung_Mass = 240.465; %kg
Front_Unsprung_Mass = 20.335; %kg
Rear_Unsprung_Mass = 19.76; %kg
Vehicle_Mass = Sprung_Mass + Front_Unsprung_Mass + Rear_Unsprung_Mass; %kg

Centre_of_Gravity = [0.811 0.500 0.280] %m
Sprung_Mass_Centre = [0.7985 0.50183 0.2732]; %m
Front_Unsprung_Mass_Centre = [0.00047121 0.500 0.2656]; %m
Rear_Unsprung_Mass_Centre = [1.5588 0.500 0.2908]; %m

Vehicle_Weight = Vehicle_Mass*9.81; %N
Sprung_Weight = Sprung_Mass*9.81; %N
Front_Unsprung_Weight = Front_Unsprung_Mass*9.81; %N
Rear_Unsprung_Weight = Rear_Unsprung_Mass*9.81; %N

Tyre_Rate = 125600 %N/m FSAE Tyre Test Consortium value = 717 lbs/in for Hoosier 25B 20.5-7-13 at 12psi - change according to setup

%%%%%%%%%%%%%%%%%%%%%%% Define Roll Axis (NRA) %%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = size(coords,1);
Front_Roll_Centre_Height = zeros(N,1);
Rear_Roll_Centre_Height = zeros(N,1);
Sprung_Centre_Perpendicular_NRA = zeros(N,1);

for k = 1:N
    Front_Roll_Centre_Height(k) = compute_Roll_Centre(coords(k,2),coords(k,3),coords(k,5), ...
    coords(k,6),coords(k,8),coords(k,9),coords(k,11),coords(k,12),coords(k,14),coords(k,15), ...
    coords(k,17),coords(k,18),coords(k,20),coords(k,21),coords(k,23),coords(k,24),Front_Left_Contact_Patch(2), ...
    Front_Left_Contact_Patch(3),Front_Right_Contact_Patch(2),Front_Right_Contact_Patch(3));

    Rear_Roll_Centre_Height(k) = compute_Roll_Centre(coords(k,26),coords(k,27),coords(k,29), ...
    coords(k,30),coords(k,32),coords(k,33),coords(k,35),coords(k,36),coords(k,38),coords(k,39), ...
    coords(k,41),coords(k,42),coords(k,44),coords(k,45),coords(k,47), coords(k,48),Rear_Left_Contact_Patch(2), ...
    Rear_Left_Contact_Patch(3),Rear_Right_Contact_Patch(2),Rear_Right_Contact_Patch(3));

    Sprung_Centre_Perpendicular_NRA(k) = define_Roll_Axis_Distance(Front_Roll_Centre_Height(k), ...
    Rear_Roll_Centre_Height(k),Sprung_Mass_Centre(1),Sprung_Mass_Centre(3),Wheelbase);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%% CALCULATIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Front_Roll_Rate = (Front_Spring_Stiffness*Front_Motion_Ratio^2*Track_Width^2*Tyre_Rate)/(2*(Front_Spring_Stiffness*Front_Motion_Ratio^2+Tyre_Rate)); %Nm/rad
Rear_Roll_Rate = (Rear_Spring_Stiffness*Rear_Motion_Ratio^2*Track_Width^2*Tyre_Rate)/(2*(Rear_Spring_Stiffness*Rear_Motion_Ratio^2+Tyre_Rate)); %Nm/rad

Vehicle_Roll_Sensitivity_rad = -(Sprung_Weight*Sprung_Centre_Perpendicular_NRA)/(Front_Roll_Rate + Rear_Roll_Rate); %rad/g
Vehicle_Roll_Sensitivity_deg = Vehicle_Roll_Sensitivity_rad*(180/pi); %deg/g
Lateral_Acceleration = roll_ts.Data ./ Vehicle_Roll_Sensitivity_deg; %g

Front_Lateral_Load_Transfer_per_g = (Sprung_Weight/Track_Width)*((Sprung_Centre_Perpendicular_NRA*Front_Roll_Rate)./(Front_Roll_Rate+Rear_Roll_Rate))+...
    (Sprung_Weight/Track_Width)*((Wheelbase-Sprung_Mass_Centre(1))/Wheelbase)*Front_Roll_Centre_Height+...
    (Front_Unsprung_Weight/Track_Width)*Front_Unsprung_Mass_Centre(3); %N/g

Rear_Lateral_Load_Transfer_per_g = (Sprung_Weight/Track_Width)*((Sprung_Centre_Perpendicular_NRA*Rear_Roll_Rate)./(Front_Roll_Rate+Rear_Roll_Rate))+...
    (Sprung_Weight/Track_Width)*(Sprung_Mass_Centre(1)/Wheelbase)*Rear_Roll_Centre_Height+...
    (Rear_Unsprung_Weight/Track_Width)*Rear_Unsprung_Mass_Centre(3); %N/g

Front_Lateral_Load_Transfer = Front_Lateral_Load_Transfer_per_g .* Lateral_Acceleration
Rear_Lateral_Load_Transfer = Rear_Lateral_Load_Transfer_per_g .* Lateral_Acceleration
Total_Lateral_Load_Transfer = Front_Lateral_Load_Transfer + Rear_Lateral_Load_Transfer

Front_Left_Static_Load = (Front_Unsprung_Weight + Sprung_Weight*((Wheelbase-Sprung_Mass_Centre(1))/Wheelbase))/2; %N
Front_Right_Static_Load = (Front_Unsprung_Weight + Sprung_Weight*((Wheelbase-Sprung_Mass_Centre(1))/Wheelbase))/2; %N
Rear_Left_Static_Load = (Rear_Unsprung_Weight + Sprung_Weight*(Sprung_Mass_Centre(1)/Wheelbase))/2; %N
Rear_Right_Static_Load = (Rear_Unsprung_Weight + Sprung_Weight*(Sprung_Mass_Centre(1)/Wheelbase))/2; %N

Front_Transfer_Distribution = Front_Lateral_Load_Transfer_per_g ./ (Front_Lateral_Load_Transfer_per_g + Rear_Lateral_Load_Transfer_per_g);
Rear_Transfer_Distribution = Rear_Lateral_Load_Transfer_per_g ./ (Front_Lateral_Load_Transfer_per_g + Rear_Lateral_Load_Transfer_per_g);
Check = Front_Transfer_Distribution + Rear_Transfer_Distribution;

Longitudinal_Load_Transfer = (Vehicle_Weight*Longitudinal_Acceleration*Centre_of_Gravity(3))/Wheelbase; %N

FL_Load = Front_Left_Static_Load - Longitudinal_Load_Transfer/2 + Front_Lateral_Load_Transfer_per_g .* Lateral_Acceleration; %N
FR_Load = Front_Right_Static_Load - Longitudinal_Load_Transfer/2 - Front_Lateral_Load_Transfer_per_g .* Lateral_Acceleration; %N
RL_Load = Rear_Left_Static_Load + Longitudinal_Load_Transfer/2 + Rear_Lateral_Load_Transfer_per_g .* Lateral_Acceleration; %N
RR_Load = Rear_Right_Static_Load + Longitudinal_Load_Transfer/2 - Rear_Lateral_Load_Transfer_per_g .* Lateral_Acceleration; %N
Load_Sum = FL_Load + FR_Load + RL_Load + RR_Load

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% Plotting Load Transfer Data %%%%%%%%%%%%%%%%%%%%%%%

% Sort data

[Lateral_Acceleration, idx] = sort(Lateral_Acceleration);
FL_Load = FL_Load(idx); FR_Load = FR_Load(idx); RL_Load = RL_Load(idx); RR_Load = RR_Load(idx);
Front_Transfer_Distribution = Front_Transfer_Distribution(idx); Rear_Transfer_Distribution = Rear_Transfer_Distribution(idx);
Vehicle_Roll_Sensitivity_deg = Vehicle_Roll_Sensitivity_deg(idx);
Front_Roll_Centre_Height = Front_Roll_Centre_Height(idx); Rear_Roll_Centre_Height = Rear_Roll_Centre_Height(idx);
Sprung_Centre_Perpendicular_NRA = Sprung_Centre_Perpendicular_NRA(idx);

% Plot Loads against Lateral Acceleration


if Zero_Case == false

    figure('Color','w','Position',[100 100 800 550]);
    hold on;
    plot(Lateral_Acceleration, FL_Load, 'r', 'DisplayName', 'Front Left Load');
    plot(Lateral_Acceleration, FR_Load, 'g', 'DisplayName', 'Front Right Load');
    plot(Lateral_Acceleration, RL_Load, 'b', 'DisplayName', 'Rear Left Load');
    plot(Lateral_Acceleration, RR_Load, 'm', 'DisplayName', 'Rear Right Load');
    plot(Lateral_Acceleration, Load_Sum, 'w', 'DisplayName', 'Load Sum');
    plot(0, Vehicle_Weight, 'o', 'DisplayName', 'Vehicle Weight');
    xlabel('Lateral Acceleration (g)');
    ylabel('Load (N)');
    title('Load Transfer vs. Lateral Acceleration');
    legend show;
    grid on;
    hold off;

    % Plot load transfer distribution fractions against Lateral Acceleration
    figure('Color','w','Position',[100 100 800 550]);
    hold on;
    plot(Lateral_Acceleration, Front_Transfer_Distribution, 'y', 'DisplayName', 'Front Load Transfer Fraction');
    plot(Lateral_Acceleration, Rear_Transfer_Distribution, 'b', 'DisplayName', 'Rear Load Transfer Fraction');
    plot(Lateral_Acceleration, Check, 'w', 'DisplayName', 'Sum');
    ylim([0 1.10]);
    xlabel('Lateral Acceleration (g)');
    ylabel('Load Transfer Distribution Fraction');
    title('Load Transfer Fractions vs. Lateral Acceleration');
    legend show;
    grid on;
    hold off;

    % Plot roll rates against Lateral Acceleration
    figure('Color','w','Position',[100 100 800 550]);
    hold on;
    plot(Lateral_Acceleration, Vehicle_Roll_Sensitivity_deg, 'g', 'DisplayName', 'Vehicle Roll Sensitivity');
    xlabel('Lateral Acceleration (g)');
    ylabel('Roll Rate (deg/g)');
    title('Roll Sensitivty vs. Lateral Acceleration');
    legend show;
    grid on;
    hold off;

    % Plot roll axis data against lateral acceleration
    figure('Color','w','Position',[100 100 800 550]);
    hold on;
    plot(Lateral_Acceleration, Front_Roll_Centre_Height, 'y', 'DisplayName', 'Front Roll Centre Height');
    plot(Lateral_Acceleration, Rear_Roll_Centre_Height, 'r', 'DisplayName', 'Rear Roll Centre Height');
    plot(Lateral_Acceleration, Sprung_Centre_Perpendicular_NRA, 'g', 'DisplayName', 'Height of CG Above NRA');
    xlabel('Lateral Acceleration (g)');
    ylabel('Height (m)');
    title('Roll Centre Heights vs. Lateral Acceleration');
    legend show;
    grid on;
    hold off;

 % Plot roll axis data against lateral acceleration
    figure('Color','w','Position',[100 100 800 550]);
    hold on;
    plot(roll_angles, Total_Lateral_Load_Transfer, 'w', 'DisplayName', 'Front Roll Centre Height');
    xlabel('Roll Angle (g)');
    ylabel('Total Lateral Load Transfer (m)');
    title('Total Load Transfer vs Roll Angle');
    legend show;
    grid on;
    hold off;

else

    figure('Color','w','Position',[100 100 800 550]);
    hold on;
    plot(time, FL_Load, 'r', 'DisplayName', 'Front Left Load');
    plot(time, FR_Load, 'g', 'DisplayName', 'Front Right Load');
    plot(time, RL_Load, 'b', 'DisplayName', 'Rear Left Load');
    plot(time, RR_Load, 'm', 'DisplayName', 'Rear Right Load');
    plot(time, Load_Sum, 'w', 'DisplayName', 'Load Sum');
    yline(Vehicle_Weight, '--', 'DisplayName', 'Vehicle Weight');
    xlabel('Time (s)');
    ylabel('Load (N)');
    title('Load Transfer vs. Time');
    legend show;
    grid on;
    hold off;

    % Plot load transfer distribution fractions against time
    figure('Color','w','Position',[100 100 800 550]);
    hold on;
    plot(time, Front_Transfer_Distribution, 'y', 'DisplayName', 'Front Load Transfer Fraction');
    plot(time, Rear_Transfer_Distribution, 'b', 'DisplayName', 'Rear Load Transfer Fraction');
    plot(time, Check, 'k', 'DisplayName', 'Sum');
    ylim([0 1.10]);
    xlabel('Time (s)');
    ylabel('Load Transfer Distribution Fraction');
    title('Load Transfer Fractions vs. Time');
    legend show;
    grid on;
    hold off;

    % Plot roll sensitivity against time
    figure('Color','w','Position',[100 100 800 550]);
    hold on;
    plot(time, Vehicle_Roll_Sensitivity_deg, 'g', 'DisplayName', 'Vehicle Roll Sensitivity');
    xlabel('Time (s)');
    ylabel('Roll Rate (deg/g)');
    title('Roll Sensitivty vs. Time');
    legend show;
    grid on;
    hold off;

    % Plot roll axis data against time
    figure('Color','w','Position',[100 100 800 550]);
    hold on;
    plot(time, Front_Roll_Centre_Height, 'y', 'DisplayName', 'Front Roll Centre Height');
    plot(time, Rear_Roll_Centre_Height, 'r', 'DisplayName', 'Rear Roll Centre Height');
    plot(time, Sprung_Centre_Perpendicular_NRA, 'g', 'DisplayName', 'Height of CG Above NRA');
    xlabel('Time (s)');
    ylabel('Height (m)');
    title('Roll Centre Heights vs. Time');
    legend show;
    grid on;
    hold off;
end;


% find the index closest to the roll angle you want
target_roll = 1.5;   % degrees, whatever you want
[~, k] = min(abs(roll_angles - target_roll));

% read h2 at that index
h2_value = Sprung_Centre_Perpendicular_NRA(k);
roll_value = roll_angles(k)
TLLT_value = Total_Lateral_Load_Transfer(k)
A_value = Lateral_Acceleration(k)

fprintf('At roll = %.2f deg: h2 = %.4f m\n', roll_angles(k), h2_value);
fprintf('At roll = %.2f deg: Lateral Load Transfer = %.4f m\n', roll_angles(k), TLLT_value);
print(A_value)