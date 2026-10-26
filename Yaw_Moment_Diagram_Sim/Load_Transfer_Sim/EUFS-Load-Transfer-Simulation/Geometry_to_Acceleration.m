function [Lateral_Acceleration, Longitudinal_Acceleration] = Geometry_to_Acceleration(Front_Spring_Stiffness,Rear_Spring_Stiffness,...
    Front_Motion_Ratio,Rear_Motion_Ratio,Tyre_Rate,Track_Width,Wheelbase,Sprung_Weight,Sprung_Centre_Perpendicular_NRA,...
    Sprung_Mass_Centre,roll_angle,pitch_angle)

    %%%%%%%%%%%%%%%%%%%% ROLL STIFFNESS CALCULATIONS %%%%%%%%%%%%%%%%%%%%%%
    Front_Roll_Rate = (Front_Spring_Stiffness*Front_Motion_Ratio^2*Track_Width^2*Tyre_Rate)/(2*(Front_Spring_Stiffness*Front_Motion_Ratio^2+Tyre_Rate)); %Nm/rad
    Rear_Roll_Rate  = (Rear_Spring_Stiffness*Rear_Motion_Ratio^2*Track_Width^2*Tyre_Rate)/(2*(Rear_Spring_Stiffness*Rear_Motion_Ratio^2+Tyre_Rate)); %Nm/rad

    Vehicle_Roll_Sensitivity_rad = (Sprung_Weight*Sprung_Centre_Perpendicular_NRA)/(Front_Roll_Rate + Rear_Roll_Rate); %rad/g
    Vehicle_Roll_Sensitivity_deg = Vehicle_Roll_Sensitivity_rad*(180/pi); %deg/g

    %%%%%%%%%%%%%%%%%%%%% PITCH STIFFNESS CALCULATIONS %%%%%%%%%%%%%%%%%%%%
    Vehicle_Pitch_Stiffness = (Sprung_Mass_Centre(1)^2*Front_Spring_Stiffness*Front_Motion_Ratio^2*Tyre_Rate)/...
        (2*(Front_Spring_Stiffness*Front_Motion_Ratio^2+Tyre_Rate)) + ...
        ((Wheelbase - Sprung_Mass_Centre(1))^2*Rear_Spring_Stiffness*Rear_Motion_Ratio^2*Tyre_Rate)/...
        (2*(Rear_Spring_Stiffness*Rear_Motion_Ratio^2+Tyre_Rate));

    Vehicle_Pitch_Sensitivity_rad = Sprung_Weight*Sprung_Mass_Centre(3)/Vehicle_Pitch_Stiffness; % rad/g
    Vehicle_Pitch_Sensitivity_deg = Vehicle_Pitch_Sensitivity_rad*180/pi; % deg/g

    Lateral_Acceleration = roll_angle./Vehicle_Roll_Sensitivity_deg; % g's
    Longitudinal_Acceleration = pitch_angle./Vehicle_Pitch_Sensitivity_deg; % g's

end