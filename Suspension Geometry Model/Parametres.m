%% University of Edinburgh Formula Student
% Suspension Geometry Simulator
% Paul Wang, Vehicle Dynamics
% Winter 2024

clear
close all
%% GLOBAL SETUP

% You want positive camber for inside wheel, slightly negative for outside
% wheel. Acceleration and braking should be near 0

% Ballpark initial static camber = -1.5

Travel_Mode = false;
Steering_Mode = false;
Pitch_Mode = false;
Roll_Mode = false;

%%%%%%%%%%%%%%%%%%%%%%%
% Steering_Mode = true;
Travel_Mode = true;
% Pitch_Mode = true;
% Roll_Mode = true;
%%%%%%%%%%%%%%%%%%%%%%%

chassis_height = 2*207*1/1000; %m
chassis_length = 1.5; %m
chassis_width = 0.42; %m

Ride_Height = 0.14; %m
Track_Width = 1.575; %m
Front_Wheelbase = 0.55; %m
Rear_Wheelbase = 0.87; %m

Number_Of_Iterations = 1;
Iteration_Step = 0.02; %m


simIn = Simulink.SimulationInput("SGS_3D_1");
simIn4 = Simulink.SimulationInput("SGS_3D_2_4WHEEL");


%% SUSPENSION PICKUP POINT LIMITS
Plane_Pickup_Angle = 7; %6.634449131; % Deg

BottomArms_Dist_Limit = chassis_height/2;
TopArms_Starting_Position = -0.06;
RearTopArms_Starting_Position = -0.08;

chassis_rear_width_addition = 0.065; %m

