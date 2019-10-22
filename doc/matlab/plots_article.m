clear all; close all; clc; 
load('data/selected_trials.mat');

%% Step Response Flexo Extension 
font_size_legends = 11;
font_size_axis = 18;
font_size_title = 28;
f1 = figure(1);
    firstax = axes (f1, 'FontSize', 16); 
    L1 = plot(step_response(1).mean_motor_state_frontal.Timestamp,-step_response(1).mean_motor_state_frontal.goal_angle, '--', 'LineWidth', 2, 'Color', [0 84 159]/255, 'Parent', firstax);
    hold on;
    L2 = plot(step_response(1).mean_motor_state_posterior.Timestamp,step_response(1).mean_motor_state_posterior.goal_angle, '--', 'LineWidth', 2, 'Color', [0 184 159]/255, 'Parent', firstax);
    set(firstax, 'Box', 'off','XLim',[0 2], 'YLim',[-15 15]);
    l = legend([L1 L2], {'Frontal: Flexion', 'Posterior: Extension'},'FontSize',font_size_legends);
    title(l,'Motors Goal Angle')
    pos = get(l,'Position');
    posx = 0.6;
    posy = 0.3;
    set(l,'Position',[posx posy pos(3) pos(4)]);
    ylabel('Torque [N]','FontSize',font_size_axis);
    secondax = copyobj(firstax, gcf);
    delete( get(secondax, 'Children'))
    H1 = plot(step_response(1).mean_load.Timestamp,step_response(1).mean_load.filtered, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');
    H2 = plot(step_response(2).mean_load.Timestamp,step_response(2).mean_load.filtered, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');
    H3 = plot(step_response(3).mean_load.Timestamp,step_response(3).mean_load.filtered, '-', 'LineWidth', 2, 'Parent', secondax, 'Visible', 'on');


    set(secondax, 'Color', 'none', 'XTick', [], 'YAxisLocation', 'right', 'Box', 'Off','YLim',[-13 10]) 
    l1 = legend ([H1 H2 H3], {'5N','10N','20N'},'FontSize',font_size_legends-1);
    title(l1, "Rigid-Tendons");
    pos = get(l1,'Position');
    posx = 0.652;
    posy = 0.2;
    set(l1,'Position',[posx posy pos(3) pos(4)]);

    thirdax = copyobj(firstax, gcf);
    delete( get(thirdax, 'Children'))
    H4 = plot(step_response(4).mean_load.Timestamp,step_response(4).mean_load.filtered, ':', 'LineWidth', 2, 'Parent', thirdax, 'Visible', 'on');
    H5 = plot(step_response(5).mean_load.Timestamp,step_response(5).mean_load.filtered, ':', 'LineWidth', 2, 'Parent', thirdax, 'Visible', 'on');
    H6 = plot(step_response(6).mean_load.Timestamp,step_response(6).mean_load.filtered, ':', 'LineWidth', 2, 'Parent', thirdax, 'Visible', 'on');

    set(thirdax, 'Color', 'none', 'XTick', [], 'YAxisLocation', 'right', 'Box', 'Off', 'Visible', 'Off', 'YLim',[-13 10]) 
    
    l2 = legend ([H4 H5 H6], {'5N','10','20'},'FontSize',font_size_legends-1);
    title(l2, "Tendons");
    title('Ankle torque for step response','FontSize',font_size_title)
    pos = get(l2,'Position');
    posx = 0.746;
    posy = 0.2;
    set(l2,'Position',[posx posy pos(3) pos(4)]);
    xlabel('Time [s]','FontSize',font_size_axis)
    ylabel('Angle [deg]','FontSize',font_size_axis)
hold off
