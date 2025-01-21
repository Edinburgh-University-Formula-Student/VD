clear
chassis_height = 0.3; %m
chassis_length = 1.6; %m
chassis_width = 0.3; %m


Arm_W = 0.025; %m
ArmHole_R = 0.01; %m
Arm_Num_Holes = 2;

% plot(A_Arm(:,1), A_Arm(:,2))

Wheel_radius = 0.25; %m
Wheel_width = 0.175; %m




Bell_CrankL_Height = 0.1; %m
Bell_CrankL_Top_Length = 0.08; %m 
Bell_CrankL = [0, 0; Bell_CrankL_Top_Length/2, Bell_CrankL_Height; -Bell_CrankL_Top_Length/2, Bell_CrankL_Height;];
Bell_CrankL_Internal_Angle = atand((0.5*Bell_CrankL_Top_Length)/Bell_CrankL_Height);

Inboard_Pickup_Height = chassis_height/2+Bell_CrankL_Height; %m
Cylinder_Length = 0.1; %m
Piston_Length = 0.1; %m

Spring_Stiffness = 2000000/10;
% Damping_Coefficient = 100000;
% Spring_Stiffness = 100000;
Damping_Coefficient = 10000;

cyl_x_sec = [0 -Cylinder_Length/2; 1.5/100 -Cylinder_Length/2; 1.5/100 Cylinder_Length/2; 0.75/100 Cylinder_Length/2; 0.75/100 -(Cylinder_Length-0.25)/2; 0 -(Cylinder_Length-0.25)/2];
piston_x_sec = [0 -Piston_Length/2; 0.75/100 -Piston_Length/2; 0.75/100 Piston_Length/2; 0 Piston_Length/2];


%% ROAD PARAMETRES
Kw = -1e6; %proportional gain
Dw = -1e5; %derivative gain



%% PICKUP POINTS
InTopL_Pickup_Dist = 0.1; %m
InTopL_Pickup_AFT = 0.14; %m

InTopR_Pickup_Dist = 0.1; %m
InTopR_Pickup_FOR = 0.1; %m

InBotL_Pickup_Dist = 0.1; %m
InBotL_Pickup_AFT = 0.1; %m

InBotR_Pickup_Dist = 0.1; %m
InBotR_Pickup_FOR = 0.15; %m

TieRod_Pickup_Dist = 0.06; %m
TieRod_Pickup_FOR_AFT = -0.095; %m Positive for FOR, Negative for AFT

ShockL_Pickup_Height = 0.09; %m




InBoard_TopL_PickupCOORD = [-InTopL_Pickup_AFT, chassis_width/2, InTopL_Pickup_Dist];
InBoard_BotL_PickupCOORD = [-InBotL_Pickup_AFT, chassis_width/2, -InBotL_Pickup_Dist];
InBoard_TopR_PickupCOORD = [InTopR_Pickup_FOR, chassis_width/2, InTopR_Pickup_Dist];
InBoard_BotR_PickupCOORD = [InBotR_Pickup_FOR, chassis_width/2, -InBotR_Pickup_Dist];

InBoard_TopL_PickupCOORD_RIGHT = [InTopL_Pickup_AFT, chassis_width/2, InTopL_Pickup_Dist];
InBoard_BotL_PickupCOORD_RIGHT = [InBotL_Pickup_AFT, chassis_width/2, -InBotL_Pickup_Dist];
InBoard_TopR_PickupCOORD_RIGHT = [-InTopR_Pickup_FOR, chassis_width/2, InTopR_Pickup_Dist];
InBoard_BotR_PickupCOORD_RIGHT = [-InBotR_Pickup_FOR, chassis_width/2, -InBotR_Pickup_Dist];

TieRod_PickupCOORD = [TieRod_Pickup_FOR_AFT, chassis_width/2, -TieRod_Pickup_Dist];
TieRod_PickupCOORD_RIGHT = [-TieRod_Pickup_FOR_AFT, chassis_width/2, -TieRod_Pickup_Dist];

CrankL_PickupCOORD = [0, chassis_width/2, chassis_height/2];
ShockL_PickupCOORD = [0, 0, chassis_height/2 + ShockL_Pickup_Height];



