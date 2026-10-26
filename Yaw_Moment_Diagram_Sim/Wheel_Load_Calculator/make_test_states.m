%% MAKE_TEST_STATES
% Generates synthetic "SGS output" timeseries (as if exported from Simulink),
% then transforms them into the `states` struct array that the sweep loop consumes.
%
% The two halves are deliberately separate:
%   PART 1 - fake timeseries  (throw this away once the real SGS works)
%   PART 2 - timeseries -> struct   (KEEP THIS - reuse on real SGS data)

addpath("C:\FS\EUFS Internship\MATLAB Programs\Yaw_Moment_Diagram_Program\EUFS-Load-Transfer-Simulation");
savepath;

%% ------------------------------------------------------------------
%  PART 1: SYNTHETIC SGS TIMESERIES  (replace with real Simulink export)
%  ------------------------------------------------------------------
%  The SGS sweeps the car through roll and pitch. Each "sample" k is one
%  articulated state of the suspension.

N = 100;                                  % number of samples in the sweep

% --- Roll and pitch sweeps (degrees) ---
roll_angles  = linspace(-6, 6, N)';      % deg, chassis roll
%pitch_angles = linspace(-1.2,1.2,N)';               % deg, zero for the pure-lateral first build
pitch_angles = zeros(N,1); 

