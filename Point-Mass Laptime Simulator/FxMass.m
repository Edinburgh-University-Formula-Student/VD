function [Total_Mass_Force] = FxMass(Mass, TrackInclination)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

Total_Mass_Force = (Mass * 9.81 * sin(TrackInclination));

end