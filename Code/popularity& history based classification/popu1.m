%% Import data from text file.
% Script for importing data from the following text file:
%
%    C:\Users\Monika\Desktop\extract\final_codes\extract3.txt
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2015/08/14 20:01:18

%% Initialize variables.
filename = 'D:\STUDIES_MSBR\Academics\BTProject\Final Project\BTP(ipg2012-mentor)\Code\popularity& history based classification\extract3.txt';
delimiter = '\t';
startRow = 2;

%% Format string for each line of text:
%   column1: text (%s)
%	column2: text (%s)
%   column3: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
triplets = dataset(dataArray{1:end-1}, 'VarNames', {'user_ID','song','count'});
%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;
%%
 d=triplets(:,2);
  uni=unique(d);
   [b j j]=unique(d);
count=histc(j,1:length(b));
 ds = mat2dataset(count);
 concat=[b,ds];
 B = sortrows(concat,{'count1'},{'descend'});  %songs as per popularity
user_songs=triplets(:,[1:2]);    
 user = input('ENTER THE USER ID ','S');   %input user id to extract his history
  C = dataset2cell(user_songs);
  only_songs=user_songs.song;
  Y = circshift(only_songs,1);
  index = find(ismember(C,user));
  rec=Y(index);   %saving users history
   ext=B(B.count1>90,:);
ext = sortrows(ext,'count1','descend');
popular_songs=(ext.song);
recommend_Semi = setdiff(rec,popular_songs);  %check record 695
final_recommendations =vertcat(popular_songs,recommend_Semi); %final recommendations on the basis of popularity & history.
display(final_recommendations);