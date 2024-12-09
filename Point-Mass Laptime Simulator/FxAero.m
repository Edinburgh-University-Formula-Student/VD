function [Total_Aero_Force] = FxAero(AirDensity, CrossSectionalArea, CoefDrag, Velocity)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

Total_Aero_Force = (0.5 * AirDensity * CrossSectionalArea * CoefDrag * Velocity^2);

end