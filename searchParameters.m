% Search Parameters:
cityLabel = uicontrol('Parent', f,...
                      'Style', 'text',... 
                      'String', 'City', ...
                      'HorizontalAlignment', 'left',...
                      'Position', [20 380 100 20]) ;
cityControl = uicontrol('Parent', f,...
                        'Style', 'popup',...
                        'String', {'Boston','New York',},...
                        'Position', [100 385 100 20],...
                        'Callback', @setmap); 
       
maxLabel = uicontrol('Parent', f,...
                     'Style', 'text',... 
                     'String', 'Max ($)', ...
                     'HorizontalAlignment', 'left',...
                     'Position', [20 355 100 20]) ;
maxControl = uicontrol('Parent', f,...
                       'Style', 'edit',...
                       'Position', [100 360 100 20],...
                       'Callback', @setmap);     

categoryLabel = uicontrol('Parent', f,...
                          'Style', 'text',... 
                          'String', 'Category', ...
                          'HorizontalAlignment', 'left',...
                          'Position', [20 330 100 20]) ;
categoryControl = uicontrol('Parent', f,...
                            'Style', 'popup',...
                            'String', {'Boston','New York',},...
                            'Position', [100 335 100 20],...
                            'Callback', @setmap);     