% Load and Parse .tir file
fileText = fileread('magicformularun17.tir');

% Extract Pacejka Magic Formula Coefficients from .tir file
Cx = str2double(extractBetween(fileText, 'PCX1                         =', newline)); % Shape factor
Dx1 = str2double(extractBetween(fileText, 'PDX1                         =', newline)); % Peak factor
Dx2 = str2double(extractBetween(fileText, 'PDX2                         =', newline)); % Load-dependent factor
Dx3 = str2double(extractBetween(fileText, 'PDX3                         =', newline)); % Camber-dependent factor
Ex1 = str2double(extractBetween(fileText, 'PEX1                         =', newline)); % Curvature factor
Ex2 = str2double(extractBetween(fileText, 'PEX2                         =', newline));
Ex3 = str2double(extractBetween(fileText, 'PEX3                         =', newline));
Ex4 = str2double(extractBetween(fileText, 'PEX4                         =', newline));
Bx1 = str2double(extractBetween(fileText, 'PKX1                         =', newline)); % Stiffness factor
Bx2 = str2double(extractBetween(fileText, 'PKX2                         =', newline));
Bx3 = str2double(extractBetween(fileText, 'PKX3                         =', newline));



% Compute Final Coefficients
Dx = Dx1 + Dx2; % Adjusted peak factor
Bx = Bx1 + Bx2; % Adjusted stiffness factor
Ex = Ex1 + Ex2; % Adjusted curvature factor

% Display Extracted Values
disp(['Bx = ', num2str(Bx)]);
disp(['Cx = ', num2str(Cx)]);
disp(['Dx = ', num2str(Dx)]);
disp(['Ex = ', num2str(Ex)]);

% Define the input slip ratio (kappa)
kappa = linspace(-0.2, 0.2, 100); % Slip ratio range from -0.2 to 0.2

% Compute Longitudinal Force using Pacejka's Magic Formula
Fx = Dx .* sin(Cx .* atan(Bx .* kappa - Ex .* (Bx .* kappa - atan(Bx .* kappa))));

% Plot the results
figure;
plot(kappa, Fx, 'b', 'LineWidth', 2);
xlabel('Slip Ratio (κ)');
ylabel('Longitudinal Force (Fx)');
title('Longitudinal Force');
grid on;
