%% University of Edinburgh Formula Student
% Weight Transfer & Jacking Forces
% Paul Wang, Vehicle Dynamics
% Fall 2025

clear
%% GLOBAL PARAMETRES


%% CAR PARAMETRES

options = detectImportOptions("Car_Parametres_CONCEPT_SISU26E.xlsx");
options = setvartype(options, "Value", 'char');  %or 'char' if you prefer
CarParamTable = readtable("Car_Parametres_CONCEPT_SISU26E.xlsx", options); 
CarParamTable.Properties.RowNames=CarParamTable.Item;
Variable_Names = string(CarParamTable.Item);
CarParamTable(:,{'Item'}) = [];

for i=1:length(Variable_Names)
    if CarParamTable(Variable_Names(i),:).Unit == "mm"
        Variable_Value = str2double(CarParamTable(Variable_Names(i),:).Value)/1000;
    else
        Variable_Value = str2double(CarParamTable(Variable_Names(i),:).Value);
    end
    assignin('base', Variable_Names(i), Variable_Value)
end
% clear i Variable_Names Variable_Value options

Car_Name = string(CarParamTable({'Car_Name'},:).Other);
COG_Reference_Origin_to_Solidworks_Origin = str2num(string(CarParamTable({'COG_Reference_Origin_to_Solidworks_Origin'},:).Value));
COG_Reference_Origin_to_Solidworks_Origin = COG_Reference_Origin_to_Solidworks_Origin .* [-1 1 1];
CoG_File_Name = string(CarParamTable({'CoG_File_Name'},:).Other);
Tyre_x_sec = [0.127000254000508,0.095250190500381;0.127000254000508,-0.095250190500381;0.203200406400813,-0.095250190500381;0.203200406400813,0.095250190500381];

%% COG PARAMETRES

COGtable = readtable(CoG_File_Name);
COGtable.Properties.RowNames=COGtable.Name;
% COGtable(:,{'Name'}) = [];

