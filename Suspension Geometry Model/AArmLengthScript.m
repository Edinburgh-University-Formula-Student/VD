clear
chassis_height = 0.3; %m
chassis_length = 0.6; %m
chassis_width = 0.3; %m
Wheel_radius = 0.25; %m
Wheel_width = 0.1; %m

Ride_Height = 0.15; %m RIDE HEIGHT
Track_Width = 1.5; %m Track Width, in total, from contact patch to contact patch

InTopL_Pickup_Dist = 0.1; %m Distance of the inboard pickup from middle of the chassis upward (always positive)
InTopL_Pickup_AFT = 0.1; %m Distance of the inboard pickup from middle of the chassis aftward (always positive)

InTopR_Pickup_Dist = 0.1; %m Distance of the inboard pickup from middle of the chassis upward (always positive)
InTopR_Pickup_FOR = 0.1; %m Distance of the inboard pickup from middle of the chassis forward (always positive)

InBotL_Pickup_Dist = 0.1; %m Distance of the inboard pickup from middle of the chassis downward (always positive)
InBotL_Pickup_AFT = 0.1; %m Distance of the inboard pickup from middle of the chassis aftward (always positive)

InBotR_Pickup_Dist = 0.1; %m Distance of the inboard pickup from middle of the chassis downward (always positive)
InBotR_Pickup_FOR = 0.1; %m Distance of the inboard pickup from middle of the chassis forward (always positive)

OutTopL_Pickup_Dist = 0.075; %m Distance of the outboard pickup from middle of the wheel upward (always positive)
OutBotL_Pickup_Dist = 0.075; %m Distance of the outboard pickup from middle of the wheel downward (always positive)


CAMBER = -2; %DEG

%---------------------------------------------------------------------------------------------

BottomCamberPurpleLength = sqrt( (Wheel_radius - OutBotL_Pickup_Dist)^2 + (0.5*Wheel_width)^2 );
BottomCamberRedLength = (Wheel_radius - OutBotL_Pickup_Dist)/cosd(CAMBER);
BottomCamberPhi = atand((0.5*Wheel_width)/(Wheel_radius - OutBotL_Pickup_Dist));
BottomCamberBeta = abs(CAMBER - BottomCamberPhi);
BottomCamberWhiteLength = sqrt( (BottomCamberPurpleLength)^2 + (BottomCamberRedLength)^2 - 2*BottomCamberPurpleLength*BottomCamberRedLength*cosd(BottomCamberBeta));
BottomCamberBlueLength = BottomCamberWhiteLength * cosd(CAMBER) * sign(CAMBER - BottomCamberPhi);



Bot_Length = sqrt( (Track_Width/2-chassis_width/2+BottomCamberBlueLength)^2  +  (abs( (Ride_Height + chassis_height/2 - InBotL_Pickup_Dist)  -  (Wheel_radius - OutBotL_Pickup_Dist)*(1/cosd(CAMBER))  ))^2     );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BotL_Length = sqrt( (InBotL_Pickup_AFT)^2 + (Bot_Length)^2 ) % Length of the Bottom Back A Arm
BotR_Length = sqrt( (InBotR_Pickup_FOR)^2 + (Bot_Length)^2 ) % Length of the Bottom Front A Arm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


TopCamberPurpleLength = sqrt( (Wheel_radius + OutTopL_Pickup_Dist)^2 + (0.5*Wheel_width)^2 );
TopCamberRedLength = (Wheel_radius + OutTopL_Pickup_Dist)/cosd(CAMBER);
TopCamberPhi = atand((0.5*Wheel_width)/(Wheel_radius + OutTopL_Pickup_Dist));
TopCamberBeta = abs(CAMBER - TopCamberPhi);
TopCamberWhiteLength = sqrt( (TopCamberPurpleLength)^2 + (TopCamberRedLength)^2 - 2*TopCamberPurpleLength*TopCamberRedLength*cosd(TopCamberBeta));
TopCamberBlueLength = TopCamberWhiteLength * cosd(CAMBER) * sign(CAMBER - TopCamberPhi);


Top_Length = sqrt( (Track_Width/2-chassis_width/2+TopCamberBlueLength)^2  +  (abs( (Ride_Height + chassis_height/2 + InTopL_Pickup_Dist)  -  (Wheel_radius + OutTopL_Pickup_Dist)*(1/cosd(CAMBER))  ))^2     );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TopL_Length = sqrt( (InTopL_Pickup_AFT)^2 + (Top_Length)^2 ) % Length of the Top Back A Arm
TopR_Length = sqrt( (InTopR_Pickup_FOR)^2 + (Top_Length)^2 ) % Length of the Top Front A Arm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
