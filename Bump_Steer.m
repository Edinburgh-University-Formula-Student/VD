%% Minimising Bump Steer Via Tr_out Optimisation, With Comparative Bump Steer Plots For Old Vs New Tr_out And A 3D Front Suspension Simulation Of The Optimised Geometry.

function Bump_Steer

%% Defining Variables

data = readcell('Car_Data.xlsx');

UWB_front = str2num(data{2,2}); % static coordinates of the front inboard upper wishbone joint
UWB_rear = str2num(data{3,2}); % static coordinates of the rear inboard upper wishbone joint
UWB_out = str2num(data{4,2}); % static coordinates of the outboard upper wishbone joint
LWB_front = str2num(data{5,2}); % static coordinates of the front inboard lower wishbone join
LWB_rear = str2num(data{6,2}); % static coordinates of the rear inboard lower wishbone joint
LWB_out = str2num(data{7,2}); % static coordinates of the outboard lower wishbone joint
Tr_in = str2num(data{8,2}); % static coordinates of the inboard tie rod joint
WI = str2num(data{10,2}); % static coordinates of the inboard wheel point
WO = str2num(data{11,2}); % static coordinates of the outboard wheel point
h_max = data{13,2}; % maximum Bump travel
h_min = data{14,2}; % maximum Rebound travel

%__________________________________________________________________________

%% Solving For Tr_out_target

Tr_out_target_guess = str2num(data{9,2}); % initial guess for the solver, based on the original tie-rod coordinates

lb = Tr_out_target_guess + [-20 -80 -80]; % lower bound for the optimiser, offset 80 mm below the initial guess
ub = Tr_out_target_guess + [ 20  80  80]; % upper bound for the optimiser, offset 80 mm above the initial guess

fun = @(Tr_out_target) Compute_BumpSteer_ForTrOutTarget(Tr_out_target); % creating a function handle

opts = optimoptions('lsqnonlin', 'Display', 'iter');

Tr_out_target = lsqnonlin(fun, Tr_out_target_guess, lb, ub, opts); % solving for the tie-rod target that minimises bump steer

%__________________________________________________________________________

