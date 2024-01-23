%% relational and logical operators
a = 3
a == 3

a~=3 %~= means not

a == 2 & a < 4; % &: both have to be correct/true.
a> 0 & a<10 & a*a>8; % &: all and's have to be correct. 

a>100 | a<4; % |: Or operator. One has to be correct.  

%% Implementing logical operators w/ vectors:

b = [1:100];
b == 3;     % Gives a vector where the logical operator is tested per element. 1 where b=3 and 0 where b~=3.
b>50 & rem(b,2)==0

%% Find function 
find(b==3)  % find where b==3
find(b>30)  % find where b is greater than 30. 

a = (1:1:10)*2
find(a > 10, 1, 'first')    % find with 'first' tells us the first occurance of something. Can use this for signal low to high for example. 
find(a  < 10, 1, 'last')    % find with 'last' tells us the last occurance of something. Can use this for signal high to low for example.

% all function can be used to compute for all elements in a vector. 

%% What does this output?

mysteryVec = randn(1, 1000)>0.9;   % What does ">0.9" and ">2" mean again?
mysteryMat = randn(10, 1000)>2;    % Oh it's where the Vector/matrix is greater than 0.9 or 2

%% Matrices 
p1 = [1 2 3; 4 5 6]
p1(1:2, [1 3])      % Select columns 1 and 3 from rows 1 and 2

c = [1:5;6:10]
mean(c)             % get mean down columns
max(c)              % gets max value across columns. Giving a function like this a matrix leads to column wise operation.

mean(c, 1)          % get mean across first dimension. Same as mean(c)
mean(c, 2)          % get mean across second dimension.


p = [1 2 3 NaN 4 5]
mean(p);            % Comes out as NaN, as NaN is undefined.
mean(p, 'omitnan')  % get mean, ignore NaN values. 
nanmean(p);         % ignores/excludes NaN
isnan(p);           % get a vector of which values is NaN
~isnan(p);          % get a vector of not NaN values. 

%% Plotting
a = rand(1,100)
plot(a)
plot(10:10:1000, a) % always give plot x first, they y

ax = 10:10:1000;
plot(ax, a)         % a more elegant way of doing this. 

plot(ax, a, 'ko')   % plot without connecting the lines. 
xlabel('indices')
ylabel('y value')
title('plot')

grid on;            % turns on a grid
grid minor;         % smaller grids?
