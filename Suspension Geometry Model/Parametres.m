%% University of Edinburgh Formula Student
% Suspension Geometry Simulator
% Paul Wang, Vehicle Dynamics
% Winter 2024, Spring 2025

clear
close all
set(0,'DefaultFigureWindowStyle','docked')
%% GLOBAL SETUP

% You want positive camber for inside wheel, slightly negative for outside
% wheel. Acceleration and braking should be near 0

% Ballpark initial static camber = -1.5

Steering_Mode = false;
Travel_Mode = false;
Pitch_Mode = false;
Roll_Mode = false;
Motion_Ratio = false;
Roll_Center = false;

%%%%%%%%%%%%%%%%%%%%%%%
% Steering_Mode = true;
% Travel_Mode = true;
% Pitch_Mode = true;
Roll_Mode = true;

Motion_Ratio = true;
% Roll_Center = true;
%%%%%%%%%%%%%%%%%%%%%%%

chassis_height = 2*207*1/1000; %m
chassis_length = 1.5; %m
chassis_width = 0.42; %m


Ride_Height = 0.14; %m

Ride_Height_Block_Height = 0.14;
Track_Width = 1.300;  %m 1300mm ROBERTO VALUE
Front_Wheelbase = 0.53; %m 561
Rear_Wheelbase = 1.01; %m 




Number_Of_Iterations = 4;

Iteration_Step = 0.02; %m

    % (:,:,1) = TopBackArm
    % (:,:,2) = TopFrontArm
    % (:,:,3) = CamberSlope
    % (:,:,4) = CasterSlope
    % (:,:,5) = ToeSlope
if Steering_Mode
    Steering_Slope_Data = zeros(Number_Of_Iterations, Number_Of_Iterations, 4);
elseif Travel_Mode
    Travel_Slope_Data = zeros(Number_Of_Iterations, Number_Of_Iterations, 5);
elseif Pitch_Mode
    % (:,:,6) = RollCenterDistance
    Pitch_Slope_Data = zeros(Number_Of_Iterations, Number_Of_Iterations, 8);
elseif Roll_Mode
    Roll_Slope_Data = zeros(Number_Of_Iterations, Number_Of_Iterations, 6);
end

simIn = Simulink.SimulationInput("SGS_3D_1");
simIn4 = Simulink.SimulationInput("SGS_3D_2_4WHEEL");


%% SUSPENSION PICKUP POINT LIMITS
Plane_Pickup_Angle = 7; %6.634449131; % Deg REAL VALUE

BottomArms_Dist_Limit = chassis_height/2;
Arms_FOR_AFT_Position = 0.25;

TopArms_Starting_Position = -0.06; % REAL VALUE
RearTopArms_Starting_Position = -0.08;


Height_Of_Suspension_Window = 0.18;
TopArms_Upper_Bound = TopArms_Starting_Position + Height_Of_Suspension_Window/2;
TopArms_Lower_Bound = TopArms_Starting_Position - Height_Of_Suspension_Window/2;
RearTopArms_Upper_Bound = RearTopArms_Starting_Position + Height_Of_Suspension_Window/2;
RearTopArms_Lower_Bound = RearTopArms_Starting_Position - Height_Of_Suspension_Window/2;
TopArms_Veritcal_Iteration_Step = Height_Of_Suspension_Window/Number_Of_Iterations;




if Height_Of_Suspension_Window == 0; Height_Of_Suspension_Window=0.001; end

chassis_rear_width_addition = 0.065; %m


if Travel_Mode
    CAMBER = -1.5 - 0.21; %DEG, Static Camber at ride height
    TOE = -2 - 0.35;
elseif Roll_Mode || Pitch_Mode
    CAMBER = -1.5 - 0.9; %DEG, Static Camber at ride height
    TOE = -2 + 0.35;
else
    CAMBER = -1.5;
    TOE = 1.6;
end



%DEG, Static Toe at ride height
CASTER = 5.51; %DEG, Static Caster at ride height, 5.51 REAL VALUE
% KINGPIN = 17.5; %DEG, Kingpin with respect to tyre rim, 17.478 REAL VALUE
KINGPIN = 10.5;
Scrub_Radius = 0.035; %m, Scrub radius from steering axis to middle of tyre REAL VALUE
% Scrub_Radius = 0;
Scrub_Offset = 0; %m, DO NOT CHANGE! offset from upright to middle of rim, has no effect on KingPin


Bell_CrankL_Chassis_Desired_Angle = 15; %DEG
Shock_Pickup_Height = 0.01; %m
Bell_CrankL_Height = 0.08; %m
Bell_CrankL_Top_Length = 0.037; %m


Bell_CrankL_Internal_Angle_BACK = 90; %DEG
Bell_CrankL_Left_Length_BACK = 0.08;
Bell_CrankL_Right_Length_BACK = 0.06;
Bell_CrankL_BACK = [0, 0; Bell_CrankL_Right_Length_BACK, 0; 0, Bell_CrankL_Left_Length_BACK;];


Shock_Pickup_Height_BACK = 0.01; %m
Bell_CrankL_Pickup_Height_BACK = -0.2+0.05; %m






%% BELLCRANK & SHOCK

% plot(A_Arm(:,1), A_Arm(:,2))

Bell_CrankL = [0, 0; Bell_CrankL_Top_Length/2, Bell_CrankL_Height; -Bell_CrankL_Top_Length/2, Bell_CrankL_Height;];
Bell_CrankL_Internal_Angle = atand((0.5*Bell_CrankL_Top_Length)/Bell_CrankL_Height);

Inboard_Pickup_Height = chassis_height/2+Bell_CrankL_Height; %m
Cylinder_Length = 0.15; %m
Piston_Length = 0.15; %m
Arm_W = 0.025; %m
ArmHole_R = 0.01; %m
Arm_Num_Holes = 2;

cyl_x_sec = [0 -Cylinder_Length/2; 1.5/100 -Cylinder_Length/2; 1.5/100 Cylinder_Length/2; 0.75/100 Cylinder_Length/2; 0.75/100 -(Cylinder_Length-0.25)/2; 0 -(Cylinder_Length-0.25)/2];
piston_x_sec = [0 -Piston_Length/2; 0.75/100 -Piston_Length/2; 0.75/100 Piston_Length/2; 0 Piston_Length/2];

%% PISTON NEUTRAL POSITION
BlueLineLength = sqrt(Shock_Pickup_Height^2 + (chassis_width/2)^2);
AngleBetweenBlueAndWhiteLine = Bell_CrankL_Chassis_Desired_Angle + atand((0.5*chassis_width)/Shock_Pickup_Height);
PurpleLineLength = sqrt(  (BlueLineLength^2) + (Bell_CrankL_Height^2) - 2*BlueLineLength*Bell_CrankL_Height*cosd(AngleBetweenBlueAndWhiteLine) );
PistonL_Neutral_Displacement = PurpleLineLength - (Piston_Length);


Front_Spring_Stiffness = 30000; %NM ROBERTO VALUE
Rear_Spring_Stiffness = 40000; %NM ROBERTO VALUE
if Travel_Mode && Motion_Ratio
    Damping_Coefficient = 0;
else
    Damping_Coefficient = 1500; %1500 Ns/m ROBERTO VALUE
end



% -------------------------
% 0.2057 m
Tyre_Wall_Thickness = 3; Tyre_Wall_Thickness = Tyre_Wall_Thickness/39.37; %INCHES; m conversion
Rim_Outer_Radius = 5; Rim_Outer_Radius = Rim_Outer_Radius/39.37; %INCHES; m conversion

Wheel_width = 7.5/39.37; %INCHES   %0.213; %m
Rim_Thickness = 0.02; %m

Wheel_radius = Rim_Outer_Radius+Tyre_Wall_Thickness; %m
Rim_x_sec = [Rim_Outer_Radius-Rim_Thickness Wheel_width/2; Rim_Outer_Radius-Rim_Thickness -Wheel_width/2; Rim_Outer_Radius -Wheel_width/2; Rim_Outer_Radius Wheel_width/2];
Tyre_x_sec = [Wheel_radius-Tyre_Wall_Thickness Wheel_width/2; Wheel_radius-Tyre_Wall_Thickness -Wheel_width/2; Wheel_radius -Wheel_width/2; Wheel_radius Wheel_width/2];
% ------------------------

Track_Width = Track_Width+Wheel_radius; %m

OutTop_Pickup_Dist = 0.06948184943; %m REAL VALUE
OutBot_Pickup_Dist = 0.07778083697; %m REAL VALUE

OutTieRod_Pickup_Dist = 0.02117; %m REAL VALUE
OutTieRod_Pickup_FOR_AFT = -0.07555; %m Positive for FOR, Negative for AFT REAL VALUE

OutTieRod_Pickup_Dist_BACK = 0.073325; %m REAL VALUE
OutTieRod_Pickup_FOR_AFT_BACK = -0.052195; %m Positive for FOR, Negative for AFT REAL VALUE

% -0.073325	-0.052195

% [innertop(radius, width), innerbottom(radius, -width), outbottom(radius, -width), outtop(radius, width)]

%% DRIVESHAFT

Powertrain_Inboard_CV_Joint_Offset_Inboard_Outboard = 152.58; %mm SOLIDWORKS/SIMSCAPE Y
Powertrain_Inboard_CV_Joint_Offset_Up_Down = 56.88; %mm SOLIDWORKS/SIMSCAPE Z
Powertrain_Inboard_CV_Joint_Offset_For_Aft = 47.97;%mm SOLIDWORKS/SIMSCAPE X 

Powertrain_Outboard_CV_Offset_Inboard_Outboard = 31.82; %mm

Powertrain_Cone_Length = Track_Width/2 + Wheel_width/2 - Powertrain_Inboard_CV_Joint_Offset_Inboard_Outboard/1000 - Powertrain_Outboard_CV_Offset_Inboard_Outboard/1000; %m
Powertrain_Cone_x_sec = [0, 0; 0, -Powertrain_Cone_Length;Powertrain_Cone_Length*sind(8), -Powertrain_Cone_Length;];

