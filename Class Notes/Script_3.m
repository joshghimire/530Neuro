
%% Today:
% Plotting cont.
% Functions
% Loops
% Conditions
%% 
x = (0:0.1:10);

z = cos(x);
y = sin(x);
g= 11.5;
figure

plot(x,z)

hold on

plot(x,y,'g')

% labeling your plot

xlabel('X axis is Time')
ylabel('Y axis is Voltage')
title(['My plot of y and z ' num2str(g)])



%% another way
figure;
plot([x;x]',[z;y]')

%% subplots
figure;
subplot(2,1,1)
plot(x,z)
subplot(2,1,2)
plot(x,z,'o','markerfacecolor','k')

%% useful functions
% xlim, ylim, axis
%% histogram
myRands=randn(1,1000);
figure;
subplot(2,1,1)
plot(myRands)
subplot(2,1,2)
histogram(myRands)
%% imagesc
x = (0:0.1:10);
y1 = sin(x);
y2 = sin(x+pi/4);
y3 = sin(x+pi/2);
y4 = sin(x+3*pi/4);
y5 = sin(x+pi);


figure;
subplot(2,1,1)
plot(x,y1);
hold on;
plot(x,y2);
plot(x,y3);
plot(x,y4);
plot(x,y5);
%%
allYs=[y1;y2;y3;y4;y5];
subplot(2,1,2)
imagesc(x,1:5,allYs)

%% Functions (and scripts)

% .m files
% naming
% Matlab file "visibility"
% Function input and output
% Advantages of using functions
% Variable visibility encapsulation
% debugger
% Functions vs scripts
% Smart indent


%% class practice
% Create a function called plotMyLine.
% The inputs to the function are: 
% 1. A number a 
% 2. A number b
% 3. A string denoting one of the base colors in matlab ('r', 'g', 'b', 'm', ...)
% 
% The function should plot the line y=a*x+b for x=[-100:100]; using the
% color denoted as the third input. The x-axis label should say "X", the
% Y-axis label should say "Y" and the title of the plot should say "Y as a
% function of X".
% In addition, the function should return the values of y as output.
% Test out your function using some values of a and b.

%%
plotMyLine(4,5,'g')
%% For loop
for i=1:10
    i
end
%% Loop but don't iterate over every single index. Only prints out odd numbers. 
for i=1:2:10
    i
end
%%
allMyIs=[];
for i=10:20
    allMyIs=[allMyIs i];
end
%% would this be equivalent? if not, how to modify?
allMyIs=[];
for i=10:20
    allMyIs(i)=i;          
end

%%
x = (0:0.1:10);           %First, define the vector x,
figure                    %... and open a new figure.
for k=1:1:5               %For k from 1 to 5 in steps of 1,
    y = sin(x + k*pi/4);  %... define y (note 'k' in sin),
    hold on               %... hold the figure,
    plot(x,y)             %... plot x versus y,
end
%% while loop
k=1;
figure  
while k<=5
    y = sin(x + k*pi/4);  
    hold on               
    plot(x,y, 'LineWidth', 25)
    k=k+1;  % What would happen if we didn't have this?
end
% useful to know : break

%% Create a script file called myFirstScript.m 
% Inside it, call your plotMyLine function from within a loop that runs from i=-100:100, 
% calling it with i as the first parameter a.
% Now, with i as the second parameter b.
%%
figure;
for i=-100:100
    plotMyLine(i,5,'g');
    hold on;
end
%% Logical conditions
% If.. else
a=3;
if a==1
    'nope'
elseif a==2
    'getting close'
else
    'yes!'
end

%% modify your plotMyLine function to only plot if a is larger than 0.
% Otherwise, the function should avoid plotting and print out "No can do"
% Now re-run the for loop with the function and observe the difference 


%% Save, Load