%% Computing Bump Steer With Tr_out Replaced By Tr_out_target

    function [angle_vec_new,uwb_matrix_new,lwb_matrix_new,tr_matrix_new,wi_matrix_new,wo_matrix_new,h,n_h] = Compute_BumpSteer_ForTrOutTarget (Tr_out_target)

        Tr_out = Tr_out_target; % definit a new Tr_out

        %% Residual Functions

        function [residuals_UWB] = UWB_residuals(uwb,h)

            L_f = sqrt((UWB_front(1) - UWB_out(1)).^2 + (UWB_front(2) - UWB_out(2)).^2 + (UWB_front(3) - UWB_out(3)).^2); % static distance between the upper wishbone front inboard joint and upper wishbone outboard joint
            L_r = sqrt((UWB_rear(1) - UWB_out(1)).^2 + (UWB_rear(2) - UWB_out(2)).^2 + (UWB_rear(3) - UWB_out(3)).^2); % static distance between the upper wishbone rear inboard joint and upper wishbone outboard joint
            z_target = UWB_out(3) + h; % the outboard upper wishbone joint is forced to move vertically by h from its static position
        
            x_uwb = uwb(1); % x-coordinate of the current outboard upper wishbone point estimate
            y_uwb = uwb(2); % y-coordinate of the current outboard upper wishbone point estimate
            z_uwb = uwb(3); % z-coordinate of the current outboard upper wishbone point estimate
        
            r_1 = L_f - sqrt((UWB_front(1) - x_uwb).^2 + (UWB_front(2) - y_uwb).^2 + (UWB_front(3) - z_uwb).^2); % dist. constrained to be the same 
            r_2 = L_r - sqrt((UWB_rear(1) - x_uwb).^2 + (UWB_rear(2) - y_uwb).^2 + (UWB_rear(3) - z_uwb).^2); % dist. constrained to be the same
            r_3 = z_uwb - z_target; % vertical displacement is constrained to be the same

            residuals_UWB = [r_1; r_2; r_3]; % residual vector, fsolve adjusts uwb to drive these values toward zero

        end

        function [residuals_LWB] = LWB_residuals(lwb,h)

            L_f = sqrt((LWB_front(1) - LWB_out(1)).^2 + (LWB_front(2) - LWB_out(2)).^2 + (LWB_front(3) - LWB_out(3)).^2); % static distance between the lower wishbone front inboard joint and lower wishbone outboard joint
            L_r = sqrt((LWB_rear(1) - LWB_out(1)).^2 + (LWB_rear(2) - LWB_out(2)).^2 + (LWB_rear(3) - LWB_out(3)).^2); % static distance between the lower wishbone rear inboard joint and lower wishbone outboard joint
            z_target = LWB_out(3) + h; % the outboard lower wishbone joint is forced to move vertically by h from its static position

        
            x_lwb = lwb(1); % x-coordinate of the current outboard lower wishbone point estimate
            y_lwb = lwb(2); % y-coordinate of the current outboard lower wishbone point estimate
            z_lwb = lwb(3); % z-coordinate of the current outboard lower wishbone point estimate

            r_1 = L_f - sqrt((LWB_front(1) - x_lwb).^2 + (LWB_front(2) - y_lwb).^2 + (LWB_front(3) - z_lwb).^2); % dist. constrained to be the same 
            r_2 = L_r - sqrt((LWB_rear(1) - x_lwb).^2 + (LWB_rear(2) - y_lwb).^2 + (LWB_rear(3) - z_lwb).^2); % dist. constrained to be the same
            r_3 = z_lwb - z_target; % vertical displacement is constrained to be the same

            residuals_LWB = [r_1; r_2; r_3]; % residual vector, fsolve adjusts lwb to drive these values toward zero
        
    
        end

        function [residuals_TR] = TR_residuals(tr,UWB_out_h,LWB_out_h)

            UWB_out_h; % coordinates of the outboard upper wishbone point at the current h
            LWB_out_h; % coordinates of the outboard lower wishbone point at the current h
     
            L_t = sqrt((Tr_in(1) - Tr_out(1)).^2 + (Tr_in(2) - Tr_out(2)).^2 + (Tr_in(3) - Tr_out(3)).^2);% static distance from the tie-rod inboard joint to the outboard joint
            L_u = sqrt( (UWB_out(1) - Tr_out(1)).^2 + (UWB_out(2) - Tr_out(2)).^2 + (UWB_out(3) - Tr_out(3)).^2); % static distance between the upper wishbone outboard joint and the tie-rod outboard joint
            L_l = sqrt( (LWB_out(1) - Tr_out(1)).^2 + (LWB_out(2) - Tr_out(2)).^2 + (LWB_out(3) - Tr_out(3)).^2); % static distance between the lower wishbone outboard joint and the tie-rod outboard joint

            x_tr = tr(1); % x-coordinate of the current outboard tie rod point estimate
            y_tr = tr(2); % y-coordinate of the current outboard tie rod point estimate
            z_tr = tr(3); % z-coordinate of the current outboard tie rod point estimate

            r_1 = L_t - sqrt((Tr_in(1) - x_tr).^2 + (Tr_in(2) - y_tr).^2 + (Tr_in(3) - z_tr).^2); % dist. constrained to be the same 
            r_2 = L_u - sqrt( (UWB_out_h(1) - x_tr).^2 + (UWB_out_h(2) - y_tr).^2 + (UWB_out_h(3) - z_tr).^2); % dist. constrained to be the same 
            r_3 = L_l - sqrt( (LWB_out_h(1) - x_tr).^2 + (LWB_out_h(2) - y_tr).^2 + (LWB_out_h(3) - z_tr).^2); % dist. constrained to be the same 

            residuals_TR = [r_1; r_2; r_3]; % residual vector, fsolve adjusts tr to drive these values toward zero

        end

        function [residuals_WI] = WI_residuals(wi,UWB_out_h,LWB_out_h,Tr_out_h)

            UWB_out_h; % coordinates of the outboard upper wishbone point at the current h
            LWB_out_h; % coordinates of the outboard lower wishbone point at the current h
            Tr_out_h; % coordinates of the outboard tie rod point at the current h
        
            x_wi = wi(1); % x-coordinate of the current inboard wheel point estimate
            y_wi = wi(2); % y-coordinate of the current inboard wheel point estimate
            z_wi = wi(3); % z-coordinate of the current inboard wheel point estimate

        
            L_t = sqrt((WI(1) - Tr_out(1)).^2 + (WI(2) - Tr_out(2)).^2 + (WI(3) - Tr_out(3)).^2); % static distance between the inboard wheel point and the tie-rod outboard joint
            L_u = sqrt((WI(1) - UWB_out(1)).^2 + (WI(2) - UWB_out(2)).^2 + (WI(3) - UWB_out(3)).^2); % static distance between the inboard wheel point and the upper wishbone outboard joint
            L_l = sqrt((WI(1) - LWB_out(1)).^2 + (WI(2) - LWB_out(2)).^2 + (WI(3) - LWB_out(3)).^2); % static distance between the inboard wheel point and the lower wishbone outboard joint
        
            r_1 = L_t - sqrt((x_wi - Tr_out_h(1)).^2 + (y_wi - Tr_out_h(2)).^2 + (z_wi - Tr_out_h(3)).^2); % dist. constrained to be the same 
            r_2 = L_u - sqrt((x_wi - UWB_out_h(1)).^2 + (y_wi - UWB_out_h(2)).^2 + (z_wi - UWB_out_h(3)).^2); % dist. constrained to be the same 
            r_3 = L_l - sqrt((x_wi - LWB_out_h(1)).^2 + (y_wi - LWB_out_h(2)).^2 + (z_wi - LWB_out_h(3)).^2); % dist. constrained to be the same 

            residuals_WI = [r_1; r_2; r_3]; % residual vector, fsolve adjusts wi to drive these values toward zero
    
        end

        function [residuals_WO] = WO_residuals(wo,LWB_out_h,Tr_out_h,WI_h)

            LWB_out_h; % coordinates of the outboard lower wishbone point at the current h
            Tr_out_h; % coordinates of the outboard tie rod point at the current h
            WI_h; % coordinates of the inboard wheel point at the current h

            x_wo = wo(1); % x-coordinate of the current outboard wheel point estimate
            y_wo = wo(2); % y-coordinate of the current outboard wheel point estimate
            z_wo = wo(3); % z-coordinate of the current outboard wheel point estimate

            L_axl = sqrt((WO(1) - WI(1)).^2 + (WO(2) - WI(2)).^2 + (WO(3) - WI(3)).^2); % static distance between the inboard and outboard wheel points
            L_t = sqrt((WO(1) - Tr_out(1)).^2 + (WO(2) - Tr_out(2)).^2 + (WO(3) - Tr_out(3)).^2); % static distance between the outboard wheel point and the tie-rod outboard joint
            L_l = sqrt((WO(1) - LWB_out(1)).^2 + (WO(2) - LWB_out(2)).^2 + (WO(3) - LWB_out(3)).^2); % static distance between the outboard wheel point and the lower wishbone outboard joint

            r_1 = L_axl - sqrt((x_wo - WI_h(1)).^2 + (y_wo - WI_h(2)).^2 + (z_wo - WI_h(3)).^2); % dist. constrained to be the same 
            r_2 = L_t - sqrt((x_wo - Tr_out_h(1)).^2 + (y_wo - Tr_out_h(2)).^2 + (z_wo - Tr_out_h(3)).^2); % dist. constrained to be the same 
            r_3 = L_l - sqrt((x_wo - LWB_out_h(1)).^2 + (y_wo - LWB_out_h(2)).^2 + (z_wo - LWB_out_h(3)).^2); % dist. constrained to be the same 

            residuals_WO = [r_1; r_2; r_3]; % residual vector, fsolve adjusts wo to drive these values toward zero

        end

        %__________________________________________________________________________

        %% Wrapper Function

        function sol = solve_closest_branch(resfun, guess, prev_sol)
            % tries several initial guesses and keeps the converged solution closest to the previous step, which helps prevent the solver from jumping to a different kinematic branch
       
            opts = optimoptions('fsolve','Display', 'off');

            guesses = [ % creating the array of different guesses
              guess;
              prev_sol;
              0.5*(guess + prev_sol);
              guess + [ 2  0  0]; 
              guess + [-2  0  0];
              guess + [ 0  2  0];
              guess + [ 0 -2  0];
              guess + [ 0  0  2];
              guess + [ 0  0 -2]];

            bestScore = inf; % setting initial best score to be +infinity 
            sol = guess; % setting the initial solution to be original guess

            for k = 1:size(guesses,1)
                
                try
       
                    [cand, ~, exitflag] = fsolve(resfun, guesses(k,:), opts); % solving the residuals with given guess 
       
                    if exitflag > 0 % accepting only solutions that successful convergence
          
                        score = norm(cand - prev_sol); % measuring distance from the previous accepted solution to stay on the same branch
                    
                        if score < bestScore % checking whether the current candidate solution is closer to prev_sol than the best candidate found so far
              
                            bestScore = score; % if the current candidate is indeed closer, store its score as the new best score
                            sol = cand; % holding 'sol' as the closest converged solution seen up to that point
           
                        end
                    end
                catch
                end
            end

            if ~isfinite(bestScore)
                sol = prev_sol; % if nothing converged then use the previous answer as a solution
            end

        end
   
        %__________________________________________________________________________

        %% Solving Residuals For New Bump Steer

       h = -h_min:0.1:h_max;
       n_h = numel(h);

        uwb_matrix_new = zeros(n_h,3); % creating the matrix of three columns and n_h rows of zeros
        UWB_guess = UWB_out; % using the static UWB_out coordinate as the first guess 

        for i = 1:n_h
            if i == 1
                prev_UWB = UWB_guess; % using the static starting point as the branch reference for the first step
            else
                prev_UWB = uwb_matrix_new(i-1,:); % using the previous accepted solution as the branch reference for later steps
            end
    
            uwb_solved = solve_closest_branch(@(uwb) UWB_residuals(uwb,h(i)), UWB_guess, prev_UWB); % finding the uwb, which satisfies all three constrains
    
            uwb_matrix_new(i, :) = uwb_solved; % storing the solved uwb position in the i-th row
            UWB_guess = uwb_solved; % using the solved value as the first guess for the next step
        end


        lwb_matrix_new = zeros(n_h,3); % creating the matrix of three columns and n_h rows
        LWB_guess= LWB_out; % using the static LWB_out coordinate as the first guess 

        for i = 1:n_h
            if i == 1
                prev_LWB = LWB_guess; % using the static starting point as the branch reference for the first step
            else
                prev_LWB = lwb_matrix_new(i-1,:); % using the previous accepted solution as the branch reference for later steps
            end

            lwb_solved = solve_closest_branch(@(lwb) LWB_residuals(lwb,h(i)), LWB_guess, prev_LWB); %finding the lwb, which satisfies all three constrains

            lwb_matrix_new(i, :) = lwb_solved; % storing the solved lwb position in the i-th row
            LWB_guess = lwb_solved; % using the solved value as the first guess for the next step
        end


        tr_matrix_new = zeros(n_h,3); % creating the matrix of three columns and n_h rows
        Tr_guess = Tr_out; % using the static Tr_out coordinate as the first guess 

        for i = 1:n_h
            if i == 1
                prev_Tr = Tr_guess; % using the static starting point as the branch reference for the first step
            else
                prev_Tr = tr_matrix_new(i-1,:); % using the previous accepted solution as the branch reference for later steps
            end

            UWB_out_h = uwb_matrix_new(i, :); % defining UWB_out_h as coordinates of the outboard upper wishbone point at the current h
            LWB_out_h = lwb_matrix_new(i, :); % defining LWB_out_h as coordinates of the outboard lower wishbone point at the current h

            tr_solved = solve_closest_branch(@(tr) TR_residuals(tr,UWB_out_h,LWB_out_h),Tr_guess, prev_Tr); % finding the tr, which satisfies all three constrains
 
            tr_matrix_new(i, :) = tr_solved; % storing the solved lwb position in the i-th row  
            Tr_guess = tr_solved; % using the solved value as the first guess for the next step
        end


        wi_matrix_new = zeros(n_h,3); % creating the matrix of three columns and n_h rows
        WI_guess = WI; % using the static WI coordinate as the first guess
        
        for i = 1:n_h
            if i == 1
                prev_WI = WI_guess; % using the static starting point as the branch reference for the first step
            else
                prev_WI = wi_matrix_new(i-1,:); % using the previous accepted solution as the branch reference for later steps
            end

            UWB_out_h = uwb_matrix_new(i, :); % defining UWB_out_h as coordinates of the outboard upper wishbone point at the current h
            LWB_out_h = lwb_matrix_new(i, :); % defining LWB_out_h as coordinates of the outboard lower wishbone point at the current h
            Tr_out_h = tr_matrix_new(i,:); % defining Tr_out_h as coordinates of the outboard tie rod point at the current h

            wi_solved = solve_closest_branch(@(wi) WI_residuals(wi,UWB_out_h,LWB_out_h,Tr_out_h),WI_guess, prev_WI); % finding the wi, which satisfies all three constrains

            wi_matrix_new(i, :) = wi_solved; % storing the solved lwb position in the i-th row
            WI_guess = wi_solved; % using the solved value as the first guess for the next step
        end


        wo_matrix_new = zeros(n_h,3); % creating the matrix of three columns and n_h rows
        WO_guess = WO; % using the static WO coordinate as the first guess

        for i = 1:n_h
            if i == 1
                prev_WO = WO_guess; % using the static starting point as the branch reference for the first step
            else
                prev_WO = wo_matrix_new(i-1,:); % using the previous accepted solution as the branch reference for later steps
            end

            LWB_out_h = lwb_matrix_new(i, :); % defining LWB_out_h as coordinates of the outboard lower wishbone point at the current h
            Tr_out_h = tr_matrix_new(i,:); % defining Tr_out_h as coordinates of the outboard tie rod point at the current h
            WI_h = wi_matrix_new(i,:); % defining WI_h as coordinates of the iboard wheel point at the current h
            
            wo_solved = solve_closest_branch(@(wo) WO_residuals(wo,LWB_out_h,Tr_out_h,WI_h),WO_guess, prev_WO); %finding the wo, which satisfies all three constrains

            wo_matrix_new(i, :) = wo_solved; % storing the solved lwb position in the i-th row
            WO_guess = wo_solved; % using the solved value as the first guess for the next step
        end

        %__________________________________________________________________________
        
        %% Calculate Change In Axle Direction In Plan View For New Bump Steer

        angle_vec_new = zeros(n_h,1); % creating the matrix of one column and n_h rows
        for i = 1:n_h

            WI_h = wi_matrix_new(i, :); % defining WI_h as coordinates of the inboard wheel point at the current h
            WO_h = wo_matrix_new(i, :); % defining WO_h as coordinates of the outboard wheel point at the current h

            axle_0 = [WO(1)-WI(1), WO(2)-WI(2)]; % creating a vector of static wheel axis in plan view
            axle_h = [WO_h(1)-WI_h(1), WO_h(2)-WI_h(2)]; % creating a vector of wheel axis at the current h in plan view

            ang_0 = atan2(axle_0(2), axle_0(1)); % finding the angle between the static wheel axis and the positive x-axis
            ang_h = atan2(axle_h(2), axle_h(1)); % finding the angle between the wheel axis at the current h and the positive x-axis

            angle_vec_new(i) = ang_h - ang_0; % finding the angle between the wheel axis at the current h and the static wheel axis

        end

        %__________________________________________________________________________
    end

