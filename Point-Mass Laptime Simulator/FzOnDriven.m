function [Force_On_Driven_Tyres] = FzOnDriven(FzMass, FzAero, Driven_wheels)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

Force_On_Driven_Tyres = (FzMass + FzAero)/Driven_wheels; % AWD settings


end