Driveshaft_Length = Track_Width/2; %m
Driveshaft_Radius = 10 / 1000; %mm
Driveshaft_x_sec = [0 -Driveshaft_Length/2; Driveshaft_Radius -Driveshaft_Length/2; Driveshaft_Radius Driveshaft_Length/2; 0 Driveshaft_Length/2];


Driveshaft_buffer_x_sec = [0 -Driveshaft_Length/2; Driveshaft_Radius+0.020 -Driveshaft_Length/2; Driveshaft_Radius+0.020 Driveshaft_Length/2; 0 Driveshaft_Length/2];


Chassis_Crossbar_Radius = 0.0254/2;
Chassis_Crossbar_x_sec = [0 -Driveshaft_Length/2;Chassis_Crossbar_Radius  -Driveshaft_Length/2;Chassis_Crossbar_Radius  Driveshaft_Length/2; 0 Driveshaft_Length/2];


Steering_Cone_Length = Track_Width/2; %m
Steering_Cone_x_sec = [0, 0; 0, -Steering_Cone_Length;Steering_Cone_Length*sind(5), -Steering_Cone_Length;];




%% EXPERIMENTAL
Tyre_Floor_Plane = -abs(chassis_height/2 + Ride_Height - (Wheel_radius/cosd(CAMBER) - (Wheel_radius*tand(CAMBER) - Wheel_width/2)*sind(CAMBER)));

%% ITERATION

