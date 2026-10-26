% 1. generate
[coordArray, timeVec, rollAngle, colMap] = generateSamplePickupData(201, 'FL', 3);

% 2. package as a timeseries (From Workspace's preferred format)
pickup_ts = timeseries(coordArray, timeVec);   % N×48 data, N×1 time

% 3. in the From Workspace block dialog, set:
%      Data: pickup_ts

roll_ts = timeseries(rollAngle,timeVec)

K_phi = 1.5;   % deg/g — set to YOUR car's roll gradient
[AY_ts, AX_ts] = generateLateralAccel(timeVec, rollAngle, K_phi);