%% PISTON NEUTRAL POSITION
Bell_CrankL_Chassis_Desired_Angle = 20; %DEG

BlueLineLength = sqrt(ShockL_Pickup_Height^2 + (chassis_width/2)^2);
AngleBetweenBlueAndWhiteLine = Bell_CrankL_Chassis_Desired_Angle + atand((0.5*chassis_width)/ShockL_Pickup_Height);
PurpleLineLength = sqrt(  (BlueLineLength^2) + (Bell_CrankL_Height^2) - 2*BlueLineLength*Bell_CrankL_Height*cosd(AngleBetweenBlueAndWhiteLine) );
PistonL_Neutral_Displacement = PurpleLineLength - (Piston_Length);

%% RIDE HEIGHT
Ride_Height = 0.15; %m
Track_Width = 1.45; %m
Front_Wheelbase = 0.5; %m
Rear_Wheelbase = 0.5; %m


OutTopL_Pickup_Dist = 0.075; %m
OutBotL_Pickup_Dist = 0.075; %m

OutTieRod_Pickup_Dist = 0.03; %m
OutTieRod_Pickup_FOR_AFT = -0.095; %m Positive for FOR, Negative for AFT

OutTopR_Pickup_Dist = OutTopL_Pickup_Dist; %m
OutBotR_Pickup_Dist = OutBotL_Pickup_Dist; %m








%% CAMBER
CAMBER = -2; %DEG

BottomCamberPurpleLength = sqrt( (Wheel_radius - OutBotL_Pickup_Dist)^2 + (0.5*Wheel_width)^2 );
BottomCamberRedLength = (Wheel_radius - OutBotL_Pickup_Dist)/cosd(CAMBER);
BottomCamberPhi = atand((0.5*Wheel_width)/(Wheel_radius - OutBotL_Pickup_Dist));
BottomCamberBeta = abs(CAMBER - BottomCamberPhi);
BottomCamberWhiteLength = sqrt( (BottomCamberPurpleLength)^2 + (BottomCamberRedLength)^2 - 2*BottomCamberPurpleLength*BottomCamberRedLength*cosd(BottomCamberBeta));
BottomCamberBlueLength = BottomCamberWhiteLength * cosd(CAMBER) * sign(CAMBER - BottomCamberPhi);



Bot_Length = sqrt( (Track_Width/2-chassis_width/2+BottomCamberBlueLength)^2  +  (abs( (Ride_Height + chassis_height/2 - InBotL_Pickup_Dist)  -  (Wheel_radius - OutBotL_Pickup_Dist)*(1/cosd(CAMBER))  ))^2     );
BotL_Length = sqrt( (InBotL_Pickup_AFT)^2 + (Bot_Length)^2 );
[BotL_Arm] = Extr_Data_LinkHoles(BotL_Length, Arm_W, ArmHole_R, Arm_Num_Holes);

% ------------------------------------------------


BotR_Length = sqrt( (InBotR_Pickup_FOR)^2 + (Bot_Length)^2 );
[BotR_Arm] = Extr_Data_LinkHoles(BotR_Length, Arm_W, ArmHole_R, Arm_Num_Holes);

Angle_LeftBot_Internal = atand(InBotL_Pickup_AFT/Bot_Length);
Angle_RightBot_Internal = atand(InBotR_Pickup_FOR/Bot_Length);
Angle_Bot_AOA = atand( (InBotL_Pickup_Dist-InBotR_Pickup_Dist)/(InBotR_Pickup_FOR+InBotL_Pickup_AFT) );

Angle_Between_Bot_Arms = Angle_LeftBot_Internal + Angle_RightBot_Internal;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

TopCamberPurpleLength = sqrt( (Wheel_radius + OutTopL_Pickup_Dist)^2 + (0.5*Wheel_width)^2 );
TopCamberRedLength = (Wheel_radius + OutTopL_Pickup_Dist)/cosd(CAMBER);
TopCamberPhi = atand((0.5*Wheel_width)/(Wheel_radius + OutTopL_Pickup_Dist));
TopCamberBeta = abs(CAMBER - TopCamberPhi);
TopCamberWhiteLength = sqrt( (TopCamberPurpleLength)^2 + (TopCamberRedLength)^2 - 2*TopCamberPurpleLength*TopCamberRedLength*cosd(TopCamberBeta));
TopCamberBlueLength = TopCamberWhiteLength * cosd(CAMBER) * sign(CAMBER - TopCamberPhi);


