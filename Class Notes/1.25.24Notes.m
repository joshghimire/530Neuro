x = 0:.1:10;
z = cos(x);
y = sin(x);

figure
plot(x,z)
hold on
plot(x, y, 'r')
g =  11.5;

% labelling plot
xlabel('Time')
ylabel('Voltage')
%title('Y and Z')
title(['Y and Z ' num2str(g)])

%% Subplots
figure;
subplot(2,1,1)  % How many rows, how many columns of plot, what is index of current one that I want to plot
plot(x,z)       % plot this on the first plot
subplot(2,1,2)  % switch over to the second subplot
plot(x,z,'o', 'markerfacecolor', 'k')
% once a plot is generated, can click on the subplot of interest and change the x and y lim of individual subplots
axis([-100 100 -2 2]); %changing both ylim and x lim of a single subplot at once. 

%% histogram
myRands = randn(1, 1000);
figure;
subplot(2, 1, 1)
plot(myRands)
subplot(2,1,2)
%hist(myRands)
hist(myRands, [-4:0.5:4])
% first bin centered at -4, bin width of 0.5, last bin centered at 4

%% image sc : kind of like a heatmap
x = 0:0.1:10;
y1 = sin(x)
% lots of lines in class, didn't write all down.
% with image sc, the magnitude is colorcoded
% type in colorbar to get a power legend/color legend
% use caxis to change the top/bottom / min/max of the color bar/legend.
    % for ex, use caxis([0.5 0.5])

   % See Script_3.m file