% for l=1:Number_Of_Iterations
%     for k=1:Number_Of_Iterations
        for j=1:Number_Of_Iterations
            for i=1:Number_Of_Iterations
                disp(string(+j-2) + "/" + string(Number_Of_Iterations^2) + "," + string((i+j-2)/(Number_Of_Iterations^2)))
                % clearvars -except Steering_Mode Travel_Mode Pitch_Mode Roll_Mode Number_Of_Iterations Iteration_Step i
                %% VARIABLES


                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                Inboard_TopBack_Pickup_UP = TopArms_Starting_Position - Iteration_Step * (i-1); %m
                Inboard_TopBack_Pickup_AFT = 0.25 - Iteration_Step; %m
                front_chassis_top_back_offset = tand(Plane_Pickup_Angle) * (chassis_height/2 - abs(Inboard_TopBack_Pickup_UP));

                Inboard_TopFront_Pickup_UP = TopArms_Starting_Position - Iteration_Step * (j-1); %m
                Inboard_TopFront_Pickup_FOR = 0.25 - Iteration_Step; %m
                front_chassis_top_front_offset = tand(Plane_Pickup_Angle) * (chassis_height/2 - abs(Inboard_TopFront_Pickup_UP));

                Inboard_BotBack_Pickup_DOWN = BottomArms_Dist_Limit; %m
                Inboard_BotBack_Pickup_AFT = 0.25; %m

                Inboard_BotFront_Pickup_DOWN = BottomArms_Dist_Limit; %m
                Inboard_BotFront_Pickup_FOR = 0.25; %m

                TieRod_Pickup_Dist = 0.15; %m
                TieRod_Pickup_FOR_AFT = -0.07555; %m Positive for FOR, Negative for AFT
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                Inboard_TopBack_Pickup_UP_BACK = RearTopArms_Starting_Position  - Iteration_Step * i; %m
                Inboard_TopBack_Pickup_AFT_BACK = 0.17; %m

                Inboard_TopFront_Pickup_UP_BACK = RearTopArms_Starting_Position  - Iteration_Step * i; %m
                Inboard_TopFront_Pickup_FOR_BACK = 0.15; %m

                Inboard_BotBack_Pickup_DOWN_BACK = BottomArms_Dist_Limit; %m
                Inboard_BotBack_Pickup_AFT_BACK = 0.17; %m

                Inboard_BotFront_Pickup_DOWN_BACK = BottomArms_Dist_Limit; %m
                Inboard_BotFront_Pickup_FOR_BACK = 0.15; %m

                TieRod_Pickup_Dist_BACK = 0.15; %m
                TieRod_Pickup_FOR_AFT_BACK = -0.07555; %m Positive for FOR, Negative for AFT
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                %[innertop(radius, width), innerbottom(radius, -width), outbottom(radius, -width), outtop(radius, width)]

                % -------------------------


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


                OutTop_Pickup_Dist = 0.06948184943; %m
                OutBot_Pickup_Dist = 0.07778083697; %m

                OutTieRod_Pickup_Dist = 0.02117; %m
                OutTieRod_Pickup_FOR_AFT = -0.07555; %m Positive for FOR, Negative for AFT



                CAMBER = 2; %DEG, Static Camber at ride height
                TOE = -2; %DEG, Static Toe at ride height
                CASTER = 0; %DEG, Static Caster at ride height
                KINGPIN = 0; %DEG, Kingpin with respect to tyre rim
                Scrub_Radius = 0; %m, Scrub radius from steering axis to middle of tyre
                Scrub_Offset = 0; %m, offset from upright to middle of rim, has no effect on KingPin


                Bell_CrankL_Chassis_Desired_Angle = 15; %DEG
                Shock_Pickup_Height = 0.01; %m
                Bell_CrankL_Height = 0.08; %m
                Bell_CrankL_Top_Length = 0.08; %m


                Shock_Pickup_Height_BACK = 0.01; %m
                Bell_CrankL_Pickup_Height_BACK = -0.2; %m


                % if Pitch_Mode || Roll_Mode
                %     Spring_Stiffness = 20000;
                % else
                %     Spring_Stiffness = 20000; %0000/10;
                % end
                % Spring_Stiffness = 20000;
                Spring_Stiffness = 350; %LBS/IN = 61294nm
                Damping_Coefficient = 1000;

















                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %% COMPUTATION & CALCULATION %%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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

                TieRod_PickupCOORD_BACK = [TieRod_Pickup_FOR_AFT, chassis_width/2, -TieRod_Pickup_Dist];
                TieRod_PickupCOORD_RIGHT_BACK = [-TieRod_Pickup_FOR_AFT, chassis_width/2, -TieRod_Pickup_Dist];

                CrankL_PickupCOORD = [0, chassis_width/2, chassis_height/2];
                ShockL_PickupCOORD = [0, 0, chassis_height/2 + Shock_Pickup_Height];

                CrankL_PickupCOORD_BACK = [0, chassis_width/2, chassis_height/2 + Bell_CrankL_Pickup_Height_BACK];
                ShockL_PickupCOORD_BACK = [0, 0, chassis_height/2 + Shock_Pickup_Height_BACK + Bell_CrankL_Pickup_Height_BACK];


                %% PISTON NEUTRAL POSITION
                BlueLineLength = sqrt(Shock_Pickup_Height^2 + (chassis_width/2)^2);
                AngleBetweenBlueAndWhiteLine = Bell_CrankL_Chassis_Desired_Angle + atand((0.5*chassis_width)/Shock_Pickup_Height);
                PurpleLineLength = sqrt(  (BlueLineLength^2) + (Bell_CrankL_Height^2) - 2*BlueLineLength*Bell_CrankL_Height*cosd(AngleBetweenBlueAndWhiteLine) );
                PistonL_Neutral_Displacement = PurpleLineLength - (Piston_Length);

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
                BottomCamberPurpleLength = sqrt( (Wheel_radius - OutBot_Pickup_Dist)^2 + (0.5*Wheel_width)^2 );
                BottomCamberRedLength = (Wheel_radius - OutBot_Pickup_Dist)/cosd(CAMBER);
                BottomCamberPhi = atand((0.5*Wheel_width)/(Wheel_radius - OutBot_Pickup_Dist));
                BottomCamberBeta = abs(CAMBER - BottomCamberPhi);
                BottomCamberWhiteLength = sqrt( (BottomCamberPurpleLength)^2 + (BottomCamberRedLength)^2 - 2*BottomCamberPurpleLength*BottomCamberRedLength*cosd(BottomCamberBeta));
                BottomCamberBlueLength = BottomCamberWhiteLength * cosd(CAMBER) * sign(CAMBER - BottomCamberPhi);
                BottomCamberGreenLength = BottomCamberWhiteLength * sind(CAMBER) * sign(CAMBER - BottomCamberPhi);

                % LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL %
                Bot_Length = sqrt( (Track_Width/2-chassis_width/2+BottomCamberBlueLength+OutBot_KingPin_Offset)^2  +  (abs( (Ride_Height + chassis_height/2 - Inboard_BotBack_Pickup_DOWN)  -  (Wheel_radius - OutBot_Pickup_Dist + BottomCamberGreenLength)  ))^2     );
                BotL_Length = sqrt( (Inboard_BotBack_Pickup_AFT - OutBot_Pickup_FOR_AFT)^2 + (Bot_Length)^2 );
                [BotL_Arm] = Extr_Data_LinkHoles(BotL_Length, Arm_W, ArmHole_R, Arm_Num_Holes);

                % BBBBBBBB
                % BottomCamberPurpleLength_BACK = sqrt( (Wheel_radius - OutBot_Pickup_Dist)^2 + (0.5*Wheel_width)^2 );
                % BottomCamberRedLength_BACK = (Wheel_radius - OutBot_Pickup_Dist)/cosd(CAMBER);
                % BottomCamberPhi_BACK = atand((0.5*Wheel_width)/(Wheel_radius - OutBot_Pickup_Dist));
                % BottomCamberBeta_BACK = abs(CAMBER - BottomCamberPhi_BACK);
                % BottomCamberWhiteLength_BACK = sqrt( (BottomCamberPurpleLength_BACK)^2 + (BottomCamberRedLength_BACK)^2 - 2*BottomCamberPurpleLength_BACK*BottomCamberRedLength_BACK*cosd(BottomCamberBeta_BACK));
                % BottomCamberBlueLength_BACK = BottomCamberWhiteLength_BACK * cosd(CAMBER) * sign(CAMBER - BottomCamberPhi_BACK);
                % BottomCamberGreenLength_BACK = BottomCamberWhiteLength_BACK * sind(CAMBER) * sign(CAMBER - BottomCamberPhi_BACK);
                BotL2D_Length_BACK = sqrt( (Track_Width/2-chassis_rear_width_addition-chassis_width/2+BottomCamberBlueLength+OutBot_KingPin_Offset)^2  +  (abs( (Ride_Height + chassis_height/2 - Inboard_BotBack_Pickup_DOWN_BACK)  -  (Wheel_radius - OutBot_Pickup_Dist + BottomCamberGreenLength)  ))^2     );
                BotR2D_Length_BACK = sqrt( (Track_Width/2-chassis_rear_width_addition-chassis_width/2+BottomCamberBlueLength+OutBot_KingPin_Offset)^2  +  (abs( (Ride_Height + chassis_height/2 - Inboard_BotFront_Pickup_DOWN_BACK)  -  (Wheel_radius - OutBot_Pickup_Dist + BottomCamberGreenLength)  ))^2     );
                BotL_Length_BACK = sqrt( (Inboard_BotBack_Pickup_AFT_BACK - OutBot_Pickup_FOR_AFT)^2 + (BotL2D_Length_BACK)^2 );
                [BotL_Arm_BACK] = Extr_Data_LinkHoles(BotL_Length_BACK, Arm_W, ArmHole_R, Arm_Num_Holes);

                % RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR %
                BotR_Length = sqrt( (Inboard_BotFront_Pickup_FOR + OutBot_Pickup_FOR_AFT)^2 + (Bot_Length)^2 );
                [BotR_Arm] = Extr_Data_LinkHoles(BotR_Length, Arm_W, ArmHole_R, Arm_Num_Holes);

                % BBBBBBBB
                BotR_Length_BACK = sqrt( (Inboard_BotFront_Pickup_FOR_BACK + OutBot_Pickup_FOR_AFT)^2 + (BotR2D_Length_BACK)^2 );
                [BotR_Arm_BACK] = Extr_Data_LinkHoles(BotR_Length_BACK, Arm_W, ArmHole_R, Arm_Num_Holes);

                Angle_LeftBot_Internal = atand((Inboard_BotBack_Pickup_AFT + OutBot_Pickup_FOR_AFT)/Bot_Length);
                Angle_RightBot_Internal = atand((Inboard_BotFront_Pickup_FOR + OutBot_Pickup_FOR_AFT)/Bot_Length);
                Angle_Bot_AOA = atand( (Inboard_BotBack_Pickup_DOWN-Inboard_BotFront_Pickup_DOWN)/(Inboard_BotFront_Pickup_FOR+Inboard_BotBack_Pickup_AFT) );
                Angle_Between_Bot_Arms = Angle_LeftBot_Internal + Angle_RightBot_Internal;

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                TopCamberPurpleLength = sqrt( (Wheel_radius + OutTop_Pickup_Dist)^2 + (0.5*Wheel_width)^2 );
                TopCamberRedLength = (Wheel_radius + OutTop_Pickup_Dist)/cosd(CAMBER);
                TopCamberPhi = atand((0.5*Wheel_width)/(Wheel_radius + OutTop_Pickup_Dist));
                TopCamberBeta = abs(CAMBER - TopCamberPhi);
                TopCamberWhiteLength = sqrt( (TopCamberPurpleLength)^2 + (TopCamberRedLength)^2 - 2*TopCamberPurpleLength*TopCamberRedLength*cosd(TopCamberBeta));
                TopCamberBlueLength = TopCamberWhiteLength * cosd(CAMBER) * sign(CAMBER - TopCamberPhi);
                TopCamberGreenLength = TopCamberWhiteLength * sind(CAMBER) * sign(CAMBER - TopCamberPhi);

                % LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL %
                TopL2D_Length = sqrt( (Track_Width/2-chassis_width/2-front_chassis_top_back_offset+TopCamberBlueLength+OutTop_KingPin_Offset)^2  +  (abs( (Ride_Height + chassis_height/2 + Inboard_TopBack_Pickup_UP)  -  (Wheel_radius + OutTop_Pickup_Dist + TopCamberGreenLength )  ))^2     );
                TopR2D_Length = sqrt( (Track_Width/2-chassis_width/2-front_chassis_top_front_offset+TopCamberBlueLength+OutTop_KingPin_Offset)^2  +  (abs( (Ride_Height + chassis_height/2 + Inboard_TopBack_Pickup_UP)  -  (Wheel_radius + OutTop_Pickup_Dist + TopCamberGreenLength )  ))^2     );
                TopL2D_Length_BACK = sqrt( (Track_Width/2-chassis_rear_width_addition-chassis_width/2+TopCamberBlueLength+OutTop_KingPin_Offset)^2  +  (abs( (Ride_Height + chassis_height/2 + Inboard_TopBack_Pickup_UP_BACK)  -  (Wheel_radius + OutTop_Pickup_Dist + TopCamberGreenLength )  ))^2     );
                TopR2D_Length_BACK = sqrt( (Track_Width/2-chassis_rear_width_addition-chassis_width/2+TopCamberBlueLength+OutTop_KingPin_Offset)^2  +  (abs( (Ride_Height + chassis_height/2 + Inboard_TopFront_Pickup_UP_BACK)  -  (Wheel_radius + OutTop_Pickup_Dist + TopCamberGreenLength )  ))^2     );


                TopL_Length = sqrt( (Inboard_TopBack_Pickup_AFT - OutTop_Pickup_FOR_AFT)^2 + (TopL2D_Length)^2 );
                [TopL_Arm] = Extr_Data_LinkHoles(TopL_Length, Arm_W, ArmHole_R, Arm_Num_Holes);

                % BBBBBBBB
                TopL_Length_BACK = sqrt( (Inboard_TopBack_Pickup_AFT_BACK - OutTop_Pickup_FOR_AFT)^2 + (TopL2D_Length_BACK)^2 );
                [TopL_Arm_BACK] = Extr_Data_LinkHoles(TopL_Length_BACK, Arm_W, ArmHole_R, Arm_Num_Holes);

                % RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR %
                TopR_Length = sqrt( (Inboard_TopFront_Pickup_FOR + OutTop_Pickup_FOR_AFT)^2 + (TopR2D_Length)^2 ); %- 0.016;
                [TopR_Arm] = Extr_Data_LinkHoles(TopR_Length, Arm_W, ArmHole_R, Arm_Num_Holes);

                % BBBBBBBB
                TopR_Length_BACK = sqrt( (Inboard_TopFront_Pickup_FOR_BACK + OutTop_Pickup_FOR_AFT)^2 + (TopR2D_Length_BACK)^2 ); %- 0.016;
                [TopR_Arm_BACK] = Extr_Data_LinkHoles(TopR_Length_BACK, Arm_W, ArmHole_R, Arm_Num_Holes);

                Angle_LeftTop_Internal = atand((Inboard_TopBack_Pickup_AFT + OutTop_Pickup_FOR_AFT)/TopL2D_Length);
                Angle_RightTop_Internal = atand((Inboard_TopFront_Pickup_FOR + OutTop_Pickup_FOR_AFT)/TopR2D_Length);
                Angle_Top_AOA = atand( (Inboard_TopBack_Pickup_UP-Inboard_TopFront_Pickup_UP)/(Inboard_TopFront_Pickup_FOR+Inboard_TopBack_Pickup_AFT) );
                Angle_Between_Top_Arms = Angle_LeftTop_Internal + Angle_RightTop_Internal;




                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                %% PUSHROD LENGTH
                PurpleAlpha = 90 - Bell_CrankL_Chassis_Desired_Angle - 2*Bell_CrankL_Internal_Angle; %DEG
                PurpleLinePushRod = sqrt(Bell_CrankL_Height^2 + (Bell_CrankL_Top_Length/2)^2); %m
                TealLinePushRod = PurpleLinePushRod * sind(PurpleAlpha);
                YellowLinePushRod = PurpleLinePushRod * cosd(PurpleAlpha);
                BrownLinePushRod = Track_Width/2 - chassis_width/2 - YellowLinePushRod + BottomCamberBlueLength + OutBot_KingPin_Offset;
                DashedPuplePushRod = Ride_Height - ((Wheel_radius - OutBot_Pickup_Dist)*(1/cosd(CAMBER)));
                PushRod__2D_Length = sqrt( (chassis_height + TealLinePushRod + DashedPuplePushRod)^2 + (BrownLinePushRod)^2 );

                BrownLinePushRod_BACK = Track_Width/2-chassis_rear_width_addition- chassis_width/2 - YellowLinePushRod + BottomCamberBlueLength + OutBot_KingPin_Offset;
                PushRod__2D_Length_BACK = sqrt( (chassis_height + Bell_CrankL_Pickup_Height_BACK + TealLinePushRod + DashedPuplePushRod)^2 + (BrownLinePushRod_BACK)^2 );

                PushRod_Length = sqrt( (PushRod__2D_Length)^2 + (OutBot_Pickup_FOR_AFT)^2 );
                PushRod_x_sec = [0 -PushRod_Length/2; 0.75/100 -PushRod_Length/2; 0.75/100 PushRod_Length/2; 0 PushRod_Length/2];

                PushRod_Length_BACK = sqrt( (PushRod__2D_Length_BACK)^2 + (OutBot_Pickup_FOR_AFT)^2 );
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
                TieRod_Inboard_Z_BACK = chassis_height/2 - TieRod_Pickup_Dist_BACK + Ride_Height;
                TieRod_Outboard_Z = (Wheel_radius - OutTieRod_Pickup_Dist)*(1/cosd(CAMBER)) + ( (Wheel_radius - OutTieRod_Pickup_Dist)*tand(CAMBER) - Wheel_width/2 ) * sind(CAMBER);
                TieRod_Delta_Z = TieRod_Inboard_Z - TieRod_Outboard_Z;
                TieRod_Delta_Z_BACK = TieRod_Inboard_Z_BACK - TieRod_Outboard_Z;

                % TieRod_Delta_Z = OutTieRod_Pickup_Dist


                TieRod_Inboard_Y = chassis_width/2;
                TieRod_Outboard_Y = Track_Width/2 + ((Wheel_radius - OutTieRod_Pickup_Dist)*tand(CAMBER) - Wheel_width/2) * (cosd(CAMBER)) - OutTieRod_Pickup_FOR_AFT*sind(TOE);
                TieRod_Delta_Y = TieRod_Outboard_Y - TieRod_Inboard_Y;

                TieRod_Delta_X = TieRod_Pickup_FOR_AFT - OutTieRod_Pickup_FOR_AFT*cosd(TOE);
                TieRod_Delta_X_BACK = TieRod_Pickup_FOR_AFT_BACK - OutTieRod_Pickup_FOR_AFT*cosd(TOE);

                TieRod_Length = sqrt( (TieRod_Delta_X)^2 + (TieRod_Delta_Y)^2 + (TieRod_Delta_Z)^2 );
                TieRod_x_sec = [0 -TieRod_Length/2; 0.75/100 -TieRod_Length/2; 0.75/100 TieRod_Length/2; 0 TieRod_Length/2];

                TieRod_Length_BACK = sqrt( (TieRod_Delta_X_BACK)^2 + (TieRod_Delta_Y-chassis_rear_width_addition)^2 + (TieRod_Delta_Z_BACK)^2 );
                TieRod_x_sec_BACK = [0 -TieRod_Length_BACK/2; 0.75/100 -TieRod_Length_BACK/2; 0.75/100 TieRod_Length_BACK/2; 0 TieRod_Length_BACK/2];



















                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %% SUSPENSION GEOMETREY SIMULATION %%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



                % if Steering_Mode || Travel_Mode
                %     simIn = Simulink.SimulationInput("SGS_3D_1"); %create object
                % else
                %     simIn = Simulink.SimulationInput("SGS_3D_1_4WHEEL"); %create object
                % end
                % set_param(bdroot, 'SimulationCommand', 'Update')
                % out = sim(simIn); %run simulation, all results returned in "out"


                if Steering_Mode || Travel_Mode
                    out = sim(simIn);
                else
                    out = sim(simIn4);
                end


                timeOutput = out.CTC.time;
                camberOutput = out.CTC.signals(1).values;
                toeOutput = out.CTC.signals(2).values;
                casterOutput = out.CTC.signals(3).values;


                if Pitch_Mode || Roll_Mode
                    diveOutput = out.CTC.signals(4).values;
                    squatOutput = out.CTC.signals(5).values;
                end


                %% TODO: FIX TOE SENSORS
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%





                %% STEERING
                % Pi frequency, -pi/4 phase sine wave, time 0.750 -> 2.750
                if Steering_Mode == true
                    steering_Time_Index_Start = 76;
                    steering_Time_Index_End = 276;

                    steering_camber = camberOutput(steering_Time_Index_Start:steering_Time_Index_End);
                    steering_toe = toeOutput(steering_Time_Index_Start:steering_Time_Index_End);
                    steering_caster = casterOutput(steering_Time_Index_Start:steering_Time_Index_End);
                    steering_angle = steering_toe - steering_toe(1);



                    hold on
                    subplot(1,2,1)
                    plot(steering_angle, steering_camber, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
                    xline(0, '--')
                    yline(CAMBER, '--')
                    xlabel("Steering Angle")
                    ylabel("Camber")
                    % hold off

                    hold on
                    subplot(1,2,2)
                    plot(steering_angle, steering_caster, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
                    xline(0, '--')
                    yline(CASTER, '--')
                    xlabel("Steering Angle")
                    ylabel("Caster")
                    % hold off
                end


                %% SUSPENSION TRAVEL
                % Pi frequency, -3*pi/4 phase sine wave, 0.03m amplitude, time 0.25 -> 1.25
                if Travel_Mode == true
                    travel_Time_Index_Start = 26;
                    travel_Time_Index_End = 126;

                    travel_rideheight = out.CTC.signals(4).values(travel_Time_Index_Start:travel_Time_Index_End) + Ride_Height;
                    travel_camber = camberOutput(travel_Time_Index_Start:travel_Time_Index_End);
                    travel_toe = toeOutput(travel_Time_Index_Start:travel_Time_Index_End);
                    travel_caster = casterOutput(travel_Time_Index_Start:travel_Time_Index_End);

                    hold on
                    subplot(1,3,1)
                    plot(travel_rideheight, travel_camber, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
                    xline(Ride_Height, '--')
                    yline(CAMBER, '--')
                    grid on
                    xlabel("RideHeight Travel")
                    ylabel("Camber")
                    % hold off

                    hold on
                    subplot(1,3,2)
                    plot(travel_rideheight, travel_caster, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
                    xline(Ride_Height, '--')
                    yline(CASTER, '--')
                    grid on
                    xlabel("RideHeight Travel")
                    ylabel("Caster")
                    % hold off
   
                    hold on
                    subplot(1,3,3)
                    plot(travel_rideheight, travel_toe, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
                    xline(Ride_Height, '--')
                    yline(TOE, '--')
                    grid on
                    xlabel("RideHeight Travel")
                    ylabel("Toe")
                    % hold off

                end

                %% TODO: GET REAR CAMBER VS REAR RIDEHEIGHT
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%


                %% PITCH
                % Pi frequency, -3*pi/4 phase sine wave, 2000 amplitude, time 3.25 -> 5.25

                if Pitch_Mode == true
                    pitch_Time_Index_Start = 326;
                    pitch_Time_Index_End = 526;


                    pitch_camber = camberOutput(pitch_Time_Index_Start:pitch_Time_Index_End);
                    pitch_toe = toeOutput(pitch_Time_Index_Start:pitch_Time_Index_End);
                    pitch_caster = casterOutput(pitch_Time_Index_Start:pitch_Time_Index_End);
                    pitch_dive = diveOutput(pitch_Time_Index_Start:pitch_Time_Index_End);
                    pitch_squat = squatOutput(pitch_Time_Index_Start:pitch_Time_Index_End);

                    hold on
                    subplot(2,3,1)
                    plot(pitch_dive, pitch_camber, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
                    xline(Ride_Height, '--')
                    yline(CAMBER, '--')
                    grid on
                    xlabel("Front Rideheight (Dive)")
                    ylabel("Camber")
                    % hold off

                    hold on
                    subplot(2,3,2)
                    plot(pitch_dive, pitch_caster, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
                    xline(Ride_Height, '--')
                    yline(CASTER, '--')
                    grid on
                    xlabel("Front Rideheight (Dive)")
                    ylabel("Caster")
                    % hold off

                    hold on
                    subplot(2,3,3)
                    plot(pitch_dive, pitch_toe, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
                    xline(Ride_Height, '--')
                    yline(TOE, '--')
                    grid on
                    xlabel("Front Rideheight (Dive)")
                    ylabel("Toe")
                    % hold off

                    hold on
                    subplot(2,3,4)
                    plot(pitch_squat, pitch_camber, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
                    xline(Ride_Height, '--')
                    yline(CAMBER, '--')
                    grid on
                    xlabel("Rear Rideheight (Squat)")
                    ylabel("Camber")
                    % hold off

                    hold on
                    subplot(2,3,5)
                    plot(pitch_squat, pitch_caster, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
                    xline(Ride_Height, '--')
                    yline(CASTER, '--')
                    grid on
                    xlabel("Rear Rideheight (Squat)")
                    ylabel("Caster")
                    % hold off

                    hold on
                    subplot(2,3,6)
                    plot(pitch_squat, pitch_toe, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
                    xline(Ride_Height, '--')
                    yline(TOE, '--')
                    grid on
                    xlabel("Rear Rideheight (Squat)")
                    ylabel("Toe")
                    % hold off

                end

                %% ROLL
                if Roll_Mode == true
                    roll_Time_Index_Start = 326;
                    roll_Time_Index_End = 526;


                    roll_camber = camberOutput(roll_Time_Index_Start:roll_Time_Index_End);
                    roll_toe = toeOutput(roll_Time_Index_Start:roll_Time_Index_End);
                    roll_caster = casterOutput(roll_Time_Index_Start:roll_Time_Index_End);
                    roll_dive = diveOutput(roll_Time_Index_Start:roll_Time_Index_End);
                    roll_squat = squatOutput(roll_Time_Index_Start:roll_Time_Index_End);

                    hold on
                    subplot(2,3,1)
                    plot(roll_dive, roll_camber, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
                    xline(Ride_Height, '--')
                    yline(CAMBER, '--')
                    grid on
                    xlabel("Front Rideheight (Dive)")
                    ylabel("Camber")
                    % hold off

                    hold on
                    subplot(2,3,2)
                    plot(roll_dive, roll_caster, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
                    xline(Ride_Height, '--')
                    yline(CASTER, '--')
                    grid on
                    xlabel("Front Rideheight (Dive)")
                    ylabel("Caster")
                    % hold off

                    hold on
                    subplot(2,3,3)
                    plot(roll_dive, roll_toe, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
                    xline(Ride_Height, '--')
                    yline(TOE, '--')
                    grid on
                    xlabel("Front Rideheight (Dive)")
                    ylabel("Toe")
                    % hold off

                    hold on
                    subplot(2,3,4)
                    plot(roll_squat, roll_camber, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
                    xline(Ride_Height, '--')
                    yline(CAMBER, '--')
                    grid on
                    xlabel("Rear Rideheight (Squat)")
                    ylabel("Camber")
                    % hold off

                    hold on
                    subplot(2,3,5)
                    plot(roll_squat, roll_caster, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
                    xline(Ride_Height, '--')
                    yline(CASTER, '--')
                    grid on
                    xlabel("Rear Rideheight (Squat)")
                    ylabel("Caster")
                    % hold off

                    hold on
                    subplot(2,3,6)
                    plot(roll_squat, roll_toe, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
                    xline(Ride_Height, '--')
                    yline(TOE, '--')
                    grid on
                    xlabel("Rear Rideheight (Squat)")
                    ylabel("Toe")
                    % hold off

                end


            end
        end
%     end
% end

disp(":D")