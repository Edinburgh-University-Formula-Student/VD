%% Ackermann Curve Comparison And Optimised Geometry (a, b, theta)

function p_sol = Ackermann_Geometry()

%% Defining Variables

data = readcell('Car_Data.xlsx');
Tr_in = str2num(data{8,2}); % static coordinates of the inboard tie rod joint
Tr_out = str2num(data{9,2}); % static coordinates of the outboard tie-rod joint
W_c = str2num(data{12,2}); % static coordinates of the wheel centre
TW = data{26,2}; % track width
h = data{19,2}; % maximum linear travel per side

S = data{18,2}; % length of the steering rack
theta = data{20,2}; % angle between steering arm and an upright
a = W_c(1) - Tr_out(1); % steering arm length
h = -h:0.1:h ; % rack displacement along its axis positive from left to right)
w = TW - 2*(W_c(2) - Tr_out(2)); % effective lateral distance between left and right steering-arm–to-upright joints in plan view
b = sqrt((Tr_in(1) - Tr_out(1)).^2 + (Tr_in(2) - Tr_out(2)).^2); % length of the Tie Rod in top view
u = W_c(1) - Tr_in(1); % longitudinal distance from the front axle centreline to the Steering rack

u_new = 0; % changed longitudinal distance from the front axle centreline to the Steering rack

%__________________________________________________________________________

%% Optimising Steering Geometry (a, b, theta)

 [original_Ackermann_geometry,x,y] = Compute_original_Ackermann();

 p0 = [a, b, theta]; % initial guess for the optimiser
 lb = [0.05, 0.05, 0]; % lower bound for the optimiser
 ub = [200, 500,  pi/2]; % upper bound for the optimiser
 
 fun = @(p) ackermann_residual(p, h, S, w, u_new, original_Ackermann_geometry);  % creating a function handle

 opts = optimoptions('lsqnonlin','Display', 'none');

 p_sol = lsqnonlin(fun, p0, lb, ub, opts); % solving for new steering arm length (a), tie-rod length (b), and steering arm angle (theta)

%__________________________________________________________________________

%% Computing Mean Ackermann Error

 [residual,x_new,y_new] = ackermann_residual(p_sol, h, S, w, u_new, original_Ackermann_geometry);
  
 error = norm(residual)/sqrt(numel(residual)); % mean residual error over all h values (0 means the new geometry exactly matches the original Ackermann curve)
 disp(error)

%__________________________________________________________________________

%% Plotting Ackermann Curves

 figure
 plot(x_new, y_new, 'b-', 'LineWidth', 1.5)
 hold on
 plot(x, y, 'r--', 'LineWidth', 1.5)
 hold off
 grid on
 xlim([-0.6 0.6]);
 ylim([-0.05 0.05]);
 ylabel('Inner - Outer');
 xlabel('(Inner + Outer)/2');
 title('Ackermann Curve');
 legend({'New geometry','Original geometry'},'Location','best');  

%__________________________________________________________________________

%% Residual Function For New Geometry

    function [residual,x_new,y_new] = ackermann_residual(p, h, S, w, u_new, Original_Ackermann_geometry)

        a = p(1); % new steering arm length
        b = p(2); % new tie-rod length
        theta = p(3); % angle between the steering arm and the upright
        u = u_new;

        inside  = zeros(size(h)); % creating a matrix of zeros of length of h
        outside = zeros(size(h)); % creating a matrix of zeros of length of h

        for k = 1:numel(h)
            inside(k)  = Inside_turn_angle(a,b,S,w,u,h(k),theta); % computing inside angle for each rack displacement h(k)
            outside(k) = Outside_turn_angle(a,b,S,w,u,h(k),theta); % computing outside angle for each rack displacement h(k)
        end

        x_new = (inside + outside)/2;
        y_new = inside - outside;

        residual = [Original_Ackermann_geometry(:,1) - x_new(:); Original_Ackermann_geometry(:,2) - y_new(:)]; 

    end

%__________________________________________________________________________

%% Original Ackermann Geometry

    function [original_Ackermann_geometry,x,y] = Compute_original_Ackermann()

        inside  = zeros(size(h)); % creating a matrix of zeros of length of h
        outside = zeros(size(h)); % creating a matrix of zeros of length of h

        for k = 1:numel(h) 
           inside(k)  = Inside_turn_angle(a,b,S,w,u,h(k),theta); % computing inside angle for each rack displacement h(k)
           outside(k) = Outside_turn_angle(a,b,S,w,u,h(k),theta); % computing outside angle for each rack displacement h(k)
       end

       y = inside - outside;
       x = (inside + outside)/2;

       original_Ackermann_geometry = [x(:), y(:)];
   
    end

%__________________________________________________________________________

%% Inside Wheel Angle

    function deltaI = Inside_turn_angle(a,b,S,w,u,h,theta)
       % computing inside wheel steer angle deltaI from steering geometry parameters
           
        f = @(deltaI) (h - (1/2)*(S - w) - a*sin(theta + deltaI))^2 + (a*cos(theta + deltaI) - u)^2 - b^2;
        deltaI  = fzero(f, 0);  % finding deltaI such that f(deltaI) = 0, starting from 0 rad

    end
       
%__________________________________________________________________________

%% Outside Wheel Angle

    function deltaO = Outside_turn_angle(a,b,S,w,u,h,theta)
        % computing inside wheel steer angle deltaO from steering geometry parameters

        f = @(deltaO) (-a * sin(theta -deltaO) - h - (1/2)*(S - w) )^2 - b^2 + (a * cos(theta - deltaO) - u)^2;
        deltaO  = fzero(f, 0);  % finding deltaI such that f(deltaO) = 0, starting from 0 rad
      
    end

%__________________________________________________________________________

end

%__________________________________________________________________________
