function pitchCentre = findpitchCentre( ...
    frontIC, rearIC, frontCP, rearCP)

% Validate inputs as finite 2D coordinates
validateattributes(frontIC, {'numeric'}, ...
    {'size',[1,2],'real','finite'});

validateattributes(rearIC, {'numeric'}, ...
    {'size',[1,2],'real','finite'});

validateattributes(frontCP, {'numeric'}, ...
    {'size',[1,2],'real','finite'});

validateattributes(rearCP, {'numeric'}, ...
    {'size',[1,2],'real','finite'});

% Convert inputs to double precision
frontIC = double(frontIC);
rearIC  = double(rearIC);
frontCP = double(frontCP);
rearCP  = double(rearCP);



pitchCentre = findLineIntersection( ...
    frontIC, frontCP, rearIC, rearCP);
end