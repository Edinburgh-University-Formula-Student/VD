%% Finding Maximum Off-Axis Force The Wheel Can Exert On The Steering Rack

function Max_Off_Axis_Rack_F ()

% according to SAE convention

% positive x: forwards along the vehicle's longitudinal axis (towards the front).
% positive y: to the left side of the vehicle.
% positive z: upward from the road surface.
% (hence positive moment around the axis is anticlockwise)

% this case analyses off-axis force on the steering rack, from the outside
% wheel as the car is turning left and braking
  
%% Raw Data in SI Units

data = readcell('Car_Data.xlsx');

UWB_out = str2num(data{4,2})*10.^-3; % coordinates  of the outboard pick-up point of the Upper Wishbone (m)
LWB_out = str2num(data{7,2})*10.^-3; % coordinates  of the outboard pick-up point of the Lower Wishbone (m)
Tr_in = str2num(data{8,2})*10.^-3; % coordinates  of the inboard pick-up point of the Tie rod (m)
Tr_out = str2num(data{9,2})*10.^-3; % coordinates  of the outboard pick-up point of the Tie rod (m)
W_c = str2num(data{12,2})*10.^-3; %  coordinates  of the wheel centre (m)
WD_long = data{23,2}; % weight distribution to the front with the driver 
WD_lat = data{24,2}; % weight distribution to the left with the driver
C = data{16,2}; % caster angle (rad)
nu = data{29,2}; % longitudinal coefficient of friction
KPI = data{15,2};  % kingpin axis inclination  (rad)
theta = data{20,2}; % angle between steering arm and an upright (rad)
WB = data{25,2}*10.^-3; % wheel base of the car(m)
TW = data{26,2}*10.^-3; % track width of the car (m)
CoG_h = data{22,2}*10.^-3; % height of the centre of gravity above the ground(m)
S = data{18,2}*10.^-3; % length of the steering rack (m)
Sr = data{17,2}*10.^-3; % scrub radius(m)
Ty_d = data{27,2}*10.^-3; % tyre diameter(m)
m = data{21,2}; % mass of the car(kg)

%__________________________________________________________________________

%% Finding The Combination Of Lateral And Longitudinal Accelerations

[ax_from_ay, ayMax_GG, axMin_GG,Vtop] = GG_relation(); % importing GG relation

V = Vtop; % setting the speed at which accelerations will be found to the maximum speed 

ayValues = linspace(0,ayMax_GG); % defining all the cornering acceleration values to test
axValues = linspace(0,-axMin_GG); % defining all the braking acceleration values to test

MaxAbsForce = -Inf; % defining the initial best (highest) rack force to be negative infinity
momentAtMaxRackForce = NaN; 
axAtMaxRackForce = NaN;
ayAtMaxRackForce = NaN;  
% leaving other parameters as undefined, as they will be tied to the actual
% moment values


for a_x = axValues % taking all a_x one by one values
    for a_y = ayValues % then taking all the a_y values one by one for given a_x

        axGGlimit = -ax_from_ay(a_y); % using the GG relationship to find maximum a_x values that the GG relationship allows for a given a_y

        if a_x > axGGlimit % checking if our a_x is smaller then the  maximum a_x 
            continue % if it is (meaning it is within GG relationship), pass it further
        end % if it is not, stop

        try
            [Mtotal, F_Steer_rack] = Off_Axis_Rack_F(a_x, a_y, V); % passing the a_x a_y combination that followed GG relationship successfully  through the total Moment formula

            if abs(F_Steer_rack) > MaxAbsForce % setting the new Off-axis Steering Rack Force to be bestAbsRF if its absolute value is above the absolute value of the highest Off-axis Steering Rack Force to this point (note that the initial bestAbsRF was set to - Inf, so that any existing value would be above it)
                MaxAbsForce = abs(F_Steer_rack);
                momentAtMaxRackForce = Mtotal;
                axAtMaxRackForce = a_x;
                ayAtMaxRackForce = a_y;
                MaxForce = F_Steer_rack; % assigning all the other variables for that bestAbsRF
            end
        catch ME
            warning('Skipped ax = %.3f, ay = %.3f: %s', ...
            a_x, a_y, ME.message);
        end
    end
end

fprintf('\nMaximum |Rack force| condition:\n');
fprintf('Rack force          = %.3f N\n', MaxForce);
fprintf('|Rack force|        = %.3f N\n', MaxAbsForce);
fprintf('a_x             = %.3f m/s^2\n', axAtMaxRackForce);
fprintf('a_y             = %.3f m/s^2\n', ayAtMaxRackForce);
fprintf('Mtotal      = %.3f Nm\n', momentAtMaxRackForce);

