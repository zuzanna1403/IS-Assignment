
>> load fake_news                                                        % upload dataset


t = table;                                                 				 % create a table
t.names = arrayfun(@(x) x.status.user.name, ...             	         % get user names from twitter
fake_news.statuses, 'UniformOutput', false);
t.names = regexprep(t.names,'[^a-zA-Z .,'']','');           
t.screen_names = arrayfun(@(x) ...                          			% get twitter screen names
x.status.user.screen_name, fake_news.statuses, 'UniformOutput', false);
t.followers_count = arrayfun(@(x)  ...                    			    % get followers count
x.status.user.followers_count, fake_news.statuses);
t = unique(t,'rows');                                       		    % remove the duplicates
t = sortrows(t,'followers_count', 'descend');               			% rank the users in descending order
disp(t(1:100,:))							                            % 100 users shown in results 


load fake_news							                               %load from dataset
figure                                               					% create a new figure
histogram(scores,'Normalization','probability')        			 % positive tweets to be seen
line([0 0], [0 .60],'Color','b',);                      				  % reference line shown in blue 
title(['Sentiment Analysis Distribution and Detection of "Fake News" ' ])  % add title
xlabel('Score')                               				    % add x-axis label
ylabel('Tweets')                                       				   % add y-axis label
yticklabels(string(0:5:35))                            				     %  add y-axis ticks
text(-10,.100,'Negative');text(3,.100,'Positive');  



load fake_news                                                 	  	% load from dataset 
count = sum(DTM);                                         	 	 % get word count within tweets
labels = erase(dict(count >= 60),'@');                    	               % high frequently used words
pos = [find(count >= 60);count(count >= 60)] + 0.1;                   % x y positions
figure                                                    			  % new figure
scatter(1:length(dict),count)                          			   % scatter plot
text(pos(1,1),pos(2,1)+3,cellstr(labels(1)),...         		   % place labels
    'HorizontalAlignment','center');
text(pos(1,2),pos(2,2)-2,cellstr(labels(2)),...
    'HorizontalAlignment','right');
text(pos(1,3) ,pos(2,3)-4,cellstr(labels(3)));
text(pos(1,3:end),pos(2,3:end),cellstr(labels(3:end)));
title('Frequent Words within Tweets that Mention Fake News')         % title
xlabel('Indices of tweets')                                         			   % x-axis label
ylabel(' Count of words')                                            		                  % y-axis label
ylim([0 100])


