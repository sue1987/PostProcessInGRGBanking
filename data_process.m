%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%data_process,v1,July 5th
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  media paramters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

media_length = 120;
media_width = 60;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   data decomposition and preprocess
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time = sim_result(:,1);
x1 = sim_result(:,2);
y1 = sim_result(:,3);
z1 = sim_result(:,4);
x2 = sim_result(:,5);
z2 = sim_result(:,6);
x3 = sim_result(:,7);
z3 = sim_result(:,8);
xc = sim_result(:,9);
zc = sim_result(:,10);
baseline_force = sim_result(:,11);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% time = sim_result(:,1);
% x1 = sim_result(:,2);
% y1 = sim_result(:,4);
% z1 = sim_result(:,6);
% x2 = sim_result(:,8);
% z2 = sim_result(:,10);
% x3 = sim_result(:,12);
% z3 = sim_result(:,14);
% xc = sim_result(:,16);
% zc = sim_result(:,18);
% baseline_force = sim_result(:,20);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   find the coordinate of the point 4 based on point 3 and point c
sita = atan(media_width/media_length);
rotate_array=[cos(sita),sin(sita);-sin(sita),cos(sita)];
temp_vector = [zc-z3,xc-x3];
temp_array = temp_vector*rotate_array;
z4_ = temp_array(:,1);
x4_ = temp_array(:,2);
rital = 2 * media_length / sqrt(media_length^2 + media_width^2);
z4 = (z4_  * rital) + z3;
x4 = (x4_  * rital) + x3;

%baseline coordinate
z_baseline=116.75;
baseline_length = 250;
%leftline angle unit du
angle_1_2 = atan((z1-z2)./(x1-x2)) * 180 / pi;

%velosity of the center
velocity_time = time(1:(length(time)-1),1);
velocity_c_x = zeros(length(xc)-1,1);
velocity_c_z = zeros(length(zc)-1,1);
velocity_1_z = zeros(length(z1)-1,1);
for i =1:1:length(xc)-1
    velocity_c_x(i) = (xc(i+1)-xc(i))/(time(i+1)-time(i));
end
for i =1:1:length(xc)-1
    velocity_c_z(i) = (zc(i+1)-zc(i))/(time(i+1)-time(i));
end
for i =1:1:length(z1)-1
    velocity_1_z(i) = (z1(i+1)-z1(i))/(time(i+1)-time(i));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%time of collision
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% time of collision based on z1
% collision_position_1 = -1;
% collision_happened_1 = false;
% collision_happened_2 = false;
% for i = 1:1:length(time)
%     if(z1(i)>z_baseline)
%         collision_position_1 = i;
%         collision_happened_1 = true;
%         break;
%     end
% end
% time of collision based on force
collision_position_2 = -1;
for i = 1:1:length(time)
    if(baseline_force(i) > 0 && x1(i) < baseline_length)
        collision_position_2 = i;
        collision_happened_2 = true;
        break;
    end
end

% collision happened or not
if(collision_happened_2)
    display('**********************collsion parameters*****************************')
    display('collsion happened ');
    %display(['collision_position_1 = ' num2str(collision_position_1 - 1)]);
    display(['collision_position_2 = ' num2str(collision_position_2 - 1)]);
else
    display('collsion did not happen ');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	collision parameters caculation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(collision_happened_2)
    
    % angle, force, velocity, x coordinate when collision
    angle_collision =  angle_1_2(collision_position_2);
    
    force_collision = baseline_force(collision_position_2);
    
    point1_x_collision =  x1(collision_position_2);
    
    
    velocity_collision_2 = (z1(collision_position_2) - z1(collision_position_2 - 1))/(time(collision_position_2) - time(collision_position_2 - 1));
    velocity_collsion =  velocity_collision_2;
    
%     acc_collision_1 = (z1(collision_position_1) + z1(collision_position_1 - 2) - 2*z1(collision_position_1 - 1))/0.00001;
%     acc_collision_2 = (z1(collision_position_2) + z1(collision_position_2 - 2) - 2*z1(collision_position_2 - 1))/0.00001;
%     
%     acc_collosion = max(acc_collision_1,acc_collision_2);
    
    display(['angle_collision = ' num2str( angle_collision)]);
    display(['force_collision = ' num2str( force_collision)]);
    display(['point1_x_collision = ' num2str( point1_x_collision)]);
    display(['velocity_collsion = ' num2str( velocity_collsion)]);
    %display(['acc_collosion = ' num2str( acc_collosion)]);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% align position parameters 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% align_position = -1;% -1 is unvalid position
% if(collision_happened_1 && collision_happened_2)
%     for i = collision_position_1:1:length(time)
%         if(angle_1_2(i) <= 2)
%             align_poistion = i;
%         end
%     end
% end
% 
% if(align_position ~= -1)
%     time_used_to_align = align_poisition - collision_position_1;
%     %display('********end position parameters************')
%     display(['time used to align = ' num2str(time_used_to_align)]);
% end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% end position parameters 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end_position = length(time);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% senser position parameters 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
senser_position = -1;
for i = 1:1:length(time)
       if(x1(i) >= 292)
            senser_position = i;
            break;
       end
end
if(senser_position ~= -1)
    senser_angle = angle_1_2(i);
    display('**************senser event position parameters*************************')
    display(['senser_angle = ' num2str(senser_angle)]);
else
    display('no senser event');
end
    
