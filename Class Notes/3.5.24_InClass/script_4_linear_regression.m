close; clc; clear;

% linear regression: 
% y = mx + b; m and b are parameters. For statistical modeling m and b are things we want to
% change around to describe the relationship between x and y

% for ex: y = mx;  where y = 7 and x =2
% algeabrically youre solving for m so m = y/x = 3.5
% Solving for a line with one point like above, just involves one division operation.
% in matlab, you can do y/x OR x\y
% \: means division backwards. 
% y/x == y * inverse(x)
% x\y: is like inv(x) * y       An easy way to remember is that the backslash points to the thing getting inversed.
% inverse(x) is different than inverse(Matrix A)??

% also, something about \ being easier for column vectors and / being easier for row vectors. 

% for linear regression, if you have a column vector x, and a column vector y, it only matters which y is dependant on which x.
% the 3rd element of y is dependant on the 3rd element of x, but not the 4th element. If Y is neural responses and X is opto light intensity shined
% for ex.

%% explain the backslash operator

% For the purposes of this class, we can treat the `\` operator (also 
% called mldivide or just backslash) as "backwards" division. If the 
% expression `1/2` is 1 divided by 2, `2\1` is also one divided by two, but
% written differently (go try it in the console). Another perspecitve is to 
% view `1/2` as equal to one times two inverse or `1 * (2^-1)`, so the 
% `a/b` operator means "a times the inverse of b". This way, we can think 
% of `\` as meaning "(the inverse of a) times b". When you have the
% equation `y = a*x`, and you're trying to sole for a, the solution is
% `y/x`, which is "y times the inverse of x". You can also write this as 
% `x\y`. This logic works for matrices and matrix inverses as well, and so
% when you see `x\y`, you can think of it as finding the `a` such that 
% `y = a*x`, which is how you solve linear regression. We usually 
% use `\` instead of `/` because `\` is more convinient for column vectors.
% As an aside, `/` is defined in terms of `\`, (try `help /`) so we're
% actually using the original.


% for more info:
doc \
%% generate data
% Imagine we are investigating the relationship between the intensity of a
% light stimulus and the firing rate of a population of neurons in the LGN.
% We will sample a random set of (normalized) light intensities from -.5 to 
% .5, and record the LGN's firing rate for each stimulus.

slope = 1.7;
sampled_light_intensities = linspace(-.5,.5)';
neural_response_true = sampled_light_intensities * slope;
neural_response_measured = neural_response_true + randn(size(sampled_light_intensities,1),1)*.1;

%% plot the population tuning curve

figure;
scatter(sampled_light_intensities, neural_response_measured);
xlabel("intensity of the light stimulus (compared to daylight)");
ylabel("LGN average spiking rate");

% Question 1: What general geometric shape does the scatterplot of the data
% follow?

% Question 2: In the context of our neruoscience experiment, how would you
% explain the relationship between `sampled_light_intensities(1)` and 
% `neural_response_measured(1)`?

%% fit a linear model to our generated data

% fit using mldivide
regressed_slope = sampled_light_intensities\neural_response_measured;
                    % ^ x                     \           y
% fit using a built-in linear model
mdl = fitlm(sampled_light_intensities, neural_response_measured, 'Intercept',false);
library_regressed_slope = mdl.Coefficients{1,1};

% check that the fits agree
assert(abs(regressed_slope - library_regressed_slope) < 1e-15) % should probably expalin this line


%% show how well our linear model describes our data
figure;
hold on;
scatter(sampled_light_intensities,neural_response_measured, 'DisplayName','noisy data'); 
x_line = linspace(-.5,.5,10);
plot(x_line, regressed_slope * x_line, 'DisplayName','regressed line');
plot(x_line, slope * x_line, 'DisplayName','true (generating) line');
legend();
xlabel("intensity of the light stimulus (compared to daylight)");
ylabel("LGN average spiking rate");

% Question 3: If you were to try to predict how the LGN population would
% react to a new stimulus of intensity 3, what would our model predict?

%% generate 2d data

% Now imagine we are investigating the tuning curve of a newly discovered 
% population of neurons in the thalamus, the NGL. We suspect that the NGL
% could be sensitive to both light and sound stimuli, and so we are going
% to record its response to both light and auditory stimuli at the same
% time.

sampling_density=10;
visual_stimuli = repelem(linspace(-.5,.5,sampling_density)',sampling_density);
auditory_stimuli = repmat(linspace(-.5,.5,sampling_density)',sampling_density,1);

visual_stimuli = rand(200,1)-.5;
auditory_stimuli = rand(200,1)-.5;

joint_stimuli = [visual_stimuli, auditory_stimuli];

slopes = [2,-1]';
% first one is response for visual stimuli, the second one is response for auditory stimuli.
% so it will spike a lot for bright lights and little for dim lightss. And inverse for sound?

neural_response_true = joint_stimuli * slopes;
neural_response_measured = neural_response_true + randn(size(joint_stimuli,1),1)*.1;

% Question 4: How can you interpret the first row of `joint_stimuli`? How
% does it relate to the first row of `neural_response_measured`?.

%% show the data from our new experiment
figure;
scatter3(visual_stimuli, auditory_stimuli, neural_response_measured);
xlabel("visual stimuli");
ylabel("audtory stimuli");
zlabel("neural response");
title("our data is still linear, but now makes a plane");

% Question 5: What general geometric shape does the scatterplot of the data
% follow? How does this compare to your answer to Question 1?

%% regress the neural data on just the visual stimuli

regressed_partial_slope = visual_stimuli\neural_response_measured;

figure;
hold on;
scatter(visual_stimuli,neural_response_measured, 'DisplayName','noisy data'); 
x_line = linspace(-.5,.5,10);
plot(x_line, regressed_partial_slope * x_line, 'DisplayName','regressed line');
plot(x_line, slopes(1) * x_line, '--', 'DisplayName','true line');

legend();

% Question idea: something about the "worse" fit because the scatterplot 
% band around our line is wider.

%% show how a 1d regression on this data is sub-optimal
figure;
subplot(1,2,1)
hold on;
scatter(visual_stimuli, neural_response_measured);
plot(x_line, regressed_partial_slope *x_line);
xlabel("visual stimuli");
ylabel("neural response");
title("regression with just visual information");


subplot(1,2,2);
hold on;
scatter3(joint_stimuli(:,1), joint_stimuli(:,2), neural_response_measured);
view([0,-1,0]);
rotate3d();
xlabel("visual stimuli");
ylabel("audtory stimuli");
zlabel("neural response");


points = linspace(-.5,.5,20);
[meshX, meshY] = meshgrid(points, points);
Z = regressed_partial_slope * meshX;
surf(meshX,meshY,Z);

title("regressed plane (rotate this)");

% Question idea: does our regression on just visual stimuli capture all of
% the populaiton's responses?


%% show how a multi regression on this data fits the appropriate plane
figure;
hold on;
regressed_slopes = joint_stimuli\neural_response_measured;


scatter3(joint_stimuli(:,1), joint_stimuli(:,2), neural_response_measured);
view([0,-1,0]);
rotate3d();


points = linspace(-.5,.5,20);
[meshX, meshY] = meshgrid(points, points);
Z = regressed_slopes(1) * meshX + regressed_slopes(2) * meshY;
surf(meshX,meshY,Z);
xlabel("visual stimuli");
ylabel("audtory stimuli");
zlabel("neural response");
title("multiple linear regression");

% Question idea: how does this fit on both auditory and visual information
% differ from the fit on just auditory information?


%% happy valentine's day
% thanks to Elie Huez for finding this

shamrock()
% rose()

function rose()
% https://www.linkedin.com/posts/the-mathworks_2_get-the-code-to-make-a-rose-in-matlab-activity-7161739546492153857-iZB8?utm_source=li_share&utm_content=feedcontent&utm_medium=g_dt_web&utm_campaign=copy

n = 800;
A = 1.995653;
B = 1.27689;
C = 8;
r=linspace(0,1,n);
theta=linspace(-2,20*pi,n);
[R,THETA]=ndgrid(r,theta);
% define the number of petals we want per cycle. Roses have 3 and a bit.
petalNum=3.6;
x = 1 - (1/2)*((5/4)*(1 - mod(petalNum*THETA, 2*pi)/pi).^2 - 1/4).^2;
phi = (pi/2)*exp(-THETA/(C*pi));
y = A*(R.^2).*(B*R - 1).^2.*sin(phi);
R2 = x.*(R.*sin(phi) + y.*cos(phi));
X=R2.*sin(THETA);
Y=R2.*cos(THETA);
Z=x.*(R.*cos(phi)-y.*sin(phi));
% % define a red map for our rose colouring
red_map=linspace(1,0.25,10)';
red_map(:,2)=0;
red_map(:,3)=0;
figure
surf(X,Y,Z,'LineStyle','none')
view([-40.50 42.00])
colormap(red_map)
title("Happy Valentine's Day");
end

function shamrock()
t=linspace(0,2*pi,301)*3;% linspace(0,2*pi,n)*nb;
% Mesh
r=linspace(0,1,50);
[R,T]=ndgrid(r,t);
% Unit Wave function
M=(1-mod(T*3,2*pi)/pi);
W = rescale(1-(abs(M)-1/3).^2,.2,1);
% Apply wave to R
S=R.*W;
% Vertices for a disk with wave applied
X=S.*cos(T);
Y=S.*sin(T);
surf(X,Y,X*0,R,FaceC='i',EdgeC='n');
% Re-use r from the 'radius' computation to create a green colormap.
m(2,:)=r;
m(3,:)=0;
colormap(gca,m');
axis equal off
view(2)
end