%__________________________________________________________________________

%% Computing Bump Steer For Original Geometry

    function [angle_vec_orig] = Compute_original_BumpSteer ()

        Tr_out = str2num(data{9,2}); % static coordinates of the outboard tie-rod joint

        %% Residual Functions

        function [residuals_UWB] = UWB_residuals(uwb,h)

            L_f = sqrt((UWB_front(1) - UWB_out(1)).^2 + (UWB_front(2) - UWB_out(2)).^2 + (UWB_front(3) - UWB_out(3)).^2); % static distance between the upper wishbone front inboard joint and upper wishbone outboard joint
            L_r = sqrt((UWB_rear(1) - UWB_out(1)).^2 + (UWB_rear(2) - UWB_out(2)).^2 + (UWB_rear(3) - UWB_out(3)).^2); % static distance between the upper wishbone rear inboard joint and upper wishbone outboard joint
            z_target = UWB_out(3) + h; % the outboard upper wishbone joint is forced to move vertically by h from its static position
        
            x_uwb = uwb(1); % x-coordinate of the current outboard upper wishbone point estimate
            y_uwb = uwb(2); % y-coordinate of the current outboard upper wishbone point estimate
            z_uwb = uwb(3); % z-coordinate of the current outboard upper wishbone point estimate
        
            r_1 = L_f - sqrt((UWB_front(1) - x_uwb).^2 + (UWB_front(2) - y_uwb).^2 + (UWB_front(3) - z_uwb).^2); % dist. constrained to be the same 
            r_2 = L_r - sqrt((UWB_rear(1) - x_uwb).^2 + (UWB_rear(2) - y_uwb).^2 + (UWB_rear(3) - z_uwb).^2); % dist. constrained to be the same
            r_3 = z_uwb - z_target; % vertical displacement is constrained to be the same

            residuals_UWB = [r_1; r_2; r_3]; % residual vector, fsolve adjusts uwb to drive these values toward zero

        end

        function [residuals_LWB] = LWB_residuals(lwb,h)

            L_f = sqrt((LWB_front(1) - LWB_out(1)).^2 + (LWB_front(2) - LWB_out(2)).^2 + (LWB_front(3) - LWB_out(3)).^2); % static distance between the lower wishbone front inboard joint and lower wishbone outboard joint
            L_r = sqrt((LWB_rear(1) - LWB_out(1)).^2 + (LWB_rear(2) - LWB_out(2)).^2 + (LWB_rear(3) - LWB_out(3)).^2); % static distance between the lower wishbone rear inboard joint and lower wishbone outboard joint
            z_target = LWB_out(3) + h; % the outboard lower wishbone joint is forced to move vertically by h from its static position

        
            x_lwb = lwb(1); % x-coordinate of the current outboard lower wishbone point estimate
            y_lwb = lwb(2); % y-coordinate of the current outboard lower wishbone point estimate
            z_lwb = lwb(3); % z-coordinate of the current outboard lower wishbone point estimate

            r_1 = L_f - sqrt((LWB_front(1) - x_lwb).^2 + (LWB_front(2) - y_lwb).^2 + (LWB_front(3) - z_lwb).^2); % dist. constrained to be the same 
            r_2 = L_r - sqrt((LWB_rear(1) - x_lwb).^2 + (LWB_rear(2) - y_lwb).^2 + (LWB_rear(3) - z_lwb).^2); % dist. constrained to be the same
            r_3 = z_lwb - z_target; % vertical displacement is constrained to be the same

            residuals_LWB = [r_1; r_2; r_3]; % residual vector, fsolve adjusts lwb to drive these values toward zero
        
    
        end

        function [residuals_TR] = TR_residuals(tr,UWB_out_h,LWB_out_h)

            UWB_out_h; % coordinates of the outboard upper wishbone point at the current h
            LWB_out_h; % coordinates of the outboard lower wishbone point at the current h
     
            L_t = sqrt((Tr_in(1) - Tr_out(1)).^2 + (Tr_in(2) - Tr_out(2)).^2 + (Tr_in(3) - Tr_out(3)).^2);% static distance from the tie-rod inboard joint to the outboard joint
            L_u = sqrt( (UWB_out(1) - Tr_out(1)).^2 + (UWB_out(2) - Tr_out(2)).^2 + (UWB_out(3) - Tr_out(3)).^2); % static distance between the upper wishbone outboard joint and the tie-rod outboard joint
            L_l = sqrt( (LWB_out(1) - Tr_out(1)).^2 + (LWB_out(2) - Tr_out(2)).^2 + (LWB_out(3) - Tr_out(3)).^2); % static distance between the lower wishbone outboard joint and the tie-rod outboard joint

            x_tr = tr(1); % x-coordinate of the current outboard tie rod point estimate
            y_tr = tr(2); % y-coordinate of the current outboard tie rod point estimate
            z_tr = tr(3); % z-coordinate of the current outboard tie rod point estimate

            r_1 = L_t - sqrt((Tr_in(1) - x_tr).^2 + (Tr_in(2) - y_tr).^2 + (Tr_in(3) - z_tr).^2); % dist. constrained to be the same 
            r_2 = L_u - sqrt( (UWB_out_h(1) - x_tr).^2 + (UWB_out_h(2) - y_tr).^2 + (UWB_out_h(3) - z_tr).^2); % dist. constrained to be the same 
            r_3 = L_l - sqrt( (LWB_out_h(1) - x_tr).^2 + (LWB_out_h(2) - y_tr).^2 + (LWB_out_h(3) - z_tr).^2); % dist. constrained to be the same 

            residuals_TR = [r_1; r_2; r_3]; % residual vector, fsolve adjusts tr to drive these values toward zero

        end

        function [residuals_WI] = WI_residuals(wi,UWB_out_h,LWB_out_h,Tr_out_h)

            UWB_out_h; % coordinates of the outboard upper wishbone point at the current h
            LWB_out_h; % coordinates of the outboard lower wishbone point at the current h
            Tr_out_h; % coordinates of the outboard tie rod point at the current h
        
            x_wi = wi(1); % x-coordinate of the current inboard wheel point estimate
            y_wi = wi(2); % y-coordinate of the current inboard wheel point estimate
            z_wi = wi(3); % z-coordinate of the current inboard wheel point estimate

        
            L_t = sqrt((WI(1) - Tr_out(1)).^2 + (WI(2) - Tr_out(2)).^2 + (WI(3) - Tr_out(3)).^2); % static distance between the inboard wheel point and the tie-rod outboard joint
            L_u = sqrt((WI(1) - UWB_out(1)).^2 + (WI(2) - UWB_out(2)).^2 + (WI(3) - UWB_out(3)).^2); % static distance between the inboard wheel point and the upper wishbone outboard joint
            L_l = sqrt((WI(1) - LWB_out(1)).^2 + (WI(2) - LWB_out(2)).^2 + (WI(3) - LWB_out(3)).^2); % static distance between the inboard wheel point and the lower wishbone outboard joint
        
            r_1 = L_t - sqrt((x_wi - Tr_out_h(1)).^2 + (y_wi - Tr_out_h(2)).^2 + (z_wi - Tr_out_h(3)).^2); % dist. constrained to be the same 
            r_2 = L_u - sqrt((x_wi - UWB_out_h(1)).^2 + (y_wi - UWB_out_h(2)).^2 + (z_wi - UWB_out_h(3)).^2); % dist. constrained to be the same 
            r_3 = L_l - sqrt((x_wi - LWB_out_h(1)).^2 + (y_wi - LWB_out_h(2)).^2 + (z_wi - LWB_out_h(3)).^2); % dist. constrained to be the same 

            residuals_WI = [r_1; r_2; r_3]; % residual vector, fsolve adjusts wi to drive these values toward zero
    
        end

        function [residuals_WO] = WO_residuals(wo,LWB_out_h,Tr_out_h,WI_h)

            LWB_out_h; % coordinates of the outboard lower wishbone point at the current h
            Tr_out_h; % coordinates of the outboard tie rod point at the current h
            WI_h; % coordinates of the insboard wheel point at the current h

            x_wo = wo(1); % x-coordinate of the current outboard wheel point estimate
            y_wo = wo(2); % y-coordinate of the current outboard wheel point estimate
            z_wo = wo(3); % z-coordinate of the current outboard wheel point estimate

            L_axl = sqrt((WO(1) - WI(1)).^2 + (WO(2) - WI(2)).^2 + (WO(3) - WI(3)).^2); % static distance between the inboard and outboard wheel points
            L_t = sqrt((WO(1) - Tr_out(1)).^2 + (WO(2) - Tr_out(2)).^2 + (WO(3) - Tr_out(3)).^2); % static distance between the outboard wheel point and the tie-rod outboard joint
            L_l = sqrt((WO(1) - LWB_out(1)).^2 + (WO(2) - LWB_out(2)).^2 + (WO(3) - LWB_out(3)).^2); % static distance between the outboard wheel point and the lower wishbone outboard joint

            r_1 = L_axl - sqrt((x_wo - WI_h(1)).^2 + (y_wo - WI_h(2)).^2 + (z_wo - WI_h(3)).^2); % dist. constrained to be the same 
            r_2 = L_t - sqrt((x_wo - Tr_out_h(1)).^2 + (y_wo - Tr_out_h(2)).^2 + (z_wo - Tr_out_h(3)).^2); % dist. constrained to be the same 
            r_3 = L_l - sqrt((x_wo - LWB_out_h(1)).^2 + (y_wo - LWB_out_h(2)).^2 + (z_wo - LWB_out_h(3)).^2); % dist. constrained to be the same 

            residuals_WO = [r_1; r_2; r_3]; % residual vector, fsolve adjusts wo to drive these values toward zero

        end

        %__________________________________________________________________________

