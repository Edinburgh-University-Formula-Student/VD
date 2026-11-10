function results = pitchCalc(p, gForce, verbose)
% PITCHCALC  Pitch angle from longitudinal acceleration (braking or traction).
%
%   results = pitchCalc(p, gForce)
%   results = pitchCalc(p, gForce, verbose)
%
%   gForce  : longitudinal acceleration in g. Positive = traction (load moves
%             to the rear), negative = braking (load moves to the front).
%   verbose : (optional) print results, default true.
%
%   p is a struct of car parameters (SI units: N, kg, m, N/m):
%       massCar         total mass of car                         [kg]
%       frontWeight     static front axle load                    [N]
%       rearWeight      static rear axle load                     [N]
%       cogHeight       centre of gravity height                  [m]
%       wheelbase       wheelbase                                 [m]
%       tyreRateFront   vertical stiffness of ONE front tyre      [N/m]
%       tyreRateRear    vertical stiffness of ONE rear tyre       [N/m]
%
%     Wheel rate (per wheel) for each axle: give EITHER
%       wheelRateFront / wheelRateRear                            [N/m]
%     OR
%       springRateFront / springRateRear                          [N/m]
%       motionRatioFront / motionRatioRear
%
%     Motion ratio convention (optional field mrDefinition):
%       'wheelOverSpring' (default, as in the chapter):
%               MR = wheel travel / spring travel,  wheel rate = spring rate / MR^2
%       'springOverWheel':
%               MR = spring travel / wheel travel,  wheel rate = spring rate * MR^2
%
%     Anti-geometry (optional, in PERCENT, default 0):
%       antiDive        % of braking load transfer at the front that goes
%                       through the suspension arms instead of the springs
%       antiSquat       % of traction load transfer at the rear that goes
%                       through the suspension arms instead of the springs
%     The other axle in each case (rear under braking, front under traction)
%     is assumed to have 0% anti geometry, so all of its transfer goes
%     through the springs.
%
%   Sign convention:
%       ride height change: positive = ride height increases (chassis rises)
%       pitch angle:        positive = nose up
%
%   Output struct fields:
%       longitTransfer, forceFrontNet, forceRearNet,
%       springTransferFront, springTransferRear,
%       armTransferFront, armTransferRear,
%       wheelRateFront, wheelRateRear, rideRateFront, rideRateRear,
%       rideChangeFront, rideChangeRear, thetaRad, thetaDeg, wheelLift

    if nargin < 3
        verbose = true;
    end

    g = 9.81;

    % ---- Sanity check on static weights ----
    expectedWeight = p.massCar * g;
    if abs((p.frontWeight + p.rearWeight) - expectedWeight) / expectedWeight > 0.02
        warning('pitchCalc:weightMismatch', ...
            ['Front + rear weight (%.0f N) differs from massCar*9.81 ' ...
             '(%.0f N) by more than 2%%. Check units (weights must be in N).'], ...
            p.frontWeight + p.rearWeight, expectedWeight);
    end

    % ---- 1. Longitudinal load transfer ----
    accel = gForce * g;
    longitTransfer = (p.massCar * accel * p.cogHeight) / p.wheelbase;   % N

    % ---- 2. Net axle forces (tyre loads, NOT affected by anti geometry) ----
    forceFrontNet = p.frontWeight - longitTransfer;
    forceRearNet  = p.rearWeight  + longitTransfer;

    wheelLift = (forceFrontNet < 0) || (forceRearNet < 0);
    if wheelLift
        warning('pitchCalc:wheelLift', ...
            ['Load transfer exceeds the static load on an axle, so that axle ' ...
             'would lift. Linear ride-rate results are not physical.']);
    end

    % ---- 3. Split the transfer: springs vs suspension arms ----
    antiDive  = getPercentFraction(p, 'antiDive');    % 0 to 1
    antiSquat = getPercentFraction(p, 'antiSquat');   % 0 to 1

    if gForce >= 0
        % Traction: anti-squat acts at the rear, front has no anti geometry
        springFractionFront = 1;
        springFractionRear  = 1 - antiSquat;
    else
        % Braking: anti-dive acts at the front, rear has no anti geometry
        springFractionFront = 1 - antiDive;
        springFractionRear  = 1;
    end

    springTransferFront = longitTransfer * springFractionFront;
    springTransferRear  = longitTransfer * springFractionRear;
    armTransferFront    = longitTransfer - springTransferFront;
    armTransferRear     = longitTransfer - springTransferRear;

    % ---- 4. Wheel rate -> ride rate -> ride change ----
    wheelRateFront = getWheelRate(p, 'Front');
    wheelRateRear  = getWheelRate(p, 'Rear');

    % Ride rate per wheel = wheel rate and tyre rate in series
    rideRateWheelFront = seriesRate(wheelRateFront, p.tyreRateFront);
    rideRateWheelRear  = seriesRate(wheelRateRear,  p.tyreRateRear);

    % Ride rate per axle = two wheels in parallel
    rideRateFront = 2 * rideRateWheelFront;
    rideRateRear  = 2 * rideRateWheelRear;

    % Only the spring-borne part of the transfer causes a ride change.
    % Positive = ride height rises. Front unloads (rises) and rear loads
    % (drops) under traction; reversed under braking.
    rideChangeFront =  springTransferFront / rideRateFront;
    rideChangeRear  = -springTransferRear  / rideRateRear;

    % ---- 5. Pitch angle (positive = nose up) ----
    theta = atan((rideChangeFront - rideChangeRear) / p.wheelbase);

    results = struct( ...
        'longitTransfer',      longitTransfer, ...
        'forceFrontNet',       forceFrontNet, ...
        'forceRearNet',        forceRearNet, ...
        'springTransferFront', springTransferFront, ...
        'springTransferRear',  springTransferRear, ...
        'armTransferFront',    armTransferFront, ...
        'armTransferRear',     armTransferRear, ...
        'wheelRateFront',      wheelRateFront, ...
        'wheelRateRear',       wheelRateRear, ...
        'rideRateFront',       rideRateFront, ...
        'rideRateRear',        rideRateRear, ...
        'rideChangeFront',     rideChangeFront, ...
        'rideChangeRear',      rideChangeRear, ...
        'thetaRad',            theta, ...
        'thetaDeg',            rad2deg(theta), ...
        'wheelLift',           wheelLift);

    if verbose
        if theta >= 0
            direction = "nose up";
        else
            direction = "nose down";
        end
        fprintf("\n---------------- RESULTS (%.2f g) ----------------\n", gForce);
        fprintf("Longitudinal transfer:    %.2f N\n",  longitTransfer);
        fprintf("Front net force:          %.2f N\n",  forceFrontNet);
        fprintf("Rear net force:           %.2f N\n",  forceRearNet);
        fprintf("Front via springs / arms: %.2f N / %.2f N\n", ...
            springTransferFront, armTransferFront);
        fprintf("Rear via springs / arms:  %.2f N / %.2f N\n", ...
            springTransferRear, armTransferRear);
        fprintf("Front wheel rate:         %.1f N/mm\n", wheelRateFront / 1000);
        fprintf("Rear wheel rate:          %.1f N/mm\n", wheelRateRear  / 1000);
        fprintf("Front ride rate (axle):   %.1f N/mm\n", rideRateFront / 1000);
        fprintf("Rear ride rate (axle):    %.1f N/mm\n", rideRateRear  / 1000);
        fprintf("Front ride height change: %+.2f mm\n", rideChangeFront * 1000);
        fprintf("Rear ride height change:  %+.2f mm\n", rideChangeRear  * 1000);
        fprintf("Pitch angle: %+.4f rad (%+.3f deg, %s)\n", ...
            theta, rad2deg(theta), direction);
        if wheelLift
            fprintf("WARNING: wheel lift, results not physical.\n");
        end
    end