Top_Length = sqrt( (Track_Width/2-chassis_width/2+TopCamberBlueLength)^2  +  (abs( (Ride_Height + chassis_height/2 + InTopL_Pickup_Dist)  -  (Wheel_radius + OutTopL_Pickup_Dist)*(1/cosd(CAMBER))  ))^2     );
TopL_Length = sqrt( (InTopL_Pickup_AFT)^2 + (Top_Length)^2 );
[TopL_Arm] = Extr_Data_LinkHoles(TopL_Length, Arm_W, ArmHole_R, Arm_Num_Holes);

% --------------------------------------------------


TopR_Length = sqrt( (InTopR_Pickup_FOR)^2 + (Top_Length)^2 );
[TopR_Arm] = Extr_Data_LinkHoles(TopR_Length, Arm_W, ArmHole_R, Arm_Num_Holes);

Angle_LeftTop_Internal = atand(InTopL_Pickup_AFT/Top_Length);
Angle_RightTop_Internal = atand(InTopR_Pickup_FOR/Top_Length);
Angle_Top_AOA = atand( (InTopL_Pickup_Dist-InTopR_Pickup_Dist)/(InTopR_Pickup_FOR+InTopL_Pickup_AFT) );

Angle_Between_Top_Arms = Angle_LeftTop_Internal + Angle_RightTop_Internal;



%% PUSHROD LENGTH
PurpleAlpha = 90 - Bell_CrankL_Chassis_Desired_Angle - 2*Bell_CrankL_Internal_Angle; %DEG
PurpleLinePushRod = sqrt(Bell_CrankL_Height^2 + (Bell_CrankL_Top_Length/2)^2); %m
TealLinePushRod = PurpleLinePushRod * sind(PurpleAlpha);
YellowLinePushRod = PurpleLinePushRod * cosd(PurpleAlpha);
BrownLinePushRod = Track_Width/2 - chassis_width/2 - YellowLinePushRod + BottomCamberBlueLength;
DashedPuplePushRod = Ride_Height - ((Wheel_radius - OutBotL_Pickup_Dist)*(1/cosd(CAMBER)));
PushRod_Length = sqrt( (chassis_height + TealLinePushRod + DashedPuplePushRod)^2 + (BrownLinePushRod)^2 );
PushRod_x_sec = [0 -PushRod_Length/2; 0.75/100 -PushRod_Length/2; 0.75/100 PushRod_Length/2; 0 PushRod_Length/2];


%% TIEROD LENGTH
TieRodCamberPurpleLength = sqrt( (Wheel_radius - OutTieRod_Pickup_Dist)^2 + (0.5*Wheel_width)^2 );
TieRodCamberRedLength = (Wheel_radius - OutTieRod_Pickup_Dist)/cosd(CAMBER);
TieRodCamberPhi = atand((0.5*Wheel_width)/(Wheel_radius - OutTieRod_Pickup_Dist));
TieRodCamberBeta = abs(CAMBER - TieRodCamberPhi);
TieRodCamberWhiteLength = sqrt( (TieRodCamberPurpleLength)^2 + (TieRodCamberRedLength)^2 - 2*TieRodCamberPurpleLength*TieRodCamberRedLength*cosd(TieRodCamberBeta));
TieRodCamberBlueLength = TieRodCamberWhiteLength * cosd(CAMBER) * sign(CAMBER - TieRodCamberPhi);

TieRod2D_Length = sqrt( (Track_Width/2-chassis_width/2+TieRodCamberBlueLength)^2  +  (abs( (Ride_Height + chassis_height/2 - TieRod_Pickup_Dist)  -  (Wheel_radius - TieRod_Pickup_Dist)*(1/cosd(CAMBER))  ))^2     );
TieRod_Length = sqrt( (OutTieRod_Pickup_FOR_AFT-TieRod_Pickup_FOR_AFT)^2 + (TieRod2D_Length)^2 );
TieRod_x_sec = [0 -TieRod_Length/2; 0.75/100 -TieRod_Length/2; 0.75/100 TieRod_Length/2; 0 TieRod_Length/2];
