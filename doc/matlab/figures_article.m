clc; clear; close;
%% Load Data
load('data/processed/chirp_models.mat')

%% Assigning Bandwidth
bw_RT_FE_m1(:,3) = [gs(9).bandwidth.model_frontal_motor, gs(7).bandwidth.model_frontal_motor, gs(8).bandwidth.model_frontal_motor];
bw_RT_FE_m1(:,2) = [gs(3).bandwidth.model_frontal_motor, gs(1).bandwidth.model_frontal_motor, gs(2).bandwidth.model_frontal_motor];
bw_RT_FE_m1(:,1) = [gs(6).bandwidth.model_frontal_motor, gs(4).bandwidth.model_frontal_motor, gs(5).bandwidth.model_frontal_motor];

bw_RT_FE_m2(:,3) = [gs(9).bandwidth.model_posterior_motor, gs(7).bandwidth.model_posterior_motor, gs(8).bandwidth.model_posterior_motor];
bw_RT_FE_m2(:,2) = [gs(3).bandwidth.model_posterior_motor, gs(1).bandwidth.model_posterior_motor, gs(2).bandwidth.model_posterior_motor];
bw_RT_FE_m2(:,1) = [gs(6).bandwidth.model_posterior_motor, gs(4).bandwidth.model_posterior_motor, gs(5).bandwidth.model_posterior_motor];

bw_T_FE_m1(:,3) = [gs(18).bandwidth.model_frontal_motor, gs(16).bandwidth.model_frontal_motor, gs(17).bandwidth.model_frontal_motor];
bw_T_FE_m1(:,2) = [gs(12).bandwidth.model_frontal_motor, gs(10).bandwidth.model_frontal_motor, gs(11).bandwidth.model_frontal_motor];
bw_T_FE_m1(:,1) = [gs(15).bandwidth.model_frontal_motor, gs(13).bandwidth.model_frontal_motor, gs(14).bandwidth.model_frontal_motor];

bw_T_FE_m2(:,3) = [gs(18).bandwidth.model_posterior_motor, gs(16).bandwidth.model_posterior_motor, gs(17).bandwidth.model_posterior_motor];
bw_T_FE_m2(:,2) = [gs(12).bandwidth.model_posterior_motor, gs(10).bandwidth.model_posterior_motor, gs(11).bandwidth.model_posterior_motor];
bw_T_FE_m2(:,1) = [gs(15).bandwidth.model_posterior_motor, gs(13).bandwidth.model_posterior_motor, gs(14).bandwidth.model_posterior_motor];

bw_T_S_m1(:,3) = [gs(27).bandwidth.model_frontal_motor, gs(25).bandwidth.model_frontal_motor, gs(26).bandwidth.model_frontal_motor];
bw_T_S_m1(:,2) = [gs(21).bandwidth.model_frontal_motor, gs(19).bandwidth.model_frontal_motor, gs(20).bandwidth.model_frontal_motor];
bw_T_S_m1(:,1) = [gs(24).bandwidth.model_frontal_motor, gs(22).bandwidth.model_frontal_motor, gs(23).bandwidth.model_frontal_motor];

bw_T_S_m2(:,3) = [gs(27).bandwidth.model_posterior_motor, gs(25).bandwidth.model_posterior_motor, gs(26).bandwidth.model_posterior_motor];
bw_T_S_m2(:,2) = [gs(21).bandwidth.model_posterior_motor, gs(19).bandwidth.model_posterior_motor, gs(20).bandwidth.model_posterior_motor];
bw_T_S_m2(:,1) = [gs(24).bandwidth.model_posterior_motor, gs(22).bandwidth.model_posterior_motor, gs(23).bandwidth.model_posterior_motor];

