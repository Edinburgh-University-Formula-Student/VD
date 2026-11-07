function intersection = findLineIntersection(a, b, c, d)

%makes sure you get the correct format of the input, where it's a vector
%vector with only real finite numbers with 2 entries only 
validateattributes(a, {'numeric'}, {'vector','numel',2,'real','finite'});
validateattributes(b, {'numeric'}, {'vector','numel',2,'real','finite'});
validateattributes(c, {'numeric'}, {'vector','numel',2,'real','finite'});
validateattributes(d, {'numeric'}, {'vector','numel',2,'real','finite'});


%converts to a row vector with precision 
a = double(a(:).');
b = double(b(:).');
c = double(c(:).');
d = double(d(:).');


v1 = b - a;
v2 = d - c;


if norm(v1) == 0
    error('LineIntersection:DegenerateLine1', ...
        'Points A and B are identical.');
end

if norm(v2) == 0
    error('LineIntersection:DegenerateLine2', ...
        'Points C and D are identical.');
end

%
A = [v1(:), -v2(:)];
B = (c - a).';



% Numerical tolerances
angleTolerance = 1e-10;
distanceTolerance = 1e-3;  % mm for current test data

% Measure how close the directions are to parallel
r = abs(det(A)) / (norm(v1) * norm(v2));

if r <= angleTolerance

    % Directions are nearly parallel, but not exactly
    % parallel according to floating-point arithmetic
    if det(A) ~= 0
        error('LineIntersection:NearParallel', ...
            'Lines are nearly parallel; intersection may be unreliable.');
    end

    % Check whether parallel lines occupy the same position
    offset = c - a;

    distance = abs(v1(1)*offset(2) - v1(2)*offset(1)) ...
        / norm(v1);

    if distance <= distanceTolerance

        error('LineIntersection:Coincident', ...
            'Lines coincide within the distance tolerance.');

    else

        error('LineIntersection:Parallel', ...
            'Lines are parallel and separate.');

    end

end



t = A \ B;

% Calculate intersection using the first line
intersection = a + t(1) * v1;

end