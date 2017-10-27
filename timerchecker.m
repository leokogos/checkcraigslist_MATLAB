clc
clear

% % Timer
%     tmr = timer                                 ...
%         (   'Name'          , 'Check houses'        ...
%         ,   'TimerFcn'      , @(x,y)craigslistread  ...
%         ,   'BusyMode'      , 'drop'            ...
%         ,   'ExecutionMode' , 'fixedDelay'      ...
%         ,   'Period'        ,  12               ...
%         ,   'StartDelay'    ,  1                ...
%         ); 
% 
% start( tmr )



for ct=1:75
    ct
    craigslistread;
    pause(3600);
end

% 
%  T = timer('timerfcn','disp(''Hello World'')','ExecutionMode','fixedRate','Period',7)