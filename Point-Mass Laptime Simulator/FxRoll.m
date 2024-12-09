function [Total_Rolling_Force] = FxRoll(CoefRoll,FzTotal)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

Total_Rolling_Force = CoefRoll * abs(FzTotal);

end