%All configurations
bw_total_m1(1,1:3) = [bw_RT_FE_m1(3,1),bw_T_FE_m1(3,1),bw_T_S_m1(3,1)];
bw_total_m1(1,4:6) = [bw_RT_FE_m1(3,2),bw_T_FE_m1(3,2),bw_T_S_m1(3,2)];
bw_total_m1(1,7:9) = [bw_RT_FE_m1(3,3),bw_T_FE_m1(3,3),bw_T_S_m1(3,3)];
bw_total_m1(2,1:3) = [bw_RT_FE_m1(2,1),bw_T_FE_m1(2,1),bw_T_S_m1(2,1)];
bw_total_m1(2,4:6) = [bw_RT_FE_m1(2,2),bw_T_FE_m1(2,2),bw_T_S_m1(2,2)];
bw_total_m1(2,7:9) = [bw_RT_FE_m1(2,3),bw_T_FE_m1(2,3),bw_T_S_m1(2,3)];
bw_total_m1(3,1:3) = [bw_RT_FE_m1(1,1),bw_T_FE_m1(1,1),bw_T_S_m1(1,1)];
bw_total_m1(3,4:6) = [bw_RT_FE_m1(1,2),bw_T_FE_m1(1,2),bw_T_S_m1(1,2)];
bw_total_m1(3,7:9) = [bw_RT_FE_m1(1,3),bw_T_FE_m1(1,3),bw_T_S_m1(1,3)];

bw_total_m2(1,1:3) = [bw_RT_FE_m2(3,1),bw_T_FE_m2(3,1),bw_T_S_m2(3,1)];
bw_total_m2(1,4:6) = [bw_RT_FE_m2(3,2),bw_T_FE_m2(3,2),bw_T_S_m2(3,2)];
bw_total_m2(1,7:9) = [bw_RT_FE_m2(3,3),bw_T_FE_m2(3,3),bw_T_S_m2(3,3)];
bw_total_m2(2,1:3) = [bw_RT_FE_m2(2,1),bw_T_FE_m2(2,1),bw_T_S_m2(2,1)];
bw_total_m2(2,4:6) = [bw_RT_FE_m2(2,2),bw_T_FE_m2(2,2),bw_T_S_m2(2,2)];
bw_total_m2(2,7:9) = [bw_RT_FE_m2(2,3),bw_T_FE_m2(2,3),bw_T_S_m2(2,3)];
bw_total_m2(3,1:3) = [bw_RT_FE_m2(1,1),bw_T_FE_m2(1,1),bw_T_S_m2(1,1)];
bw_total_m2(3,4:6) = [bw_RT_FE_m2(1,2),bw_T_FE_m2(1,2),bw_T_S_m2(1,2)];
bw_total_m2(3,7:9) = [bw_RT_FE_m2(1,3),bw_T_FE_m2(1,3),bw_T_S_m2(1,3)];

%% Max Torque Values

max_torque_RT_FE_flexion(:,3) = [gs(9).max_values.flexion, gs(7).max_values.flexion, gs(8).max_values.flexion];
max_torque_RT_FE_flexion(:,2) = [gs(3).max_values.flexion, gs(1).max_values.flexion, gs(2).max_values.flexion];
max_torque_RT_FE_flexion(:,1) = [gs(6).max_values.flexion, gs(4).max_values.flexion, gs(5).max_values.flexion];

max_torque_RT_FE_extension(:,3) = [gs(9).max_values.extension, gs(7).max_values.extension, gs(8).max_values.extension];
max_torque_RT_FE_extension(:,2) = [gs(3).max_values.extension, gs(1).max_values.extension, gs(2).max_values.extension];
max_torque_RT_FE_extension(:,1) = [gs(6).max_values.extension, gs(4).max_values.extension, gs(5).max_values.extension];

max_torque_T_FE_flexion(:,3) = [gs(18).max_values.flexion, gs(16).max_values.flexion, gs(17).max_values.flexion];
max_torque_T_FE_flexion(:,2) = [gs(12).max_values.flexion, gs(10).max_values.flexion, gs(11).max_values.flexion];
max_torque_T_FE_flexion(:,1) = [gs(15).max_values.flexion, gs(13).max_values.flexion, gs(14).max_values.flexion];