% --- Static setup values (your car's alignment at ride height) ---
static_camber_F = -1.5;                  % deg
static_camber_R = -1;                  % deg
static_toe_F    =  0.2;                  % deg  (sign convention: see note below)
static_toe_R    =  0.1;                  % deg

% --- Kinematic gradients (from your SGS; plausible FSAE values) ---
camber_gain_F   = -0.6;                  % deg camber per deg roll (front)
camber_gain_R   = -0.5;                  % deg camber per deg roll (rear)
roll_steer_F    =  0.05;                 % deg toe per deg roll (front)
roll_steer_R    = -0.03;                 % deg toe per deg roll (rear)

% --- Per-corner camber (deg), road-referenced is handled later ---
% Outer/inner wheels gain camber in OPPOSITE senses in roll.
FL_camber = static_camber_F + camber_gain_F * roll_angles;
FR_camber = static_camber_F - camber_gain_F * roll_angles;
RL_camber = static_camber_R + camber_gain_R * roll_angles;
RR_camber = static_camber_R - camber_gain_R * roll_angles;

% --- Per-corner toe (deg), signed as a STEER angle in the vehicle frame ---
% NOTE: left/right carry OPPOSITE signs for symmetric toe-in.
FL_toe =  static_toe_F + roll_steer_F * roll_angles;
FR_toe = -static_toe_F + roll_steer_F * roll_angles;
RL_toe =  static_toe_R + roll_steer_R * roll_angles;
RR_toe = -static_toe_R + roll_steer_R * roll_angles;

% --- Contact patches: 4x3 (FL FR RL RR) x (x,y,z) per sample -> N x 4 x 3 ---
Wheelbase   = 1.530;                     % m
Track_Width = 1.00;                     % m
CP = zeros(N,4,3);
for k = 1:N
    CP(k,1,:) = [ 0.000, 0, 0];   % FL
    CP(k,2,:) = [ 0.000, -Track_Width, 0];   % FR
    CP(k,3,:) = [-Wheelbase, 0, 0];   % RL
    CP(k,4,:) = [-Wheelbase, -Track_Width, 0];   % RR
end

% --- Valid double-wishbone hardpoints (metres), Y,Z with X as filler ---
% Per corner, 4 points x 3 coords = 12 slots; order per point: [x, y, z]
% Point order: OUTtop, OUTbot, INtop, INbot
%   (x is filler = 0 since compute_Roll_Centre ignores it)

% One corner's 12 numbers as a template (typical FSAE front, metres):
%            OUTtop            OUTbot            INtop             INbot
% y:         0.560             0.580             0.180             0.200
% z:         0.320             0.130             0.290             0.120
cornerL = [0 0.560 0.320,  0 0.580 0.130,  0 0.180 0.290,  0 0.200 0.120];
cornerR = [0 -0.560 0.320, 0 -0.580 0.130, 0 -0.180 0.290, 0 -0.200 0.120];  % mirror y

front_row = [cornerL, cornerR];   % 24 values: slots 1-24
rear_row  = [cornerL, cornerR];   % 24 values: slots 25-48 (same geometry for test)
one_state = [front_row, rear_row];   % 48 values

pickups = repmat(one_state, N, 1);              % N x 48, static base
pickups = pickups + 0.001*roll_angles;          % tiny per-state migration so interp1 works

%% ------------------------------------------------------------------
%  PART 2: TIMESERIES -> STATES STRUCT   (KEEP - reuse on real SGS data)
%  ------------------------------------------------------------------
%  This is the code you'll point at the real Simulink export.

%%% Compute roll axis from A arm pickup coordinates

Front_Roll_Centre_Heights = zeros(N,1);
Rear_Roll_Centre_Heights  = zeros(N,1);
Sprung_Centre_Perpendicular_NRA = zeros(N,1)

for k = 1:N
    Front_Roll_Centre_Heights(k) = compute_Roll_Centre(pickups(k,2),pickups(k,3),pickups(k,5), ...
                            pickups(k,6),pickups(k,8),pickups(k,9),pickups(k,11),pickups(k,12),pickups(k,14),pickups(k,15), ...
                            pickups(k,17),pickups(k,18),pickups(k,20),pickups(k,21),pickups(k,23),pickups(k,24),CP(k,1,2), ...
                            CP(k,1,3),CP(k,2,2),CP(k,2,3));

    Rear_Roll_Centre_Heights(k) = compute_Roll_Centre(pickups(k,26),pickups(k,27),pickups(k,29), ...
                            pickups(k,30),pickups(k,32),pickups(k,33),pickups(k,35),pickups(k,36),pickups(k,38),pickups(k,39), ...
                            pickups(k,41),pickups(k,42),pickups(k,44),pickups(k,45),pickups(k,47),pickups(k,48),CP(k,3,2), ...
                            CP(k,3,3),CP(k,4,2),CP(k,4,3));
    
   Sprung_Centre_Perpendicular_NRA(k) = define_Roll_Axis_Distance(Front_Roll_Centre_Heights(k), ...
    Rear_Roll_Centre_Heights(k),Sprung_Mass_Centre(1),Sprung_Mass_Centre(3),Wheelbase);
end

%%% Compute accelerations from roll stiffnesses and roll angles

[Ay_series,Ax_series] = Geometry_to_Acceleration(Front_Spring_Stiffness,Rear_Spring_Stiffness,...
    Front_Motion_Ratio,Rear_Motion_Ratio,Tyre_Rate,Track_Width,Wheelbase,Sprung_Weight,Sprung_Centre_Perpendicular_NRA,...
    Sprung_Mass_Centre,roll_angles,pitch_angles)



for k = 1:N
    states(k).Ay        = Ay_series(k);
    states(k).Ax        = Ax_series(k);
    states(k).roll      = roll_angles(k);
    states(k).pitch     = pitch_angles(k);
    states(k).FL_camber = FL_camber(k);
    states(k).FR_camber = FR_camber(k);
    states(k).RL_camber = RL_camber(k);
    states(k).RR_camber = RR_camber(k);
    states(k).FL_toe    = FL_toe(k);
    states(k).FR_toe    = FR_toe(k);
    states(k).RL_toe    = RL_toe(k);
    states(k).RR_toe    = RR_toe(k);
    states(k).pickups   = pickups(k,:);
    states(k).contact_patches = squeeze(CP(k,:,:));
    states(k).F_Roll_Centres = Front_Roll_Centre_Heights(k);
    states(k).R_Roll_Centres = Rear_Roll_Centre_Heights(k);

end

% Sort by Ay for interpolation
[~, order] = sort([states.Ay]);
states = states(order);

fprintf('Built %d states, Ay range %.2f to %.2f g\n', ...
        numel(states), min([states.Ay]), max([states.Ay]));