%% Wrapper Function

        function sol = solve_closest_branch(resfun, guess, prev_sol)
            % tries several initial guesses and keeps the converged solution closest to the previous step, which helps prevent the solver from jumping to a different kinematic branch
       
            opts = optimoptions('fsolve','Display', 'off');

            guesses = [ % creating the array of different guesses
              guess;
              prev_sol;
              0.5*(guess + prev_sol);
              guess + [ 2  0  0]; 
              guess + [-2  0  0];
              guess + [ 0  2  0];
              guess + [ 0 -2  0];
              guess + [ 0  0  2];
              guess + [ 0  0 -2]];

            bestScore = inf; % setting initial best score to be +infinity 
            sol = guess; % setting the initial solution to be original guess

            for k = 1:size(guesses,1)
                
                try
       
                    [cand, ~, exitflag] = fsolve(resfun, guesses(k,:), opts); % solving the residuals with given guess 
       
                    if exitflag > 0 % accepting only solutions that succesfull convergence
          
                        score = norm(cand - prev_sol); % measuring distance from the previous accepted solution to stay on the same branch
                    
                        if score < bestScore % checking whether the current candidate solution is closer to prev_sol than the best candidate found so far
              
                            bestScore = score; % if the current candidate is indeed closer, store its score as the new best score
                            sol = cand; % holding 'sol' as the closest converged solution seen up to that point
           
                        end
                    end
                catch
                end
            end

            if ~isfinite(bestScore)
                sol = prev_sol; % if nothing converged then use the previous answer as a solution
            end

        end
   
        %__________________________________________________________________________

        %% Solving Residuals For Original Bump Steer

        h = -h_min:0.1:h_max; % range of suspension travel
        n_h = numel(h); % number of different suspension positions through the travel

        uwb_matrix = zeros(n_h,3); % creating the matrix of three columns and n_h rows of zeros
        UWB_guess = UWB_out; % using the static UWB_out coordinate as the first guess 

        for i = 1:n_h
            if i == 1
                prev_UWB = UWB_guess; % using the static starting point as the branch reference for the first step
            else
                prev_UWB = uwb_matrix(i-1,:); % using the previous accepted solution as the branch reference for later steps
            end
    
            uwb_solved = solve_closest_branch(@(uwb) UWB_residuals(uwb,h(i)), UWB_guess, prev_UWB); % finding the uwb, which satisfies all three constrains
    
            uwb_matrix(i, :) = uwb_solved; % storing the solved uwb position in the i-th row
            UWB_guess = uwb_solved; % using the solved value as the first guess for the next step
        end


        lwb_matrix = zeros(n_h,3); % creating the matrix of three columns and n_h rows
        LWB_guess= LWB_out; % using the stsatic LWB_out coordinate as the first guess 

        for i = 1:n_h
            if i == 1
                prev_LWB = LWB_guess; % using the static starting point as the branch reference for the first step
            else
                prev_LWB = lwb_matrix(i-1,:); % using the previous accepted solution as the branch reference for later steps
            end

            lwb_solved = solve_closest_branch(@(lwb) LWB_residuals(lwb,h(i)), LWB_guess, prev_LWB); %finding the lwb, which satisfies all three constrains

            lwb_matrix(i, :) = lwb_solved; % storing the solved lwb position in the i-th row
            LWB_guess = lwb_solved; % using the solved value as the first guess for the next step
        end


        tr_matrix = zeros(n_h,3); % creating the matrix of three columns and n_h rows
        Tr_guess = Tr_out; % using the stsatic Tr_out coordinate as the first guess 

        for i = 1:n_h
            if i == 1
                prev_Tr = Tr_guess; % using the static starting point as the branch reference for the first step
            else
                prev_Tr = tr_matrix(i-1,:); % using the previous accepted solution as the branch reference for later steps
            end

            UWB_out_h = uwb_matrix(i, :); % defining UWB_out_h as coordinates of the outboard upper wishbone point at the current h
            LWB_out_h = lwb_matrix(i, :); % defining LWB_out_h as coordinates of the outboard lower wishbone point at the current h

            tr_solved = solve_closest_branch(@(tr) TR_residuals(tr,UWB_out_h,LWB_out_h),Tr_guess, prev_Tr); % finding the tr, which satisfies all three constrains
 
            tr_matrix(i, :) = tr_solved; % storing the solved lwb position in the i-th row  
            Tr_guess = tr_solved; % using the solved value as the first guess for the next step
        end


        wi_matrix = zeros(n_h,3); % creating the matrix of three columns and n_h rows
        WI_guess = WI; % using the static WI coordinate as the first guess
        
        for i = 1:n_h
            if i == 1
                prev_WI = WI_guess; % using the static starting point as the branch reference for the first step
            else
                prev_WI = wi_matrix(i-1,:); % using the previous accepted solution as the branch reference for later steps
            end

            UWB_out_h = uwb_matrix(i, :); % defining UWB_out_h as coordinates of the outboard upper wishbone point at the current h
            LWB_out_h = lwb_matrix(i, :); % defining LWB_out_h as coordinates of the outboard lower wishbone point at the current h
            Tr_out_h = tr_matrix(i,:); % defining Tr_out_h as coordinates of the outboard tie rod point at the current h

            wi_solved = solve_closest_branch(@(wi) WI_residuals(wi,UWB_out_h,LWB_out_h,Tr_out_h),WI_guess, prev_WI); % finding the wi, which satisfies all three constrains

            wi_matrix(i, :) = wi_solved; % storing the solved lwb position in the i-th row
            WI_guess = wi_solved; % using the solved value as the first guess for the next step
        end


        wo_matrix = zeros(n_h,3); % creating the matrix of three columns and n_h rows
        WO_guess = WO; % using the static WO coordinate as the first guess

        for i = 1:n_h
            if i == 1
                prev_WO = WO_guess; % using the static starting point as the branch reference for the first step
            else
                prev_WO = wo_matrix(i-1,:); % using the previous accepted solution as the branch reference for later steps
            end

            LWB_out_h = lwb_matrix(i, :); % defining LWB_out_h as coordinates of the outboard lower wishbone point at the current h
            Tr_out_h = tr_matrix(i,:); % defining Tr_out_h as coordinates of the outboard tie rod point at the current h
            WI_h = wi_matrix(i,:); % defining WI_h as coordinates of the inboard wheel point at the current h

            wo_solved = solve_closest_branch(@(wo) WO_residuals(wo,LWB_out_h,Tr_out_h,WI_h),WO_guess, prev_WO); %finding the wo, which satisfies all three constrains

            wo_matrix(i, :) = wo_solved; % storing the solved lwb position in the i-th row
            WO_guess = wo_solved; % using the solved value as the first guess for the next step
        end

        %__________________________________________________________________________