max_torque_T_FE_extension(:,3) = [gs(18).max_values.extension, gs(16).max_values.extension, gs(17).max_values.extension];
max_torque_T_FE_extension(:,2) = [gs(12).max_values.extension, gs(10).max_values.extension, gs(11).max_values.extension];
max_torque_T_FE_extension(:,1) = [gs(15).max_values.extension, gs(13).max_values.extension, gs(14).max_values.extension];

max_torque_T_S_flexion(:,3) = [gs(27).max_values.flexion, gs(25).max_values.flexion, gs(26).max_values.flexion];
max_torque_T_S_flexion(:,2) = [gs(21).max_values.flexion, gs(19).max_values.flexion, gs(20).max_values.flexion];
max_torque_T_S_flexion(:,1) = [gs(24).max_values.flexion, gs(22).max_values.flexion, gs(23).max_values.flexion];

max_torque_T_S_extension(:,3) = [gs(27).max_values.extension, gs(25).max_values.extension, gs(26).max_values.extension];
max_torque_T_S_extension(:,2) = [gs(21).max_values.extension, gs(19).max_values.extension, gs(20).max_values.extension];
max_torque_T_S_extension(:,1) = [gs(24).max_values.extension, gs(22).max_values.extension, gs(23).max_values.extension];

%All configurations
max_torque_flexion(1,1:3) = [max_torque_RT_FE_flexion(3,1),max_torque_T_FE_flexion(3,1),max_torque_T_S_flexion(3,1)];
max_torque_flexion(1,4:6) = [max_torque_RT_FE_flexion(3,2),max_torque_T_FE_flexion(3,2),max_torque_T_S_flexion(3,2)];
max_torque_flexion(1,7:9) = [max_torque_RT_FE_flexion(3,3),max_torque_T_FE_flexion(3,3),max_torque_T_S_flexion(3,3)];
max_torque_flexion(2,1:3) = [max_torque_RT_FE_flexion(2,1),max_torque_T_FE_flexion(2,1),max_torque_T_S_flexion(2,1)];
max_torque_flexion(2,4:6) = [max_torque_RT_FE_flexion(2,2),max_torque_T_FE_flexion(2,2),max_torque_T_S_flexion(2,2)];
max_torque_flexion(2,7:9) = [max_torque_RT_FE_flexion(2,3),max_torque_T_FE_flexion(2,3),max_torque_T_S_flexion(2,3)];
max_torque_flexion(3,1:3) = [max_torque_RT_FE_flexion(1,1),max_torque_T_FE_flexion(1,1),max_torque_T_S_flexion(1,1)];
max_torque_flexion(3,4:6) = [max_torque_RT_FE_flexion(1,2),max_torque_T_FE_flexion(1,2),max_torque_T_S_flexion(1,2)];
max_torque_flexion(3,7:9) = [max_torque_RT_FE_flexion(1,3),max_torque_T_FE_flexion(1,3),max_torque_T_S_flexion(1,3)];

max_torque_extension(1,1:3) = [max_torque_RT_FE_extension(3,1),max_torque_T_FE_extension(3,1),max_torque_T_S_extension(3,1)];
max_torque_extension(1,4:6) = [max_torque_RT_FE_extension(3,2),max_torque_T_FE_extension(3,2),max_torque_T_S_extension(3,2)];
max_torque_extension(1,7:9) = [max_torque_RT_FE_extension(3,3),max_torque_T_FE_extension(3,3),max_torque_T_S_extension(3,3)];
max_torque_extension(2,1:3) = [max_torque_RT_FE_extension(2,1),max_torque_T_FE_extension(2,1),max_torque_T_S_extension(2,1)];
max_torque_extension(2,4:6) = [max_torque_RT_FE_extension(2,2),max_torque_T_FE_extension(2,2),max_torque_T_S_extension(2,2)];
max_torque_extension(2,7:9) = [max_torque_RT_FE_extension(2,3),max_torque_T_FE_extension(2,3),max_torque_T_S_extension(2,3)];
max_torque_extension(3,1:3) = [max_torque_RT_FE_extension(1,1),max_torque_T_FE_extension(1,1),max_torque_T_S_extension(1,1)];
max_torque_extension(3,4:6) = [max_torque_RT_FE_extension(1,2),max_torque_T_FE_extension(1,2),max_torque_T_S_extension(1,2)];
max_torque_extension(3,7:9) = [max_torque_RT_FE_extension(1,3),max_torque_T_FE_extension(1,3),max_torque_T_S_extension(1,3)];

