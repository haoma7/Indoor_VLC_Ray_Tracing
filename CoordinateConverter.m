function RoomCoordinate = CoordinateConverter(LocalCoordinate, Indicator)
% convert the local coordinate to the room coordinate

% author@mhrex(Hao MA) Nov.14,2014

x_local = LocalCoordinate(1);
y_local = LocalCoordinate(2);
z_local = LocalCoordinate(3);


switch(Indicator)
    case 'north'
        %% North
        theta_x = -pi/2;
        theta_y = pi/2;
        theta_z = 0;
       
    case 'south'
        %% South
        theta_x = -pi/2;
        theta_y = -pi/2;
        theta_z = 0;
    case 'east'
        %% East
        theta_x = pi/2;
        theta_y = 0;
        theta_z = -pi;
    case 'west'
        %% West
        theta_x = -pi/2;
        theta_y = 0;
        theta_z = 0;
    case 'floor'
        %% Floor
        theta_x = 0;
        theta_y = 0;
        theta_z = 0;
    case 'ceiling'
        %% Ceiling
        theta_x = -pi;
        theta_y = 0;
        theta_z = 0;
end
x_room = x_local*cos(theta_y)*cos(theta_z)+y_local*cos(theta_y)*sin(theta_z)-z_local*sin(theta_y);
y_room = -x_local*(cos(theta_x)*sin(theta_z)-sin(theta_x)*sin(theta_y)*cos(theta_z))+y_local*(cos(theta_x)*cos(theta_z)+sin(theta_x)*sin(theta_y)*sin(theta_z))+z_local*sin(theta_x)*cos(theta_y);
z_room = x_local*(sin(theta_x)*sin(theta_z)+cos(theta_x)*sin(theta_y)*cos(theta_z))-y_local*(sin(theta_x)*cos(theta_z)-cos(theta_x)*sin(theta_y)*sin(theta_z))+z_local*cos(theta_x)*cos(theta_y);


RoomCoordinate = [x_room,y_room,z_room];