%% Calculate Change In Axle Direction In Top View For Original Bump Steer

angle_vec_orig = zeros(n_h,1); % creating the matrix of one column and n_h rows

for i = 1:n_h

    WI_h = wi_matrix(i, :); % defining WI_h as coordinates of the inboard wheel point at the current h
    WO_h = wo_matrix(i, :); % defining WO_h as coordinates of the outboard wheel point at the current h

    axle_0 = [WO(1)-WI(1), WO(2)-WI(2)]; % creating a vector of static wheel axis in plan view
    axle_h = [WO_h(1)-WI_h(1), WO_h(2)-WI_h(2)]; % creating a vector of wheel axis at the current h in plan view

    ang_0 = atan2(axle_0(2), axle_0(1)); % finding the angle between the static wheel axis and the positive x-axis
    ang_h = atan2(axle_h(2), axle_h(1)); % finding the angle between the wheel axis at the current h and the positive x-axis

    angle_vec_orig(i) = ang_h - ang_0; % finding the angle between the wheel axis at the current h and the static wheel axis

end

%__________________________________________________________________________
    end

%__________________________________________________________________________

%% Plotting Bump Steer Graphs And 3D Suspension Simulation

[angle_vec_new,uwb_matrix_new,lwb_matrix_new,tr_matrix_new,wi_matrix_new,wo_matrix_new,h,n_h] = Compute_BumpSteer_ForTrOutTarget (Tr_out_target);
angle_vec_orig = Compute_original_BumpSteer ();

