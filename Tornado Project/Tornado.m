%% ECE Math II - Tornado Project
%
% Tyler Sriver
% March 1, 2015
%
%% Clean up 
clc;
close all;
clear all;

% Read in Data
data = csvread('1950-2013_torn.csv');
%
%% 
% Pre-Assignment work

NumEntries = sum(data(:,9)==40);
fprintf('Number of entries for Oklahoma: %6.0f \n', NumEntries);

% Sum -> sums columns
s = sum([1 2; 3 4]);
fprintf('Sum function: ');
disp(s);

NumEntries1 = sum((data(:,9)==40) &(data(:,2)==2011));
fprintf('Number of entries for Oklahoma in 2011: %6.0f \n', NumEntries1);

% Num tornado tracks in oklahoma
s1 = (data(:,22) == 1) & (data(:,23) == 1) & (data(:,24) == 1);
s2 = (data(:,22) == 2) & (data(:,23) == 0) & (data(:,24) == 1);
s3 = (data(:,22) == 3) & (data(:,23) == 0) & (data(:,24) == 1);
fullpathboolean = (s1|s2|s3);
NumEntries2 = sum(fullpathboolean & (data(:,9)==40) &(data(:,2)==2011));
fprintf('Number of entries of tornado tracks for Oklahoma in 2011: %6.0f \n\n\n',...
    NumEntries2);
%% Oklahoma County Tornados by Month

NumEntries = sum(data(:,9)==40 & (data(:,25)==109|data(:,26)==109|...
    data(:,27)==109|data(:,28)==109));
fprintf('Number of tornados in Oklahoma county: %6.0f \n', NumEntries);

figure(1);
hold;
axis([1 12 0 50]);
for M = 1:12
    OkCounty = sum(data(:,3)==M & data(:,9)==40 & (data(:,25)==109|...
        data(:,26)==109|data(:,27)==109|data(:,28)==109));
    bar(M, OkCounty);
end
xlabel('Months');
ylabel('Tornados');
title('Tornados in Oklahoma County by Month');
%% Probability of tornado in US each day from 1980 - 1999

january = ones(1,31);
february = ones(1,28).*2;
march = ones(1,31).*3;
april = ones(1,30).*4;
may = ones(1,31).*5;
june = ones(1,30).*6;
july = ones(1,31).*7;
august = ones(1,31).*8;
september = ones(1,30).*9;
october = ones(1,31).*10;
november = ones(1,30).*11;
december = ones(1,31).*12;

months = [january, february, march, april, may, june, july, august, september, ...
    october, november, december];
days = [ 1:31, 1:28, 1:31, 1:30, 1:31, 1:30, 1:31, 1:31, 1:30, 1:31,...
    1:30, 1:31];

tornados = zeros(1,365);

for D = 1:365
    numTorns = 0;
    for Y = 1980:1999
        if(sum(data(:,3)== months(D) & data(:,4)==days(D) & data(:,2)==Y ...
                & data(:,9)<=56 & data(:,9)~=2 & data(:,9)~= 15)>0)
            numTorns = numTorns + 1;
        end
    end
    tornados(1,D) = numTorns;
end        

tornadoProb = tornados/20;

figure(2);
hold on;
scatter(1:365, tornadoProb, 20, 'filled')
xlabel('Days');
ylabel('Probability');
title('Probability of tornado in US each day from 1980 - 1999');
axis([0 365 0 1]);

L = 30;
h = fir1(L,0.01,window(@hamming,L+1));
N = L+1;
tornadosDouble = [tornados tornados];
y = filter(h,1,tornadosDouble);
tornados = y(((N-1)/2+1):(365+((N-1)/2+1)-1));
plot(1:365, tornados/20, 'r', 'linewidth', 2);
%% Probability of tornado in Oklahoma each day from 1980-1999

tornados = zeros(1,365);

for D = 1:365
    numTorns = 0;
    for Y = 1980:1999
        if(sum(data(:,3)== months(D) & data(:,4)==days(D) & data(:,2)==Y...
                & data(:,9)==40)>0)
            numTorns = numTorns + 1;
        end
    end
    tornados(1,D) = numTorns;
end        

tornadoProb = tornados/20;

figure(3);
hold on;
scatter(1:365, tornadoProb, 20, 'filled')
xlabel('Days');
ylabel('Probability');
title('Probability of tornado in Oklahoma each day from 1980 - 1999');
axis([0 365 0 .4]);

L = 30;
h = fir1(L,0.01,window(@hamming,L+1));
N = L+1;
tornadosDouble = [tornados tornados];
y = filter(h,1,tornadosDouble);
tornados = y(((N-1)/2+1):(365+((N-1)/2+1)-1));
plot(1:365, tornados/20, 'r', 'linewidth', 2);
%% Probability of a tornado in the US for each day from 1980 through 2012

tornados = zeros(1,365);

for D = 1:365
    numTorns = 0;
    for Y = 1980:2012
        if(sum(data(:,3)== months(D) & data(:,4)==days(D) & data(:,2)==Y ...
                & data(:,9)<=56 & data(:,9)~=2 & data(:,9)~= 15)>0)
            numTorns = numTorns + 1;
        end
    end
    tornados(1,D) = numTorns;
end        

tornadoProb = tornados/32;

figure(4);
hold on;
scatter(1:365, tornadoProb, 20, 'filled')
xlabel('Days');
ylabel('Probability');
title('Probability of tornado in US each day from 1980 - 2012');
axis([0 365 0 1]);

L = 30;
h = fir1(L,0.01,window(@hamming,L+1));
N = L+1;
tornadosDouble = [tornados tornados];
y = filter(h,1,tornadosDouble);
tornados = y(((N-1)/2+1):(365+((N-1)/2+1)-1));
plot(1:365, tornados/32, 'r', 'linewidth', 2);
%% Probability of a tornado in Oklahoma for each day from 1980 through 2012

tornados = zeros(1,365);

for D = 1:365
    numTorns = 0;
    for Y = 1980:2012
        if(sum(data(:,3)== months(D) & data(:,4)==days(D) & data(:,2)==Y...
                & data(:,9)==40)>0)
            numTorns = numTorns + 1;
        end
    end
    tornados(1,D) = numTorns;
end        

tornadoProb = tornados/32;

figure(5);
hold on;
scatter(1:365, tornadoProb, 20, 'filled')
xlabel('Days');
ylabel('Probability');
title('Probability of tornado in Oklahoma each day from 1980 - 2012');
axis([0 365 0 .35]);

L = 30;
h = fir1(L,0.01,window(@hamming,L+1));
N = L+1;
tornadosDouble = [tornados tornados];
y = filter(h,1,tornadosDouble);
tornados = y(((N-1)/2+1):(365+((N-1)/2+1)-1));
plot(1:365, tornados/32, 'r', 'linewidth', 2);
%%
% End file