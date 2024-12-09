function [Total_Mass_Force] = FzMass(Mass, TrackInclination, TrackBank)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

Total_Mass_Force = (-1* Mass * 9.81 * cosd(TrackInclination) * cosd(TrackBank));

end