disp(Tr_out_target)

figure(1)

subplot(1,2,1);
plot(angle_vec_orig, h, '--b','LineWidth', 1.5)
grid on
hold on
plot(angle_vec_new, h, 'k','LineWidth', 1.5)
p_1 = plot(angle_vec_orig(1),h(1), 'r.', 'MarkerSize', 15);
p_2 = plot(angle_vec_new(1),h(1), 'r.', 'MarkerSize', 15);
axis manual
xlabel('Toe-in             0            Toe-out')
ylabel('Rebound            0               Bump')
ylim([-60 60])
xlim([-0.06 0.06])
title('Bump Steer (mm/rad)')
legend({'Original Bump Steer','New Bump Steer'},'Location','best'); 

subplot(1,2,2);
hold on
grid on
xlim([0 600]);
ylim([200 750]);
zlim([-600 -300]);
xlabel('X (mm)')
ylabel('Y (mm)')
zlabel('Z (mm)')

title('3D Kinematic Simulation of an Optimized Front Suspension')
view(3)

UWB_out_h = uwb_matrix_new(1,:);
LWB_out_h = lwb_matrix_new(1,:);
Tr_out_h = tr_matrix_new(1,:);
WI_h = wi_matrix_new(1, :);
WO_h = wo_matrix_new(1, :);

