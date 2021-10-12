%% 2-D Path Tracing with 'Inverse Kinematics'
% This example shows how to calculate inverse kinematics for simple 2D path

%% Start with a blank rigid body tree model.

robot = robotics.RigidBodyTree('DataFormat','column','MaxNumbodies',3);

% Specify arm lengths for the robot arm.
L1 = 0.4;
L2 = 0.4;

% Add ('link1') body with 'joint1') joint
body = robotics.RigidBody('link1');
joint = robotics.Joint('joint1','revolute');
setFixedTransform(joint, trvec2tform([0 0 0]));
joint.JointAxis = [0 0 1];
body.Joint = joint;
addBody(robot, body, 'base');

% Add ('link2') body with 'joint2') joint
body = robotics.RigidBody('link2');
joint = robotics.Joint('joint2','revolute');
setFixedTransform(joint, trvec2tform([L1 0 0]));
joint.JointAxis = [0 0 1];
body.Joint = joint;
addBody(robot, body, 'link1');

% Add ('link3') body with 'joint3') joint
body = robotics.RigidBody('tool');
joint = robotics.Joint('fix1','fixed');
setFixedTransform(joint, trvec2tform([L2 0 0]));
body.Joint = joint;
addBody(robot, body, 'link2');

% Show details of the robot
showdetails(robot)

%% Define the trajectory (2D path)
% Define a circle to be traced over the couse of 10 second
% Thi circle is in the xy-plane with radius of 0.15
t = (0:0.2:10)'; %Time of the movement of robot
count = length(t); 
radius1 = 1.0;
radius2 = 0.6;
center = [0.3 0.1 0]; % Origin point of robot (x0, y0) = (0.3, 0.1)
theta = t*(2*pi/t(end));
points = center + [((radius1)/2)*cos(theta) ((radius2)/2)*sin(theta) zeros(size(theta))] ;
    
%% Inverse Kinemetics Solution

q0 = homeConfiguration(robot); %Home Positon of robot
ndof = length(q0); %Number of freedom
qs = zeros(count, ndof);

% Create the inverse kinemetics solver. 
ik = robotics.InverseKinematics('RigidBodyTree', robot);
weight = [0, 0, 0, 1, 1, 0];
%Because the xy Catesian points are the only important factors of the
%end-effector pose, specify a non-zero weight fot the fourth and fifth
%element
endEffector = 'tool';

%% Loop through the trajectory of points to trace the circle

qInitial = q0; % Use home configuration as the initial guess
for i = 1:count
    %Solve for te configuration satisfying the desired position
    point = points(i,:);
    qSol = ik(endEffector, trvec2tform(point), weight, qInitial);
    %Store the configuration
    qs(i,:) = qSol;
    %Start from prior solution
    qInitial = qSol;
end

% trajectory
figure
show(robot, qs(1,:)');
view(2)
ax = gca;
ax.Projection = 'orthographic';
hold on 
plot(points(:,1), points(:,2), 'k')
axis([-0.4 1 -0.3 0.5 ])

framsPerSecond = 5;
r = robotics.Rate(framsPerSecond);
for i = 1:count
    show(robot, qs(i,:)', 'PreservePlot', false);
    drawnow
    waitfor(r);
end