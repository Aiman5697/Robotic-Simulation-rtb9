clear
clc

%% initial position
a1 = 325;
a2 = 225;
d1 = 430;
d3 = -60;
L1 = Link([0,d1,a1,0,0]);
L2 = Link([0,0,a2,0,0]);
L3 = Link([0,d3,0,0,1]);
L4 = Link([0,0,0,0,0]);
bot = SerialLink([L1 L2 L3 L4], 'name', 'SCARA');
bot.fkine([0 0 -60 0]);

%% read path input
path = readmatrix('Path_2dEllipse3.csv');
plot3(path(:,1),path(:,2),path(:,3)); grid;
T1 = transl(path);

%% inverse kinematic
qs = bot.ikine(T1,[0.616 -0.25 -130 0],[1,1,1,1,0,0]);
figure
subplot(3,1,1); plot(qs(:,1)); xlabel('Time (s)'); ylabel('Joint 1 (rad)');
subplot(3,1,2); plot(qs(:,2)); xlabel('Time (s)'); ylabel('Joint 2 (rad)');
subplot(3,1,3); plot(qs(:,3)); xlabel('Time (s)'); ylabel('Joint 3 (mm)');

%% forward kinematic
bot.fkine(qs);
figure
bot.plot([0.616 -0.25 -130 0],'workspace',[-100,700,-400,400,0,500]);
view(40,50)

for i = 1:(length(qs)-1)
    bot.plot(qs,'workspace',[-100,700,-400,400,0,500]);
    pause(0.02)
end