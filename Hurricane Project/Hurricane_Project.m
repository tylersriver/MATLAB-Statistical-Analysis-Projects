%% Hurricane Project - ECE MAth 2
%
% Tyler Sriver
% March 23, 2015
%
%%
% Clean up
clc;
close all;
clear all;
%% Number of Cyclones Per Year

fid = fopen('hurdat2-1851-2014-022315.txt');
tline = fgetl(fid);

firstYear = 1851;
endYear = 2014;
numYears = 2014-1851+1;

% First Line columns
FLBASIN = 1:2; % Basin, Atlantic AL
FLYEAR = 5:8; % Year
FLTRACKS = 34:36; % Number of Tracks
% Track Line Columns
TLSTATUS = 20:21; % Status of System
TLDAY = 7:8;
TLMONTH = 5:6;
TLYEAR = 1:4;

hurricanes = zeros(1, numYears);

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

months = [january, february, march, april, may, june, july, august,...
    september,october, november, december];
days = [ 1:31, 1:28, 1:31, 1:30, 1:31, 1:30, 1:31, 1:31, 1:30, 1:31,...
    1:30, 1:31];

Totalhurricanes = zeros(1,365);
oldDay = 25;
ifDay = true;
hitMonth = true;
hitDay = false;

while(ischar(tline))
    if strcmpi(tline(FLBASIN), 'AL')
        year = str2num(tline(FLYEAR));
        numTracks = str2num(tline(FLTRACKS));
        isHur = 0;
        
        for n = 1:numTracks
            tline = fgetl(fid);
            if strcmpi(tline(TLSTATUS), 'HU')
                isHur = isHur +1;
            end
            if strcmpi(tline(TLSTATUS), 'HU')
                day = str2num(tline(TLDAY));
                month = str2num(tline(TLMONTH));
                if oldDay ~= day
                    ifDay = true;
                    hitMonth = true;
                    hitDay = false;
                end
                if ifDay
                    for d = 1:365
                        if(months(d) == month && hitMonth)
                            hitMonth = false;
                            hitDay = true;
                        end
                        if(days(d) == day && hitDay)
                            Totalhurricanes(d) = Totalhurricanes(d) + 1;
                            hitDay = false;
                            ifDay = false;
                            oldDay = day;
                        end
                    end
                end     
            end          
        end
        
        if(isHur > 0)
            hurricanes(1, year-firstYear+1) =...
                hurricanes(1, year-firstYear+1)+1;
        end
    end
    tline = fgetl(fid);
    
end
fclose(fid);
figure(1);
scatter(1851:2014, hurricanes)
xlabel('Year');
ylabel('Number of Hurricanes');
title('Number of Hurricanes Each Year');

%% Probability of number of Hurricanes per year

xHist = 0:15;
yPos = 0:15;
figure(2);

[Y, X] = hist(hurricanes, xHist);
bar(X, Y/164);
hold();

mean = sum(hurricanes)/164;
for n = X
    yPos(n+1) = (mean.^(n)*exp(-mean))/factorial(n);
end

figure(2);
plot(X, yPos);    

xlabel('Number of Hurricanes');
ylabel('Probability');
title('Probability of Hurricanes Per Year');
%% Probability of a Hurricane on a Particular Day

figure(3);
plot(1:365, Totalhurricanes/164);
xlabel('Months');
ylabel('Probability');
title('Probability of Hurricane on a particular Day');
    
dayspermonth = [31 28 31 30 31 30 31 31 30 31 30 31];
DaysPerYear = 365;
for i=2:12,
 runsum(i)=sum(dayspermonth(1:i-1));
end;
runsum=runsum+1;
x =['Jan';'Feb';'Mar';'Apr';'May';'Jun';'Jul';'Aug';'Sep';...
    'Oct';'Nov';'Dec'];
set(gca,'XTick',runsum);
set(gca,'XTickLabel',x);
xlim([1 DaysPerYear]);
grid on;
%%
% End File
    

    
    
    
    

        