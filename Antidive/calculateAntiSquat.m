function [antiSquatPercent, h2] = calculateAntiSquat(rearIC, rearCP, cgX, cgHeight)


validateattributes(rearIC, {'numeric'}, {'size',[1,2],'real','finite'});
validateattributes(rearCP, {'numeric'}, {'size',[1,2],'real','finite'});
validateattributes(cgX, {'numeric'}, {'scalar','real','finite'});
validateattributes(cgHeight, {'numeric'}, {'scalar','real','finite','positive'});

rearIC = double(rearIC);
rearCP = double(rearCP);
dx = rearIC(1) - rearCP(1);   
dz = rearIC(2) - rearCP(2);
cgDistance = double(cgX) - rearCP(1);
lengths = [dx, dz, cgDistance];

if any(~isfinite(lengths))
    error('AntiSquat:NumericRange', 'Coordinate differences exceed the numeric range.');
end
if abs(dx) <= 1e-10 * max(abs(lengths))
    error('AntiSquat:VerticalSwingArm', 'Horizontal IC distance is zero or too small.');
end

h2 = (dz / dx) * cgDistance;  % h2 is the height of the rear 
% contact-patch-to-instant-centre line above ground, measured directly beneath the CG
antiSquatPercent = 100 * (h2 / double(cgHeight));
if ~isfinite(antiSquatPercent)
    error('AntiSquat:NumericRange', 'Anti-squat exceeds the numeric range.');
end
end
