function results = maxBrakingPitch(wheelbase, frontWingOverhang, frontWingHeight, staticRideHeight, assumedPitchCentre, verbose)
% MAXBRAKINGPITCH  Maximum nose-down pitch angle before the front wing
% scrapes the ground, or the floor touches down at the front axle.
%
% Model: rigid body rotating nose-down about a pivot (pitch centre) located
% on the wheelbase at STATIC RIDE HEIGHT above the ground.
%
% INPUTS (all in metres)
%   wheelbase           - distance between front and rear axles
%   frontWingOverhang   - front wing overhang (ahead of front axle)
%   frontWingHeight     - front wing clearance (from ground)
%   staticRideHeight    - static ride height (from ground)
%   assumedPitchCentre  - pitch centre, measured from the FRONT axle
%                         towards the rear (must be > 0 and <= wheelbase)
%   verbose             - (optional) print results to command window
%                         [default: true]
%
% OUTPUT (struct)
%   results.pitchLength        - lever arm, pivot to wing tip [m]
%   results.thetaWing          - wing scrape limit [rad]
%   results.thetaFloor         - floor contact limit [rad]
%   results.thetaMax           - max pitch angle [rad]
%   results.thetaMaxDeg        - max pitch angle [deg]
%   results.limitingFactor     - string describing the limiting case
%   results.heightDeltaFront   - front ride height change at max pitch [m]
%   results.heightDeltaRear    - rear ride height change at max pitch [m]
%
% EXAMPLE
%   r = maxBrakingPitch(1.55, 0.80, 0.05, 0.04, 0.90);

    arguments
        wheelbase           (1,1) double {mustBePositive}
        frontWingOverhang   (1,1) double {mustBeNonnegative}
        frontWingHeight     (1,1) double {mustBeNonnegative}
        staticRideHeight    (1,1) double {mustBePositive}
        assumedPitchCentre  (1,1) double
        verbose             (1,1) logical = true
    end

    % Basic validation: pitch centre must lie between front and rear axles
    if assumedPitchCentre <= 0 || assumedPitchCentre > wheelbase
        error("maxBrakingPitch:badPitchCentre", ...
              "Pitch centre must be > 0 and <= wheelbase (%.3f m).", wheelbase);
    end

    % Horizontal lever arm from the pivot to the front wing tip
    pitchLength = assumedPitchCentre + frontWingOverhang;   % [m]

    % FRONT WING LIMIT CHECK
    % Wing tip is pitchLength ahead of the pivot and (clearance - rideHeight)
    % above it. Solve for the angle where the tip height above ground = 0.
    thetaWing = scrapeAngle(pitchLength, frontWingHeight, staticRideHeight);

    % FLOOR CONTACT AT FRONT AXLE CHECK
    % The floor sits at ride height, level with the pivot (offset = 0), at a
    % lever arm equal to the pitch centre distance.
    thetaFloor = scrapeAngle(assumedPitchCentre, staticRideHeight, staticRideHeight);

    % DETERMINATION OF LIMIT CAUSE
    [thetaMax, limitIdx] = min([thetaWing, thetaFloor]);
    if limitIdx == 1
        limitingFactor = "Front wing scrape";
    else
        limitingFactor = "Floor contact at front axle";
    end

    % RIDE HEIGHT DELTA
    % Front axle is assumedPitchCentre ahead of the pivot (moves down)
    heightDeltaFront = assumedPitchCentre * sin(thetaMax);
    % Rear axle is (wheelbase - assumedPitchCentre) behind the pivot (moves up)
    heightDeltaRear  = (wheelbase - assumedPitchCentre) * sin(thetaMax);

    % PACK RESULTS
    results = struct( ...
        "pitchLength",      pitchLength, ...
        "thetaWing",        thetaWing, ...
        "thetaFloor",       thetaFloor, ...
        "thetaMax",         thetaMax, ...
        "thetaMaxDeg",      rad2deg(thetaMax), ...
        "limitingFactor",   limitingFactor, ...
        "heightDeltaFront", heightDeltaFront, ...
        "heightDeltaRear",  heightDeltaRear);

    % OUTPUT
    if verbose
        fprintf("\n---------------- RESULTS ----------------\n");
        fprintf("Pitch lever arm to wing tip : %.3f m\n", pitchLength);
        fprintf("Wing scrape limit           : %.3f deg\n", rad2deg(thetaWing));
        fprintf("Floor contact limit         : %.3f deg\n", rad2deg(thetaFloor));
        fprintf("-----------------------------------------\n");
        fprintf("MAX PITCH ANGLE             : %.3f deg\n", rad2deg(thetaMax));
        fprintf("Limited by                  : %s\n", limitingFactor);
        fprintf("-----------------------------------------\n");
        fprintf("Front ride delta at max pitch : %.3f m\n", heightDeltaFront);
        fprintf("Rear ride delta at max pitch  : %.3f m\n", heightDeltaRear);
        fprintf("-----------------------------------------\n");
    end
end

%% PIVOT CALCULATION (local function)
function theta = scrapeAngle(L, clearance, pivotHeight)
% Nose-down angle at which a point hits the ground, where:
%   L           = horizontal distance ahead of the pivot [m]
%   clearance   = height of the point above ground [m]
%   pivotHeight = height of the pivot above ground [m]
    d     = clearance - pivotHeight;   % vertical offset of point from pivot
    R     = hypot(L, d);               % straight-line distance pivot to point
    phi   = atan2(d, L);               % angle of the point above/below horizontal
    ratio = pivotHeight / R;

    if ratio >= 1
        theta = Inf;                   % point can never reach the ground
    else
        theta = phi + asin(ratio);     % [rad]
    end
end


% EXAMPLE CALLS
%   % Argument order:
%   %   maxBrakingPitch(wheelbase, frontWingOverhang, frontWingHeight, ...
%   %                   staticRideHeight, assumedPitchCentre)
%
%   % 1) Print the report and store the results
%   r = maxBrakingPitch(1.55, 0.80, 0.05, 0.04, 0.90);
%
%   % 2) Silent call (no printing), then use the outputs directly
%   r = maxBrakingPitch(1.55, 0.80, 0.05, 0.04, 0.90, false);
%   fprintf("Max pitch = %.3f deg (%s)\n", r.thetaMaxDeg, r.limitingFactor);
%