%% Bandwidth plot
% Rigid and Tendons Flexion-Extension
figure(1);
subplot(1,2,1);
bar3(bw_RT_FE_m1)
axis_opt=gca;
axis_opt.XTickLabels = {'20';'10';'5'};
axis_opt.YTickLabel = {'3';'6';'12'};
axis_opt.FontName = 'Times New Roman'; axis_opt.FontSize = 20;
title('Frontal Motor')
zlabel('Bandwidth [Hz]'); ylabel('Input Amplitude [deg]'); xlabel('Pretension level [N]')
xh = get(gca,'XLabel'); set(xh, 'Units', 'Normalized'); pos = get(xh, 'Position'); set(xh, 'Position',[0.645302740059901,-0.039320564527296,0],'Rotation',21)
yh = get(gca,'YLabel'); set(yh, 'Units', 'Normalized'); pos = get(yh, 'Position');set(yh, 'Position',[0.195468782973871,0.113192948210867,0],'Rotation',-33.5)

subplot(1,2,2);
bar3(bw_RT_FE_m2)
axis_opt=gca;
axis_opt.XTickLabels = {'20';'10';'5'};
axis_opt.YTickLabel = {'3';'6';'12'};
axis_opt.FontName = 'Times New Roman'; axis_opt.FontSize = 20;
title('Posterior Motor')
zlabel('Bandwidth [Hz]'); ylabel('Input Amplitude [deg]'); xlabel('Pretension level [N]')
xh = get(gca,'XLabel'); set(xh, 'Units', 'Normalized'); pos = get(xh, 'Position'); set(xh, 'Position',[0.639787147868203,-0.042263474446632,0],'Rotation',21)
yh = get(gca,'YLabel'); set(yh, 'Units', 'Normalized'); pos = get(yh, 'Position');set(yh, 'Position',[0.20455353708656,0.113362466409029,0],'Rotation',-33.5)

s_title = suptitle('Bandwidth for Rigid and Tendons configuration in Flexion-Extension ');
s_title.FontName = 'Times New Roman'; s_title.FontSize = 25;

% Tendons Flexion-Extension
figure(2);
subplot(1,2,1);
bar3(bw_T_FE_m1)
axis_opt=gca;
axis_opt.XTickLabels = {'20';'10';'5'};
axis_opt.YTickLabel = {'3';'6';'12'};
axis_opt.FontName = 'Times New Roman'; axis_opt.FontSize = 20;
title('Frontal Motor')
zlabel('Bandwidth [Hz]'); ylabel('Input Amplitude [deg]'); xlabel('Pretension level [N]')
xh = get(gca,'XLabel'); set(xh, 'Units', 'Normalized'); pos = get(xh, 'Position'); set(xh, 'Position',[0.645302740059901,-0.039320564527296,0],'Rotation',21)
yh = get(gca,'YLabel'); set(yh, 'Units', 'Normalized'); pos = get(yh, 'Position');set(yh, 'Position',[0.195468782973871,0.113192948210867,0],'Rotation',-33.5)

