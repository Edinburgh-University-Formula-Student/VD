function [coordArray, timeVec, rollAngle, colMap] = generateSamplePickupData(N, frame, motionScale)
%   motionScale : multiplier on outboard pickup travel (default 1).
%                 1   -> realistic (~9mm Y, 36mm Z over +/-3deg)
%                 ~3  -> exaggerated for testing RC migration sensitivity
%                        (~24mm Y, 108mm Z) - still bounded, no singularity
%GENERATESAMPLEPICKUPDATA  Synthetic pickup coordinates swept through roll.
%   (v2 - physically realistic motion magnitudes)
%
%   Produces a realistic [N x 48] array of suspension pickup coordinates
%   (16 points x [x y z]) as the car sweeps through body roll. Use to test
%   the extraction + roll-centre + load-transfer pipeline BEFORE the
%   Transform Sensors are wired in the Multibody model.
%
%   KEY FIX vs v1: pickups now move by REALISTIC small amounts.
%     - INBOARD (chassis) points: fixed in the chassis frame.
%     - OUTBOARD (upright) points: small lateral + vertical travel scaled
%       to roll angle (a few mm per degree), opposite sense left vs right.
%     v1 rotated points about the contact patch -> ~1.8 m unphysical sweep
%     that sent roll centres to infinity.
%
%   48-column map (point -> cols x,y,z):
%     FRONT (1-24): FL_OUTTop 1-3, FL_OUTBot 4-6, FL_INTop 7-9, FL_INBot 10-12,
%                   FR_OUTTop 13-15, FR_OUTBot 16-18, FR_INTop 19-21, FR_INBot 22-24
%     REAR  (25-48): RL_/RR_ same pattern
%   Coords in m. x=rearward, y=right, z=up.
%   frame: 'chassis' (default) or 'FL' (origin at front-left contact patch)

    if nargin < 1, N = 201; end
    if nargin < 2, frame = 'chassis'; end
    if nargin < 3, motionScale = 1; end

    rollAngle = linspace(-3, 3, N).';      % +/- 3 deg body roll
    timeVec   = linspace(0, 1, N).';

    track = 1.00;  yL = -track/2;  yR = +track/2;
    xFront = 0.00;  xRear = 1.56;

    FL.OUTTop=[xFront,yL+0.10,0.320]; FL.OUTBot=[xFront,yL+0.05,0.120];
    FL.INTop =[xFront,yL+0.31,0.287]; FL.INBot =[xFront,yL+0.33,0.116];
    FR.OUTTop=[xFront,yR-0.10,0.320]; FR.OUTBot=[xFront,yR-0.05,0.120];
    FR.INTop =[xFront,yR-0.31,0.287]; FR.INBot =[xFront,yR-0.33,0.116];
    RL.OUTTop=[xRear, yL+0.10,0.340]; RL.OUTBot=[xRear, yL+0.05,0.130];
    RL.INTop =[xRear, yL+0.31,0.325]; RL.INBot =[xRear, yL+0.33,0.150];
    RR.OUTTop=[xRear, yR-0.10,0.340]; RR.OUTBot=[xRear, yR-0.05,0.130];
    RR.INTop =[xRear, yR-0.31,0.325]; RR.INBot =[xRear, yR-0.33,0.150];

    pts = {FL.OUTTop,FL.OUTBot,FL.INTop,FL.INBot, ...
           FR.OUTTop,FR.OUTBot,FR.INTop,FR.INBot, ...
           RL.OUTTop,RL.OUTBot,RL.INTop,RL.INBot, ...
           RR.OUTTop,RR.OUTBot,RR.INTop,RR.INBot};
    names = {'FL_OUTTop','FL_OUTBot','FL_INTop','FL_INBot', ...
             'FR_OUTTop','FR_OUTBot','FR_INTop','FR_INBot', ...
             'RL_OUTTop','RL_OUTBot','RL_INTop','RL_INBot', ...
             'RR_OUTTop','RR_OUTBot','RR_INTop','RR_INBot'};

    colMap = struct();
    for p = 1:16, colMap.(names{p}) = (p-1)*3 + (1:3); end

    LAT_PER_DEG  = 0.0015 * motionScale;   % m/deg lateral travel of outboard point
    VERT_PER_DEG = 0.006  * motionScale;   % m/deg vertical travel of outboard point

    coordArray = zeros(N, 48);
    for k = 1:N
        phi = rollAngle(k);
        for p = 1:16
            P = pts{p}; nm = names{p};
            isInboard = contains(nm,'IN');
            isLeft = startsWith(nm,'FL') || startsWith(nm,'RL');
            if isInboard
                xyz = P;
            else
                s = 1; if ~isLeft, s = -1; end
                xyz = [P(1), P(2)+s*LAT_PER_DEG*phi, P(3)+s*VERT_PER_DEG*phi];
            end
            coordArray(k, colMap.(nm)) = xyz;
        end
    end

    if strcmpi(frame,'FL')
        coordArray(:, 2:3:end) = coordArray(:, 2:3:end) + track/2;
    end
end