h1 = plot3([UWB_front(1) UWB_out_h(1)], [UWB_front(2) UWB_out_h(2)], [UWB_front(3) UWB_out_h(3)],'b', 'LineWidth', 2);
h2 = plot3([UWB_rear(1) UWB_out_h(1)], [UWB_rear(2) UWB_out_h(2)], [UWB_rear(3) UWB_out_h(3)],'b', 'LineWidth', 2);
h3 = plot3([LWB_rear(1) LWB_out_h(1)], [LWB_rear(2) LWB_out_h(2)], [LWB_rear(3) LWB_out_h(3)],'b', 'LineWidth', 2);
h4 = plot3([LWB_front(1) LWB_out_h(1)], [LWB_front(2) LWB_out_h(2)], [LWB_front(3) LWB_out_h(3)],'b', 'LineWidth', 2);
h5 = plot3([Tr_in(1) Tr_out_h(1)], [Tr_in(2) Tr_out_h(2)], [Tr_in(3) Tr_out_h(3)],'Color', [1 0.5 0], 'LineWidth', 2);
h6 = plot3([LWB_out_h(1) Tr_out_h(1)], [LWB_out_h(2) Tr_out_h(2)], [LWB_out_h(3) Tr_out_h(3)], 'Color', [0.5 0.5 0.5], 'LineWidth', 2);
h7 = plot3([UWB_out_h(1) Tr_out_h(1)], [UWB_out_h(2) Tr_out_h(2)], [UWB_out_h(3) Tr_out_h(3)], 'Color', [0.5 0.5 0.5], 'LineWidth', 2);
h8 = plot3([UWB_out_h(1) LWB_out_h(1)], [UWB_out_h(2) LWB_out_h(2)], [UWB_out_h(3) LWB_out_h(3)], 'Color', [0.5 0.5 0.5], 'LineWidth', 2);
h9 = plot3([WI_h(1) WO_h(1)], [WI_h(2) WO_h(2)], [WI_h(3) WO_h(3)],'g', 'LineWidth', 3);