%__________________________________________________________________________

%% Finding Maximum Off-axis Steering Rack Force and Moment Around Steering Axis

function [Mtotal, F_Steer_rack] = Off_Axis_Rack_F(a_x, a_y, V)

    %% Finding Self-Aligning Torque

    function [MZ] = Aligning_Torque(FY)

        % according to SAE convention for TYRES

        % positive x: forwards along the vehicle's longitudinal axis (towards the front).
        % positive y: to the right side of the vehicle.
        % positive z: downward from the road surface.

        TTC = load('B1706run2.mat', 'P', 'IA', 'FZ', 'FY','MZ'); 

        P_all  = TTC.P;
        IA_all = TTC.IA;
        FZ_all = TTC.FZ;
        FY_all = TTC.FY;
        MZ_all = TTC.MZ;

        FYq = -FY;
        IAq = 0;
        Pq = 96.526; % maximum wheel pressure tested in the TTC (kPa)
        Fzl_y = -(m * 9.81 * WD_long * (1 - WD_lat) + W_y); % finding the vertical load on a tyre, but excluding the longitudinal load transfer

        FZ_levels = -[50 100 150 200 250]' * 4.4482216153; % converting loads at which the tyre was tested in the TTC , converted from lbf to N

        [~, idxLoad] = min(abs(FZ_levels - Fzl_y)); % finding closest available load level to the requested load

        FZq_used = FZ_levels(idxLoad); % setting the load on a wheel from TTC that will actually be used.

        [~, idxP] = min(abs(P_all-Pq)); % finding an index of the pressure value closest to the pressure we want in the data set
        P_near = P_all(idxP); % finding the actual nearest pressure value that the data set has

        [~, idxIA] = min(abs(IA_all-IAq)); % finding an index of the camber value closest to the camber we want in the data set
        IA_near = IA_all(idxIA); % finding the actual nearest pressure value that the data set has

        [~, idxFZ] = min(abs(FZ_all-FZq_used)); % finding an index of the vertical load on a tyre value closest to the vertical load on a tyre we want in the data set
        FZ_near = FZ_all(idxFZ); % finding the actual nearest vertical load on a tyre value that the data set has

        tolP  = 0.1;
        tolIA = 0.05;
        tolFZ = 10;

        mask = abs(P_all  - P_near)  <= tolP  & abs(IA_all - IA_near) <= tolIA & abs(FZ_all - FZ_near) <= tolFZ; % our x_near values, are the closest values in arrays of x to the value we want, 
        % however, now we want to see all the data that was found AT THE GIVEN X_NEAR values, so we create a mask

        FY_sub = FY_all(mask); % finding all the lateral force values at our mask settings
        MZ_sub = MZ_all(mask); % finding all the slip values at our mask settings

        [FY_sub_sorted, sortIdx] = sort(FY_sub); % because the data is not guaranteed to be sorted, we are sorting it from the smallest to the biggest; we also get sortIdx
        % which tells us what index the value had before sorting, hence if we have for example [122, ...] that means before sorting our first value was 122 

        MZ_sub_sorted = MZ_sub(sortIdx);
        % we then use the sortIdx to tell MZ how to arrange its values to se the
        % nth Fy corresponds to the nth MZ value

        [FY_unique, ia] = unique(FY_sub_sorted, 'stable');% now we are ensuring that the FY has unique values; that is done because the mask we made can still pass several rows of values, therefore there can be duplicates, which will break our function
        MZ_unique = MZ_sub_sorted(ia);% we then use the ia to tell MZ how to arrange its values to se the
        % nth FY corresponds to the nth MZ value

        if FYq < min(FY_unique) || FYq > max(FY_unique)
            error('FYq = %.1f N is outside the available FY range: %.1f to %.1f N.', FYq, min(FY_unique), max(FY_unique));
        end

        MZ = interp1(FY_unique, MZ_unique, FYq, 'linear'); % interpolating Aligning torque value for a given lateral force from the tyre data

    end

    %% Finding Steer Angle

    function [deltaO,h] = Steer_Angle(a_y,V)

        a = (W_c(1) - Tr_out(1)); % steering arm length
        w = (TW - 2*(W_c(2) - Tr_out(2))); % effective lateral distance between left and right steering-arm–to-upright joints in plan view
        b = (sqrt((Tr_in(1) - Tr_out(1)).^2 + (Tr_in(2) - Tr_out(2)).^2)); % length of the Tie Rod in top view
        u = (W_c(1) - Tr_in(1)); % longitudinal distance from the front axle centreline to the Steering rack

        f_3 = @(h) Constraining_Angle(h, theta, a, b, u, S, w, WB, a_y, V); % defining f3(h) which will internally solves for deltaI(h), deltaO(h)

        h  = fzero(f_3, 0); % solving f3(h) for the value of h

        deltaO = Solving_for_Deltas(h, theta, a, b, u, S, w); % finding deltaO with found h

        function [deltaO, deltaI] = Solving_for_Deltas(h, theta, a, b, u, S, w)

            f_1 = @(deltaI) (h - 0.5*(S - w) - a*sin(theta + deltaI)).^2 + (a*cos(theta + deltaI) - u).^2 - b.^2; 

            f_2 = @(deltaO) (-a*sin(theta - deltaO) - h - 0.5*(S - w)).^2 - b.^2 + (a*cos(theta - deltaO) - u).^2;

            deltaI = fzero(f_1, 0); % solving f_1 for deltaI
            deltaO = fzero(f_2, 0); % solving f_2 for deltaO

        end

        function [angle_const] = Constraining_Angle(h, theta, a, b, u, S, w, WB, a_y, V)

            [deltaO, deltaI] = Solving_for_Deltas(h, theta, a, b, u, S, w);

            angle_const = WB * a_y / V.^2 - (deltaO + deltaI)/2; % constraining the mean of the physical inner- and outer-wheel steering angles to bicycle-model steering angle

        end

    end

    %% Finding Orthogonal Distance From The Steering Axis To The Tie rod

    function [Tr_out_new,Tr_in_h,h,Orth_d] = Orth_D()

        function [residuals_TR] = TR_out_residuals(trout,Tr_in_h)
   
            L_t = sqrt((Tr_in(1) - Tr_out(1)).^2 + (Tr_in(2) - Tr_out(2)).^2 + (Tr_in(3) - Tr_out(3)).^2);% static distance from the tie-rod inboard joint to the outboard joint
            L_u = sqrt( (UWB_out(1) - Tr_out(1)).^2 + (UWB_out(2) - Tr_out(2)).^2 + (UWB_out(3) - Tr_out(3)).^2); % static distance between the upper wishbone outboard joint and the tie-rod outboard joint 
            L_l = sqrt( (LWB_out(1) - Tr_out(1)).^2 + (LWB_out(2) - Tr_out(2)).^2 + (LWB_out(3) - Tr_out(3)).^2); % static distance between the lower wishbone outboard joint and the tie-rod outboard joint
 
            x_trout = trout(1); % x-coordinate of the current outboard tie rod point estimate   
            y_trout = trout(2); % y-coordinate of the current outboard tie rod point estimate  
            z_trout = trout(3); % z-coordinate of the current outboard tie rod point estimate

            r_1 = L_t - sqrt((Tr_in_h(1) - x_trout).^2 + (Tr_in_h(2) - y_trout).^2 + (Tr_in_h(3) - z_trout).^2); % dist. constrained to be the same 
            r_2 = L_u - sqrt( (UWB_out(1) - x_trout).^2 + (UWB_out(2) - y_trout).^2 + (UWB_out(3) - z_trout).^2); % dist. constrained to be the same 
            r_3 = L_l - sqrt( (LWB_out(1) - x_trout).^2 + (LWB_out(2) - y_trout).^2 + (LWB_out(3) - z_trout).^2); % dist. constrained to be the same 

            residuals_TR = [r_1; r_2; r_3]; % residual vector, fsolve adjusts trout to drive these values toward zero
    
        end

        [deltaO,h] = Steer_Angle(a_y,V);
    
        Tr_in_h = [Tr_in(1), Tr_in(2) + h , Tr_in(3)]; % defining the new tie-rod inboard joint coordinates, as static coordinates plus the steering rack displacement along the lateral axis
    
        Tr_guess = Tr_out; % using the static Tr_out coordinate as the first guess
        opts = optimoptions('fsolve','Display', 'off');
    
        Tr_out_new = fsolve(@(trout) TR_out_residuals(trout,Tr_in_h),Tr_guess,opts); % finding the trout, which satisfies all three constrains
    
        a1 = LWB_out;
        a2 = Tr_in_h;
    
        b1 = UWB_out - LWB_out;
        b2 = Tr_in_h - Tr_out_new;

        Orth_d = (abs(dot(cross(b1,b2), (a2-a1))) / norm(cross(b1,b2))); % orthogonal distance from the steering axis to the tie rod (m)
    
    end

    %% Finding Angle Between The Tie rod And Steering Rack's Axis

    function lateral_angle = Outside_rack_angle()

        [Tr_out_new,Tr_in_h,h,Orth_d] = Orth_D();

        a = (W_c(1) - Tr_out(1)); % steering arm length
        w = (TW - 2*(W_c(2) - Tr_out(2))); % effective lateral distance between left and right steering-arm–to-upright joints in plan view
        b = (sqrt((Tr_in(1) - Tr_out(1)).^2 + (Tr_in(2) - Tr_out(2)).^2)); % length of the Tie Rod in top view
        u = (W_c(1) - Tr_in(1)); % longitudinal distance from the front axle centreline to the Steering rack

        v0 = [221.31-221.31, 0-220.98];
        vh = [Tr_in(1)-Tr_out(1), Tr_in(2)-Tr_out(2)];

        ang0 = atan2(v0(2), v0(1)); % finding the angle between the steering rack and the positive x-axis
        angh = atan2(vh(2), vh(1)); % finding the angle between static tie-rod and the positive x-axis

        phi = angh - ang0; % finding an angle between the static tie-rod and the steering rack

        f = @(psi) (b*sin(phi+psi)-u).^2 + (-b*cos(phi+psi)-h-0.5*(S-w)).^2 - a.^2; % solving for the increase in angle between the steering rack and tie rod for a given h

        psi  = fzero(f, 0); % solving f for psi, with starting guess as 0

        lateral_angle = phi+psi; %  angle between the steering rack and tie-rod at a given h

    end

    %% Finding the Total Moment Around a Steering Axis

    W_x = m * (a_x) * CoG_h / WB; % longitudinal load transfer (N)
    W_y = a_y * m  * CoG_h * WD_long / TW; % lateral Load Transfer (N)

    Fz_o = (m * 9.81 * WD_long + W_x) * (1 - WD_lat) + W_y; % total vertical load front outside wheel (N)
    Fx_o = - Fz_o * nu; % tractive force front outside wheel (N)

    F_yf = a_y * m  * WD_long; % lateral force acting on the front axle 
    Fz_i = (m * 9.81 * WD_long + W_x) * WD_lat - W_y; % vertical load on the front inner tyre
    FY = F_yf * Fz_o / (Fz_o + Fz_i); % lateral force on the front outer wheel

    deltaO = Steer_Angle(a_y, V);
    MZ = Aligning_Torque(FY);

    Mv = - Fz_o * Sr * sin(KPI) * sin(deltaO) - Fz_o * Sr * sin(C) * cos(deltaO); % moment caused by a vertical force (N*m)
    Ml = FY * Ty_d / 2 * tan(C); % moment caused by a lateral force (N*m)
    Mt = - Fx_o * Sr; % moment caused by a tractive force (N*m)
    Mat = - MZ * cos(sqrt(KPI.^2 + C.^2)); % resolving aligning torque around the steering axis (N*m)

    Mtotal = Mv + Mt + Mat + Ml; % total moment around a kingpin axis (N*m)

    %__________________________________________________________________________

    %% Finding Off-axis Force On The Steering Rack

    lateral_angle = Outside_rack_angle();
    [Tr_out_new,Tr_in_h,h,Orth_d] = Orth_D();

    F_tierod = Mtotal / Orth_d; % force through the tie rod from the total reaction moment (N)

    F_Steer_rack = F_tierod * sin(lateral_angle); % component of the force through the tie rod that act perpendicular to the axis of the steering rack (N)

    %__________________________________________________________________________

