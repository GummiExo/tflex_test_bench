clear all; close all; clc; 
addpath('src/');
load('data/selected_trials.mat');

%% Step Response Flexo-Extension movements

font_size_legends = 15;
font_size_axis = 20;
font_size_title = 28;
f = figure(1);
    firstax = axes (f, 'FontSize', 16); 
    L1 = plot(step_response(1).mean_motor_state_frontal.Timestamp,-step_response(1).mean_motor_state_frontal.goal_angle, '--', 'LineWidth', 2, 'Color', [0 84 159]/255, 'Parent', firstax);
    hold on;
    L2 = plot(step_response(1).mean_motor_state_posterior.Timestamp,step_response(1).mean_motor_state_posterior.goal_angle, '--', 'LineWidth', 2, 'Color', [0 184 159]/255, 'Parent', firstax);
    set(firstax, 'Box', 'off','XLim',[0 3], 'YLim',[-15 15]);
    l = legend([L1 L2], {'Frontal: Flexion', 'Posterior: Extension'},'FontSize',font_size_legends,'FontName','FreeSerif');
    title(l,'Motors Goal Angle')
    pos = get(l,'Position');
    posx = 0.6;
    posy = 0.3;
    set(l,'Position',[posx posy pos(3) pos(4)]);
    
    secondax = copyobj(firstax, gcf);
    delete( get(secondax, 'Children'))
    H1 = plot(step_response(1).mean_load.Timestamp,step_response(1).mean_load.filtered, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');
    H2 = plot(step_response(2).mean_load.Timestamp,step_response(2).mean_load.filtered, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');
    H3 = plot(step_response(3).mean_load.Timestamp,step_response(3).mean_load.filtered, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');


    set(secondax, 'Color', 'none', 'XTick', [], 'YAxisLocation', 'right', 'Box', 'Off','YLim',[-13 10], 'Visible', 'Off') 
    l1 = legend ([H1 H2 H3], {'5N','10N','20N'},'FontSize',font_size_legends-1,'FontName','FreeSerif');
    title(l1, "Rigid-Tendons");
    pos = get(l1,'Position');
    posx = 0.652;
    posy = 0.18;
    set(l1,'Position',[posx posy pos(3) pos(4)]);

    thirdax = copyobj(firstax, gcf);
    delete( get(thirdax, 'Children'))
    H4 = plot(step_response(4).mean_load.Timestamp,step_response(4).mean_load.filtered, ':', 'LineWidth', 2, 'Parent', thirdax, 'Visible', 'on');
    H5 = plot(step_response(5).mean_load.Timestamp,step_response(5).mean_load.filtered, ':', 'LineWidth', 2, 'Parent', thirdax, 'Visible', 'on');
    H6 = plot(step_response(6).mean_load.Timestamp,step_response(6).mean_load.filtered, ':', 'LineWidth', 2, 'Parent', thirdax, 'Visible', 'on');

    set(thirdax, 'Color', 'none', 'XTick', [], 'YAxisLocation', 'right', 'Box', 'Off', 'Visible', 'Off', 'YLim',[-13 10]) 
    
    l2 = legend ([H4 H5 H6], {'5N','10','20'},'FontSize',font_size_legends-1,'FontName','FreeSerif');
    title(l2, "Tendons");
    
    pos = get(l2,'Position');
    posx = 0.756;
    posy = 0.18;
    set(l2,'Position',[posx posy pos(3) pos(4)]);
    xlabel('Time [s]','FontSize',font_size_axis,'FontName','FreeSerif')
    
    yyaxis left;
    ylabel('Angle [deg]','FontSize',font_size_axis,'FontName','FreeSerif')
    yyaxis right;
    ylim([-13 10])
    set(gca,'FontSize',font_size_axis,'FontName','FreeSerif', 'yticklabel', sprintfc('\\color{black}%g', get(gca,'Ytick')))
    ylabel('Torque [N]','FontSize',font_size_axis,'FontName','FreeSerif', 'Color', 'Black');
    title('Ankle torque response for flexion and extension movements','FontSize',font_size_title,'FontName','FreeSerif')
    grid on;
    hold off

    clearvars -except chirp_response step_response;

%% Step Response for Stiffness movement

font_size_legends = 15;
font_size_axis = 20;
font_size_title = 28;
f = figure(2);
    firstax = axes (f, 'FontSize', 16); 
    L1 = plot(step_response(7).mean_motor_state_frontal.Timestamp,-step_response(7).mean_motor_state_frontal.goal_angle, '--', 'LineWidth', 2, 'Color', [0 84 159]/255, 'Parent', firstax);
    hold on;
    L2 = plot(step_response(7).mean_motor_state_posterior.Timestamp,step_response(7).mean_motor_state_posterior.goal_angle, '--', 'LineWidth', 2, 'Color', [0 184 159]/255, 'Parent', firstax);
    set(firstax, 'Box', 'off','XLim',[0 2], 'YLim',[-15 15]);
    l = legend([L1 L2], {'Frontal: Flexion', 'Posterior: Extension'},'FontSize',font_size_legends,'FontName','FreeSerif');
    title(l,'Motors Goal Angle')
    pos = get(l,'Position');
    posx = 0.6;
    posy = 0.3;
    set(l,'Position',[posx posy pos(3) pos(4)]);
    
    secondax = copyobj(firstax, gcf);
    delete( get(secondax, 'Children'))
    H1 = plot(step_response(7).mean_load.Timestamp,step_response(7).mean_load.filtered, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');
    H2 = plot(step_response(8).mean_load.Timestamp,step_response(8).mean_load.filtered, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');
    H3 = plot(step_response(9).mean_load.Timestamp,step_response(9).mean_load.filtered, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');


    set(secondax, 'Color', 'none', 'XTick', [], 'YAxisLocation', 'right', 'Box', 'Off','YLim',[-5 1], 'Visible', 'Off') 
    l1 = legend ([H1 H2 H3], {'5N','10N','20N'},'FontSize',font_size_legends-1,'FontName','FreeSerif');
    title(l1, "Pretension");
    pos = get(l1,'Position');
    posx = 0.705;
    posy = 0.18;
    set(l1,'Position',[posx posy pos(3) pos(4)]);

    
    xlabel('Time [s]','FontSize',font_size_axis,'FontName','FreeSerif')
    
    yyaxis left;
    ylabel('Angle [deg]','FontSize',font_size_axis,'FontName','FreeSerif')
    yyaxis right;
    ylim([-5 1])
    set(gca,'FontSize',font_size_axis,'FontName','FreeSerif', 'yticklabel', sprintfc('\\color{black}%g', get(gca,'Ytick')))
    ylabel('Torque [N]','FontSize',font_size_axis,'FontName','FreeSerif', 'Color', 'Black');
    title('Ankle torque response for stiffness movements','FontSize',font_size_title,'FontName','FreeSerif')
    grid on;
    hold off

    clearvars -except chirp_response step_response;

%% Motor Response for Flexo-Extension

font_size_legends = 15;
font_size_axis = 20;
font_size_title = 28;
f = figure(3);
    firstax = axes (f, 'FontSize', font_size_axis); 
    L1 = plot(step_response(2).mean_motor_state_frontal.Timestamp,-step_response(2).mean_motor_state_frontal.goal_angle, '-', 'LineWidth', 2, 'Parent', firstax); hold on;
    set(firstax, 'Box', 'off','XLim',[0 2], 'YLim',[-1 15]);
    l = legend(L1, {'Goal Angle'},'FontSize',font_size_legends,'FontName','FreeSerif');
    pos = get(l,'Position');
    posx = 0.66;
    posy = 0.33;
    set(l,'Position',[posx posy pos(3) pos(4)]);
    
    secondax = copyobj(firstax, gcf);
    delete( get(secondax, 'Children'))
    H1 = plot(step_response(1).mean_motor_state_frontal.Timestamp,-step_response(1).mean_motor_state_frontal.angle, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');
    H2 = plot(step_response(2).mean_motor_state_frontal.Timestamp,-step_response(2).mean_motor_state_frontal.angle, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');
    H3 = plot(step_response(3).mean_motor_state_frontal.Timestamp,-step_response(3).mean_motor_state_frontal.angle, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');
    
    set(secondax, 'Color', 'none', 'XTick', [], 'YAxisLocation', 'right', 'Box', 'Off','YLim',[-1 15], 'Visible', 'Off') 
    l1 = legend ([H1 H2 H3], {'5N','10N','20N'},'FontSize',font_size_legends-1,'FontName','FreeSerif');
    title(l1, "Rigid-Tendons");
    pos = get(l1,'Position');
    posx = 0.652;
    posy = 0.18;
    set(l1,'Position',[posx posy pos(3) pos(4)]);
    
    thirdax = copyobj(firstax, gcf);
    delete( get(thirdax, 'Children'))
    H4 = plot(step_response(4).mean_motor_state_frontal.Timestamp,-step_response(4).mean_motor_state_frontal.angle, ':', 'LineWidth', 2, 'Parent', thirdax, 'Visible', 'on');
    H5 = plot(step_response(5).mean_motor_state_frontal.Timestamp,-step_response(5).mean_motor_state_frontal.angle, ':', 'LineWidth', 2, 'Parent', thirdax, 'Visible', 'on');
    H6 = plot(step_response(6).mean_motor_state_frontal.Timestamp,-step_response(6).mean_motor_state_frontal.angle, ':', 'LineWidth', 2, 'Parent', thirdax, 'Visible', 'on');

    set(thirdax, 'Color', 'none', 'XTick', [], 'YAxisLocation', 'right', 'Box', 'Off', 'Visible', 'Off', 'YLim',[-1 15]) 
    
    l2 = legend ([H4 H5 H6], {'5N','10','20'},'FontSize',font_size_legends-1,'FontName','FreeSerif');
    title(l2, "Tendons");
    
    pos = get(l2,'Position');
    posx = 0.756;
    posy = 0.18;
    set(l2,'Position',[posx posy pos(3) pos(4)]);
    xlabel('Time [s]','FontSize',font_size_axis,'FontName','FreeSerif')
    set(gca,'FontSize',font_size_axis,'FontName','FreeSerif', 'yticklabel', sprintfc('\\color{black}%g', get(gca,'Ytick')))
    
    ylabel('Angle [deg]','FontSize',font_size_axis,'FontName','FreeSerif')
   
    grid on;
    hold off
    
    title('Frontal Motor Response for Flexo-Extensio','FontSize',font_size_title,'FontName','FreeSerif');
    
    
f = figure(4);
    firstax = axes (f, 'FontSize', font_size_axis); 
    L1 = plot(step_response(2).mean_motor_state_posterior.Timestamp,step_response(2).mean_motor_state_posterior.goal_angle, '-', 'LineWidth', 2, 'Parent', firstax); hold on;
    set(firstax, 'Box', 'off','XLim',[0 2], 'YLim',[-15 1]);
    l = legend(L1, {'Goal Angle'},'FontSize',font_size_legends,'FontName','FreeSerif');
    pos = get(l,'Position');
    posx = 0.66;
    posy = 0.33 + 0.5;
    set(l,'Position',[posx posy pos(3) pos(4)]);
    
    secondax = copyobj(firstax, gcf);
    delete( get(secondax, 'Children'))
    H1 = plot(step_response(1).mean_motor_state_posterior.Timestamp,step_response(1).mean_motor_state_posterior.angle, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');
    H2 = plot(step_response(2).mean_motor_state_posterior.Timestamp,step_response(2).mean_motor_state_posterior.angle, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');
    H3 = plot(step_response(3).mean_motor_state_posterior.Timestamp,step_response(3).mean_motor_state_posterior.angle, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');
    
    set(secondax, 'Color', 'none', 'XTick', [], 'YAxisLocation', 'right', 'Box', 'Off','YLim',[-15 1], 'Visible', 'Off') 
    l1 = legend ([H1 H2 H3], {'5N','10N','20N'},'FontSize',font_size_legends-1,'FontName','FreeSerif');
    title(l1, "Rigid-Tendons");
    pos = get(l1,'Position');
    posx = 0.652;
    posy = 0.18 + 0.5;
    set(l1,'Position',[posx posy pos(3) pos(4)]);
    
    thirdax = copyobj(firstax, gcf);
    delete( get(thirdax, 'Children'))
    H4 = plot(step_response(4).mean_motor_state_posterior.Timestamp,step_response(4).mean_motor_state_posterior.angle, ':', 'LineWidth', 2, 'Parent', thirdax, 'Visible', 'on');
    H5 = plot(step_response(5).mean_motor_state_posterior.Timestamp,step_response(5).mean_motor_state_posterior.angle, ':', 'LineWidth', 2, 'Parent', thirdax, 'Visible', 'on');
    H6 = plot(step_response(6).mean_motor_state_posterior.Timestamp,step_response(6).mean_motor_state_posterior.angle, ':', 'LineWidth', 2, 'Parent', thirdax, 'Visible', 'on');

    set(thirdax, 'Color', 'none', 'XTick', [], 'YAxisLocation', 'right', 'Box', 'Off', 'Visible', 'Off', 'YLim',[-15 1]) 
    
    l2 = legend ([H4 H5 H6], {'5N','10','20'},'FontSize',font_size_legends-1,'FontName','FreeSerif');
    title(l2, "Tendons");
    
    pos = get(l2,'Position');
    posx = 0.756;
    posy = 0.18 + 0.5;
    set(l2,'Position',[posx posy pos(3) pos(4)]);
    xlabel('Time [s]','FontSize',font_size_axis,'FontName','FreeSerif')
    set(gca,'FontSize',font_size_axis,'FontName','FreeSerif', 'yticklabel', sprintfc('\\color{black}%g', get(gca,'Ytick')))
    
    ylabel('Angle [deg]','FontSize',font_size_axis,'FontName','FreeSerif')
   
    grid on;
    hold off
    
    title('Posterior Motor Response for Flexo-Extension','FontSize',font_size_title,'FontName','FreeSerif');
    
    clearvars -except chirp_response step_response;
    
%% Motor Response for Stiffness

font_size_legends = 15;
font_size_axis = 20;
font_size_title = 28;
f = figure(5);
    firstax = axes (f, 'FontSize', font_size_axis); 
    L1 = plot(step_response(7).mean_motor_state_frontal.Timestamp,-step_response(7).mean_motor_state_frontal.goal_angle, '-', 'LineWidth', 2, 'Parent', firstax); hold on;
    set(firstax, 'Box', 'off','XLim',[0 2], 'YLim',[-1 15]);
    l = legend(L1, {'Goal Angle'},'FontSize',font_size_legends,'FontName','FreeSerif');
    pos = get(l,'Position');
    posx = 0.66;
    posy = 0.33;
    set(l,'Position',[posx posy pos(3) pos(4)]);
    
    secondax = copyobj(firstax, gcf);
    delete( get(secondax, 'Children'))
    H1 = plot(step_response(7).mean_motor_state_frontal.Timestamp,-step_response(7).mean_motor_state_frontal.angle, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');
    H2 = plot(step_response(8).mean_motor_state_frontal.Timestamp,-step_response(8).mean_motor_state_frontal.angle, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');
    H3 = plot(step_response(9).mean_motor_state_frontal.Timestamp,-step_response(9).mean_motor_state_frontal.angle, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');
    
    set(secondax, 'Color', 'none', 'XTick', [], 'YAxisLocation', 'right', 'Box', 'Off','YLim',[-1 15], 'Visible', 'Off') 
    l1 = legend ([H1 H2 H3], {'5N','10N','20N'},'FontSize',font_size_legends-1,'FontName','FreeSerif');
    title(l1, "Pretension");
    pos = get(l1,'Position');
    posx = 0.652;
    posy = 0.18;
    set(l1,'Position',[posx posy pos(3) pos(4)]);
    
    
    xlabel('Time [s]','FontSize',font_size_axis,'FontName','FreeSerif')
    set(gca,'FontSize',font_size_axis,'FontName','FreeSerif', 'yticklabel', sprintfc('\\color{black}%g', get(gca,'Ytick')))
    
    ylabel('Angle [deg]','FontSize',font_size_axis,'FontName','FreeSerif')
   
    grid on;
    hold off
    
    title('Frontal Motor Response for Stiffness','FontSize',font_size_title,'FontName','FreeSerif');
    
    
f = figure(6);
    firstax = axes (f, 'FontSize', font_size_axis); 
    L1 = plot(step_response(2).mean_motor_state_posterior.Timestamp,step_response(2).mean_motor_state_posterior.goal_angle, '-', 'LineWidth', 2, 'Parent', firstax); hold on;
    set(firstax, 'Box', 'off','XLim',[0 2], 'YLim',[-15 1]);
    l = legend(L1, {'Goal Angle'},'FontSize',font_size_legends,'FontName','FreeSerif');
    pos = get(l,'Position');
    posx = 0.66;
    posy = 0.33 + 0.5;
    set(l,'Position',[posx posy pos(3) pos(4)]);
    
    secondax = copyobj(firstax, gcf);
    delete( get(secondax, 'Children'))
    H1 = plot(step_response(1).mean_motor_state_posterior.Timestamp,step_response(1).mean_motor_state_posterior.angle, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');
    H2 = plot(step_response(2).mean_motor_state_posterior.Timestamp,step_response(2).mean_motor_state_posterior.angle, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');
    H3 = plot(step_response(3).mean_motor_state_posterior.Timestamp,step_response(3).mean_motor_state_posterior.angle, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');
    
    set(secondax, 'Color', 'none', 'XTick', [], 'YAxisLocation', 'right', 'Box', 'Off','YLim',[-15 1], 'Visible', 'Off') 
    l1 = legend ([H1 H2 H3], {'5N','10N','20N'},'FontSize',font_size_legends-1,'FontName','FreeSerif');
    title(l1, "Rigid-Tendons");
    pos = get(l1,'Position');
    posx = 0.652;
    posy = 0.18 + 0.5;
    set(l1,'Position',[posx posy pos(3) pos(4)]);
    
    thirdax = copyobj(firstax, gcf);
    delete( get(thirdax, 'Children'))
    H4 = plot(step_response(4).mean_motor_state_posterior.Timestamp,step_response(4).mean_motor_state_posterior.angle, ':', 'LineWidth', 2, 'Parent', thirdax, 'Visible', 'on');
    H5 = plot(step_response(5).mean_motor_state_posterior.Timestamp,step_response(5).mean_motor_state_posterior.angle, ':', 'LineWidth', 2, 'Parent', thirdax, 'Visible', 'on');
    H6 = plot(step_response(6).mean_motor_state_posterior.Timestamp,step_response(6).mean_motor_state_posterior.angle, ':', 'LineWidth', 2, 'Parent', thirdax, 'Visible', 'on');

    set(thirdax, 'Color', 'none', 'XTick', [], 'YAxisLocation', 'right', 'Box', 'Off', 'Visible', 'Off', 'YLim',[-15 1]) 
    
    l2 = legend ([H4 H5 H6], {'5N','10','20'},'FontSize',font_size_legends-1,'FontName','FreeSerif');
    title(l2, "Tendons");
    
    pos = get(l2,'Position');
    posx = 0.756;
    posy = 0.18 + 0.5;
    set(l2,'Position',[posx posy pos(3) pos(4)]);
    xlabel('Time [s]','FontSize',font_size_axis,'FontName','FreeSerif')
    set(gca,'FontSize',font_size_axis,'FontName','FreeSerif', 'yticklabel', sprintfc('\\color{black}%g', get(gca,'Ytick')))
    
    ylabel('Angle [deg]','FontSize',font_size_axis,'FontName','FreeSerif')
   
    grid on;
    hold off
    
    title('Posterior Motor Response for Stiffness','FontSize',font_size_title,'FontName','FreeSerif');
    
    clearvars -except chirp_response step_response;

%% Relationship between Motor Angles Flexo-Extension and Ankle Torque
    
font_size_legends = 15;
font_size_axis = 20;
font_size_title = 28;

motor_angle_frontal_interp = {};
motor_angle_posterior_interp = {};
load_data_interp = {};
p = {};
R = {};
%%% Interpolation
for i = 1:length(step_response)
    if min(length(step_response(i).mean_motor_state_frontal.Timestamp),length(step_response(i).mean_motor_state_posterior.Timestamp)) == length(step_response(i).mean_motor_state_frontal.Timestamp)
        if min(length(step_response(i).mean_load.filtered),length(step_response(i).mean_motor_state_frontal.Timestamp)) == length(step_response(i).mean_load.filtered)
            motor_angle_frontal_interp{i,1} = -interp1(step_response(i).mean_motor_state_frontal.Timestamp, step_response(i).mean_motor_state_frontal.angle, step_response(i).mean_load.Timestamp);
            motor_angle_posterior_interp{i,1} = interp1(step_response(i).mean_motor_state_posterior.Timestamp, step_response(i).mean_motor_state_posterior.angle, step_response(i).mean_load.Timestamp);
            load_data_interp{i,1} = step_response(i).mean_load.filtered;
        else
            motor_angle_frontal_interp{i,1} = -step_response(i).mean_motor_state_frontal.angle;
            motor_angle_posterior_interp{i,1} = interp1(step_response(i).mean_motor_state_posterior.Timestamp, step_response(i).mean_motor_state_posterior.angle, step_response(i).mean_motor_state_frontal.Timestamp);
            load_data_interp{i,1} = interp1(step_response(i).mean_load.Timestamp, step_response(i).mean_load.filtered, step_response(i).mean_motor_state_frontal.Timestamp);
        end
    else
        if min(length(step_response(i).mean_load.filtered),length(step_response(i).mean_motor_state_frontal.Timestamp)) == length(step_response(i).mean_load.filtered)
            motor_angle_frontal_interp{i,1} = -interp1(step_response(i).mean_motor_state_frontal.Timestamp, step_response(i).mean_motor_state_frontal.angle, step_response(i).mean_load.Timestamp);
            motor_angle_posterior_interp{i,1} = interp1(step_response(i).mean_motor_state_posterior.Timestamp, step_response(i).mean_motor_state_posterior.angle, step_response(i).mean_load.Timestamp);
            load_data_interp{i,1} = step_response(i).mean_load.filtered;
        else
            motor_angle_frontal_interp{i,1} = -interp1(step_response(i).mean_motor_state_frontal.Timestamp, step_response(i).mean_motor_state_frontal.angle, step_response(i).mean_motor_state_posterior.Timestamp); 
            motor_angle_posterior_interp{i,1} = step_response(i).mean_motor_state_posterior.angle;
            load_data_interp{i,1} = interp1(step_response(i).mean_load.Timestamp, step_response(i).mean_load.filtered, step_response(i).mean_motor_state_posterior.Timestamp);
        end
    end
    xt = motor_angle_frontal_interp{i,1};
    yt = motor_angle_posterior_interp{i,1};
    p{i,1}= polyfit(xt,yt,1); 
    R{i,1}= corrcoef(xt,yt); 
    
end

    
f = figure(7);
    firstax = axes (f, 'FontSize', font_size_axis); 
    L1 = plot(motor_angle_frontal_interp{1,1},motor_angle_posterior_interp{1,1}, '-', 'LineWidth', 2, 'Parent', firstax); hold on;
    L2 = plot(motor_angle_frontal_interp{2,1},motor_angle_posterior_interp{2,1}, '-', 'LineWidth', 2, 'Parent', firstax); hold on;
    L3 = plot(motor_angle_frontal_interp{3,1},motor_angle_posterior_interp{3,1}, '-', 'LineWidth', 2, 'Parent', firstax); hold on;
    
    set(firstax, 'Box', 'off','XLim',[-1 13], 'YLim',[-15 1]);
    l = legend([L1 L2 L3], {'5N','10N','20N'},'FontSize',font_size_legends,'FontName','FreeSerif');
    pos = get(l,'Position');
    posx = 0.66 + 0.1;
    posy = 0.33 ;
    set(l,'Position',[posx posy pos(3) pos(4)]);
    title(l, "Rigid-Tendons");
    
    secondax = copyobj(firstax, gcf);
    delete( get(secondax, 'Children'))
    H1 = plot(motor_angle_frontal_interp{4,1},motor_angle_posterior_interp{4,1}, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');
    H2 = plot(motor_angle_frontal_interp{5,1},motor_angle_posterior_interp{5,1}, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');
    H3 = plot(motor_angle_frontal_interp{6,1},motor_angle_posterior_interp{6,1}, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');
    
    set(secondax, 'Color', 'none', 'XTick', [], 'YAxisLocation', 'right', 'Box', 'Off','YLim',[-15 1], 'Visible', 'Off') 
    l1 = legend ([H1 H2 H3], {'5N','10N','20N'},'FontSize',font_size_legends-1,'FontName','FreeSerif');
    title(l1, "Tendons");
    pos = get(l1,'Position');
    posx = 0.663 +0.1;
    posy = 0.18 ;
    set(l1,'Position',[posx posy pos(3) pos(4)]);
    
    title('Frontal Angle vs Posterior Angle for Flexo-Extension','FontSize',font_size_title,'FontName','FreeSerif')
    
f = figure(8);
    subplot(2,3,1); plot(motor_angle_frontal_interp{1,1},motor_angle_posterior_interp{1,1},'*'); title('Rigid-Tendons 5N','FontSize',font_size_title-5,'FontName','FreeSerif');
                    hold on; x = -1:13/length(motor_angle_frontal_interp{1,1}):13; plot(x,p{1,1}(1)*x + p{1,1}(2)); legend('Data','Tendency','Location','southeast')
                    txt = num2str(p{1,1}(1)) + "x " + num2str(p{1,1}(2));
                    text(4,0.5,txt)
                    
    subplot(2,3,2); plot(motor_angle_frontal_interp{2,1},motor_angle_posterior_interp{2,1},'*'); title('Rigid-Tendons 10N','FontSize',font_size_title-5,'FontName','FreeSerif');
                    hold on; x = -1:13/length(motor_angle_frontal_interp{2,1}):13; plot(x,p{2,1}(1)*x + p{2,1}(2)); legend('Data','Tendency','Location','southeast')
                    txt = num2str(p{2,1}(1)) + "x " + num2str(p{2,1}(2));
                    text(4,0.5,txt)
                    
    subplot(2,3,3); plot(motor_angle_frontal_interp{3,1},motor_angle_posterior_interp{3,1},'*'); title('Rigid-Tendons 20N','FontSize',font_size_title-5,'FontName','FreeSerif');
                    hold on; x = -1:13/length(motor_angle_frontal_interp{3,1}):13; plot(x,p{3,1}(1)*x + p{3,1}(2)); legend('Data','Tendency','Location','southeast')
                    txt = num2str(p{3,1}(1)) + "x " + num2str(p{3,1}(2));
                    text(4,0.5,txt)
                    
    subplot(2,3,4); plot(motor_angle_frontal_interp{4,1},motor_angle_posterior_interp{4,1},'*'); title('Tendons 5N','FontSize',font_size_title-5,'FontName','FreeSerif');
                    hold on; x = -1:13/length(motor_angle_frontal_interp{4,1}):13; plot(x,p{4,1}(1)*x + p{4,1}(2)); legend('Data','Tendency','Location','southeast')
                    txt = num2str(p{4,1}(1)) + "x " + num2str(p{4,1}(2));
                    text(4,0.5,txt)
                    
    subplot(2,3,5); plot(motor_angle_frontal_interp{5,1},motor_angle_posterior_interp{5,1},'*'); title('Tendons 10N','FontSize',font_size_title-5,'FontName','FreeSerif');
                    hold on; x = -1:13/length(motor_angle_frontal_interp{5,1}):13; plot(x,p{5,1}(1)*x + p{5,1}(2)); legend('Data','Tendency','Location','southeast')
                    txt = num2str(p{5,1}(1)) + "x " + num2str(p{5,1}(2));
                    text(4,0.5,txt)
                    
    subplot(2,3,6); plot(motor_angle_frontal_interp{6,1},motor_angle_posterior_interp{6,1},'*'); title('Tendons 20N','FontSize',font_size_title-5,'FontName','FreeSerif');
                    hold on; x = -1:13/length(motor_angle_frontal_interp{6,1}):13; plot(x,p{6,1}(1)*x + p{6,1}(2)); legend('Data','Tendency','Location','southeast')
                    txt = num2str(p{6,1}(1)) + "x " + num2str(p{6,1}(2));
                    text(4,0.5,txt)
                    
    suptitle('Motor Frontal Angle vs Motor Posterior Angle for Flexo-Extension') 
    
    
f = figure(9);
    plot3(motor_angle_frontal_interp{1,1},motor_angle_posterior_interp{1,1},load_data_interp{1,1},'--', 'LineWidth', 2)
    hold on;
    plot3(motor_angle_frontal_interp{2,1},motor_angle_posterior_interp{2,1},load_data_interp{2,1},'-o', 'LineWidth', 2)
    plot3(motor_angle_frontal_interp{3,1},motor_angle_posterior_interp{3,1},load_data_interp{3,1},'-^', 'LineWidth', 2)
    plot3(motor_angle_frontal_interp{4,1},motor_angle_posterior_interp{4,1},load_data_interp{4,1},'-*', 'LineWidth', 2)
    plot3(motor_angle_frontal_interp{5,1},motor_angle_posterior_interp{5,1},load_data_interp{5,1},'-+', 'LineWidth', 2)
    plot3(motor_angle_frontal_interp{6,1},motor_angle_posterior_interp{6,1},load_data_interp{6,1},'-x', 'LineWidth', 2)
    legend('Rigid-Tendon: 5N','Rigid-Tendon: 10N','Rigid-Tendon: 20N','Tendon: 5N','Tendon: 10N','Tendon: 20N')
    grid on;
    title('Angle vs Torque for Flexo-Extension movements','FontSize',font_size_title,'FontName','FreeSerif')
    
    clearvars -except chirp_response step_response;
    
%% Relationship between Torque And Current

font_size_legends = 15;
font_size_axis = 20;
font_size_title = 28;

motor_angle_frontal_interp = {};
motor_angle_posterior_interp = {};
load_data_interp = {};
p = {};
R = {};

%%% Interpolation
for i = 1:length(step_response)
    if min(length(step_response(i).mean_motor_state_frontal.Timestamp),length(step_response(i).mean_motor_state_posterior.Timestamp)) == length(step_response(i).mean_motor_state_frontal.Timestamp)
        if min(length(step_response(i).mean_load.filtered),length(step_response(i).mean_motor_state_frontal.Timestamp)) == length(step_response(i).mean_load.filtered)
            motor_current_filtered_frontal_interp{i,1} = -interp1(step_response(i).mean_motor_state_frontal.Timestamp, step_response(i).mean_motor_state_frontal.current_filtered, step_response(i).mean_load.Timestamp);
            motor_current_filtered_posterior_interp{i,1} = interp1(step_response(i).mean_motor_state_posterior.Timestamp, step_response(i).mean_motor_state_posterior.current_filtered, step_response(i).mean_load.Timestamp);
            load_data_interp{i,1} = step_response(i).mean_load.filtered;
        else
            motor_current_filtered_frontal_interp{i,1} = -step_response(i).mean_motor_state_frontal.current_filtered;
            motor_current_filtered_posterior_interp{i,1} = interp1(step_response(i).mean_motor_state_posterior.Timestamp, step_response(i).mean_motor_state_posterior.current_filtered, step_response(i).mean_motor_state_frontal.Timestamp);
            load_data_interp{i,1} = interp1(step_response(i).mean_load.Timestamp, step_response(i).mean_load.filtered, step_response(i).mean_motor_state_frontal.Timestamp);
        end
    else
        if min(length(step_response(i).mean_load.filtered),length(step_response(i).mean_motor_state_frontal.Timestamp)) == length(step_response(i).mean_load.filtered)
            motor_current_filtered_frontal_interp{i,1} = -interp1(step_response(i).mean_motor_state_frontal.Timestamp, step_response(i).mean_motor_state_frontal.current_filtered, step_response(i).mean_load.Timestamp);
            motor_current_filtered_posterior_interp{i,1} = interp1(step_response(i).mean_motor_state_posterior.Timestamp, step_response(i).mean_motor_state_posterior.current_filtered, step_response(i).mean_load.Timestamp);
            load_data_interp{i,1} = step_response(i).mean_load.filtered;
        else
            motor_current_filtered_frontal_interp{i,1} = -interp1(step_response(i).mean_motor_state_frontal.Timestamp, step_response(i).mean_motor_state_frontal.current_filtered, step_response(i).mean_motor_state_posterior.Timestamp); 
            motor_current_filtered_posterior_interp{i,1} = step_response(i).mean_motor_state_posterior.current_filtered;
            load_data_interp{i,1} = interp1(step_response(i).mean_load.Timestamp, step_response(i).mean_load.filtered, step_response(i).mean_motor_state_posterior.Timestamp);
        end
    end
    xt = motor_current_filtered_frontal_interp{i,1};
    yt = motor_current_filtered_posterior_interp{i,1};
    p{i,1}= polyfit(xt,yt,1); 
    R{i,1}= corrcoef(xt,yt); 
    
end

f = figure(10);
    subplot(2,3,1); plot(motor_current_filtered_frontal_interp{1,1},motor_current_filtered_posterior_interp{1,1},'*'); title('Rigid-Tendons 5N','FontSize',font_size_title-5,'FontName','FreeSerif');
                    hold on; x = -1:13/length(motor_current_filtered_frontal_interp{1,1}):13; plot(x,p{1,1}(1)*x + p{1,1}(2)); legend('Data','Tendency','Location','southeast')
                    txt = num2str(p{1,1}(1)) + "x " + num2str(p{1,1}(2));
                    text(4,0.5,txt)
                    
    subplot(2,3,2); plot(motor_current_filtered_frontal_interp{2,1},motor_current_filtered_posterior_interp{2,1},'*'); title('Rigid-Tendons 10N','FontSize',font_size_title-5,'FontName','FreeSerif');
                    hold on; x = -1:13/length(motor_current_filtered_frontal_interp{2,1}):13; plot(x,p{2,1}(1)*x + p{2,1}(2)); legend('Data','Tendency','Location','southeast')
                    txt = num2str(p{2,1}(1)) + "x " + num2str(p{2,1}(2));
                    text(4,0.5,txt)
                    
    subplot(2,3,3); plot(motor_current_filtered_frontal_interp{3,1},motor_current_filtered_posterior_interp{3,1},'*'); title('Rigid-Tendons 20N','FontSize',font_size_title-5,'FontName','FreeSerif');
                    hold on; x = -1:13/length(motor_current_filtered_frontal_interp{3,1}):13; plot(x,p{3,1}(1)*x + p{3,1}(2)); legend('Data','Tendency','Location','southeast')
                    txt = num2str(p{3,1}(1)) + "x " + num2str(p{3,1}(2));
                    text(4,0.5,txt)
                    
    subplot(2,3,4); plot(motor_current_filtered_frontal_interp{4,1},motor_current_filtered_posterior_interp{4,1},'*'); title('Tendons 5N','FontSize',font_size_title-5,'FontName','FreeSerif');
                    hold on; x = -1:13/length(motor_current_filtered_frontal_interp{4,1}):13; plot(x,p{4,1}(1)*x + p{4,1}(2)); legend('Data','Tendency','Location','southeast')
                    txt = num2str(p{4,1}(1)) + "x " + num2str(p{4,1}(2));
                    text(4,0.5,txt)
                    
    subplot(2,3,5); plot(motor_current_filtered_frontal_interp{5,1},motor_current_filtered_posterior_interp{5,1},'*'); title('Tendons 10N','FontSize',font_size_title-5,'FontName','FreeSerif');
                    hold on; x = -1:13/length(motor_current_filtered_frontal_interp{5,1}):13; plot(x,p{5,1}(1)*x + p{5,1}(2)); legend('Data','Tendency','Location','southeast')
                    txt = num2str(p{5,1}(1)) + "x " + num2str(p{5,1}(2));
                    text(4,0.5,txt)
                    
    subplot(2,3,6); plot(motor_current_filtered_frontal_interp{6,1},motor_current_filtered_posterior_interp{6,1},'*'); title('Tendons 20N','FontSize',font_size_title-5,'FontName','FreeSerif');
                    hold on; x = -1:13/length(motor_current_filtered_frontal_interp{6,1}):13; plot(x,p{6,1}(1)*x + p{6,1}(2)); legend('Data','Tendency','Location','southeast')
                    txt = num2str(p{6,1}(1)) + "x " + num2str(p{6,1}(2));
                    text(4,0.5,txt)
                    
    suptitle('Motor Frontal Current vs Motor Posterior Current for Flexo-Extension') 

f = figure(11);
    plot3(motor_current_filtered_frontal_interp{1,1},motor_current_filtered_posterior_interp{1,1},load_data_interp{1,1},'--', 'LineWidth', 2)
    hold on;
    plot3(motor_current_filtered_frontal_interp{2,1},motor_current_filtered_posterior_interp{2,1},load_data_interp{2,1},'-o', 'LineWidth', 2)
    plot3(motor_current_filtered_frontal_interp{3,1},motor_current_filtered_posterior_interp{3,1},load_data_interp{3,1},'-^', 'LineWidth', 2)
    plot3(motor_current_filtered_frontal_interp{4,1},motor_current_filtered_posterior_interp{4,1},load_data_interp{4,1},'-*', 'LineWidth', 2)
    plot3(motor_current_filtered_frontal_interp{5,1},motor_current_filtered_posterior_interp{5,1},load_data_interp{5,1},'-+', 'LineWidth', 2)
    plot3(motor_current_filtered_frontal_interp{6,1},motor_current_filtered_posterior_interp{6,1},load_data_interp{6,1},'-x', 'LineWidth', 2)
    legend('Rigid-Tendon: 5N','Rigid-Tendon: 10N','Rigid-Tendon: 20N','Tendon: 5N','Tendon: 10N','Tendon: 20N')
    grid on;
    title('Current vs Torque for Flexo-Extension movements','FontSize',font_size_title,'FontName','FreeSerif')
    
    clearvars -except chirp_response step_response;
    
%% LoadCell Force
    
font_size_legends = 15;
font_size_axis = 20;
font_size_title = 28;

f = figure(12);
    subplot(2,2,1); yyaxis left;
                    plot(step_response(1).mean_motor_state_frontal.Timestamp,step_response(1).mean_motor_state_frontal.angle,'--','LineWidth',2,'Color','black'); hold on;
                    %plot(step_response(1).mean_motor_state_posterior.Timestamp,step_response(1).mean_motor_state_posterior.angle,':','LineWidth',2,'Color','black');

                    yyaxis right;
                    plot(step_response(1).mean_frontal_loadcell.Timestamp,step_response(1).mean_frontal_loadcell.Data,'-','LineWidth',2,'Color',[0.8500 0.3250 0.0980]); hold on;
                    plot(step_response(2).mean_frontal_loadcell.Timestamp,step_response(2).mean_frontal_loadcell.Data,'-','LineWidth',2,'Color',[0.9290 0.6940 0.1250]);
                    plot(step_response(3).mean_frontal_loadcell.Timestamp,step_response(3).mean_frontal_loadcell.Data,'-','LineWidth',2,'Color',[0.4940 0.1840 0.5560]);
                    plot(step_response(4).mean_frontal_loadcell.Timestamp,step_response(4).mean_frontal_loadcell.Data,'-','LineWidth',2,'Color',[0.4660 0.6740 0.1880]);
                    plot(step_response(5).mean_frontal_loadcell.Timestamp,step_response(5).mean_frontal_loadcell.Data,'-','LineWidth',2,'Color',[0.3010 0.7450 0.9330]);
                    plot(step_response(6).mean_frontal_loadcell.Timestamp,step_response(6).mean_frontal_loadcell.Data,'-','LineWidth',2,'Color',[0.6350 0.0780 0.1840]);
                    legend('Goal Angle','Rigid-Tendon: 5N','Rigid-Tendon: 10N','Rigid-Tendon: 20N','Tendon: 5N','Tendon: 10N','Tendon: 20N')
                    grid on;
                    title('Frontal Tendon for Flexo-Extension movements','FontSize',font_size_title,'FontName','FreeSerif')
                    
    subplot(2,2,2); yyaxis left;
                    plot(step_response(7).mean_motor_state_frontal.Timestamp,step_response(7).mean_motor_state_frontal.angle,'--','LineWidth',2,'Color','black'); hold on;
                    
                    yyaxis right;
                    plot(step_response(7).mean_frontal_loadcell.Timestamp,step_response(7).mean_frontal_loadcell.Data,'-', 'LineWidth',2,'Color',[0.8500 0.3250 0.0980]); hold on;
                    plot(step_response(8).mean_frontal_loadcell.Timestamp,step_response(8).mean_frontal_loadcell.Data,'-', 'LineWidth',2,'Color',[0.9290 0.6940 0.1250]);
                    plot(step_response(9).mean_frontal_loadcell.Timestamp,step_response(9).mean_frontal_loadcell.Data,'-', 'LineWidth',2,'Color',[0.4940 0.1840 0.5560]);
                    legend('Goal Angle','Tendon: 5N','Tendon: 10N','Tendon: 20N')
                    grid on;
                    title('Frontal Tendon for Stiffness movements','FontSize',font_size_title,'FontName','FreeSerif')
    
    subplot(2,2,3); yyaxis left;
                    plot(step_response(1).mean_motor_state_posterior.Timestamp,step_response(1).mean_motor_state_posterior.angle,'--','LineWidth',2,'Color','black'); hold on;
                    
                    yyaxis right;
                    plot(step_response(1).mean_posterior_loadcell.Timestamp,step_response(1).mean_posterior_loadcell.Data,'-', 'LineWidth',2,'Color',[0.8500 0.3250 0.0980]); hold on;
                    plot(step_response(2).mean_posterior_loadcell.Timestamp,step_response(2).mean_posterior_loadcell.Data,'-', 'LineWidth',2,'Color',[0.9290 0.6940 0.1250]);
                    plot(step_response(3).mean_posterior_loadcell.Timestamp,step_response(3).mean_posterior_loadcell.Data,'-', 'LineWidth',2,'Color',[0.4940 0.1840 0.5560]);
                    plot(step_response(4).mean_posterior_loadcell.Timestamp,step_response(4).mean_posterior_loadcell.Data,'-', 'LineWidth',2,'Color',[0.4660 0.6740 0.1880]);
                    plot(step_response(5).mean_posterior_loadcell.Timestamp,step_response(5).mean_posterior_loadcell.Data,'-', 'LineWidth',2,'Color',[0.3010 0.7450 0.9330]);
                    plot(step_response(6).mean_posterior_loadcell.Timestamp,step_response(6).mean_posterior_loadcell.Data,'-', 'LineWidth',2,'Color',[0.6350 0.0780 0.1840]);
                    legend('Goal Angle','Rigid-Tendon: 5N','Rigid-Tendon: 10N','Rigid-Tendon: 20N','Tendon: 5N','Tendon: 10N','Tendon: 20N')
                    grid on;
                    title('posterior Tendon for Flexo-Extension movements','FontSize',font_size_title,'FontName','FreeSerif')
                    
    subplot(2,2,4); yyaxis left;
                    plot(step_response(7).mean_motor_state_posterior.Timestamp,step_response(7).mean_motor_state_posterior.angle,'--','LineWidth',2,'Color','black'); hold on;
                    
                    yyaxis right;
                    plot(step_response(7).mean_posterior_loadcell.Timestamp,step_response(7).mean_posterior_loadcell.Data,'-', 'LineWidth',2,'Color',[0.8500 0.3250 0.0980]); hold on;
                    plot(step_response(8).mean_posterior_loadcell.Timestamp,step_response(8).mean_posterior_loadcell.Data,'-', 'LineWidth',2,'Color',[0.9290 0.6940 0.1250]);
                    plot(step_response(9).mean_posterior_loadcell.Timestamp,step_response(9).mean_posterior_loadcell.Data,'-', 'LineWidth',2,'Color',[0.4940 0.1840 0.5560]);
                    legend('Goal Angle','Tendon: 5N','Tendon: 10N','Tendon: 20N')
                    grid on;
                    title('Posterior Tendon for Stiffness movements','FontSize',font_size_title,'FontName','FreeSerif')
    suptitle('Tendon Response');
    
    clearvars -except chirp_response step_response;
    
%% Relationship between Tendon Force and Current

%%% Interpolation
for i = 1:length(step_response)
    if min(length(step_response(i).mean_motor_state_frontal.Timestamp),length(step_response(i).mean_motor_state_posterior.Timestamp)) == length(step_response(i).mean_motor_state_frontal.Timestamp)
        if min(length(step_response(i).mean_frontal_loadcell),length(step_response(i).mean_motor_state_frontal.Timestamp)) == length(step_response(i).mean_load.filtered)
            motor_angle_frontal_interp{i,1} = -interp1(step_response(i).mean_motor_state_frontal.Timestamp, step_response(i).mean_motor_state_frontal.angle, step_response(i).mean_load.Timestamp);
            motor_angle_posterior_interp{i,1} = interp1(step_response(i).mean_motor_state_posterior.Timestamp, step_response(i).mean_motor_state_posterior.angle, step_response(i).mean_load.Timestamp);
            load_data_interp{i,1} = step_response(i).mean_load.filtered;
        else
            motor_angle_frontal_interp{i,1} = -step_response(i).mean_motor_state_frontal.angle;
            motor_angle_posterior_interp{i,1} = interp1(step_response(i).mean_motor_state_posterior.Timestamp, step_response(i).mean_motor_state_posterior.angle, step_response(i).mean_motor_state_frontal.Timestamp);
            load_data_interp{i,1} = interp1(step_response(i).mean_load.Timestamp, step_response(i).mean_load.filtered, step_response(i).mean_motor_state_frontal.Timestamp);
        end
    else
        if min(length(step_response(i).mean_load.filtered),length(step_response(i).mean_motor_state_frontal.Timestamp)) == length(step_response(i).mean_load.filtered)
            motor_angle_frontal_interp{i,1} = -interp1(step_response(i).mean_motor_state_frontal.Timestamp, step_response(i).mean_motor_state_frontal.angle, step_response(i).mean_load.Timestamp);
            motor_angle_posterior_interp{i,1} = interp1(step_response(i).mean_motor_state_posterior.Timestamp, step_response(i).mean_motor_state_posterior.angle, step_response(i).mean_load.Timestamp);
            load_data_interp{i,1} = step_response(i).mean_load.filtered;
        else
            motor_angle_frontal_interp{i,1} = -interp1(step_response(i).mean_motor_state_frontal.Timestamp, step_response(i).mean_motor_state_frontal.angle, step_response(i).mean_motor_state_posterior.Timestamp); 
            motor_angle_posterior_interp{i,1} = step_response(i).mean_motor_state_posterior.angle;
            load_data_interp{i,1} = interp1(step_response(i).mean_load.Timestamp, step_response(i).mean_load.filtered, step_response(i).mean_motor_state_posterior.Timestamp);
        end
    end
    xt = motor_angle_frontal_interp{i,1};
    yt = motor_angle_posterior_interp{i,1};
    p{i,1}= polyfit(xt,yt,1); 
    R{i,1}= corrcoef(xt,yt); 
    
end