subplot(1,2,2);
bar3(bw_T_FE_m2)
axis_opt=gca;
axis_opt.XTickLabels = {'20';'10';'5'};
axis_opt.YTickLabel = {'3';'6';'12'};
axis_opt.FontName = 'Times New Roman'; axis_opt.FontSize = 20;
title('Posterior Motor')
zlabel('Bandwidth [Hz]'); ylabel('Input Amplitude [deg]'); xlabel('Pretension level [N]')
xh = get(gca,'XLabel'); set(xh, 'Units', 'Normalized'); pos = get(xh, 'Position'); set(xh, 'Position',[0.639787147868203,-0.042263474446632,0],'Rotation',21)
yh = get(gca,'YLabel'); set(yh, 'Units', 'Normalized'); pos = get(yh, 'Position');set(yh, 'Position',[0.20455353708656,0.113362466409029,0],'Rotation',-33.5)

s_title = suptitle('Bandwidth for Tendons configuration in Flexion-Extension ');
s_title.FontName = 'Times New Roman'; s_title.FontSize = 25;

% Tendons Stiffness
figure(3);
subplot(1,2,1);
bar3(bw_T_S_m1)
axis_opt=gca;
axis_opt.XTickLabels = {'20';'10';'5'};
axis_opt.YTickLabel = {'3';'6';'12'};
axis_opt.FontName = 'Times New Roman'; axis_opt.FontSize = 20;
title('Frontal Motor')
zlabel('Bandwidth [Hz]'); ylabel('Input Amplitude [deg]'); xlabel('Pretension level [N]')
xh = get(gca,'XLabel'); set(xh, 'Units', 'Normalized'); pos = get(xh, 'Position'); set(xh, 'Position',[0.645302740059901,-0.039320564527296,0],'Rotation',21)
yh = get(gca,'YLabel'); set(yh, 'Units', 'Normalized'); pos = get(yh, 'Position');set(yh, 'Position',[0.195468782973871,0.113192948210867,0],'Rotation',-33.5)

subplot(1,2,2);
bar3(bw_T_S_m2)
axis_opt=gca;
axis_opt.XTickLabels = {'20';'10';'5'};
axis_opt.YTickLabel = {'3';'6';'12'};
axis_opt.FontName = 'Times New Roman'; axis_opt.FontSize = 20;
title('Posterior Motor')
zlabel('Bandwidth [Hz]'); ylabel('Input Amplitude [deg]'); xlabel('Pretension level [N]')
xh = get(gca,'XLabel'); set(xh, 'Units', 'Normalized'); pos = get(xh, 'Position'); set(xh, 'Position',[0.639787147868203,-0.042263474446632,0],'Rotation',21)
yh = get(gca,'YLabel'); set(yh, 'Units', 'Normalized'); pos = get(yh, 'Position');set(yh, 'Position',[0.20455353708656,0.113362466409029,0],'Rotation',-33.5)

s_title = suptitle('Bandwidth for Tendons configuration in Stiffness ');
s_title.FontName = 'Times New Roman'; s_title.FontSize = 25;

clear pos

%% Bandwidth of the all Configurations
close all;

% Colors
color_RT_FE = [0 0.450980392156863 0.741176470588235];  
color_T_FE = [0.929411764705882 0.690196078431373 0.129411764705882];
color_T_S = [0.486274509803922 0.780392156862745 0.07843137254902];
    
