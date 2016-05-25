%% Baby Project - ECE Math 2
%
% Tyer Sriver
% April , 2015

%%
% clean up
clear all;
close all;
clc;

%% 
% Load Data
load('baby(1).mat');

%% Variables
MAGE = baby(:, 1);
BWEIGHT = baby(:, 2);
APGAR5 = baby(:,3);
GEST = baby(:, 7);
CIG_3 = baby(:, 11);

%% Correlation Comparisons

% Mothers Age and Birth Weight
AgeWeight = corrcoef(MAGE, BWEIGHT);
fprintf('The correlation for Mothers age and Baby weight is:');
disp(AgeWeight(1,2));

% Birth Weight and APGAR5
WeightAPGAR = corrcoef(BWEIGHT, APGAR5);
fprintf('The correlation for Birth Weight and APGAR 5m score is:');
disp(WeightAPGAR(1,2));

% Birth Weight and Gestation
WeightGest = corrcoef(BWEIGHT, GEST);
fprintf('The correlation for Birth Weight and Gestation is:');
disp(WeightGest(1,2));

% Mother Smoking 3rd Trimester and Birth weight
SmokeWeight = corrcoef(CIG_3, BWEIGHT);
fprintf('The correlation for Mother smoking 3rd Tri and Birth weight:');
disp(SmokeWeight(1,2));

%% Probability Distribution of Birth Weight

WeightStep = 0:110:8200;
[H, x] = hist(BWEIGHT, WeightStep);
TotBirths = size(BWEIGHT);
H = H / TotBirths(1)/110;

% Plot 
figure(1);
bar(x, H);
hold on;
title('Probability of Weight of a Baby');
xlabel('Weight (grams)');
ylabel('Probability');
 
% Calculate mean
meanBWEIGHT = mean(BWEIGHT);
fprintf('Mean of Birth Weights: %2.f \n', meanBWEIGHT);

% Caclulate Standard Deviation
stdBWEIGHT = std(BWEIGHT);
fprintf('Standard Deviation of Birth weights: %2.f \n', stdBWEIGHT);

% Calculate and plot Normal Distribution
NormDist = (1/(sqrt(2*pi)*stdBWEIGHT))...
    *exp(-((x-meanBWEIGHT).^2)/(2*stdBWEIGHT^2));
plot(x, NormDist, 'r');

%% Probability Distribution of Gestation > 37

WeightStep = 0:110:9000;

index = (baby(:,7)>=37) & (baby(:,7)~=99); 
WGestGreater37 = baby(index,2);


[H, x] = hist(WGestGreater37, WeightStep);
H = H /size(WGestGreater37, 1)/110;

figure(2);
bar(x, H);
hold on;
title('Probability Distribution of Birth Weights for Gestation > 37');
xlabel('Weight (grams)');
ylabel('Probability');

% Calculate mean
meanWGestGreater37 = mean(WGestGreater37);

% Caclulate Standard Deviation
stdWGestGreater37 = std(WGestGreater37);

% Calculate and plot Normal Distribution
NormDist = (1/(sqrt(2*pi)*stdWGestGreater37))...
    *exp(-((x-meanWGestGreater37).^2)/(2*stdWGestGreater37^2));
plot(x, NormDist, 'r');

%% Probability Distribution with Gestation < 37

WeightStep = 0:110:9000;

index = (baby(:,7)<37); 
WGestGreater37 = baby(index,2);


[H, x] = hist(WGestGreater37, WeightStep);
H = H /size(WGestGreater37, 1)/110;

figure(3);
bar(x, H);
hold on;
title('Probability Distribution of Birth Weights for Gestation < 37');
xlabel('Weight (grams)');
ylabel('Probability');

%% Gestation and Birth Weight Joint Distribution

figure(4);
plot(GEST/4, BWEIGHT, 'o');
xlabel('Gestation');
ylabel('Birth Weight');
title('Gest vs Birth Weight');

% 3D Plot

n1 = 31;
n2 = 90;

x1 = 17:1:47;
y1 = 50:100:9000;

xr = interp1(x1, 1:numel(x1), GEST, 'nearest');
yr = interp1(y1, 1:numel(y1), BWEIGHT, 'nearest');
z = accumarray([xr yr], 1, [n1, n2]);

figure(5);
surf(z', 'linestyle', 'none');
surf(z', 'Facecolor', 'interp', 'facelighting', 'phong',...
    'linestyle', 'none'); 
camlight right;
colormap cool;


%Contour Plot
figure(6)
contour(z', 10.^(0:0.3:6));
title('Gestation and Birth Weight Joint Probability Distribution');
ylabel('Baby Weight (dekagrams)')
xlabel('Gestation Period (weeks)');
colormap cool;

%Refined Surface Plot
figure(7)
q = log10(z);
surf(q', 'linestyle', 'none');
surf(q', 'Facecolor', 'interp', 'facelighting', 'phong', 'linestyle','none');
xlabel('Gestation Period (weeks)');
ylabel('Baby Weight (dekagrams)');
camlight right;
colormap cool;

%%

% End File








