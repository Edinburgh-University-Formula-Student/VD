function [Total_Aero_Force] = FzAero(AirDensity, CrossSectionalArea, CoefLift, Velocity)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

Total_Aero_Force = (0.5 * AirDensity * CrossSectionalArea * CoefLift * Velocity^2);

end