end

 %__________________________________________________________________________

%% Finding GG relation from 'Point-Mass Laptime Simulator'
    
    function [ax_from_ay, ayMax_GG, axMin_GG,Vtop] = GG_relation()

        filetable = readtable("Vehicle Profile for PM-LTS.xlsx"); 
        file = table2array(filetable(:,2));

        % Necessary
        Mass = file(1); % Mass (kg)
        C_Drag = file(2); % Drag Coefficient (Coefficient)
        C_Lift = file(3); % Downforce Coefficient (Coefficient)
        Area = file(4); % Aero Surfaces Area (m^2)
        Rho = file(5); % Air Density (kg/m^3)
        C_Roll = file(16); % Rolling Resistence Coefficient (Coefficient)
        CF_Long = file(17); % Longitudinal Friction From Tyres (Coefficient)
        CF_Lat = file(18); % Lateral Friction From Tyres (Coefficient)
        D_mux = file(19); % Rate Of Lateral Friction Lost From Normal Force (Coefficient)
        D_muy = file(19); % Rate Of Longitudinal Friction Lost From Normal Force (Coefficient)
        Braking_Wheels = file(31); % Wheels Braking (Number Of)

        %% GGV Calculations
        Track_Incl = 0; % Track Inclination
        Track_Bank = 0; % Track Bank, can be used as an array with array indexing
        vMax = 50; % Maximum velocity, needs to exceed vehicle top speed in order to account for braking
        N = 45; % Resolution of GGV plot length and width-wise
        dv = 0.5; % Resolution of the GGV plot heightwise
        v = (0:dv:vMax)';

        if v(end)~=vMax % Defines the array
            v = [v;vMax];
        end

        GGV = zeros(length(v),2*N-1,3); % Defines the GGV matrix

        % GGV Looping Per Velocity
        for i=1:length(v)
            Aero_Downforce = (0.5 * Rho * Area * C_Lift * v(i)^2); % Aero Downforce (Total Force) (Affected by Velocity)
            Aero_Drag = (0.5 * Rho * Area * C_Drag * v(i)^2); % Aero Drag (Total Forces) (Affected by Velocity)
            Roll_Drag = C_Roll * abs(-1*(-1* Mass * 9.81 * cosd(Track_Incl) * cosd(Track_Bank)) - Aero_Downforce); % Rolling Drag (Total Force) (Affected by Velocity)
            ax_drag = (Aero_Drag + Roll_Drag + (Mass * 9.81 * sin(Track_Incl)))/Mass; % Total Drag Forces, in Acceleration form
            ay_max = (1/Mass) * (CF_Lat + D_muy*((Mass*9.81/Braking_Wheels)  -  (-1 * (-1* Mass * 9.81 * cosd(Track_Incl) * cosd(Track_Bank))   -  Aero_Downforce)/Braking_Wheels)) * (-1 * (-1* Mass * 9.81 * cosd(Track_Incl) * cosd(Track_Bank))   -  Aero_Downforce); % Maximum Lateral Acceleration Available From Tyres
            ax_tyre_max_dec = (-1/Mass) * (CF_Long + D_mux*( (Mass*9.81/Braking_Wheels) - (-1 * (-1* Mass * 9.81 * cosd(Track_Incl) * cosd(Track_Bank)) - Aero_Downforce)/Braking_Wheels)) * (-1 * (-1* Mass * 9.81 * cosd(Track_Incl) * cosd(Track_Bank)) - Aero_Downforce); % Maximum Longitudinal Deceleration Available From Tyres
            ay = ay_max*cosd(linspace(0,180,N))' ; % Creates The Array For all possible Lateral Acceleration values
            ax_dec = ax_tyre_max_dec*sqrt(1-(ay/ay_max).^2)+ax_drag ; % Friction Ellipse For Longitudinal Deceleration creates an array of friction limited a_x for each a_y, hence N=0 will give us a_y = max and a_x = 0

            % GGV 3D Matrix
            GGV(i,:,1) = [ax_dec', ax_dec(2:end)'];
            GGV(i,:,2) = [ay',flipud(ay(2:end))'];
            GGV(i,:,3) = v(i)*ones(1,2*N-1);
        end

        %------------------------------------------------------------------
        
        positiveAy = ay >= 0; % creating a mask which gives true if the value is above or equal to 0 and false if otherwise

        ay_GG = flipud(ay(positiveAy)); % mask is aplied to the array of ay values, to give us an aray of purely positve ay values, while also ensuring the array goes in ascending order
        ax_GG = flipud(ax_dec(positiveAy)); % mask is then aplied to the array of ax values, to give us an aray of ax values for positive ay values, while also ensuring the array goes in ascending order

        ayMax_GG = max(ay_GG); % we create a variable for maximum ay value
        axMin_GG = min(ax_GG); % we create a variable for minimum ax value
        Vtop = max(v); % we create a variable for maximum v value

        ax_from_ay = @(a_y) interp1(ay_GG, ax_GG,a_y, 'pchip'); % this creates a function that tells us which a_x value is possible form the GG relaionship given some a_y

    end

 %__________________________________________________________________________

end