global foundListings;

locations=importdata('locations.txt');
categories=importdata('categories.txt');
len=length(categories);
cat=cell(1,len);
param=cell(1,len);
for ct=1:len
    cat{ct}=extractAfter(strtrim(categories{ct}),'=');
    param{ct}=extractBefore(strtrim(categories{ct}),'=');
end

%Check found listings:
fileID = fopen('housinglists.txt');
foundListings=countLines(fileID);
fclose(fileID);

stime=clock;
timestring=['on: ',num2str(stime(2)),...
    '/',num2str(stime(3)),...
    '/',num2str(stime(1)),...
    ' at: ',num2str(stime(4)),...
    ':',num2str(stime(5)),'hrs'];


%Panels
TimerPanel = uipanel('Parent', f, 'Units', 'normal', 'Position', [0 9/10 1 1/10]); 
ParameterPanel = uipanel('Parent', f, 'Units', 'normal', 'Position', [0 1/10 1/2 8/10]) ;
ResultsPanel = uipanel('Parent', f, 'Units', 'normal', 'Position', [1/2 1/10 1/2 8/10]) ;
RunButtonPanel = uipanel('Parent', f, 'Units', 'normal', 'Position', [0 0 1 1/10]);



%Timer Banner:
timerLabel = uicontrol('Parent', TimerPanel,...
                     'Style', 'text',... 
                     'String', ['This program started ',timestring], ...
                     'Units', 'normal',... 
                     'HorizontalAlignment', 'left',...
                     'Position', [0 0 1 1]) ;

%Results Banner:
resultsLabel = uicontrol('Parent', ResultsPanel,...
                     'Style', 'text',... 
                     'String', ['Found:',num2str(foundListings)], ...
                     'Units', 'normal',... 
                     'HorizontalAlignment', 'left',...
                     'Position', [1/20 1/4 1 1/2]) ;
%Run Banner:
runButton = uicontrol('Parent', RunButtonPanel,...
                     'Style', 'pushbutton',... 
                     'String', 'Start/Stop', ...
                     'Units', 'normal',... 
                     'HorizontalAlignment', 'left',...
                     'Position', [0 0 1 1],...
                     'Callback',@submit);
                 
% Search Parameters:
locationLabel = uicontrol('Parent', ParameterPanel,...
                      'Style', 'text',... 
                      'String', 'Location:', ...
                      'Units', 'normal',...
                      'HorizontalAlignment', 'left',...
                      'Position', [1/20 5/6 1/2 1/10]) ;
locationControl = uicontrol('Parent', ParameterPanel,...
                        'Style', 'popup',...
                        'String', locations,...
                        'Units', 'normal',...                        
                        'Position', [1/2-1/20 5/6 1/2 1/10]); 
       
maxLabel = uicontrol('Parent', ParameterPanel,...
                     'Style', 'text',... 
                     'String', 'Max ($):', ...
                     'Units', 'normal',... 
                     'HorizontalAlignment', 'left',...
                     'Position', [1/20 4/6 1/2 1/10]) ;
maxControl = uicontrol('Parent', ParameterPanel,...
                       'Style', 'edit',...
                       'Units', 'normal',... 
                       'Position', [1/2-1/20 4/6 1/2 1/10],...
                       'callback',@checkNumber);     

categoryLabel = uicontrol('Parent', ParameterPanel,...
                          'Style', 'text',... 
                          'String', 'Category:', ...
                          'Units', 'normal',... 
                          'HorizontalAlignment', 'left',...
                          'Position', [1/20 3/6 1/2 1/10]) ;
categoryControl = uicontrol('Parent', ParameterPanel,...
                            'Style', 'popup',...
                            'String', cat,...
                            'Units', 'normal',... 
                            'Position', [1/2-1/20 3/6 1/2 1/10]);    
searchStringLabel = uicontrol('Parent', ParameterPanel,...
                          'Style', 'text',... 
                          'String', 'Search String:', ...
                          'Units', 'normal',... 
                          'HorizontalAlignment', 'left',...
                          'Position', [1/20 2/6 1/2 1/10]) ;
searchStringControl = uicontrol('Parent', ParameterPanel,...
                            'Style', 'edit',...
                            'Units', 'normal',... 
                            'Position', [1/2-1/20 2/6 1/2 1/10]); 
                        
searchIntervalL = uicontrol('Parent', ParameterPanel,...
                     'Style', 'text',... 
                     'String', 'Update interval(s):', ...
                     'Units', 'normal',... 
                     'HorizontalAlignment', 'left',...
                     'Position', [1/20 1/6 1/2 1/10]) ;
searchIntervalV = uicontrol('Parent', ParameterPanel,...
                       'Style', 'edit',...
                       'Units', 'normal',... 
                       'Position', [1/2-1/20 1/6 1/2 1/10],...
                       'callback',@checkTime);     

                        
function submit(~,~)
global runSearch;
runSearch = ~runSearch;

    if runSearch
        uiresume(gcbf);
    else
        close(gcbf);
    end
end 

function checkNumber(src,~)
str=get(src,'String');
    if str2double(str)<0
        set(src,'string','');
        warndlg('Input must be positive Ignoring Input');
    end
end

function checkTime(src,~)
str=get(src,'String');
    if str2double(str)<1
        set(src,'string','');
        warndlg('Interval must be at least 1 second!');
    end
end
function n = countLines(fid)
n = 0;
tline = fgetl(fid);
while ischar(tline)
  tline = fgetl(fid);
  n = n+1;
end
end