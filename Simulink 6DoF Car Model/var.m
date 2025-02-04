% Longitudinal
mass = 200; % kg
cgToFrontAxle = 0.8; % m
cgToRearAxle = 0.7; % m
cgVerticalToAxlePlane = 0.1; % m
wheelBase = cgToFrontAxle + cgToRearAxle; % m

% Lateral
trackWidth = 1; % m

% Yaw
yawPolarInertia = 200; % kg*m^2

% Aero
longDragArea = 1.29; % m^2
longDragCoeff = .15;
longLiftCoeff = 2.95;

% Steering
wheelAngleLimit = 45 *pi/180; % rad

% Power
batteryVoltage = 500; % V

% Braking
maxBrakePressure = 5000000; % Pa
staticFriction = 0.3; 
kineticFriction = 0.2;
discBrakeActuatorBore = 0.05; % m
brakePadMeanRadius = 2; % m
numBrakePads = 2;

% Tires
tireRadius = 0.2057; % m
cornerStiffness = 20000; % N/rad
camber = 1 *pi/180; % rad
tirePressure = 83000; % Pa
lammux = 0.65;
lammuy = 0.65;

% Motor
motorSpeedBreakpoints = [ 0 500 5000 6500 6501] *2*pi*(1/60); % rad/s
motorTorqueBreakpoints = [220 230 230 175 0]; % N*m
torqueControlTimeConstant = 0.02; % s

% Powertrain
finalDriveRatio = 2;