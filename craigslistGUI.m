close all
clear
clc

ss = get(0,'screensize'); %The screen size
width = ss(3);
height = ss(4);

global runSearch;
runSearch=false;


f = figure('Name','Craigslist Monitor','position', [width/2-250, height/2-125, 500, 250]);

locations=importdata('locations.txt');
categories=importdata('categories.txt');
len=length(categories);
cat=cell(1,len);
param=cell(1,len);
for ct=1:len
    cat{ct}=extractAfter(strtrim(categories{ct}),'=');
    param{ct}=extractBefore(strtrim(categories{ct}),'=');
end



%Panels
TimerPanel = uipanel('Parent', f, 'Units', 'normal', 'Position', [0 9/10 1 1/10]); 
ParameterPanel = uipanel('Parent', f, 'Units', 'normal', 'Position', [0 1/10 1/2 8/10]) ;
ResultsPanel = uipanel('Parent', f, 'Units', 'normal', 'Position', [1/2 1/10 1/2 8/10]) ;
RunButtonPanel = uipanel('Parent', f, 'Units', 'normal', 'Position', [0 0 1 1/10]);

searchParameters;
disp('Waiting for Start!')
uiwait(gcf);
disp('running.................')


%create url
if str2double(maxControl.String)~=0
    link=strtrim(strcat('https://',locations{locationControl.Value},...
     '.craigslist.org/search/',param{categoryControl.Value},...
     '?availabilityMode=0&format=rss&hasPic=1&max_price=',maxControl.String,...
     '&query=',searchStringControl.String,...
     '&sort=date'));
else
    link=strtrim(strcat('https://',locations{locationControl.Value},...
     '.craigslist.org/search/',param{categoryControl.Value},...
     '?availabilityMode=0&format=rss&hasPic=1',...
     '&query=',searchStringControl.String,...
     '&sort=date'));
end

for ct=1:75
    disp(['Running iteration:',num2str(ct)]);
    if~runSearch
        break;
    end
    craigslistread;
    pause(str2double(searchIntervalV.String)); %Intervals between checking.
end

