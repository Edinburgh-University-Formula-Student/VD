function antiDivePercent = calculateAntiDive( ...
    frontIC, frontCP, frontBrakePercent, wheelbase, cgHeight,cgX)

% Validate 2D coordinates [x,z]
validateattributes(frontIC, {'numeric'}, ...
    {'size',[1,2],'real','finite'});

validateattributes(frontCP, {'numeric'}, ...
    {'size',[1,2],'real','finite'});

if nargin == 6
    validateattributes(cgX, {'numeric'}, {'scalar','real','finite'});
    validateattributes(cgHeight, {'numeric'}, ...
        {'scalar','real','finite','positive'});

    dx = double(frontCP(1)) - double(frontIC(1));
    dz = double(frontIC(2)) - double(frontCP(2));
    cgDistance = double(frontCP(1)) - double(cgX); % +X forward

    if abs(dx) <= 1e-10 * max(abs([dx, dz, cgDistance]))
        error('AntiDive:VerticalSwingArm', ...
            'Horizontal IC distance is zero or too small.');
    end

    h2 = (dz / dx) * cgDistance;
    antiDivePercent = 100 * h2 / double(cgHeight);
    return
end

% Validate front braking-force percentage (0-100)
validateattributes(frontBrakePercent, {'numeric'}, ...
    {'scalar','real','finite','>=',0,'<=',100});

% Wheelbase and CG height must be positive
validateattributes(wheelbase, {'numeric'}, ...
    {'scalar','real','finite','positive'});

validateattributes(cgHeight, {'numeric'}, ...
    {'scalar','real','finite','positive'});

% If CG X is supplied, usegeometric definition.


% Convert to double precision
frontIC = double(frontIC);
frontCP = double(frontCP);
frontBrakePercent = double(frontBrakePercent);
wheelbase = double(wheelbase);
cgHeight = double(cgHeight);

% Convert percentage into a fraction
beta = frontBrakePercent / 100;

% Contact patch to IC geometry
dx = frontCP(1) - frontIC(1);
dz = frontIC(2) - frontCP(2);

% Reject a vertical or nearly vertical swing arm
if abs(dx) <= 1e-10 * wheelbase
    error('AntiDive:VerticalSwingArm', ...
        'Horizontal IC distance is zero or too small.');
end

% Calculate anti-dive percentage
antiDivePercent = 100 * beta * ...
    (wheelbase / cgHeight) * (dz / dx);

end