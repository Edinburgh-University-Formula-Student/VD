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
% Tyre Rate
% Longitudinal Acceleration
% Lateral Acceleration
% Front Roll Centre Height
% Rear Roll Centre Height
% Perpendicular Distance Between Roll Axis and Sprung CG
% Velocity 
% Front Lift Coefficient
% Rear Lift Coefficient
% Vehicle Frontal Area
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Wheel_Loads = Compute_Vertical_Wheel_Loads_Aero(Velocity,Vehicle_Weight,Centre_of_Gravity,Wheelbase,Track_Width,...
    Lateral_Acceleration,Longitudinal_Acceleration,Sprung_Weight,Sprung_Mass_Centre,Front_Unsprung_Weight,...
    Rear_Unsprung_Weight,Front_Unsprung_Mass_Centre,Rear_Unsprung_Mass_Centre,...
    Front_Roll_Centre_Height, Rear_Roll_Centre_Height, Sprung_Centre_Perpendicular_NRA, Front_Roll_Rate,...
    Rear_Roll_Rate, Front_Lift_Coefficient, Rear_Lift_Coefficient,Vehicle_Frontal_Area)

Front_Lateral_Load_Transfer_per_g = (Sprung_Weight/Track_Width)*((Sprung_Centre_Perpendicular_NRA*Front_Roll_Rate)./(Front_Roll_Rate+Rear_Roll_Rate))+...
    (Sprung_Weight/Track_Width)*((Wheelbase-Sprung_Mass_Centre(1))/Wheelbase)*Front_Roll_Centre_Height+...
    (Front_Unsprung_Weight/Track_Width)*Front_Unsprung_Mass_Centre(3); %N/g

Rear_Lateral_Load_Transfer_per_g = (Sprung_Weight/Track_Width)*((Sprung_Centre_Perpendicular_NRA*Rear_Roll_Rate)./(Front_Roll_Rate+Rear_Roll_Rate))+...
    (Sprung_Weight/Track_Width)*(Sprung_Mass_Centre(1)/Wheelbase)*Rear_Roll_Centre_Height+...
    (Rear_Unsprung_Weight/Track_Width)*Rear_Unsprung_Mass_Centre(3); %N/g

Front_Lateral_Load_Transfer = Front_Lateral_Load_Transfer_per_g .* Lateral_Acceleration;
Rear_Lateral_Load_Transfer = Rear_Lateral_Load_Transfer_per_g .* Lateral_Acceleration;
Total_Lateral_Load_Transfer = Front_Lateral_Load_Transfer + Rear_Lateral_Load_Transfer;

Front_Left_Static_Load = (Front_Unsprung_Weight + Sprung_Weight*((Wheelbase-Sprung_Mass_Centre(1))/Wheelbase))/2; %N
Front_Right_Static_Load = (Front_Unsprung_Weight + Sprung_Weight*((Wheelbase-Sprung_Mass_Centre(1))/Wheelbase))/2; %N
Rear_Left_Static_Load = (Rear_Unsprung_Weight + Sprung_Weight*(Sprung_Mass_Centre(1)/Wheelbase))/2; %N
Rear_Right_Static_Load = (Rear_Unsprung_Weight + Sprung_Weight*(Sprung_Mass_Centre(1)/Wheelbase))/2; %N

%%%%%%%%%%%%%%%%%%%%%%%%%%% Aerodynamic Loads %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Front_Downforce = (1/2)*1.225*Velocity^2*Vehicle_Frontal_Area*Front_Lift_Coefficient;
Rear_Downforce = (1/2)*1.225*Velocity^2*Vehicle_Frontal_Area*Rear_Lift_Coefficient;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% Computing Load Transfer %%%%%%%%%%%%%%%%%%%%%%%%%%%
Front_Transfer_Distribution = Front_Lateral_Load_Transfer_per_g ./ (Front_Lateral_Load_Transfer_per_g + Rear_Lateral_Load_Transfer_per_g);
Rear_Transfer_Distribution = Rear_Lateral_Load_Transfer_per_g ./ (Front_Lateral_Load_Transfer_per_g + Rear_Lateral_Load_Transfer_per_g);
Check = Front_Transfer_Distribution + Rear_Transfer_Distribution;

Longitudinal_Load_Transfer = (Vehicle_Weight*Longitudinal_Acceleration*Centre_of_Gravity(3))/Wheelbase; %N

FL_Load = Front_Left_Static_Load - Longitudinal_Load_Transfer/2 + Front_Lateral_Load_Transfer_per_g * Lateral_Acceleration + Front_Downforce/2; %N
FR_Load = Front_Right_Static_Load - Longitudinal_Load_Transfer/2 - Front_Lateral_Load_Transfer_per_g * Lateral_Acceleration + Front_Downforce/2; %N
RL_Load = Rear_Left_Static_Load + Longitudinal_Load_Transfer/2 + Rear_Lateral_Load_Transfer_per_g * Lateral_Acceleration + Rear_Downforce/2; %N
RR_Load = Rear_Right_Static_Load + Longitudinal_Load_Transfer/2 - Rear_Lateral_Load_Transfer_per_g * Lateral_Acceleration + Rear_Downforce/2; %N

Wheel_Loads = [FL_Load ; FR_Load ; RL_Load ; RR_Load];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end