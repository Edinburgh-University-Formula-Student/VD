function [Total_Mass_Force] = FyMass(Mass, TrackBank)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

Total_Mass_Force = -1 * Mass * 9.81 * sin(TrackBank);

end