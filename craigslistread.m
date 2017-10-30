
%Email Setup
mail = 'email@example.com';    % Replace with your email address
password = 'password';          % Replace with your email password
server = 'smtp.server.com';     % Replace with your SMTP server
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true'); % Replace your settings
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');% Replace your settings
props.setProperty('mail.smtp.socketFactory.port','465');% Replace your settings

% Apply prefs and props
setpref('Internet','E_mail',mail);
setpref('Internet','SMTP_Server',server);
setpref('Internet','SMTP_Username',mail);
setpref('Internet','SMTP_Password',password);



%Load Saved Data
fileID = fopen('housinglists.txt');
tempFile = textscan(fileID,'%s');
savedData=tempFile{1};


%Script to scrape relevant part of rss feed craigslist, compare to list
%already saved. Add any new links and email a notification with the url

stuff=webread(link);
expression= 'rdf:resource=\"(.*?)\"';

% Regular expression for HTML repersenting the links. Only part of the 
% retrieved xml data that we need.
matchStr = regexp(stuff,expression,'match')';  

for ct1=1:length(matchStr)
    temp=char(matchStr(ct1))
    indx=strfind(temp,'"')
    matchStr{ct1}=temp(indx(1)+1:indx(2)-1);
    check=0;
    for ct2=1:length(savedData)
        check=strcmp(matchStr{ct1},savedData{ct2})+check;
    end
    if check == 0
        fid = fopen('housinglists.txt','a');
        fprintf(fid,'%s\n', matchStr{ct1});
        fclose(fid);
        
        fid = fopen('times.txt','a');
        t = char(datetime('now','TimeZone','America/New_York','Format','d-MMM-y HH:mm:ss Z'));
        fprintf(fid,'%s\n', t);
        fclose(fid);
        % Send the email
        sendmail('receivingemail@mail.com', 'New Listing!!', matchStr{ct1});
        
    end
end

