%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%left_line_plot only key point,v1,July 5th
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot baseline
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
line_width = 3;
vector_x = [z_baseline,z_baseline];
vector_y = [0,250];
figure(1)
plot(vector_x,vector_y,'-b','LineWidth',line_width);
xlim([0 130]);
ylim([-200 400]);
axis equal;
hold on;
for i=0:20:230
    vector_x = [z_baseline,z_baseline + 20];
    vector_y = [i,i+20];
    plot(vector_x,vector_y,'-b','LineWidth',1);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot media on the key points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[mem,max_angle_position]=max(angle_1_2);
c_p = max(collision_position_1,collision_position_2);
if c_p ~= -1
    key_point = [1,collision_position_1,senser_position];
else
    key_point = 1:10:71;
end

%key_point = [1,31,41,55,71];
% 
%l = length(key_point);
%key_point(l+1) = 55;
for i = 1:1:length(key_point)
    if(key_point(i) ~= -1)% validation
        vector_x = [z2(key_point(i)),z1(key_point(i))];
        vector_y = [x2(key_point(i)),x1(key_point(i))];
        plot(vector_x,vector_y,'--*r','LineWidth',1);
        text(z4(key_point(i)),x4(key_point(i)),num2str(angle_1_2(key_point(i))),'horiz','center');
        %text(z4(key_point(i)),x4(key_point(i)),num2str(angle_1_2(key_point(i))),'horiz','center');
    
        vector_x = [z3(key_point(i)),z2(key_point(i))];
        vector_y = [x3(key_point(i)),x2(key_point(i))];
        plot(vector_x,vector_y,'--*r','LineWidth',1);
    
        vector_x = [z4(key_point(i)),z3(key_point(i))];
        vector_y = [x4(key_point(i)),x3(key_point(i))];
        plot(vector_x,vector_y,'--*r','LineWidth',1);
    
        vector_x = [z1(key_point(i)),z4(key_point(i))];
        vector_y = [x1(key_point(i)),x4(key_point(i))];
        plot(vector_x,vector_y,'--*r','LineWidth',1);
    end
end
if(collision_happened_1 && collision_happened_2)
    text(z_baseline+30,x1(collision_position_1),['time of collision =',num2str(collision_position_1)],'horiz','left');
    text(z_baseline+30,x1(collision_position_1)-25,['position =',num2str(point1_x_collision)],'horiz','left');
    text(z_baseline+30,x1(collision_position_1)-50,['velocity =',num2str(velocity_collsion)],'horiz','left');
    text(z_baseline+30,x1(collision_position_1)-75,['angle =',num2str(angle_1_2(collision_position_1))],'horiz','left');
end
hold off