fig_all_trials = figure('WindowState','maximized');
fig_all_trials.PaperPositionMode = 'manual';
fig_all_trials.Position = [1,41,1536,748.8];
fig_all_trials.InnerPosition = [1,41,1536,748.8];
fig_all_trials.OuterPosition = [-6.2,33.8,1550.4,838.4];
fig_all_trials.PaperPosition = [3.75,1.6,16,7.8];
fig_all_trials.PaperSize = [8.5,11];
subplot(1,2,1);
    bar_opt = bar3(bw_total_m1);
    axis_opt=gca;
    axis_opt.XTick = [1 2 3 4 5 6 7 8 9];
    axis_opt.XTickLabels = {'';'20';'';'';'10';'';'';'5';''};
    axis_opt.YTickLabel = {'12';'6';'3'};
    axis_opt.OuterPosition = [-0.011953725399205,-0.022174705901546,0.490990096037426,1.07383279613194];
    axis_opt.Position = [0.05187498708566,0.125946901672967,0.41851326254281,0.875173728847528];
    
    axis_opt.FontName = 'Times New Roman'; axis_opt.FontSize = 15;
    title('Frontal Motor')
    zlabel('Bandwidth [Hz]','FontName','Times New Roman');
    ylabel('Input Amplitude [deg]','FontName','Times New Roman','Rotation',-33.5,'Position',[-0.083048157216573,1.953320870761503,-0.70347624068192]);
    xlabel('Pretension level [N]','FontName','Times New Roman','Rotation',21,'Position',[4.237658625041923,4.027161145020195,-2.35760541032536]);

    

    bar_opt(1).FaceColor = color_RT_FE;
    bar_opt(2).FaceColor = color_T_FE;
    bar_opt(3).FaceColor = color_T_S;
    bar_opt(4).FaceColor = color_RT_FE;
    bar_opt(5).FaceColor = color_T_FE;
    bar_opt(6).FaceColor = color_T_S;
    bar_opt(7).FaceColor = color_RT_FE;
    bar_opt(8).FaceColor = color_T_FE;
    bar_opt(9).FaceColor = color_T_S;

subplot(1,2,2);
    bar_opt = bar3(bw_total_m2);
    axis_opt=gca;
    axis_opt.XTick = [1 2 3 4 5 6 7 8 9];
    axis_opt.XTickLabels = {'';'20';'';'';'10';'';'';'5';'';};
    axis_opt.YTickLabel = {'12';'6';'3'};
    axis_opt.OuterPosition = [0.50727858874968,-0.01465831865941,0.512298888632177,0.944972390479376];
    axis_opt.Position = [0.552395820418991,0.169288644293322,0.418513262542809,0.770152498240692];
    
    axis_opt.FontName = 'Times New Roman'; axis_opt.FontSize = 15;
    title('Posterior Motor')
    zlabel('Bandwidth [Hz]','FontName','Times New Roman');
    ylabel('Input Amplitude [deg]','FontName','Times New Roman','Rotation',-33.5,'Position',[-0.140244689825224,1.955623686005774,-0.960228830006756]);
    xlabel('Pretension level [N]','FontName','Times New Roman','Rotation',21,'Position',[4.170732595578776,4.114380844720087,-3.127863042480386]);

    bar_opt(1).FaceColor = color_RT_FE;
    bar_opt(2).FaceColor = color_T_FE;
    bar_opt(3).FaceColor = color_T_S;
    bar_opt(4).FaceColor = color_RT_FE;
    bar_opt(5).FaceColor = color_T_FE;
    bar_opt(6).FaceColor = color_T_S;
    bar_opt(7).FaceColor = color_RT_FE;
    bar_opt(8).FaceColor = color_T_FE;
    bar_opt(9).FaceColor = color_T_S;

    leg_opt = legend('Stiff and Tendon in FE','Tendon in FE','Tendon in S');
    set(leg_opt,'Position',[0.826701388888879,0.090113540144337,0.1415364609162,0.090010685747505]);
    
s_title = suptitle('Bandwidth of the motors for all configurations');
s_title.FontName = 'Times New Roman'; s_title.FontSize = 25;

clear *_opt xh yh bw* color* fig_* s_*

%% Max torque values of the all Configurations
% Colors
color_RT_FE = [0 0.450980392156863 0.741176470588235];  
color_T_FE = [0.929411764705882 0.690196078431373 0.129411764705882];
color_T_S = [0.486274509803922 0.780392156862745 0.07843137254902];
    
