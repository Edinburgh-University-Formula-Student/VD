%% University of Edinburgh Formula Student
% Suspension Geometry Simulator
% Paul Wang, Vehicle Dynamics
% Winter 2024

clear
close all
%% GLOBAL SETUP

% Steering_Mode = true;
Steering_Mode = false;

Travel_Mode = true;
% Travel_Mode = false;

% Pitch_Mode = true;
Pitch_Mode = false;

% Roll_Mode = true;
Roll_Mode = false;

chassis_height = 2*207*1/1000; %m
chassis_length = 1.5; %m
chassis_width = 0.4; %m

Number_Of_Iterations = 1;
Iteration_Step = 0.01; %m



%% SUSPENSION PICKUP POINT LIMITS
Plane_Pickup_Angle = 6.634449131; % Deg

BottomArms_Dist_Limit = chassis_height/2;
TopArms_Starting_Posiion = -0.06;




for i=1:Number_Of_Iterations
    % clearvars -except Steering_Mode Travel_Mode Pitch_Mode Roll_Mode Number_Of_Iterations Iteration_Step i
    %% VARIABLES


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Inboard_TopBack_Pickup_UP = TopArms_Starting_Posiion; %m
    Inboard_TopBack_Pickup_AFT = 0.25; %m

    Inboard_TopFront_Pickup_UP = TopArms_Starting_Posiion; %m
    Inboard_TopFront_Pickup_FOR = 0.25; %m

    Inboard_BotBack_Pickup_DOWN = BottomArms_Dist_Limit; %m
    Inboard_BotBack_Pickup_AFT = 0.25; %m

    Inboard_BotFront_Pickup_DOWN = BottomArms_Dist_Limit; %m
    Inboard_BotFront_Pickup_FOR = 0.25; %m

    TieRod_Pickup_Dist = 0.15; %m
    TieRod_Pickup_FOR_AFT = -0.07555; %m Positive for FOR, Negative for AFT
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %[innertop(radius, width), innerbottom(radius, -width), outbottom(radius, -width), outtop(radius, width)]

    % -------------------------
    Ride_Height = 0.14; %m
    Track_Width = 1.575; %m
    Front_Wheelbase = 0.55; %m 
    Rear_Wheelbase = 0.7; %m

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



    CAMBER = -2; %DEG, Static Camber at ride height
    TOE = -2; %DEG, Static Toe at ride height
    CASTER = 0; %DEG, Static Caster at ride height
    KINGPIN = 0; %DEG, Kingpin with respect to tyre rim
    Scrub_Radius = 0; %m, Scrub radius from steering axis to middle of tyre
    Scrub_Offset = 0; %m, offset from upright to middle of rim, has no effect on KingPin


    Bell_CrankL_Chassis_Desired_Angle = 0; %DEG
    Shock_Pickup_Height = 0.02; %m
    Bell_CrankL_Height = 0.08; %m
    Bell_CrankL_Top_Length = 0.08; %m

    if Pitch_Mode || Roll_Mode
        Spring_Stiffness = 200000;
    else
        Spring_Stiffness = 20000; %0000/10;
    end
    Damping_Coefficient = 10000;

















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


    %% ROAD PARAMETRES
    % Kw = -1e6; %proportional gain
    % Dw = -1e5; %derivative gain



    %% PICKUP POINTS
    InBoard_TopL_PickupCOORD = [-Inboard_TopBack_Pickup_AFT, chassis_width/2, Inboard_TopBack_Pickup_UP];
    InBoard_BotL_PickupCOORD = [-Inboard_BotBack_Pickup_AFT, chassis_width/2, -Inboard_BotBack_Pickup_DOWN];
    InBoard_TopR_PickupCOORD = [Inboard_TopFront_Pickup_FOR, chassis_width/2, Inboard_TopFront_Pickup_UP];
    InBoard_BotR_PickupCOORD = [Inboard_BotFront_Pickup_FOR, chassis_width/2, -Inboard_BotFront_Pickup_DOWN];

    InBoard_TopL_PickupCOORD_RIGHT = [Inboard_TopBack_Pickup_AFT, chassis_width/2, Inboard_TopBack_Pickup_UP];
    InBoard_BotL_PickupCOORD_RIGHT = [Inboard_BotBack_Pickup_AFT, chassis_width/2, -Inboard_BotBack_Pickup_DOWN];
    InBoard_TopR_PickupCOORD_RIGHT = [-Inboard_TopFront_Pickup_FOR, chassis_width/2, Inboard_TopFront_Pickup_UP];
    InBoard_BotR_PickupCOORD_RIGHT = [-Inboard_BotFront_Pickup_FOR, chassis_width/2, -Inboard_BotFront_Pickup_DOWN];

    TieRod_PickupCOORD = [TieRod_Pickup_FOR_AFT, chassis_width/2, -TieRod_Pickup_Dist];
    TieRod_PickupCOORD_RIGHT = [-TieRod_Pickup_FOR_AFT, chassis_width/2, -TieRod_Pickup_Dist];

    CrankL_PickupCOORD = [0, chassis_width/2, chassis_height/2];
    ShockL_PickupCOORD = [0, 0, chassis_height/2 + Shock_Pickup_Height];


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
    % BotL_Length = sqrt( (Track_Width/2-chassis_width/2+BottomCamberBlueLength+OutBot_KingPin_Offset)^2  + (Inboard_BotBack_Pickup_AFT - OutBot_Pickup_FOR_AFT)^2 +  ( (Ride_Height + chassis_height/2 - Inboard_BotBack_Pickup_UP)  -  (Wheel_radius - OutBot_Pickup_Dist)*(1/cosd(CAMBER))  )^2)
    % BotL_Length = BotL_Length/cosd(CAMBER)
    [BotL_Arm] = Extr_Data_LinkHoles(BotL_Length, Arm_W, ArmHole_R, Arm_Num_Holes);

    % RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR %
    BotR_Length = sqrt( (Inboard_BotFront_Pickup_FOR + OutBot_Pickup_FOR_AFT)^2 + (Bot_Length)^2 );
    % BotL_Length = sqrt( (Track_Width/2-chassis_width/2+BottomCamberBlueLength+OutBot_KingPin_Offset)^2  + (Inboard_BotFront_Pickup_FOR - OutBot_Pickup_FOR_AFT)^2 +  ( (Ride_Height + chassis_height/2 - Inboard_BotFront_Pickup_DOWN)  -  (Wheel_radius - OutBot_Pickup_Dist)*(1/cosd(CAMBER))  )^2)
    % BotR_Length = BotR_Length/cosd(CAMBER)
    [BotR_Arm] = Extr_Data_LinkHoles(BotR_Length, Arm_W, ArmHole_R, Arm_Num_Holes);

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
    Top_Length = sqrt( (Track_Width/2-chassis_width/2+TopCamberBlueLength+OutTop_KingPin_Offset)^2  +  (abs( (Ride_Height + chassis_height/2 + Inboard_TopBack_Pickup_UP)  -  (Wheel_radius + OutTop_Pickup_Dist + TopCamberGreenLength )  ))^2     );
    TopL_Length = sqrt( (Inboard_TopBack_Pickup_AFT - OutTop_Pickup_FOR_AFT)^2 + (Top_Length)^2 );
    % TopL_Length = TopL_Length/cosd(CAMBER)
    [TopL_Arm] = Extr_Data_LinkHoles(TopL_Length, Arm_W, ArmHole_R, Arm_Num_Holes);

    % RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR %
    TopR_Length = sqrt( (Inboard_TopFront_Pickup_FOR + OutTop_Pickup_FOR_AFT)^2 + (Top_Length)^2 ); %- 0.016;
    % TopR_Length = TopR_Length/cosd(CAMBER)
    [TopR_Arm] = Extr_Data_LinkHoles(TopR_Length, Arm_W, ArmHole_R, Arm_Num_Holes);


    Angle_LeftTop_Internal = atand((Inboard_TopBack_Pickup_AFT + OutTop_Pickup_FOR_AFT)/Top_Length);
    Angle_RightTop_Internal = atand((Inboard_TopFront_Pickup_FOR + OutTop_Pickup_FOR_AFT)/Top_Length);
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
    PushRod_Length = sqrt( (PushRod__2D_Length)^2 + (OutBot_Pickup_FOR_AFT)^2 );
    PushRod_x_sec = [0 -PushRod_Length/2; 0.75/100 -PushRod_Length/2; 0.75/100 PushRod_Length/2; 0 PushRod_Length/2];


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
    % TieRod_Delta_Z = OutTieRod_Pickup_Dist
    

    TieRod_Inboard_Y = chassis_width/2;
    TieRod_Outboard_Y = Track_Width/2 + ((Wheel_radius - OutTieRod_Pickup_Dist)*tand(CAMBER) - Wheel_width/2) * (cosd(CAMBER)) - OutTieRod_Pickup_FOR_AFT*sind(TOE);
    TieRod_Delta_Y = TieRod_Outboard_Y - TieRod_Inboard_Y;

    TieRod_Delta_X = TieRod_Pickup_FOR_AFT - OutTieRod_Pickup_FOR_AFT*cosd(TOE);

    TieRod_Length = sqrt( (TieRod_Delta_X)^2 + (TieRod_Delta_Y)^2 + (TieRod_Delta_Z)^2 );
    % TieRod_Length = TieRod_Delta_Y
    TieRod_x_sec = [0 -TieRod_Length/2; 0.75/100 -TieRod_Length/2; 0.75/100 TieRod_Length/2; 0 TieRod_Length/2];



















    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% SUSPENSION GEOMETREY SIMULATION %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



    if Steering_Mode || Travel_Mode
        simIn = Simulink.SimulationInput("SGS_3D_1"); %create object
    else
        simIn = Simulink.SimulationInput("SGS_3D_1_4WHEEL"); %create object
    end
    set_param(bdroot, 'SimulationCommand', 'Update')
    out = sim(simIn); %run simulation, all results returned in "out"


    camberOutput = out.CTC.signals(1).values;
    toeOutput = out.CTC.signals(2).values;
    casterOutput = out.CTC.signals(3).values;
    % diveOutput = out.CTC.signals(4).values;
    % squatOutput = out.CTC.signals(5).values;
    % timeOutput = out.tout;




    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% FIX TIME INDEXING: IT'S THE REASON WHY SOME LINES ARE STUBBY
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %% STEERING
    % Pi frequency, -pi/4 phase sine wave
    if Steering_Mode == true

        steering_camber = camberOutput(136:469);
        steering_toe = toeOutput(136:469);
        steering_caster = casterOutput(136:469);
        steering_toe = steering_toe - steering_toe(1);



        hold on
        subplot(1,2,1)
        plot(steering_toe, steering_camber, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
        xlabel("Steering Angle")
        ylabel("Camber")
        % hold off

        hold on
        subplot(1,2,2)
        plot(steering_toe, steering_caster, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
        xlabel("Steering Angle")
        ylabel("Caster")
        % hold off
    end


    %% SUSPENSION TRAVEL
    % Pi frequency, -3*pi/4 phase sine wave, 0.03m amplitude, time 0.25 -> 1.25
    if Travel_Mode == true

        travel_rideheight = out.CTC.signals(4).values(116:289) + Ride_Height;
        travel_camber = camberOutput(116:289);
        travel_toe = toeOutput(116:289);
        travel_caster = casterOutput(116:289);

        hold on
        subplot(1,3,1)
        plot(travel_rideheight, travel_camber, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
        grid on
        xlabel("RideHeight Travel")
        ylabel("Camber")
        % hold off

        hold on
        subplot(1,3,2)
        plot(travel_rideheight, travel_caster, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
        grid on
        xlabel("RideHeight Travel")
        ylabel("Caster")
        % hold off

        hold on
        subplot(1,3,3)
        plot(travel_rideheight, travel_toe, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
        grid on
        xlabel("RideHeight Travel")
        ylabel("Toe")
        % hold off

    end

    % TopR_Length

    %% ROLL AND PITCH
    % Pi frequency, -3*pi/4 phase sine wave, 2000 amplitude, time 0.25 -> 1.25

    % if Pitch_Mode
    %     pitch_camber = camberOutput %(136:469);
    %     pitch_toe = toeOutput %(136:469);
    %     pitch_caster = casterOutput %(136:469);
    %     pitch_dive = diveOutput
    %     pitch_squat = squatOutput
    %
    %     hold on
    %     subplot(1,3,1)
    %     plot(travel_rideheight, travel_camber, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
    %     grid on
    %     xlabel("RideHeight Travel")
    %     ylabel("Camber")
    %     % hold off
    %
    %     hold on
    %     subplot(1,3,2)
    %     plot(travel_rideheight, travel_caster, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
    %     grid on
    %     xlabel("RideHeight Travel")
    %     ylabel("Caster")
    %     % hold off
    %
    %     hold on
    %     subplot(1,3,3)
    %     plot(travel_rideheight, travel_toe, 'Color',[0 1-(i/Number_Of_Iterations) (i/Number_Of_Iterations)])
    %     grid on
    %     xlabel("RideHeight Travel")
    %     ylabel("Toe")
    %     % hold off
    %
    % end
    %
    % if Roll_Mode
    %
    % end


end

