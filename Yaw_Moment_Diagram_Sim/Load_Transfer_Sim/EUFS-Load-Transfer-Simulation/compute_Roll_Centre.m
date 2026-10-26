function roll_Centre_Z = compute_Roll_Centre(OUTTopYLeft,OUTTopZLeft,OUTBotYLeft,OUTBotZLeft, ...
    INTopYLeft,INTopZLeft,INBotYLeft,INBotZLeft,OUTTopYRight,OUTTopZRight,OUTBotYRight,OUTBotZRight, ...
    INTopYRight,INTopZRight,INBotYRight,INBotZRight,contactPatchYLeft,contactPatchZLeft,contactPatchYRight, ...
    contactPatchZRight)
% Input coordinates should be relative to an origin at the FRONT LEFT TYRE
% CONTACT PATCH
% If coordinates area relative to vehicle centre of gravity, coordinate
%transforms must first be done

%%%%%%%%%%%%%%%%%%%%%%%%%% LEFT INSTANT CENTRE %%%%%%%%%%%%%%%%%%%%%%%%%%%%
OUTTopLeft = [OUTTopYLeft OUTTopZLeft];
OUTBotLeft = [OUTBotYLeft OUTBotZLeft];
INTopLeft = [INTopYLeft INTopZLeft];
INBotLeft = [INBotYLeft INBotZLeft];
gradient_Top_Left = (INTopLeft(2) - OUTTopLeft(2))/(INTopLeft(1)-OUTTopLeft(1));
gradient_Bot_Left = (INBotLeft(2) - OUTBotLeft(2))/(INBotLeft(1)-OUTBotLeft(1));
inst_Centre_Y_Left = (gradient_Top_Left*OUTTopLeft(1)-gradient_Bot_Left*OUTBotLeft(1)+OUTBotLeft(2)- ...
                 OUTTopLeft(2))/(gradient_Top_Left-gradient_Bot_Left);
inst_Centre_Z_Left = gradient_Top_Left*(inst_Centre_Y_Left-OUTTopLeft(1))+OUTTopLeft(2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% RIGHT INSTANT CENTRE %%%%%%%%%%%%%%%%%%%%%%%%%%%
OUTTopRight = [OUTTopYRight OUTTopZRight];
OUTBotRight = [OUTBotYRight OUTBotZRight];
INTopRight = [INTopYRight INTopZRight];
INBotRight = [INBotYRight INBotZRight];
gradient_Top_Right = (INTopRight(2) - OUTTopRight(2))/(INTopRight(1)-OUTTopRight(1));
gradient_Bot_Right = (INBotRight(2) - OUTBotRight(2))/(INBotRight(1)-OUTBotRight(1));
inst_Centre_Y_Right = (gradient_Top_Right*OUTTopRight(1)-gradient_Bot_Right*OUTBotRight(1)+OUTBotRight(2)- ...
                 OUTTopRight(2))/(gradient_Top_Right-gradient_Bot_Right);
inst_Centre_Z_Right = gradient_Top_Right*(inst_Centre_Y_Right-OUTTopRight(1))+OUTTopRight(2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%% ROLL CENTRE CALCULATION %%%%%%%%%%%%%%%%%%%%%%%%
inst_Centre_Right = [inst_Centre_Y_Right inst_Centre_Z_Right];
inst_Centre_Left = [inst_Centre_Y_Left inst_Centre_Z_Left];
contact_Patch_Left = [contactPatchYLeft contactPatchZLeft];
contact_Patch_Right = [contactPatchYRight contactPatchZRight];
slope_CP_to_IC_Left = (inst_Centre_Left(2) - contact_Patch_Left(2))/(inst_Centre_Left(1)-contact_Patch_Left(1));
slope_CP_to_IC_Right = (inst_Centre_Right(2) - contact_Patch_Right(2))/(inst_Centre_Right(1)-contact_Patch_Right(1));
roll_Centre_Y = (slope_CP_to_IC_Right*inst_Centre_Right(1)-slope_CP_to_IC_Left*inst_Centre_Left(1)+inst_Centre_Left(2)- ...
                 inst_Centre_Right(2))/(slope_CP_to_IC_Right-slope_CP_to_IC_Left);
roll_Centre_Z = slope_CP_to_IC_Right*(roll_Centre_Y-inst_Centre_Right(1)) + inst_Centre_Right(2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end