fig_all_trials = figure('WindowState','maximized');
fig_all_trials.PaperPositionMode = 'manual';
fig_all_trials.Position = [1,41,1536,748.8];
fig_all_trials.InnerPosition = [1,41,1536,748.8];
fig_all_trials.OuterPosition = [-6.2,33.8,1550.4,838.4];
fig_all_trials.PaperPosition = [3.75,1.6,16,7.8];
fig_all_trials.PaperSize = [8.5,11];
subplot(1,2,1);
    bar_opt = bar3(max_torque_flexion);
    axis_opt=gca;
    axis_opt.XTick = [1 2 3 4 5 6 7 8 9];
    axis_opt.XTickLabels = {'';'20';'';'';'10';'';'';'5';''};
    axis_opt.YTickLabel = {'12';'6';'3'};
    axis_opt.OuterPosition = [-0.011953725399205,-0.022174705901546,0.490990096037426,1.07383279613194];
    axis_opt.Position = [0.05187498708566,0.125946901672967,0.41851326254281,0.875173728847528];
    
    axis_opt.FontName = 'Times New Roman'; axis_opt.FontSize = 15;
    title('Assistance of flexion movement')
    zlabel('Torque [Nm]','FontName','Times New Roman');
    ylabel('Input Amplitude [deg]','FontName','Times New Roman','Rotation',-33.5,'Position',[-0.149974159895748,2.040540535555843,-2.24730381875824]);
    xlabel('Pretension level [N]','FontName','Times New Roman','Rotation',21,'Position',[4.059482869217912,4.206390395489306,-5.877532032754413]);

    

    bar_opt(1).FaceColor = color_RT_FE;
    bar_opt(2).FaceColor = color_T_FE;
    bar_opt(3).FaceColor = color_T_S;
    bar_opt(4).FaceColor = color_RT_FE;
    bar_opt(5).FaceColor = color_T_FE;
    bar_opt(6).FaceColor = color_T_S;
    bar_opt(7).FaceColor = color_RT_FE;
    bar_opt(8).FaceColor = color_T_FE;
    bar_opt(9).FaceColor = color_T_S;

subplot(1,2,2);
    bar_opt = bar3(max_torque_extension);
    axis_opt=gca;
    axis_opt.XTick = [1 2 3 4 5 6 7 8 9];
    axis_opt.XTickLabels = {'';'20';'';'';'10';'';'';'5';'';};
    axis_opt.YTickLabel = {'12';'6';'3'};
    axis_opt.OuterPosition = [0.50727858874968,-0.01465831865941,0.512298888632177,0.944972390479376];
    axis_opt.Position = [0.552395820418991,0.169288644293322,0.418513262542809,0.770152498240692];
    
    axis_opt.FontName = 'Times New Roman'; axis_opt.FontSize = 15;
    title('Assistance of extension movement')
    zlabel('Torque [Nm]','FontName','Times New Roman');
    ylabel('Input Amplitude [deg]','FontName','Times New Roman','Rotation',-33.5,'Position',[-0.180400274292223,2.007955462544436,-1.653460890059902]);
    xlabel('Pretension level [N]','FontName','Times New Roman','Rotation',21,'Position',[3.931267040025774,4.161588855908779,-5.053507176190811]);

    bar_opt(1).FaceColor = color_RT_FE;
    bar_opt(2).FaceColor = color_T_FE;
    bar_opt(3).FaceColor = color_T_S;
    bar_opt(4).FaceColor = color_RT_FE;
    bar_opt(5).FaceColor = color_T_FE;
    bar_opt(6).FaceColor = color_T_S;
    bar_opt(7).FaceColor = color_RT_FE;
    bar_opt(8).FaceColor = color_T_FE;
    bar_opt(9).FaceColor = color_T_S;

    leg_opt = legend('Stiff and Tendon in FE','Tendon in FE','Tendon in S');
    set(leg_opt,'Position',[0.826701388888879,0.090113540144337,0.1415364609162,0.090010685747505]);
    
s_title = suptitle('Maximum torque values on the ankle for all configurations');
s_title.FontName = 'Times New Roman'; s_title.FontSize = 25;

clear *_opt xh yh bw* color* fig_* s_*