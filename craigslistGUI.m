clc
clear 
close all hidden
f = figure;

searchParameters;

% Email Server Setup
mail = 'matlabtesting02@gmail.com';    
password = 'password12341.';         
server = 'smtp.gmail.com';    

props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');

setpref('Internet','E_mail',mail);
setpref('Internet','SMTP_Server',server);
setpref('Internet','SMTP_Username',mail);
setpref('Internet','SMTP_Password',password);
