function instantCentre = findInstantCentre( ...
    upperFore, upperAft, upperOut, ...
    lowerFore, lowerAft, lowerOut)


validateattributes(upperFore, {'numeric'}, {'size',[1,3],'real','finite'});
validateattributes(upperAft,  {'numeric'}, {'size',[1,3],'real','finite'});
validateattributes(upperOut,  {'numeric'}, {'size',[1,3],'real','finite'});

validateattributes(lowerFore, {'numeric'}, {'size',[1,3],'real','finite'});
validateattributes(lowerAft,  {'numeric'}, {'size',[1,3],'real','finite'});
validateattributes(lowerOut,  {'numeric'}, {'size',[1,3],'real','finite'});

upperFore = double(upperFore);
upperAft  = double(upperAft);
upperOut  = double(upperOut);

lowerFore = double(lowerFore);
lowerAft  = double(lowerAft);
lowerOut  = double(lowerOut);

% Calculate 3D inboard pivot axis vectors
upperAxis = upperFore - upperAft;
lowerAxis = lowerFore - lowerAft;

% Reject coincident inboard pivots
if norm(upperAxis) == 0 || norm(lowerAxis) == 0
    error('InstantCentre:DegenerateAxis', ...
        'Inboard pivot points must be distinct.');
end

% Dimensionless skew tolerance
skewTolerance = 1e-10;

% Check upper wishbone lateral skew
if abs(upperAxis(2)) > skewTolerance * norm(upperAxis)
    error('InstantCentre:UpperSkew', ...
        'Upper inboard axis has lateral skew.');
end

% Check lower wishbone lateral skew
if abs(lowerAxis(2)) > skewTolerance * norm(lowerAxis)
    error('InstantCentre:LowerSkew', ...
        'Lower inboard axis has lateral skew.');
end

% Vectors from the aft pivot to the outboard joint
upperToOut = upperOut - upperAft;
lowerToOut = lowerOut - lowerAft;

% Calculate parallelogram areas
upperArea = norm(cross(upperAxis, upperToOut));
lowerArea = norm(cross(lowerAxis, lowerToOut));

% Dimensionless collinearity tolerance
triangleTolerance = 1e-10;

% Check upper wishbone
if upperArea <= triangleTolerance * ...
        norm(upperAxis) * norm(upperToOut)

    error('InstantCentre:DegenerateUpperArm', ...
        'Upper wishbone points are collinear.');
end

% Check lower wishbone
if lowerArea <= triangleTolerance * ...
        norm(lowerAxis) * norm(lowerToOut)

    error('InstantCentre:DegenerateLowerArm', ...
        'Lower wishbone points are collinear.');
end

% Find the direction of the upper effective line
upperDirection = upperFore([1,3]) - upperAft([1,3]);

% Find the direction of the lower effective line
lowerDirection = lowerFore([1,3]) - lowerAft([1,3]);

% Position the effective lines at the outboard joints
upperStart = upperOut([1,3]);
lowerStart = lowerOut([1,3]);

% Construct the second point on each effective line
upperEnd = upperStart + upperDirection;
lowerEnd = lowerStart + lowerDirection;

% Calculate the intersection
instantCentre = findLineIntersection( ...
    upperStart, upperEnd, lowerStart, lowerEnd);

end