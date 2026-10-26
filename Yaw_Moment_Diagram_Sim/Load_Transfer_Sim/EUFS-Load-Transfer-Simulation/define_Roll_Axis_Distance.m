function h_2 = fcn(z_RF,z_RR,a_s,h_s,l)

% z_RF = Front roll centre height
% z_RR = Rear roll centre height

frontRoll = [0 z_RF];
rearRoll = [l z_RR];
sprungCentre = [a_s h_s];

NRA = rearRoll - frontRoll;
NRA_Perp = [-(z_RR-z_RF) l]*(1/sqrt((z_RR-z_RF)^2+l^2));

FrontR_to_SprungC = sprungCentre - frontRoll;
h_2 = dot(FrontR_to_SprungC,NRA_Perp);

end