end


% =====================================================================
%  Local helper functions
% =====================================================================

function kWheel = getWheelRate(p, axle)
% Use a directly supplied wheel rate, otherwise convert spring rate using
% the motion ratio (see header for the two possible conventions).
    wheelField  = ['wheelRate'   axle];
    springField = ['springRate'  axle];
    mrField     = ['motionRatio' axle];

    if isfield(p, wheelField)
        kWheel = p.(wheelField);
    elseif isfield(p, springField) && isfield(p, mrField)
        if isfield(p, 'mrDefinition')
            definition = p.mrDefinition;
        else
            definition = 'wheelOverSpring';
        end

        switch definition
            case 'wheelOverSpring'
                kWheel = p.(springField) / p.(mrField)^2;
            case 'springOverWheel'
                kWheel = p.(springField) * p.(mrField)^2;
            otherwise
                error('pitchCalc:badMRDefinition', ...
                    'mrDefinition must be ''wheelOverSpring'' or ''springOverWheel''.');
        end
    else
        error('pitchCalc:missingWheelRate', ...
            'Give %s, or both %s and %s.', wheelField, springField, mrField);
    end
end

function k = seriesRate(k1, k2)
% Two springs in series: 1/k = 1/k1 + 1/k2
    k = (k1 * k2) / (k1 + k2);
end

function f = getPercentFraction(p, name)
% Read an optional percentage field (default 0) and return it as 0 to 1.
    if isfield(p, name)
        value = p.(name);
    else
        value = 0;
    end
    if value < 0 || value > 100
        error('pitchCalc:badPercent', '%s must be between 0 and 100 (percent).', name);
    end
    f = value / 100;
end


% ---- Vehicle values ----
p.massCar          = 280;
p.frontWeight      = 280 * 9.81 * 0.4862;
p.rearWeight       = 280 * 9.81 * 0.5138;
p.cogHeight        = 0.2232;
p.wheelbase        = 1.540;

p.springRateFront  = 52000;
p.springRateRear   = 52000;
p.motionRatioFront = 0.67;
p.motionRatioRear  = 0.71;
p.mrDefinition     = 'springOverWheel';

p.tyreRateFront    = 200000;
p.tyreRateRear     = 200000;

p.antiDive         = 14.48;
p.antiSquat        = 14.48;

% ---- Runs ----
rTraction = pitchCalc(p, 1.5);
rBraking  = pitchCalc(p, -1.5);