function [AY_ts, AX_ts, A_Y, A_X] = generateLateralAccel(timeVec, rollAngle, K_phi, opts)
%GENERATELATERALACCEL  Approximate A_Y (and A_X) timeseries for a roll sweep.
%
%   Produces lateral-acceleration data on the SAME time base as your
%   pickup-point timeseries, so the two can be fed into the load-transfer
%   model together and stay physically consistent (the A_Y at each timestep
%   is the acceleration that produces that timestep's roll angle).
%
%   The mapping uses the roll-gradient relationship from your model:
%        phi / A_Y = K_phi      ->      A_Y = phi / K_phi
%   i.e. lateral acceleration = roll angle divided by roll gradient.
%
%   INPUTS:
%     timeVec    N x 1  time vector (use the SAME one as pickup_ts)
%     rollAngle  N x 1  swept body roll angle, in DEGREES
%                       (use the rollAngle output from generateSamplePickupData)
%     K_phi      scalar roll gradient, in DEGREES PER g
%                       (typical FS values ~ 0.3 to 1.0 deg/g; default 0.5)
%     opts       (optional) struct:
%                  .units   'g' (default) or 'mps2' for A_Y output units
%                  .Ax      constant longitudinal accel to apply (default 0)
%                           (a pure roll sweep has no longitudinal component,
%                            so leave at 0 unless deliberately combining)
%
%   OUTPUTS:
%     AY_ts   timeseries of lateral acceleration (ready for From Workspace)
%     AX_ts   timeseries of longitudinal acceleration (constant = opts.Ax)
%     A_Y     N x 1 raw lateral accel vector
%     A_X     N x 1 raw longitudinal accel vector
%
%   EXAMPLE:
%     [coordArray, timeVec, rollAngle] = generateSamplePickupData(201, 'FL');
%     [AY_ts, AX_ts] = generateLateralAccel(timeVec, rollAngle, 0.5);
%     % feed pickup_ts, AY_ts, AX_ts into the model on the same clock

    if nargin < 3 || isempty(K_phi), K_phi = 0.5; end      % deg per g
    if nargin < 4, opts = struct(); end
    if ~isfield(opts,'units'), opts.units = 'g'; end
    if ~isfield(opts,'Ax'),    opts.Ax = 0;     end

    timeVec   = timeVec(:);
    rollAngle = rollAngle(:);

    % --- core mapping: A_Y = phi / K_phi  (deg / (deg/g) = g) ---
    A_Y = rollAngle / K_phi;                 % lateral accel in g

    % --- optional unit conversion ---
    if strcmpi(opts.units, 'mps2')
        A_Y = A_Y * 9.81;                    % g -> m/s^2
    end

    % --- longitudinal: constant (0 for pure roll sweep) ---
    A_X = opts.Ax * ones(size(A_Y));

    % --- package as timeseries on the shared time base ---
    AY_ts = timeseries(A_Y, timeVec);  AY_ts.Name = 'A_Y';
    AX_ts = timeseries(A_X, timeVec);  AX_ts.Name = 'A_X';
end
