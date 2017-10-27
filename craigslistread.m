
%Email Setup
mail = 'matlabtesting02@gmail.com';    % Replace with your email address
password = 'password12341.';          % Replace with your email password
server = 'smtp.gmail.com';     % Replace with your SMTP server
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');

% Apply prefs and props
setpref('Internet','E_mail',mail);
setpref('Internet','SMTP_Server',server);
setpref('Internet','SMTP_Username',mail);
setpref('Internet','SMTP_Password',password);



%Load Saved Data
fileID = fopen('housinglists.txt');
tempFile = textscan(fileID,'%s');
savedData=tempFile{1};

link='https://boston.craigslist.org/search/nos/abo?availabilityMode=0&format=rss&hasPic=1&max_price=1600&query=August%201&sort=date';

%Script to read craigslist
stuff=webread(link);
expression = 'resource="http://boston.craigslist.org/nos/abo/+\d*\.html';
matchStr = regexp(stuff,expression,'match')';

for ct1=1:length(matchStr)
    matchStr(ct1)=strrep(matchStr(ct1),'resource="','');
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
        sendmail('leokogos@gmail.com', 'New Listing!!', matchStr{ct1});
        
    end
end

% % matchStr=flip(matchStr);
% fid = fopen('testing.txt','w');
% fprintf(fid,'%s\n', stuff);
% fclose(fid);