% for j=Number_Of_Iterations:Number_Of_Iterations
    for i=Number_Of_Iterations:Number_Of_Iterations
        % disp(string((j-1)*Number_Of_Iterations + i-1) + "/" + string(Number_Of_Iterations^2) + ", " + string(((j-1)*Number_Of_Iterations + i-1)/(Number_Of_Iterations^2)) + "%")
        disp(string(i) + "/" + string(Number_Of_Iterations))

   
        %% VARIABLES


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Inboard_TopBack_Pickup_UP = TopArms_Starting_Position - 0.02 - 0.014; %Starting Position + Roll Center + Offset
        Inboard_TopBack_Pickup_AFT = Arms_FOR_AFT_Position + 0.020; %m
        front_chassis_top_back_offset = tand(Plane_Pickup_Angle) * (chassis_height/2 - abs(Inboard_TopBack_Pickup_UP));

        Inboard_TopFront_Pickup_UP = TopArms_Starting_Position - 0.02 + 0.014; %Starting Position + Roll Center + Offset
        Inboard_TopFront_Pickup_FOR = Arms_FOR_AFT_Position; %m
        front_chassis_top_front_offset = tand(Plane_Pickup_Angle) * (chassis_height/2 - abs(Inboard_TopFront_Pickup_UP));

        Inboard_BotBack_Pickup_DOWN = BottomArms_Dist_Limit; %m
        Inboard_BotBack_Pickup_AFT = Arms_FOR_AFT_Position + 0.020; %m

        Inboard_BotFront_Pickup_DOWN = BottomArms_Dist_Limit; %m
        Inboard_BotFront_Pickup_FOR = Arms_FOR_AFT_Position; %m

        TieRod_Pickup_Dist = BottomArms_Dist_Limit-0.01588; %m
        % TieRod_Pickup_FOR_AFT = -0.0300 -(abs(-0.0300-0.1156)/Number_Of_Iterations) * (i-1); %m Positive for FOR, Negative for AFT
        % -0.0700 Max Aft
        % -0.0500 Max For


        TieRod_Pickup_FOR_AFT = -0.0700;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        Inboard_TopBack_Pickup_UP_BACK = RearTopArms_Starting_Position - 0.02 + 0.006; %Starting Position + Roll Center + Offset
        Inboard_TopBack_Pickup_AFT_BACK = 0.095; %m

        Inboard_TopFront_Pickup_UP_BACK = RearTopArms_Starting_Position - 0.02 - 0.335*tand(3.6139); %Starting Position + Roll Center + Offset (3.6139 DEG AOA)
        Inboard_TopFront_Pickup_FOR_BACK = 0.335; %m REAL VALUE: 0.335

        Inboard_BotBack_Pickup_DOWN_BACK = BottomArms_Dist_Limit; %m
        Inboard_BotBack_Pickup_AFT_BACK = 0.095; %m

        Inboard_BotFront_Pickup_DOWN_BACK = BottomArms_Dist_Limit; %m
        Inboard_BotFront_Pickup_FOR_BACK = 0.335; %m REAL VALUE: 0.335

        TieRod_Pickup_Dist_BACK = 0.1911; %m
        TieRod_Pickup_FOR_AFT_BACK = -0.120; %m Positive for FOR, Negative for AFT
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


        % -------------------------


  
















        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% COMPUTATION & CALCULATION %%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




        %% PICKUP POINTS
        InBoard_TopL_PickupCOORD = [-Inboard_TopBack_Pickup_AFT, chassis_width/2+front_chassis_top_back_offset, Inboard_TopBack_Pickup_UP];
        InBoard_BotL_PickupCOORD = [-Inboard_BotBack_Pickup_AFT, chassis_width/2, -Inboard_BotBack_Pickup_DOWN];
        InBoard_TopR_PickupCOORD = [Inboard_TopFront_Pickup_FOR, chassis_width/2+front_chassis_top_front_offset, Inboard_TopFront_Pickup_UP];
        InBoard_BotR_PickupCOORD = [Inboard_BotFront_Pickup_FOR, chassis_width/2, -Inboard_BotFront_Pickup_DOWN];

        InBoard_TopL_PickupCOORD_RIGHT = [Inboard_TopBack_Pickup_AFT, chassis_width/2+front_chassis_top_back_offset, Inboard_TopBack_Pickup_UP];
        InBoard_BotL_PickupCOORD_RIGHT = [Inboard_BotBack_Pickup_AFT, chassis_width/2, -Inboard_BotBack_Pickup_DOWN];
        InBoard_TopR_PickupCOORD_RIGHT = [-Inboard_TopFront_Pickup_FOR, chassis_width/2+front_chassis_top_front_offset, Inboard_TopFront_Pickup_UP];
        InBoard_BotR_PickupCOORD_RIGHT = [-Inboard_BotFront_Pickup_FOR, chassis_width/2, -Inboard_BotFront_Pickup_DOWN];

        InBoard_TopL_PickupCOORD_BACK = [-Inboard_TopBack_Pickup_AFT_BACK, chassis_width/2, Inboard_TopBack_Pickup_UP_BACK];
        InBoard_BotL_PickupCOORD_BACK = [-Inboard_BotBack_Pickup_AFT_BACK, chassis_width/2, -Inboard_BotBack_Pickup_DOWN_BACK];
        InBoard_TopR_PickupCOORD_BACK = [Inboard_TopFront_Pickup_FOR_BACK, chassis_width/2, Inboard_TopFront_Pickup_UP_BACK];
        InBoard_BotR_PickupCOORD_BACK = [Inboard_BotFront_Pickup_FOR_BACK, chassis_width/2, -Inboard_BotFront_Pickup_DOWN_BACK];

        InBoard_TopL_PickupCOORD_RIGHT_BACK = [Inboard_TopBack_Pickup_AFT_BACK, chassis_width/2, Inboard_TopBack_Pickup_UP_BACK];
        InBoard_BotL_PickupCOORD_RIGHT_BACK = [Inboard_BotBack_Pickup_AFT_BACK, chassis_width/2, -Inboard_BotBack_Pickup_DOWN_BACK];
        InBoard_TopR_PickupCOORD_RIGHT_BACK = [-Inboard_TopFront_Pickup_FOR_BACK, chassis_width/2, Inboard_TopFront_Pickup_UP_BACK];
        InBoard_BotR_PickupCOORD_RIGHT_BACK = [-Inboard_BotFront_Pickup_FOR_BACK, chassis_width/2, -Inboard_BotFront_Pickup_DOWN_BACK];


        TieRod_PickupCOORD = [TieRod_Pickup_FOR_AFT, chassis_width/2, -TieRod_Pickup_Dist];
        TieRod_PickupCOORD_RIGHT = [-TieRod_Pickup_FOR_AFT, chassis_width/2, -TieRod_Pickup_Dist];

        TieRod_PickupCOORD_BACK = [TieRod_Pickup_FOR_AFT_BACK, chassis_width/2, -TieRod_Pickup_Dist_BACK];
        TieRod_PickupCOORD_RIGHT_BACK = [-TieRod_Pickup_FOR_AFT_BACK, chassis_width/2, -TieRod_Pickup_Dist_BACK];

        CrankL_PickupCOORD = [0, chassis_width/2-0.02, chassis_height/2+0.02];
        ShockL_PickupCOORD = [0, 0, chassis_height/2 + Shock_Pickup_Height];

        CrankL_PickupCOORD_BACK = [0, chassis_width/2, chassis_height/2 + Bell_CrankL_Pickup_Height_BACK];
        ShockL_PickupCOORD_BACK = [0, 0, chassis_height/2 + Shock_Pickup_Height_BACK + Bell_CrankL_Pickup_Height_BACK];

        


        %% CASTER
        OLDOutTop_Pickup_Dist = OutTop_Pickup_Dist;
        OutTop_Pickup_Dist = cosd(CASTER) * OutTop_Pickup_Dist;
        OutTop_Pickup_FOR_AFT = sind(CASTER) * OutTop_Pickup_Dist * sign(CASTER);

        OLDOutBot_Pickup_Dist = OutBot_Pickup_Dist;
        OutBot_Pickup_Dist = cosd(CASTER) * OutBot_Pickup_Dist;
        OutBot_Pickup_FOR_AFT = -1 * sind(CASTER) * OutBot_Pickup_Dist * sign(CASTER);

        %% KingPin
        OutTop_KingPin_Offset = -1* (Scrub_Radius + tand(KINGPIN)*(Wheel_radius+OutTop_Pickup_Dist));
        OutBot_KingPin_Offset = -1* (Scrub_Radius + tand(KINGPIN)*(Wheel_radius-OutBot_Pickup_Dist));


        %% CAMBER & RIDEHEIGHT

        %% TOP BACK/LEFT FRONT
        TB_OutboardY = OutTop_KingPin_Offset*cosd(CAMBER) - OutTop_Pickup_FOR_AFT*sind(TOE) + cosd(CAMBER)*((Wheel_radius + OutTop_Pickup_Dist) * tand(CAMBER) - Wheel_width/2);
        TB_InboardY = chassis_width/2 + front_chassis_top_back_offset;
        TB_DeltaY = Track_Width/2 - abs(TB_OutboardY - TB_InboardY);

        TB_OutboardX = OutTop_Pickup_FOR_AFT*cosd(TOE)*sign(CASTER) + OutTop_KingPin_Offset*sind(CAMBER);
        TB_InboardX = Inboard_TopBack_Pickup_AFT;
        TB_DeltaX = abs(TB_OutboardX - TB_InboardX);

        TB_OutboardZ = (Wheel_radius + OutTop_Pickup_Dist)/cosd(CAMBER) - ((Wheel_radius + OutTop_Pickup_Dist)*tand(CAMBER) - Wheel_width/2)*sind(CAMBER) + OutTop_KingPin_Offset*sind(CAMBER);
        TB_InboardZ = chassis_height/2 + Inboard_TopBack_Pickup_UP + Ride_Height;
        TB_DeltaZ = abs(TB_OutboardZ - TB_InboardZ);

        TopL_Length = sqrt( (TB_DeltaX)^2 + (TB_DeltaY)^2 + (TB_DeltaZ)^2 );
        [TopL_Arm] = Extr_Data_LinkHoles(TopL_Length, Arm_W, ArmHole_R, Arm_Num_Holes);

        %% TOP FRONT/RIGHT FRONT
        TF_OutboardY = OutTop_KingPin_Offset*cosd(CAMBER) - OutTop_Pickup_FOR_AFT*sind(TOE) + cosd(CAMBER)*((Wheel_radius + OutTop_Pickup_Dist) * tand(CAMBER) - Wheel_width/2);
        TF_InboardY = chassis_width/2 + front_chassis_top_front_offset;
        TF_DeltaY = Track_Width/2 - abs(TF_OutboardY - TF_InboardY);

        TF_OutboardX = -OutTop_Pickup_FOR_AFT*cosd(TOE)*sign(CASTER) + OutTop_KingPin_Offset*sind(CAMBER);
        TF_InboardX = Inboard_TopFront_Pickup_FOR;
        TF_DeltaX = abs(TF_OutboardX - TF_InboardX);

        TF_OutboardZ = (Wheel_radius + OutTop_Pickup_Dist)/cosd(CAMBER) - ((Wheel_radius + OutTop_Pickup_Dist)*tand(CAMBER) - Wheel_width/2)*sind(CAMBER) + OutTop_KingPin_Offset*sind(CAMBER);
        TF_InboardZ = chassis_height/2 + Inboard_TopFront_Pickup_UP + Ride_Height;
        TF_DeltaZ = abs(TF_OutboardZ - TF_InboardZ);

        TopR_Length = sqrt( (TF_DeltaX)^2 + (TF_DeltaY)^2 + (TF_DeltaZ)^2 );
        [TopR_Arm] = Extr_Data_LinkHoles(TopR_Length, Arm_W, ArmHole_R, Arm_Num_Holes);

        %% BOT FRONT/RIGHT FRONT
        BF_OutboardY = OutBot_KingPin_Offset*cosd(CAMBER) - OutBot_Pickup_FOR_AFT*sind(TOE) + cosd(CAMBER)*((Wheel_radius - OutBot_Pickup_Dist) * tand(CAMBER) - Wheel_width/2);
        BF_InboardY = chassis_width/2;
        BF_DeltaY = Track_Width/2 - abs(BF_OutboardY - BF_InboardY);

        BF_OutboardX = -OutBot_Pickup_FOR_AFT*cosd(TOE)*sign(CASTER) + OutBot_KingPin_Offset*sind(CAMBER);
        BF_InboardX = Inboard_BotFront_Pickup_FOR;
        BF_DeltaX = abs(BF_OutboardX - BF_InboardX);

        BF_OutboardZ = (Wheel_radius - OutBot_Pickup_Dist)/cosd(CAMBER) - ((Wheel_radius - OutBot_Pickup_Dist)*tand(CAMBER) - Wheel_width/2)*sind(CAMBER) + OutBot_KingPin_Offset*sind(CAMBER);
        BF_InboardZ = chassis_height/2 - Inboard_BotFront_Pickup_DOWN + Ride_Height;
        BF_DeltaZ = abs(BF_OutboardZ - BF_InboardZ);

        BotR_Length = sqrt( (BF_DeltaX)^2 + (BF_DeltaY)^2 + (BF_DeltaZ)^2 );
        [BotR_Arm] = Extr_Data_LinkHoles(BotR_Length, Arm_W, ArmHole_R, Arm_Num_Holes);

        %% BOT BACK/LEFT FRONT
        BB_OutboardY = OutBot_KingPin_Offset*cosd(CAMBER) - OutBot_Pickup_FOR_AFT*sind(TOE) + cosd(CAMBER)*((Wheel_radius - OutBot_Pickup_Dist) * tand(CAMBER) - Wheel_width/2);
        BB_InboardY = chassis_width/2;
        BB_DeltaY = Track_Width/2 - abs(BB_OutboardY - BB_InboardY);

        BB_OutboardX = OutBot_Pickup_FOR_AFT*cosd(TOE)*sign(CASTER) + OutBot_KingPin_Offset*sind(CAMBER);
        BB_InboardX = Inboard_BotBack_Pickup_AFT;
        BB_DeltaX = abs(BB_OutboardX - BB_InboardX);

        BB_OutboardZ = (Wheel_radius - OutBot_Pickup_Dist)/cosd(CAMBER) - ((Wheel_radius - OutBot_Pickup_Dist)*tand(CAMBER) - Wheel_width/2)*sind(CAMBER) + OutBot_KingPin_Offset*sind(CAMBER);
        BB_InboardZ = chassis_height/2 - Inboard_BotBack_Pickup_DOWN + Ride_Height;
        BB_DeltaZ = abs(BB_OutboardZ - BB_InboardZ);

        BotL_Length = sqrt( (BB_DeltaX)^2 + (BB_DeltaY)^2 + (BB_DeltaZ)^2 );
        [BotL_Arm] = Extr_Data_LinkHoles(BotL_Length, Arm_W, ArmHole_R, Arm_Num_Holes);

        %% REAR ARMS
                    %% TOP BACK/LEFT REAR
                    TB_OutboardY_BACK = OutTop_KingPin_Offset*cosd(CAMBER) - OutTop_Pickup_FOR_AFT*sind(TOE) + cosd(CAMBER)*((Wheel_radius + OutTop_Pickup_Dist) * tand(CAMBER) - Wheel_width/2);
                    TB_InboardY_BACK = chassis_width/2 + chassis_rear_width_addition;
                    TB_DeltaY_BACK = Track_Width/2 - abs(TB_OutboardY_BACK - TB_InboardY_BACK);
            
                    TB_OutboardX_BACK = OutTop_Pickup_FOR_AFT*cosd(TOE)*sign(CASTER) + OutTop_KingPin_Offset*sind(CAMBER);
                    TB_InboardX_BACK = Inboard_TopBack_Pickup_AFT_BACK;
                    TB_DeltaX_BACK = abs(TB_OutboardX_BACK - TB_InboardX_BACK);
            
                    TB_OutboardZ_BACK = (Wheel_radius + OutTop_Pickup_Dist)/cosd(CAMBER) - ((Wheel_radius + OutTop_Pickup_Dist)*tand(CAMBER) - Wheel_width/2)*sind(CAMBER) + OutTop_KingPin_Offset*sind(CAMBER);
                    TB_InboardZ_BACK = chassis_height/2 + Inboard_TopBack_Pickup_UP_BACK + Ride_Height;
                    TB_DeltaZ_BACK = abs(TB_OutboardZ_BACK - TB_InboardZ_BACK);
            
                    TopL_Length_BACK = sqrt( (TB_DeltaX_BACK)^2 + (TB_DeltaY_BACK)^2 + (TB_DeltaZ_BACK)^2 );
                    [TopL_Arm_BACK] = Extr_Data_LinkHoles(TopL_Length_BACK, Arm_W, ArmHole_R, Arm_Num_Holes);
            
                    %% TOP FRONT/RIGHT REAR
                    TF_OutboardY_BACK = OutTop_KingPin_Offset*cosd(CAMBER) - OutTop_Pickup_FOR_AFT*sind(TOE) + cosd(CAMBER)*((Wheel_radius + OutTop_Pickup_Dist) * tand(CAMBER) - Wheel_width/2);
                    TF_InboardY_BACK = chassis_width/2 + chassis_rear_width_addition;
                    TF_DeltaY_BACK = Track_Width/2 - abs(TF_OutboardY_BACK - TF_InboardY_BACK);
            
                    TF_OutboardX_BACK = -OutTop_Pickup_FOR_AFT*cosd(TOE)*sign(CASTER) + OutTop_KingPin_Offset*sind(CAMBER);
                    TF_InboardX_BACK = Inboard_TopFront_Pickup_FOR_BACK;
                    TF_DeltaX_BACK = abs(TF_OutboardX_BACK - TF_InboardX_BACK);
            
                    TF_OutboardZ_BACK = (Wheel_radius + OutTop_Pickup_Dist)/cosd(CAMBER) - ((Wheel_radius + OutTop_Pickup_Dist)*tand(CAMBER) - Wheel_width/2)*sind(CAMBER) + OutTop_KingPin_Offset*sind(CAMBER);
                    TF_InboardZ_BACK = chassis_height/2 + Inboard_TopFront_Pickup_UP_BACK + Ride_Height;
                    TF_DeltaZ_BACK = abs(TF_OutboardZ_BACK - TF_InboardZ_BACK);
            
                    TopR_Length_BACK = sqrt( (TF_DeltaX_BACK)^2 + (TF_DeltaY_BACK)^2 + (TF_DeltaZ_BACK)^2 );
                    [TopR_Arm_BACK] = Extr_Data_LinkHoles(TopR_Length_BACK, Arm_W, ArmHole_R, Arm_Num_Holes);
            
                    %% BOT FRONT/RIGHT REAR
                    BF_OutboardY_BACK = OutBot_KingPin_Offset*cosd(CAMBER) - OutBot_Pickup_FOR_AFT*sind(TOE) + cosd(CAMBER)*((Wheel_radius - OutBot_Pickup_Dist) * tand(CAMBER) - Wheel_width/2);
                    BF_InboardY_BACK = chassis_width/2 + chassis_rear_width_addition;
                    BF_DeltaY_BACK = Track_Width/2 - abs(BF_OutboardY_BACK - BF_InboardY_BACK);
            
                    BF_OutboardX_BACK = -OutBot_Pickup_FOR_AFT*cosd(TOE)*sign(CASTER) + OutBot_KingPin_Offset*sind(CAMBER);
                    BF_InboardX_BACK = Inboard_BotFront_Pickup_FOR_BACK;
                    BF_DeltaX_BACK = abs(BF_OutboardX_BACK - BF_InboardX_BACK);
            
                    BF_OutboardZ_BACK = (Wheel_radius - OutBot_Pickup_Dist)/cosd(CAMBER) - ((Wheel_radius - OutBot_Pickup_Dist)*tand(CAMBER) - Wheel_width/2)*sind(CAMBER) + OutBot_KingPin_Offset*sind(CAMBER);
                    BF_InboardZ_BACK = chassis_height/2 - Inboard_BotFront_Pickup_DOWN_BACK + Ride_Height;
                    BF_DeltaZ_BACK = abs(BF_OutboardZ_BACK - BF_InboardZ_BACK);
            
                    BotR_Length_BACK = sqrt( (BF_DeltaX_BACK)^2 + (BF_DeltaY_BACK)^2 + (BF_DeltaZ_BACK)^2 );
                    [BotR_Arm_BACK] = Extr_Data_LinkHoles(BotR_Length_BACK, Arm_W, ArmHole_R, Arm_Num_Holes);
            
                    %% BOT BACK/LEFT REAR
                    BB_OutboardY_BACK = OutBot_KingPin_Offset*cosd(CAMBER) - OutBot_Pickup_FOR_AFT*sind(TOE) + cosd(CAMBER)*((Wheel_radius - OutBot_Pickup_Dist) * tand(CAMBER) - Wheel_width/2);
                    BB_InboardY_BACK = chassis_width/2 + chassis_rear_width_addition;
                    BB_DeltaY_BACK = Track_Width/2 - abs(BB_OutboardY_BACK - BB_InboardY_BACK);
            
                    BB_OutboardX_BACK = OutBot_Pickup_FOR_AFT*cosd(TOE)*sign(CASTER) + OutBot_KingPin_Offset*sind(CAMBER);
                    BB_InboardX_BACK = Inboard_BotBack_Pickup_AFT_BACK;
                    BB_DeltaX_BACK = abs(BB_OutboardX_BACK - BB_InboardX_BACK);
            
                    BB_OutboardZ_BACK = (Wheel_radius - OutBot_Pickup_Dist)/cosd(CAMBER) - ((Wheel_radius - OutBot_Pickup_Dist)*tand(CAMBER) - Wheel_width/2)*sind(CAMBER) + OutBot_KingPin_Offset*sind(CAMBER);
                    BB_InboardZ_BACK = chassis_height/2 - Inboard_BotBack_Pickup_DOWN_BACK + Ride_Height;
                    BB_DeltaZ_BACK = abs(BB_OutboardZ_BACK - BB_InboardZ_BACK);
            
                    BotL_Length_BACK = sqrt( (BB_DeltaX_BACK)^2 + (BB_DeltaY_BACK)^2 + (BB_DeltaZ_BACK)^2 );
                    [BotL_Arm_BACK] = Extr_Data_LinkHoles(BotL_Length_BACK, Arm_W, ArmHole_R, Arm_Num_Holes);

        %% ANGLES
        Angle_LeftTop_Internal = atand(TB_DeltaX_BACK/TB_DeltaY_BACK);
        Angle_RightTop_Internal = atand(TF_DeltaX_BACK/TF_DeltaY_BACK);
        Angle_Top_AOA = atand( (Inboard_TopBack_Pickup_UP-Inboard_TopFront_Pickup_UP)/(Inboard_TopFront_Pickup_FOR+Inboard_TopBack_Pickup_AFT) );
        Angle_Top_AOA_BACK = atand( (Inboard_TopBack_Pickup_UP_BACK-Inboard_TopFront_Pickup_UP_BACK)/(Inboard_TopFront_Pickup_FOR_BACK+Inboard_TopBack_Pickup_AFT_BACK) );
        Angle_Between_Top_Arms = Angle_LeftTop_Internal + Angle_RightTop_Internal;


        Angle_LeftBot_Internal = atand(BB_DeltaX_BACK/BB_DeltaY_BACK);
        Angle_RightBot_Internal = atand(BF_DeltaX_BACK/BF_DeltaY_BACK);
        Angle_Bot_AOA = atand( (Inboard_BotBack_Pickup_DOWN-Inboard_BotFront_Pickup_DOWN)/(Inboard_BotFront_Pickup_FOR+Inboard_BotBack_Pickup_AFT) );
        Angle_Between_Bot_Arms = Angle_LeftBot_Internal + Angle_RightBot_Internal;

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% NEW
        BottomCamberPurpleLength = sqrt( (Wheel_radius - OutBot_Pickup_Dist)^2 + (0.5*Wheel_width)^2 );
        BottomCamberRedLength = (Wheel_radius - OutBot_Pickup_Dist)/cosd(CAMBER);
        BottomCamberPhi = atand((0.5*Wheel_width)/(Wheel_radius - OutBot_Pickup_Dist));
        BottomCamberBeta = abs(CAMBER - BottomCamberPhi);
        BottomCamberWhiteLength = sqrt( (BottomCamberPurpleLength)^2 + (BottomCamberRedLength)^2 - 2*BottomCamberPurpleLength*BottomCamberRedLength*cosd(BottomCamberBeta));
        BottomCamberBlueLength = BottomCamberWhiteLength * cosd(CAMBER) * sign(CAMBER - BottomCamberPhi);
        BottomCamberGreenLength = BottomCamberWhiteLength * sind(CAMBER) * sign(CAMBER - BottomCamberPhi);

        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% OLD
        %
        % % LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL %
        % Bot_Length = sqrt( (Track_Width/2-chassis_width/2+BottomCamberBlueLength+OutBot_KingPin_Offset)^2  +  (abs( (Ride_Height + chassis_height/2 - Inboard_BotBack_Pickup_DOWN)  -  (Wheel_radius - OutBot_Pickup_Dist + BottomCamberGreenLength)  ))^2     );
        % BotL_Length = sqrt( (Inboard_BotBack_Pickup_AFT - OutBot_Pickup_FOR_AFT)^2 + (Bot_Length)^2 );
        % [BotL_Arm] = Extr_Data_LinkHoles(BotL_Length, Arm_W, ArmHole_R, Arm_Num_Holes);
        %
        % % BBBBBBBB
        % BottomCamberPurpleLength_BACK = sqrt( (Wheel_radius - OutBot_Pickup_Dist)^2 + (0.5*Wheel_width)^2 );
        % BottomCamberRedLength_BACK = (Wheel_radius - OutBot_Pickup_Dist)/cosd(CAMBER);
        % BottomCamberPhi_BACK = atand((0.5*Wheel_width)/(Wheel_radius - OutBot_Pickup_Dist));
        % BottomCamberBeta_BACK = abs(CAMBER - BottomCamberPhi_BACK);
        % BottomCamberWhiteLength_BACK = sqrt( (BottomCamberPurpleLength_BACK)^2 + (BottomCamberRedLength_BACK)^2 - 2*BottomCamberPurpleLength_BACK*BottomCamberRedLength_BACK*cosd(BottomCamberBeta_BACK));
        % BottomCamberBlueLength_BACK = BottomCamberWhiteLength_BACK * cosd(CAMBER) * sign(CAMBER - BottomCamberPhi_BACK);
        % BottomCamberGreenLength_BACK = BottomCamberWhiteLength_BACK * sind(CAMBER) * sign(CAMBER - BottomCamberPhi_BACK);
        % BotL2D_Length_BACK = sqrt( (Track_Width/2-chassis_rear_width_addition-chassis_width/2+BottomCamberBlueLength+OutBot_KingPin_Offset)^2  +  (abs( (Ride_Height + chassis_height/2 - Inboard_BotBack_Pickup_DOWN_BACK)  -  (Wheel_radius - OutBot_Pickup_Dist + BottomCamberGreenLength)  ))^2     );
        % BotR2D_Length_BACK = sqrt( (Track_Width/2-chassis_rear_width_addition-chassis_width/2+BottomCamberBlueLength+OutBot_KingPin_Offset)^2  +  (abs( (Ride_Height + chassis_height/2 - Inboard_BotFront_Pickup_DOWN_BACK)  -  (Wheel_radius - OutBot_Pickup_Dist + BottomCamberGreenLength)  ))^2     );
        % BotL_Length_BACK = sqrt( (Inboard_BotBack_Pickup_AFT_BACK - OutBot_Pickup_FOR_AFT)^2 + (BotL2D_Length_BACK)^2 );
        % [BotL_Arm_BACK] = Extr_Data_LinkHoles(BotL_Length_BACK, Arm_W, ArmHole_R, Arm_Num_Holes);
        %
        % % RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR %
        % BotR_Length = sqrt( (Inboard_BotFront_Pickup_FOR + OutBot_Pickup_FOR_AFT)^2 + (Bot_Length)^2 );
        % [BotR_Arm] = Extr_Data_LinkHoles(BotR_Length, Arm_W, ArmHole_R, Arm_Num_Holes);
        %
        % % BBBBBBBB
        % BotR_Length_BACK = sqrt( (Inboard_BotFront_Pickup_FOR_BACK + OutBot_Pickup_FOR_AFT)^2 + (BotR2D_Length_BACK)^2 );
        % [BotR_Arm_BACK] = Extr_Data_LinkHoles(BotR_Length_BACK, Arm_W, ArmHole_R, Arm_Num_Holes);
        %
        %
        %
        %
        %
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %
        % TopCamberPurpleLength = sqrt( (Wheel_radius + OutTop_Pickup_Dist)^2 + (0.5*Wheel_width)^2 );
        % TopCamberRedLength = (Wheel_radius + OutTop_Pickup_Dist)/cosd(CAMBER);
        % TopCamberPhi = atand((0.5*Wheel_width)/(Wheel_radius + OutTop_Pickup_Dist));
        % TopCamberBeta = abs(CAMBER - TopCamberPhi);
        % TopCamberWhiteLength = sqrt( (TopCamberPurpleLength)^2 + (TopCamberRedLength)^2 - 2*TopCamberPurpleLength*TopCamberRedLength*cosd(TopCamberBeta));
        % TopCamberBlueLength = TopCamberWhiteLength * cosd(CAMBER) * sign(CAMBER - TopCamberPhi);
        % TopCamberGreenLength = TopCamberWhiteLength * sind(CAMBER) * sign(CAMBER - TopCamberPhi);
        %
        % % LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL %
        % TopL2D_Length = sqrt( (Track_Width/2-chassis_width/2-front_chassis_top_back_offset+TopCamberBlueLength+OutTop_KingPin_Offset)^2  +  (abs( (Ride_Height + chassis_height/2 + Inboard_TopBack_Pickup_UP)  -  (Wheel_radius + OutTop_Pickup_Dist + TopCamberGreenLength )  ))^2     );
        % TopR2D_Length = sqrt( (Track_Width/2-chassis_width/2-front_chassis_top_front_offset+TopCamberBlueLength+OutTop_KingPin_Offset)^2  +  (abs( (Ride_Height + chassis_height/2 + Inboard_TopBack_Pickup_UP)  -  (Wheel_radius + OutTop_Pickup_Dist + TopCamberGreenLength )  ))^2     );
        % TopL2D_Length_BACK = sqrt( (Track_Width/2-chassis_rear_width_addition-chassis_width/2+TopCamberBlueLength+OutTop_KingPin_Offset)^2  +  (abs( (Ride_Height + chassis_height/2 + Inboard_TopBack_Pickup_UP_BACK)  -  (Wheel_radius + OutTop_Pickup_Dist + TopCamberGreenLength )  ))^2     );
        % TopR2D_Length_BACK = sqrt( (Track_Width/2-chassis_rear_width_addition-chassis_width/2+TopCamberBlueLength+OutTop_KingPin_Offset)^2  +  (abs( (Ride_Height + chassis_height/2 + Inboard_TopFront_Pickup_UP_BACK)  -  (Wheel_radius + OutTop_Pickup_Dist + TopCamberGreenLength )  ))^2     );
        %
        %
        % TopL_Length = sqrt( (Inboard_TopBack_Pickup_AFT - OutTop_Pickup_FOR_AFT)^2 + (TopL2D_Length)^2 );
        % [TopL_Arm] = Extr_Data_LinkHoles(TopL_Length, Arm_W, ArmHole_R, Arm_Num_Holes);
        %
        % % BBBBBBBB
        % TopL_Length_BACK = sqrt( (Inboard_TopBack_Pickup_AFT_BACK - OutTop_Pickup_FOR_AFT)^2 + (TopL2D_Length_BACK)^2 );
        % [TopL_Arm_BACK] = Extr_Data_LinkHoles(TopL_Length_BACK, Arm_W, ArmHole_R, Arm_Num_Holes);
        %
        % % RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR %
        % TopR_Length = sqrt( (Inboard_TopFront_Pickup_FOR + OutTop_Pickup_FOR_AFT)^2 + (TopR2D_Length)^2 ); %- 0.016;
        % [TopR_Arm] = Extr_Data_LinkHoles(TopR_Length, Arm_W, ArmHole_R, Arm_Num_Holes);
        %
        % % BBBBBBBB
        % TopR_Length_BACK = sqrt( (Inboard_TopFront_Pickup_FOR_BACK + OutTop_Pickup_FOR_AFT)^2 + (TopR2D_Length_BACK)^2 ); %- 0.016;
        % [TopR_Arm_BACK] = Extr_Data_LinkHoles(TopR_Length_BACK, Arm_W, ArmHole_R, Arm_Num_Holes);
        %
        % Angle_LeftBot_Internal = atand((Inboard_BotBack_Pickup_AFT + OutBot_Pickup_FOR_AFT)/Bot_Length);
        % Angle_RightBot_Internal = atand((Inboard_BotFront_Pickup_FOR + OutBot_Pickup_FOR_AFT)/Bot_Length);
        % Angle_Bot_AOA = atand( (Inboard_BotBack_Pickup_DOWN-Inboard_BotFront_Pickup_DOWN)/(Inboard_BotFront_Pickup_FOR+Inboard_BotBack_Pickup_AFT) );
        % Angle_Between_Bot_Arms = Angle_LeftBot_Internal + Angle_RightBot_Internal;
        %
        % Angle_LeftTop_Internal = atand((Inboard_TopBack_Pickup_AFT + OutTop_Pickup_FOR_AFT)/TopL2D_Length);
        % Angle_RightTop_Internal = atand((Inboard_TopFront_Pickup_FOR + OutTop_Pickup_FOR_AFT)/TopR2D_Length);
        % Angle_Top_AOA = atand( (Inboard_TopBack_Pickup_UP-Inboard_TopFront_Pickup_UP)/(Inboard_TopFront_Pickup_FOR+Inboard_TopBack_Pickup_AFT) );
        % Angle_Between_Top_Arms = Angle_LeftTop_Internal + Angle_RightTop_Internal;
        %
        %
        %
        %
        % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %% PUSHROD LENGTH
        PurpleAlpha = 90 - Bell_CrankL_Chassis_Desired_Angle - 2*Bell_CrankL_Internal_Angle; %DEG
        PurpleLinePushRod = sqrt(Bell_CrankL_Height^2 + (Bell_CrankL_Top_Length/2)^2); %m
        TealLinePushRod = PurpleLinePushRod * sind(PurpleAlpha);
        YellowLinePushRod = PurpleLinePushRod * cosd(PurpleAlpha);
        BrownLinePushRod = Track_Width/2 - chassis_width/2 - YellowLinePushRod + BottomCamberBlueLength + OutTop_KingPin_Offset;
        DashedPuplePushRod = Ride_Height - ((Wheel_radius + OutTop_Pickup_Dist)*(1/cosd(CAMBER)));
        PushRod__2D_Length = sqrt( (chassis_height + TealLinePushRod + DashedPuplePushRod)^2 + (BrownLinePushRod)^2 );

        BrownLinePushRod_BACK = Track_Width/2 - chassis_rear_width_addition - chassis_width/2 - YellowLinePushRod + BottomCamberBlueLength + OutTop_KingPin_Offset;
        DashedPuplePushRod_BACK = Ride_Height - ((Wheel_radius + OutTop_Pickup_Dist)*(1/cosd(CAMBER)));
        PushRod__2D_Length_BACK = sqrt( (chassis_height + Bell_CrankL_Pickup_Height_BACK + TealLinePushRod + DashedPuplePushRod_BACK)^2 + (BrownLinePushRod_BACK)^2 );

        PushRod_Length = sqrt( (PushRod__2D_Length)^2 + (OutTop_Pickup_FOR_AFT)^2 ) + 0.03;
        PushRod_x_sec = [0 -PushRod_Length/2; 0.75/100 -PushRod_Length/2; 0.75/100 PushRod_Length/2; 0 PushRod_Length/2];

        PushRod_Length_BACK = sqrt( (PushRod__2D_Length_BACK)^2 + (OutBot_Pickup_FOR_AFT)^2 ) + 0.04;
        PushRod_x_sec_BACK = [0 -PushRod_Length_BACK/2; 0.75/100 -PushRod_Length_BACK/2; 0.75/100 PushRod_Length_BACK/2; 0 PushRod_Length_BACK/2];

        %% TOE & TIEROD LENGTH
        % TieRodCamberPurpleLength = sqrt( (Wheel_radius - OutTieRod_Pickup_Dist)^2 + (0.5*Wheel_width)^2 );
        % TieRodCamberRedLength = (Wheel_radius - OutTieRod_Pickup_Dist)/cosd(CAMBER);
        % TieRodCamberPhi = atand((0.5*Wheel_width)/(Wheel_radius - OutTieRod_Pickup_Dist));
        % TieRodCamberBeta = abs(CAMBER - TieRodCamberPhi);
        % TieRodCamberWhiteLength = sqrt( (TieRodCamberPurpleLength)^2 + (TieRodCamberRedLength)^2 - 2*TieRodCamberPurpleLength*TieRodCamberRedLength*cosd(TieRodCamberBeta) );
        % TieRodCamberBlueLength = TieRodCamberWhiteLength * 1/cosd(CAMBER) * sign(CAMBER - TieRodCamberPhi);
        %
        % TieRodToePurpleLength = OutTieRod_Pickup_FOR_AFT*cosd(TOE);
        % TieRodToeRedLength = OutTieRod_Pickup_FOR_AFT*sind(TOE);
        %
        % TieRod2D_Length = sqrt( (Track_Width/2-chassis_width/2+TieRodCamberBlueLength)^2  +  (abs( (Ride_Height + chassis_height/2 - TieRod_Pickup_Dist)  -  (Wheel_radius - TieRod_Pickup_Dist)*(1/cosd(CAMBER))  ))^2     );
        % TieRod_Length = sqrt( (TieRod2D_Length + TieRodToeRedLength)^2 + (TieRodToePurpleLength -TieRod_Pickup_FOR_AFT)^2 ); %- 0.0021; %-TieRodToeRedLength %- 0.0021;
        % TieRod_x_sec = [0 -TieRod_Length/2; 0.75/100 -TieRod_Length/2; 0.75/100 TieRod_Length/2; 0 TieRod_Length/2];

        TieRod_Inboard_Z = chassis_height/2 - TieRod_Pickup_Dist + Ride_Height;
        TieRod_Outboard_Z = (Wheel_radius - OutTieRod_Pickup_Dist)*(1/cosd(CAMBER)) + ( (Wheel_radius - OutTieRod_Pickup_Dist)*tand(CAMBER) - Wheel_width/2 ) * sind(CAMBER);
        TieRod_Delta_Z = TieRod_Inboard_Z - TieRod_Outboard_Z;

        
        TieRod_Inboard_Y = chassis_width/2;
        TieRod_Outboard_Y = Track_Width/2 + ((Wheel_radius - OutTieRod_Pickup_Dist)*tand(CAMBER) - Wheel_width/2) * (cosd(CAMBER)) - OutTieRod_Pickup_FOR_AFT*sind(TOE);
        % TieRod_Outboard_Y_BACK = Track_Width/2 + ((Wheel_radius - OutTieRod_Pickup_Dist)*tand(CAMBER) - Wheel_width/2) * (cosd(CAMBER)) - OutTieRod_Pickup_FOR_AFT*sind(TOE);
        TieRod_Delta_Y = TieRod_Outboard_Y - TieRod_Inboard_Y;

        TieRod_Delta_X = TieRod_Pickup_FOR_AFT - OutTieRod_Pickup_FOR_AFT*cosd(TOE);
        % TieRod_Delta_X_BACK = TieRod_Pickup_FOR_AFT_BACK - OutTieRod_Pickup_FOR_AFT*cosd(TOE);


        % BACKKKKKKKKKKKKKKKKKKKKKKKK


        TieRod_Inboard_Z_BACK = chassis_height/2 - TieRod_Pickup_Dist_BACK + Ride_Height;
        TieRod_Outboard_Z_BACK = (Wheel_radius - OutTieRod_Pickup_Dist_BACK)*(1/cosd(CAMBER)) + ( (Wheel_radius - OutTieRod_Pickup_Dist_BACK)*tand(CAMBER) - Wheel_width/2 ) * sind(CAMBER);
        TieRod_Delta_Z_BACK = TieRod_Inboard_Z_BACK - TieRod_Outboard_Z_BACK;


        TieRod_Inboard_Y_BACK = chassis_width/2;
        TieRod_Outboard_Y_BACK = Track_Width/2 + ((Wheel_radius - OutTieRod_Pickup_Dist_BACK)*tand(CAMBER) - Wheel_width/2) * (cosd(CAMBER)) - OutTieRod_Pickup_FOR_AFT_BACK*sind(TOE);
        TieRod_Delta_Y_BACK = TieRod_Outboard_Y_BACK - TieRod_Inboard_Y_BACK;


        TieRod_Delta_X_BACK = TieRod_Pickup_FOR_AFT_BACK - OutTieRod_Pickup_FOR_AFT_BACK*cosd(TOE);

        

        TieRod_Length = sqrt( (TieRod_Delta_X)^2 + (TieRod_Delta_Y)^2 + (TieRod_Delta_Z)^2 );
        TieRod_x_sec = [0 -TieRod_Length/2; 0.75/100 -TieRod_Length/2; 0.75/100 TieRod_Length/2; 0 TieRod_Length/2];

        TieRod_Length_BACK = sqrt( (TieRod_Delta_X_BACK)^2 + (TieRod_Delta_Y_BACK-chassis_rear_width_addition)^2 + (TieRod_Delta_Z_BACK)^2 );
        TieRod_x_sec_BACK = [0 -TieRod_Length_BACK/2; 0.75/100 -TieRod_Length_BACK/2; 0.75/100 TieRod_Length_BACK/2; 0 TieRod_Length_BACK/2];


        %% PITCH CENTER
        Guideline_Center_Length = 20; %m
        Guideline_x_sec = [0 -Guideline_Center_Length/2; 0.5/100 -Guideline_Center_Length/2; 0.5/100 Guideline_Center_Length/2; 0 Guideline_Center_Length/2];
        Guide_Top_Arm_Dist = sqrt( (Inboard_TopBack_Pickup_AFT + Inboard_TopFront_Pickup_FOR)^2 + (Inboard_TopBack_Pickup_UP - Inboard_TopFront_Pickup_UP)^2 );
        Guide_Top_Arm_Dist_BACK = sqrt( (Inboard_TopBack_Pickup_AFT_BACK + Inboard_TopFront_Pickup_FOR_BACK)^2 + (Inboard_TopBack_Pickup_UP_BACK - Inboard_TopFront_Pickup_UP_BACK)^2 );
        
        Front_Instant_Center = (chassis_height/2 + Inboard_TopFront_Pickup_UP)/tand(Angle_Top_AOA);
        Back_Instant_Center = (chassis_height/2 + Inboard_TopFront_Pickup_UP_BACK)/tand(Angle_Top_AOA_BACK);

        if Front_Instant_Center == inf || Front_Instant_Center == -inf
            Front_Instant_Center = 0;
        end

        if Back_Instant_Center == inf || Back_Instant_Center == -inf
            Back_Instant_Center = 0;
        end
















        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% SUSPENSION GEOMETREY SIMULATION %%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


        if Steering_Mode || Travel_Mode
            out = sim(simIn);
        elseif Pitch_Mode || Roll_Mode
            out = sim(simIn4);

            camberOutputREAR = out.CTCREAR.signals(1).values;
            toeOutputREAR = out.CTCREAR.signals(2).values;
            casterOutputREAR = out.CTCREAR.signals(3).values;

        end


        timeOutput = out.CTC.time;
        camberOutput = out.CTC.signals(1).values;
        toeOutput = out.CTC.signals(2).values;
        casterOutput = out.CTC.signals(3).values;




        if Roll_Mode
            rollOutput = out.CTC.signals(6).values;
            
        elseif Pitch_Mode
            diveOutput = out.CTC.signals(4).values;
            squatOutput = out.CTC.signals(5).values;

        end


        %% STEERING
        % Pi frequency, -pi/4 phase sine wave, time 0.750 -> 2.750
        if Steering_Mode == true
            steering_Time_Index_Start = 76;
            steering_Time_Index_End = 276;

            steering_camber = camberOutput(steering_Time_Index_Start:steering_Time_Index_End);
            steering_toe = toeOutput(steering_Time_Index_Start:steering_Time_Index_End);
            steering_caster = casterOutput(steering_Time_Index_Start:steering_Time_Index_End);
            steering_angle = steering_toe + TOE;

            camberOutputLEFT = out.CTCLEFT.signals(1).values;
            toeOutputLEFT = out.CTCLEFT.signals(2).values;
            casterOutputLEFT = out.CTCLEFT.signals(3).values;

            steering_toeLEFT = toeOutputLEFT(steering_Time_Index_Start:steering_Time_Index_End);


            % Steering_Slope_Data(i,j,1) = Inboard_TopBack_Pickup_UP - TopArms_Starting_Position;
            % Steering_Slope_Data(i,j,2) = Inboard_TopFront_Pickup_UP - TopArms_Starting_Position;
            % Steering_Slope_Data(i,j,3) = (steering_camber(floorDiv(end,2)) - steering_camber(floorDiv(end,2) + 1)) / (steering_angle(floorDiv(end,2)) - steering_angle(floorDiv(end,2) + 1));
            % Steering_Slope_Data(i,j,4) = (steering_caster(floorDiv(end,2)) - steering_caster(floorDiv(end,2) + 1)) / (steering_angle(floorDiv(end,2)) - steering_angle(floorDiv(end,2) + 1));
            % Steering_Slope_Data(i,j,3) = (steering_camber(end) - steering_camber(1)) / (steering_angle(end) - steering_angle(1));
            % Steering_Slope_Data(i,j,4) = (steering_caster(end) - steering_caster(1)) / (steering_angle(end) - steering_angle(1));

            XAxis = (steering_toe+steering_toeLEFT)/2;
            YAxis = steering_toeLEFT-steering_toe;

            hold on
            plot(YAxis, XAxis)
            xlabel("Average Steering Angle")
            ylabel("Outer-Inner")
            xlim([-20 20])
            % ylim([-2 0])


            % 
            % hold on
            % subplot(2,2,1)
            % plot(steering_angle, steering_camber, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
            % xline(0, '--')
            % yline(CAMBER, '--')
            % xlabel("Steering Angle")
            % ylabel("Camber")
            % % hold off
            % 
            % hold on
            % subplot(2,2,2)
            % plot(steering_angle, steering_caster, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
            % xline(0, '--')
            % yline(CASTER, '--')
            % xlabel("Steering Angle")
            % ylabel("Caster")
            % % hold off
        end


        %% SUSPENSION TRAVEL
        % Pi frequency, -3*pi/4 phase sine wave, 0.03m amplitude, time 0.25 -> 1.25
        if Travel_Mode == true
            travel_Time_Index_Start = 26;
            travel_Time_Index_End = 126;

            travel_rideheight = out.CTC.signals(4).values(travel_Time_Index_Start:travel_Time_Index_End) + Ride_Height - 0.002;
            travel_camber = camberOutput(travel_Time_Index_Start:travel_Time_Index_End);
            travel_toe = toeOutput(travel_Time_Index_Start:travel_Time_Index_End);
            travel_caster = casterOutput(travel_Time_Index_Start:travel_Time_Index_End);

            % if Motion_Ratio
            %     travel_piston = out.CTC.signals(5).values(travel_Time_Index_Start:travel_Time_Index_End);
            %     Motion_Ratio_Data = (max(travel_rideheight)-min(travel_rideheight))/(max(travel_piston)-min(travel_piston));
            % end

            

            % (:,:,1) = TopBackArm
            % (:,:,2) = TopFrontArm
            % (:,:,3) = CamberSlope
            % (:,:,4) = CasterSlope
            % (:,:,5) = ToeSlope
            Travel_Slope_Data(i,j,1) = Inboard_TopBack_Pickup_UP - TopArms_Starting_Position;
            Travel_Slope_Data(i,j,2) = Inboard_TopFront_Pickup_UP - TopArms_Starting_Position;
            Travel_Slope_Data(i,j,3) = (travel_camber(end) - travel_camber(1)) / (travel_rideheight(end) - travel_rideheight(1));
            Travel_Slope_Data(i,j,4) = (travel_caster(end) - travel_caster(1)) / (travel_rideheight(end) - travel_rideheight(1));
            Travel_Slope_Data(i,j,5) = (travel_toe(end) - travel_toe(1)) / (travel_rideheight(end) - travel_rideheight(1));






            % Graphing_Colour = ((j-1)*Number_Of_Iterations + i-1)/(Number_Of_Iterations^2);
            % Graphing_Colour = ((i-j)/(Number_Of_Iterations))/2 + 0.5
            % Dive_Index = (i-j)/Number_Of_Iterations;
            %
            %
            %
            % Dive_Percent = Dive_Index/2 + 0.5
            %
            % if Dive_Index < 0 % Red
            %     Graphing_Colour  = -Dive_Index*0.75;
            %     Graphing_Colour2 = 0;
            %     Graphing_Colour3 = 0;
            % elseif Dive_Index > 0 % Purple
            %     Graphing_Colour  = 0;
            %     Graphing_Colour2 = 0;
            %     Graphing_Colour3 = Dive_Index*0.75;
            % else % Blue
            %     Graphing_Colour  = 0;
            %     Graphing_Colour2 = 1;
            %     Graphing_Colour3 = 0;
            % end
            %

            Graphing_Colour  = 0;
            Graphing_Colour2 = 1 - ((j-1)*Number_Of_Iterations + i-1)/(Number_Of_Iterations^2);
            Graphing_Colour3 = ((j-1)*Number_Of_Iterations + i-1)/(Number_Of_Iterations^2);


            hold on
            subplot(3,3,1)
            plot(travel_rideheight, travel_camber, 'Color',[Graphing_Colour, Graphing_Colour2, Graphing_Colour3])
            xline(Ride_Height, '--')
            % yline(CAMBER, '--')
            yline(CAMBER + 0.21, '--')
            % colorbar
            grid on
            xlabel("RideHeight Travel")
            ylabel("Camber")
            % hold off

            hold on
            subplot(3,3,2)
            plot(travel_rideheight, travel_caster, 'Color',[Graphing_Colour, Graphing_Colour2, Graphing_Colour3])
            xline(Ride_Height, '--')
            yline(CASTER, '--')
            grid on
            xlabel("RideHeight Travel")
            ylabel("Caster")
            % hold off

            hold on
            subplot(3,3,3)
            plot(travel_rideheight, travel_toe, 'Color',[Graphing_Colour, Graphing_Colour2, Graphing_Colour3])
            xline(Ride_Height, '--')
            % yline(TOE, '--')
            yline(TOE + 0.35, '--')
            grid on
            xlabel("RideHeight Travel")
            ylabel("Toe")
            % hold off

        end

        %% TODO: GET REAR CAMBER
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%


        %% PITCH
        % Pi frequency, -3*pi/4 phase sine wave, 2000 amplitude, time 2->3

        if Pitch_Mode == true
            pitch_Time_Index_Start = 151;
            pitch_Time_Index_End = 251;

            pitch_camber = camberOutput(pitch_Time_Index_Start:pitch_Time_Index_End);
            pitch_toe = toeOutput(pitch_Time_Index_Start:pitch_Time_Index_End);
            pitch_caster = casterOutput(pitch_Time_Index_Start:pitch_Time_Index_End);
            % pitch_dive = diveOutput(pitch_Time_Index_Start:pitch_Time_Index_End);
            % pitch_squat = squatOutput(pitch_Time_Index_Start:pitch_Time_Index_End);
            pitch_pitch = out.CTC.signals(7).values(pitch_Time_Index_Start:pitch_Time_Index_End);
            pitch_pitch_center_distance = rollCenterOutput(201);

            pitch_camberREAR = camberOutputREAR(pitch_Time_Index_Start:pitch_Time_Index_End);
            pitch_toeREAR = toeOutputREAR(pitch_Time_Index_Start:pitch_Time_Index_End);
            pitch_casterREAR = casterOutputREAR(pitch_Time_Index_Start:pitch_Time_Index_End);


            Pitch_Slope_Data(i,j,1) = Inboard_TopBack_Pickup_UP - TopArms_Starting_Position;
            Pitch_Slope_Data(i,j,2) = Inboard_TopFront_Pickup_UP - TopArms_Starting_Position;
            Pitch_Slope_Data(i,j,3) = (pitch_camber(end) - pitch_camber(1)) / (pitch_pitch(end) - pitch_pitch(1));
            Pitch_Slope_Data(i,j,4) = (pitch_caster(end) - pitch_caster(1)) / (pitch_pitch(end) - pitch_pitch(1));
            Pitch_Slope_Data(i,j,5) = (pitch_toe(end) - pitch_toe(1)) / (pitch_pitch(end) - pitch_pitch(1));
            Pitch_Slope_Data(i,j,3) = (pitch_camberREAR(end) - pitch_camberREAR(1)) / (pitch_pitch(end) - pitch_pitch(1));
            Pitch_Slope_Data(i,j,4) = (pitch_casterREAR(end) - pitch_casterREAR(1)) / (pitch_pitch(end) - pitch_pitch(1));
            Pitch_Slope_Data(i,j,5) = (pitch_toeREAR(end) - pitch_toeREAR(1)) / (pitch_pitch(end) - pitch_pitch(1));

            hold on
            subplot(4,3,1)
            plot(pitch_pitch, pitch_camber, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
            xline(0, '--')
            yline(CAMBER + 0.9, '--')
            grid on
            xlabel("Pitch")
            ylabel("Camber")
            % hold off

            hold on
            subplot(4,3,2)
            plot(pitch_pitch, pitch_caster, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
            xline(0, '--')
            yline(CASTER, '--')
            grid on
            xlabel("Pitch")
            ylabel("Caster")
            % hold off

            hold on
            subplot(4,3,3)
            plot(pitch_pitch, pitch_toe, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
            xline(0, '--')
            yline(TOE - 0.35, '--')
            grid on
            xlabel("Pitch")
            ylabel("Toe")
            % hold off

            hold on
            subplot(4,3,4)
            plot(pitch_pitch, pitch_camberREAR, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
            xline(0, '--')
            yline(CAMBER + 0.9, '--')
            grid on
            xlabel("Pitch")
            ylabel("REAR Camber")
            % hold off

            hold on
            subplot(4,3,5)
            plot(pitch_pitch, pitch_casterREAR, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
            xline(0, '--')
            yline(CASTER, '--')
            grid on
            xlabel("Pitch")
            ylabel("REAR Caster")
            % hold off

            hold on
            subplot(4,3,6)
            plot(pitch_pitch, pitch_toeREAR, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
            xline(0, '--')
            yline(TOE - 0.35, '--')
            grid on
            xlabel("Pitch")
            ylabel("REAR Toe")
            % hold off


            % hold on
            % subplot(2,3,1)
            % plot(pitch_dive, pitch_camber, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
            % xline(Ride_Height, '--')
            % yline(CAMBER, '--')
            % grid on
            % xlabel("Front Rideheight (Dive)")
            % ylabel("Camber")
            % % hold off
            % 
            % hold on
            % subplot(2,3,2)
            % plot(pitch_dive, pitch_caster, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
            % xline(Ride_Height, '--')
            % yline(CASTER, '--')
            % grid on
            % xlabel("Front Rideheight (Dive)")
            % ylabel("Caster")
            % % hold off
            % 
            % hold on
            % subplot(2,3,3)
            % plot(pitch_dive, pitch_toe, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
            % xline(Ride_Height, '--')
            % yline(TOE, '--')
            % grid on
            % xlabel("Front Rideheight (Dive)")
            % ylabel("Toe")
            % % hold off
            % 
            % hold on
            % subplot(2,3,4)
            % plot(pitch_squat, pitch_camber, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
            % xline(Ride_Height, '--')
            % yline(CAMBER, '--')
            % grid on
            % xlabel("Rear Rideheight (Squat)")
            % ylabel("Camber")
            % % hold off
            % 
            % hold on
            % subplot(2,3,5)
            % plot(pitch_squat, pitch_caster, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
            % xline(Ride_Height, '--')
            % yline(CASTER, '--')
            % grid on
            % xlabel("Rear Rideheight (Squat)")
            % ylabel("Caster")
            % % hold off
            % 
            % hold on
            % subplot(2,3,6)
            % plot(pitch_squat, pitch_toe, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
            % xline(Ride_Height, '--')
            % yline(TOE, '--')
            % grid on
            % xlabel("Rear Rideheight (Squat)")
            % ylabel("Toe")
            % % hold off

        end

        %% ROLL
        if Roll_Mode == true
            roll_Time_Index_Start = 151;
            roll_Time_Index_End = 251;


            roll_camber = camberOutput(roll_Time_Index_Start:roll_Time_Index_End);
            roll_toe = toeOutput(roll_Time_Index_Start:roll_Time_Index_End);
            roll_caster = casterOutput(roll_Time_Index_Start:roll_Time_Index_End);
            roll_roll = rollOutput(roll_Time_Index_Start:roll_Time_Index_End); %- 1;
            % rollCenterOutput = out.CTC.signals(8).values;
            % roll_roll_center_distance = out.CTC.signals(8).values(101)

            % Roll_Slope_Data(i,j,1) = Inboard_TopBack_Pickup_UP - TopArms_Starting_Position;
            % Roll_Slope_Data(i,j,2) = Inboard_TopFront_Pickup_UP - TopArms_Starting_Position;
            % Roll_Slope_Data(i,j,3) = (roll_camber(end) - roll_camber(1)) / (roll_roll(end) - roll_roll(1));
            % Roll_Slope_Data(i,j,4) = (roll_caster(end) - roll_caster(1)) / (roll_roll(end) - roll_roll(1));
            % Roll_Slope_Data(i,j,5) = (roll_toe(end) - roll_toe(1)) / (roll_roll(end) - roll_roll(1));
            % Roll_Slope_Data(i,j,6) = roll_roll_center_distance;


            hold on
            subplot(3,3,1)
            plot(roll_roll, roll_camber, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
            xline(0, '--')
            yline(CAMBER + 0.9, '--')
            grid on
            xlabel("Roll")
            ylabel("Camber")
            % hold off

            hold on
            subplot(3,3,2)
            plot(roll_roll, roll_caster, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
            xline(0, '--')
            yline(CASTER, '--')
            grid on
            xlabel("Roll")
            ylabel("Caster")
            % hold off

            hold on
            subplot(3,3,3)
            plot(roll_roll, roll_toe, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
            xline(0, '--')
            yline(TOE - 0.35, '--')
            grid on
            xlabel("Roll")
            ylabel("Toe")
            % hold off

        end

        if Roll_Center == true
            % i=Number_Of_Iterations
            break
            % disp(i)
        end

        if Motion_Ratio
                MR_piston = out.CTC.signals(8).values(221:331);
                MR_rideheight = out.CTC.signals(9).values(221:331) + Ride_Height;
                plot(MR_rideheight, MR_piston)
                Motion_Ratio = (max(MR_rideheight)-min(MR_rideheight))/(max(MR_piston)-min(MR_piston))
        end


    end
% end
% 
% if Travel_Mode
%     % Coordinates
%     subplot(3,3,4)
%     surf(Travel_Slope_Data(:,:,1), Travel_Slope_Data(:,:,2), Travel_Slope_Data(:,:,3))
%     xlabel("Back Arm Position")
%     ylabel("Front Arm Position")
%     zlabel("Slope of Camber vs Rideheight")
% 
%     subplot(3,3,5)
%     surf(Travel_Slope_Data(:,:,1), Travel_Slope_Data(:,:,2), Travel_Slope_Data(:,:,4))
%     xlabel("Back Arm Position")
%     ylabel("Front Arm Position")
%     zlabel("Slope of Caster vs Rideheight")
% 
%     subplot(3,3,6)
%     surf(Travel_Slope_Data(:,:,1), Travel_Slope_Data(:,:,2), Travel_Slope_Data(:,:,5))
%     xlabel("Back Arm Position")
%     ylabel("Front Arm Position")
%     zlabel("Slope of Toe vs Rideheight")
% 
%     Travel_Slope_Data_Height = (Travel_Slope_Data(:,:,1) + Travel_Slope_Data(:,:,2)) ./2;
%     Travel_Slope_Data_Dive = atand((Travel_Slope_Data(:,:,1) + Travel_Slope_Data(:,:,2))/Arms_FOR_AFT_Position);
% 
%     % Height and Dive
%     %% WORK IN PROGRESS
%     subplot(3,3,7)
%     surf(Travel_Slope_Data_Height, Travel_Slope_Data_Dive, Travel_Slope_Data(:,:,3))
%     xlabel("Height of Arms")
%     ylabel("Amount of Anti-Dive (Deg)")
%     zlabel("Slope of Camber vs Rideheight")
%     colormap winter
% 
%     subplot(3,3,8)
%     surf(Travel_Slope_Data_Height, Travel_Slope_Data_Dive, Travel_Slope_Data(:,:,4))
%     xlabel("Height of Arms")
%     ylabel("Amount of Anti-Dive (Deg)")
%     zlabel("Slope of Caster vs Rideheight")
%     colormap winter
% 
%     subplot(3,3,9)
%     surf(Travel_Slope_Data_Height, Travel_Slope_Data_Dive, Travel_Slope_Data(:,:,5))
%     xlabel("Height of Arms")
%     ylabel("Amount of Anti-Dive (Deg)")
%     zlabel("Slope of Toe vs Rideheight")
%     colormap winter
% 
% end
% 
% if Steering_Mode
%     % Coordinates
%     subplot(2,2,3)
%     surf(Steering_Slope_Data(:,:,1), Steering_Slope_Data(:,:,2), Steering_Slope_Data(:,:,3))
%     xlabel("Back Arm Position")
%     ylabel("Front Arm Position")
%     zlabel("Slope of Camber vs Steering Angle")
%     colormap winter
% 
% 
%     subplot(2,2,4)
%     surf(Steering_Slope_Data(:,:,1), Steering_Slope_Data(:,:,2), Steering_Slope_Data(:,:,4))
%     xlabel("Back Arm Position")
%     ylabel("Front Arm Position")
%     zlabel("Slope of Caster vs Steering Angle")
%     colormap winter
% 
% 
% end
% 
% if Pitch_Mode
%     % Coordinates
%     subplot(4,3,7)
%     surf(Pitch_Slope_Data(:,:,1), Pitch_Slope_Data(:,:,2), Pitch_Slope_Data(:,:,3))
%     xlabel("Back Arm Position")
%     ylabel("Front Arm Position")
%     zlabel("Slope of Camber vs Pitch")
%     colormap winter
% 
%     subplot(4,3,8)
%     surf(Pitch_Slope_Data(:,:,1), Pitch_Slope_Data(:,:,2), Pitch_Slope_Data(:,:,4))
%     xlabel("Back Arm Position")
%     ylabel("Front Arm Position")
%     zlabel("Slope of Caster vs Pitch")
%     colormap winter
% 
%     subplot(4,3,9)
%     surf(Pitch_Slope_Data(:,:,1), Pitch_Slope_Data(:,:,2), Pitch_Slope_Data(:,:,5))
%     xlabel("Back Arm Position")
%     ylabel("Front Arm Position")
%     zlabel("Slope of Toe vs Pitch")
%     colormap winter
% 
%     subplot(4,3,10)
%     surf(Pitch_Slope_Data(:,:,1), Pitch_Slope_Data(:,:,2), Pitch_Slope_Data(:,:,6))
%     xlabel("Back Arm Position")
%     ylabel("Front Arm Position")
%     zlabel("Slope of REAR Camber vs Pitch")
%     colormap winter
% 
%     subplot(4,3,11)
%     surf(Pitch_Slope_Data(:,:,1), Pitch_Slope_Data(:,:,2), Pitch_Slope_Data(:,:,7))
%     xlabel("Back Arm Position")
%     ylabel("Front Arm Position")
%     zlabel("Slope of REAR Caster vs Pitch")
%     colormap winter
% 
%     subplot(4,3,12)
%     surf(Pitch_Slope_Data(:,:,1), Pitch_Slope_Data(:,:,2), Pitch_Slope_Data(:,:,8))
%     xlabel("Back Arm Position")
%     ylabel("Front Arm Position")
%     zlabel("Slope of REAR Toe vs Pitch")
%     colormap winter
% 
% end
% 
% if Roll_Mode
%     % Coordinates
%     subplot(3,3,4)
%     surf(Roll_Slope_Data(:,:,1), Roll_Slope_Data(:,:,2), Roll_Slope_Data(:,:,3))
%     xlabel("Back Arm Position")
%     ylabel("Front Arm Position")
%     zlabel("Slope of Camber vs Roll")
%     colormap winter
% 
%     subplot(3,3,5)
%     surf(Roll_Slope_Data(:,:,1), Roll_Slope_Data(:,:,2), Roll_Slope_Data(:,:,4))
%     xlabel("Back Arm Position")
%     ylabel("Front Arm Position")
%     zlabel("Slope of Caster vs Roll")
%     colormap winter
% 
%     subplot(3,3,6)
%     surf(Roll_Slope_Data(:,:,1), Roll_Slope_Data(:,:,2), Roll_Slope_Data(:,:,5))
%     xlabel("Back Arm Position")
%     ylabel("Front Arm Position")
%     zlabel("Slope of Toe vs Roll")
%     colormap winter
% 
%     subplot(3,3,8)
%     surf(Roll_Slope_Data(:,:,1), Roll_Slope_Data(:,:,2), Roll_Slope_Data(:,:,6))
%     xlabel("Back Arm Position")
%     ylabel("Front Arm Position")
%     zlabel("Roll Center Distance vs Roll")
%     colormap winter
% 
% 
% end



%% Chassis Coords

Chassis_Rear_SUS_Center_to_SW_Origin = [1378.62-(1675.93-1571) 279-279 524.32-1000*chassis_height/2];
Chassis_Front_SUS_Center_to_SW_Origin = [-1675.93+1378.62+31 279-279 -1000*chassis_height/2+524.32];
SW_Front_Origin = [266.3100 0 -524.3200];

FRONT_Top_Fore_Inboard = -Chassis_Front_SUS_Center_to_SW_Origin + 1000*InBoard_TopR_PickupCOORD
FRONT_Top_Aft_Inboard = -Chassis_Front_SUS_Center_to_SW_Origin + 1000*InBoard_TopL_PickupCOORD
FRONT_Bot_Fore_Inboard = -Chassis_Front_SUS_Center_to_SW_Origin + 1000*InBoard_BotR_PickupCOORD
FRONT_Bot_Aft_Inboard = -Chassis_Front_SUS_Center_to_SW_Origin + 1000*InBoard_BotL_PickupCOORD


REAR_Top_Fore_Inboard = -Chassis_Rear_SUS_Center_to_SW_Origin + 1000*InBoard_TopR_PickupCOORD_BACK + [0 chassis_rear_width_addition*1000 0]
REAR_Top_Aft_Inboard = -Chassis_Rear_SUS_Center_to_SW_Origin + 1000*InBoard_TopL_PickupCOORD_BACK + [0 chassis_rear_width_addition*1000 0]
REAR_Bot_Fore_Inboard = -Chassis_Rear_SUS_Center_to_SW_Origin + 1000*InBoard_BotR_PickupCOORD_BACK + [0 chassis_rear_width_addition*1000 0]
REAR_Bot_Aft_Inboard = -Chassis_Rear_SUS_Center_to_SW_Origin + 1000*InBoard_BotL_PickupCOORD_BACK + [0 chassis_rear_width_addition*1000 0]

FRONT_Shock = -Chassis_Front_SUS_Center_to_SW_Origin + 1000*CrankL_PickupCOORD





disp(":D")