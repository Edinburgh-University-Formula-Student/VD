%% MAKE_TEST_STATES_2D
% Generates synthetic "SGS output" for a 2-D roll x pitch sweep, then
% transforms it into the `states` struct array the sweep loop consumes.
%
%   PART 1 - fake 2-D sweep      (throw away once the real SGS works)
%   PART 2 - sweep -> struct     (KEEP - reuse on real SGS data)
%   PART 3 - build interpolants  (KEEP - use these in the main loop)

addpath('C:\FS\EUFS Internship\MATLAB Programs\EUFS-Load-Transfer-Simulation');
savepath;

%% ------------------------------------------------------------------
%  PART 1: SYNTHETIC 2-D SGS SWEEP
%  ------------------------------------------------------------------

% --- Grid axes (degrees). Deliberately WIDER than the car can reach, so
%     the convergence never queries outside the data and hits NaN. ---
n_roll  = 81;
n_pitch = 61;
roll_axis  = linspace(-5, 5, n_roll);    % deg  (car reaches ~+/-3)
pitch_axis = linspace(-3, 3, n_pitch);   % deg  (car reaches ~+/-2)

% Every combination of roll and pitch
[R, P] = meshgrid(roll_axis, pitch_axis);   % both [n_pitch x n_roll]
roll_angles  = R(:);                        % flatten to N x 1
pitch_angles = P(:);
N = numel(roll_angles);

% --- Static setup values (alignment at ride height) ---
static_camber_F = -1.5;   % deg
static_camber_R = -1.0;   % deg
static_toe_F    =  0.2;   % deg
static_toe_R    =  0.1;   % deg

% --- Kinematic gradients ---
% ROLL effects are ANTISYMMETRIC left/right (outer and inner wheels move
% in opposite directions), so they carry opposite signs on L and R.
camber_gain_F = -0.8;    % deg camber per deg roll (front)
camber_gain_R = -0.6;    % deg camber per deg roll (rear)
roll_steer_F  =  0.05;   % deg toe per deg roll (front)
roll_steer_R  = -0.03;   % deg toe per deg roll (rear)

% PITCH effects are SYMMETRIC left/right (both wheels on an axle move the
% same way), but OPPOSITE front to rear (nose down = front bump, rear droop).
camber_pitch_F = -0.30;  % deg camber per deg pitch (front)
camber_pitch_R =  0.20;  % deg camber per deg pitch (rear)
toe_pitch_F    =  0.04;  % deg toe per deg pitch (front, bump steer)
toe_pitch_R    = -0.02;  % deg toe per deg pitch (rear)

% --- Per-corner camber: roll term (antisymmetric) + pitch term (symmetric) ---
FL_camber = static_camber_F + camber_gain_F*roll_angles + camber_pitch_F*pitch_angles;
FR_camber = static_camber_F - camber_gain_F*roll_angles + camber_pitch_F*pitch_angles;
RL_camber = static_camber_R + camber_gain_R*roll_angles + camber_pitch_R*pitch_angles;
RR_camber = static_camber_R - camber_gain_R*roll_angles + camber_pitch_R*pitch_angles;

% --- Per-corner toe, signed as a STEER angle in the vehicle frame ---
% Static toe carries opposite signs L/R (toe-in points wheels at each other).
FL_toe =  static_toe_F + roll_steer_F*roll_angles + toe_pitch_F*pitch_angles;
FR_toe = -static_toe_F + roll_steer_F*roll_angles - toe_pitch_F*pitch_angles;
RL_toe =  static_toe_R + roll_steer_R*roll_angles + toe_pitch_R*pitch_angles;
RR_toe = -static_toe_R + roll_steer_R*roll_angles - toe_pitch_R*pitch_angles;

% --- Contact patches: N x 4 x 3, order FL FR RL RR ---
Wheelbase   = 1.530;   % m
Track_Width = 1.00;   % m
CP = zeros(N,4,3);
for k = 1:N
    CP(k,1,:) = [ 0.000,          0, 0];   % FL
    CP(k,2,:) = [ 0.000, -Track_Width, 0];   % FR
    CP(k,3,:) = [-Wheelbase,      0, 0];   % RL
    CP(k,4,:) = [-Wheelbase, -Track_Width, 0];   % RR
end

% --- A-arm hardpoints: 48 flat values per state ---
% Point order per corner: OUTtop, OUTbot, INtop, INbot, each [x y z]
cornerL = [0  0.560 0.320,  0  0.580 0.130,  0  0.180 0.290,  0  0.200 0.120];
cornerR = [0 -0.560 0.320,  0 -0.580 0.130,  0 -0.180 0.290,  0 -0.200 0.120];
one_state = [cornerL, cornerR, cornerL, cornerR];   % front then rear = 48

pickups = repmat(one_state, N, 1);
% Migration with BOTH roll and pitch now
pickups = pickups + 0.001*roll_angles + 0.0005*pitch_angles;

%% ------------------------------------------------------------------
%  PART 2: SWEEP -> STATES STRUCT
%  ------------------------------------------------------------------

Front_Roll_Centre_Heights       = zeros(N,1);
Rear_Roll_Centre_Heights        = zeros(N,1);
Sprung_Centre_Perpendicular_NRA = zeros(N,1);

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

% --- Accelerations from roll/pitch and the stiffnesses ---
[Ay_series, Ax_series] = Geometry_to_Acceleration(Front_Spring_Stiffness,Rear_Spring_Stiffness, ...
    Front_Motion_Ratio,Rear_Motion_Ratio,Tyre_Rate,Track_Width,Wheelbase,Sprung_Weight, ...
    Sprung_Centre_Perpendicular_NRA,Sprung_Mass_Centre,roll_angles,pitch_angles);

states = struct([]);
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
    states(k).Front_RC  = Front_Roll_Centre_Heights(k);
    states(k).Rear_RC   = Rear_Roll_Centre_Heights(k);
    states(k).h2        = Sprung_Centre_Perpendicular_NRA(k);
    states(k).pickups   = pickups(k,:);
    states(k).FL_Contact_Patches = squeeze(CP(k,1,:));
    states(k).FR_Contact_Patches = squeeze(CP(k,2,:));
    states(k).RL_Contact_Patches = squeeze(CP(k,3,:));
    states(k).RR_Contact_Patches = squeeze(CP(k,4,:));
end

fprintf('Built %d states (%d roll x %d pitch)\n', N, n_roll, n_pitch);
fprintf('  Ay range: %.2f to %.2f g\n', min([states.Ay]), max([states.Ay]));
fprintf('  Ax range: %.2f to %.2f g\n', min([states.Ax]), max([states.Ax]));