d1 = plot3(UWB_front(1),UWB_front(2),UWB_front(3), 'b.', 'MarkerSize', 15);
d2 = plot3(UWB_rear(1),UWB_rear(2),UWB_rear(3), 'b.', 'MarkerSize', 15);
d3 = plot3(UWB_out_h(1),UWB_out_h(2),UWB_out_h(3),'.', 'Color', [0.5 0.5 0.5], 'MarkerSize', 15);
d4 = plot3(LWB_front(1),LWB_front(2),LWB_front(3), 'b.', 'MarkerSize', 15);
d5 = plot3(LWB_rear(1),LWB_rear(2),LWB_rear(3), 'b.', 'MarkerSize', 15);
d6 = plot3(LWB_out_h(1),LWB_out_h(2),LWB_out_h(3),'.', 'Color', [0.5 0.5 0.5], 'MarkerSize', 15);
d7 = plot3(Tr_in(1),Tr_in(2),Tr_in(3),'.', 'Color', [1 0.5 0], 'MarkerSize', 15);
d8 = plot3(Tr_out_h(1),Tr_out_h(2),Tr_out_h(3),'.', 'Color', [1 0.5 0], 'MarkerSize', 15);
d9 = plot3(WI_h(1),WI_h(2),WI_h(3), 'g.', 'MarkerSize', 15);
d10 = plot3(WO_h(1),WO_h(2),WO_h(3), 'g.', 'MarkerSize', 15);

while true
    
    for i = 1:n_h

        p_1.XData = angle_vec_orig(i);
        p_1.YData = h(i);

        p_2.XData = angle_vec_new(i);
        p_2.YData = h(i);

        UWB_out_h = uwb_matrix_new(i, :);
        LWB_out_h = lwb_matrix_new(i,:);
        Tr_out_h = tr_matrix_new(i, :);
        WI_h = wi_matrix_new(i, :);
        WO_h = wo_matrix_new(i, :);

        set(h1, 'XData',[UWB_front(1) UWB_out_h(1)], 'YData',[UWB_front(2) UWB_out_h(2)], 'ZData',[UWB_front(3) UWB_out_h(3)]);
        set(h2, 'XData',[UWB_rear(1) UWB_out_h(1)], 'YData',[UWB_rear(2) UWB_out_h(2)], 'ZData',[UWB_rear(3) UWB_out_h(3)]);
        set(h3, 'XData',[LWB_rear(1) LWB_out_h(1)], 'YData',[LWB_rear(2) LWB_out_h(2)], 'ZData',[LWB_rear(3) LWB_out_h(3)]);
        set(h4, 'XData',[LWB_front(1) LWB_out_h(1)], 'YData',[LWB_front(2) LWB_out_h(2)], 'ZData',[LWB_front(3) LWB_out_h(3)]);
        set(h5, 'XData',[Tr_in(1) Tr_out_h(1)], 'YData',[Tr_in(2) Tr_out_h(2)], 'ZData',[Tr_in(3) Tr_out_h(3)]);
        set(h6, 'XData',[LWB_out_h(1) Tr_out_h(1)], 'YData',[LWB_out_h(2) Tr_out_h(2)], 'ZData',[LWB_out_h(3) Tr_out_h(3)]);
        set(h7, 'XData',[UWB_out_h(1) Tr_out_h(1)], 'YData',[UWB_out_h(2) Tr_out_h(2)], 'ZData',[UWB_out_h(3) Tr_out_h(3)]);
        set(h8, 'XData',[UWB_out_h(1) LWB_out_h(1)], 'YData',[UWB_out_h(2) LWB_out_h(2)], 'ZData',[UWB_out_h(3) LWB_out_h(3)]);
        set(h9, 'XData',[WI_h(1) WO_h(1)], 'YData',[WI_h(2) WO_h(2)], 'ZData',[WI_h(3) WO_h(3)]);

        set(d3, 'XData',UWB_out_h(1), 'YData',UWB_out_h(2),'ZData',UWB_out_h(3))
        set(d6, 'XData',LWB_out_h(1), 'YData',LWB_out_h(2),'ZData',LWB_out_h(3))
        set(d8, 'XData',Tr_out_h(1), 'YData',Tr_out_h(2),'ZData',Tr_out_h(3))
        set(d9, 'XData',WI_h(1), 'YData',WI_h(2),'ZData',WI_h(3))
        set(d10, 'XData',WO_h(1), 'YData',WO_h(2),'ZData',WO_h(3))

        drawnow
        pause(0.001)
    end
end

%__________________________________________________________________________

end
