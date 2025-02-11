FL_list=[];
FR_list=[];
RL_list=[];
RR_list=[];

SA_FL=5;
SA_FR=5;
WhlBase=1;
TrkWdth=1;
CamberFront=1;
TyrePress=83000;
MagicLambda=0.65;
mass=300;
SWDLeft=0.5;
SWDFront=0.5;
COGHeight=0.15;
Torque=-1000;
RollingRad=0.2;

% Forces are positive forward (+x), rightward (+y) and downward (+z)
%
%    Tyre testing convention:
% - Turning left is positive SA for both tyres
% - Positive camber is positive IA for the right tyre
% - Positive camber is negative IA for the left tyre
%
%    Due to assymetric Fy vs SA response, the convention is flipped for
%    the left tyre:
% - Positive camber is positive IA for both tyres
% - Turning left is negative SA for the left tyre
% - Turning left is positive SA for the right tyre (unchanged)
%
% Furthermore, the Ackermann steering block gives positive SA for
% turning right, hence
SA_FR=-SA_FR;
% Fy_FR hence will also need to be reversed

mfparams.UNLOADED_RADIUS=RollingRad; % filling missing data
weight=mass*9.81;
Press=TyrePress;

% Initialisation with static weight distribution
Fz_FL_static=weight*SWDFront*SWDLeft;
Fz_FR_static=weight*SWDFront*(1-SWDLeft);
Fz_RL_static=weight*(1-SWDFront)*SWDLeft;
Fz_RR_static=weight*(1-SWDFront)*(1-SWDLeft);
Fz_FL_new=Fz_FL_static;
Fz_FR_new=Fz_FR_static;
Fz_RL_new=Fz_RL_static;
Fz_RR_new=Fz_RR_static;

% Rear COF
SA=0;
Fz=min(Fz_RL_new,Fz_RR_new);
IA=0;
RearMagic=sim('MagicFormula_matlab');
COFRear=getdatasamples(RearMagic.mu_y,1); % Questionable

% Placeholder values for while loop
Fz_FL_old=2*Fz_FL_new;
Fz_FR_old=2*Fz_FR_new;
Fz_RL_old=2*Fz_RL_new;
Fz_RR_old=2*Fz_RR_new;

% Rolling ignored for now
IA=CamberFront;

epsilon=0.01; % Acceptable error (kind of)
% Iterate while the change between iterations in any corner is larger
% than epsilon
while abs(1-Fz_FL_old/Fz_FL_new)>epsilon || abs(1-Fz_FR_old/Fz_FR_new)>epsilon...
        || abs(1-Fz_RL_old/Fz_RL_new)>epsilon || abs(1-Fz_RR_old/Fz_RR_new)>epsilon

    SA=SA_FL;
    Fz=Fz_FL_new;
    FL=sim('MagicFormula_matlab');
    Fy_FL=-getdatasamples(FL.Fy,1);

    SA=SA_FR;
    Fz=Fz_FR_new;
    FR=sim('MagicFormula_matlab');
    Fy_FR=getdatasamples(FR.Fy,1); % as mentioned needs to be reversed

    if abs(Fy_FL)>abs(Fy_FR)
        Fy=2*Fy_FR;
    else
        Fy=2*Fy_FL;
    end

    ay=Fy/(mass*9.81); % in g's

    Fx_max=min(Fz_RL_new,Fz_RR_new)*COFRear*RollingRad;
    if Torque==0
        Fx=0;
    elseif abs(Torque)<Fx_max
        Fx=2*Torque/RollingRad;
    else
        if Torque<0
            Fx=-2*Fx_max;
        else
            Fx=2*Fx_max;
        end
    end

    ax=Fx/(mass*9.81); % in g's

    LatTrans=weight*ay*COGHeight/TrkWdth;
    LongTrans=weight*ax*COGHeight/WhlBase;

    Fz_FL_old=Fz_FL_new;
    Fz_FR_old=Fz_FR_new;
    Fz_RL_old=Fz_RL_new;
    Fz_RR_old=Fz_RR_new;

    Fz_FL_new=Fz_FL_static+LatTrans-LongTrans;
    FL_list(end+1)=Fz_FL_new;
    Fz_FR_new=Fz_FR_static-LatTrans-LongTrans;
    FR_list(end+1)=Fz_FR_new;
    Fz_RL_new=Fz_RL_static+LatTrans+LongTrans;
    RL_list(end+1)=Fz_RL_new;
    Fz_RR_new=Fz_RR_static-LatTrans+LongTrans;
    RR_list(end+1)=Fz_RR_new;
end

hold on

plot(0:size(FL_list,2),[Fz_FL_static FL_list],'b')
plot(0:size(FL_list,2),[Fz_FR_static FR_list],'r')
plot(0:size(FL_list,2),[Fz_RL_static RL_list],'b--')
plot(0:size(FL_list,2),[Fz_RR_static RR_list],'r--')

Mz_FL=-getdatasamples(FL.Mz,1);
Mz_FR=getdatasamples(FR.Mz,1);

if abs(Mz_FL)>abs(Mz_FR) % Like with Fy and Fx, the smaller Mz is assumed
    Mz=Mz_FR;
else
    Mz=Mz_FL;
end
