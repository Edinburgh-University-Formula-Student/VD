% Track attributes:
str1len = 500; %Temporary
turn1len = 100; %Temporary
turn1rad = 60; %Temporary
deltaX = 5; 

straight1d = 0:deltaX:str1len;
straight1 = zeros(2, ((str1len/deltaX)+1));
straight1(1,:) = straight1d;
turn1d = 0:deltaX:turn1len;
turn1 = turn1rad * ones(2, ((turn1len/deltaX)+1));
turn1(1,:) = turn1d;
track1 = [straight1 turn1];

% Expiremental
track1(2,45) = 150;
track1(2,46) = 150;
track1(2,47) = 150;
track1(2,48) = 15;
track1(2,49) = 70;


track1(2,61) = 7;
track1(2,62) = 6;
track1(2,63) = 5;
track1(2,64) = 6;
track1(2,65) = 7;

trackIncl = 0;
trackBank = 0;


% Car attributes:
filetable = readtable("Vehicle Profile for PM-LTS.xlsx");
file = table2array(filetable(:,2));

Mass = file(1);
Cdrag = file(2);
Clift = file(3);
Area = file(4);
rho = file(5);
MaxSteering = file(6);
EngTorque = file(7);
TyreD = file(8);
BrakeTorque = file(9);
Croll = file(10);
CFLong = file(11);
CFLat = file(12);


totalz = FzTotal(Mass, Area, rho, 6, Clift, trackIncl, trackBank)
totalx = Mass * -9.81 * sin(trackIncl) + (0.5 * rho * Area * Cdrag * Velocity^2) + (Croll * abs(FzTotal()) + 



ax = 5;
ay = 3;

% Track configs:
% apex_speed_turn1 = sqrt(ay*turn1rad);

acceleration_speed = zeros(2,length(track1));

for i=2 : length(track1)
    if track1(2,i) == 0
    acceleration_speed(1,i) = sqrt((acceleration_speed(1,i-1)^2) + 2 * ax * deltaX );
    else
    acceleration_speed(1,i) = sqrt(ay*track1(2,i));
    end
end

 deceleration_speed = zeros(2,length(track1));

 for i=length(track1):-1:2
    if track1(2,i) == 0
    deceleration_speed(1,i) = sqrt((deceleration_speed(1,i+1)^2) + 2 * ax * deltaX );
    else
    deceleration_speed(1,i) = sqrt(ay*track1(2,i));
    end
 end

 final_speed = min(acceleration_speed,deceleration_speed);
 times = deltaX ./ final_speed;
 times(:,1) = [];
 total_time = sum(times, 2);
 total_time(2,:) = []

 hold on
 plot(final_speed(1,:))
 % disp(sum(times(1,2), "all"))
 title(['final time = ' num2str(total_time) ' seconds'])
 hold off