clear all; clc;

%% DATA INPUT
%We begin with a simple 2 x 3 (2 bar groups, 3 bars/group) data set. 
clf;

x = [1 2 3; 4 5 6]; yh = []; ar = []; bo = []; bgo = []; xlimo = []; ylimo = []; labels = [];
t = barmod(x,yh,ar,bo,bgo,xlimo,ylimo,labels);

%% PLOT PIXEL HEIGHT
%The default is 500 pixels--let's make it a little smaller at 400 pixels.
clf;

x = [1 2 3; 4 5 6]; yh = 400; ar = []; bo = []; bgo = []; xlimo = []; ylimo = []; labels = [];
t = barmod(x,yh,ar,bo,bgo,xlimo,ylimo,labels);

%% ASPECT RATIO
%Perhaps we want the the plot a little bit wider. The default is 5/4--let's
%go to 1.5. 
clf;

x = [1 2 3; 4 5 6]; yh = 400; ar = 1.5; bo = []; bgo = []; xlimo = []; ylimo = []; labels = [];
t = barmod(x,yh,ar,bo,bgo,xlimo,ylimo,labels);

%% BAR OFFSET
%The default is 0. Let's make a small gap of .1 the bar width.
clf;

x = [1 2 3; 4 5 6]; yh = 400; ar = 1.5; bo = .1; bgo = []; xlimo = []; ylimo = []; labels = [];
t = barmod(x,yh,ar,bo,bgo,xlimo,ylimo,labels);

%% BAR GROUP OFFSET
%The default is half the total bar group width (sum of bar widths and bar
%offset widths). Let's make it a little smaller with a value of .25.
clf;

x = [1 2 3; 4 5 6]; yh = 400; ar = 1.5; bo = .1; bgo = .25; xlimo = []; ylimo = []; labels = [];
t = barmod(x,yh,ar,bo,bgo,xlimo,ylimo,labels);

%% X LIMIT OFFSET
% The default is to be the same size as the bar group offset. Let's put it 
%back at 1/2 the total bar group width.
clf;

x = [1 2 3; 4 5 6]; yh = 400; ar = 1.5; bo = .1; bgo = .25; xlimo = 1/2; ylimo = []; labels = [];
t = barmod(x,yh,ar,bo,bgo,xlimo,ylimo,labels);

%This input takes values in the range 0 <= xlimo <= inf

%% Y LIMIT OFFSET (1)
% The default is to be the same size as the x limit offset. Let's make it 
%extra large with a value of 1.
clf;

x = [1 2 3; 4 5 6]; yh = 400; ar = 1.5; bo = .1; bgo = .25; xlimo = 1/2; ylimo = 1; labels = [];
t = barmod(x,yh,ar,bo,bgo,xlimo,ylimo,labels);

%This input has a limited range, because you can't have the pixel value of
%ylimo exceed the pixel height (or 2*ylimo in the case of negative and
%positive inputs, as the offset is accounted for on both sides. This is
%done further on in the demo). I can't imagine why you would want to
%approach that limit, but for purposes of functionality, it is explained
%here. If you input a value larger than the the limit, you will recieve an
%error and the range of values you can enter while still viewing all of the
%data. The example below demonstrates this with a ylimo value of 3.

%% Y LIMIT OFFSET (2 - Error)
clf;

x = [1 2 3; 4 5 6]; yh = 400; ar = 1.5; bo = .1; bgo = .25; xlimo = 1/2; ylimo = 3; labels = [];
t = barmod(x,yh,ar,bo,bgo,xlimo,ylimo,labels);

%% LABELS (1)
% The default is a series of titles (title#). Put in something simply like
% "A" and "B".
clc; clf;

x = [1 2 3; 4 5 6]; yh = 400; ar = 1.5; bo = .1; bgo = .25; xlimo = 1/2; ylimo = 1; labels = ["A","B"];
t = barmod(x,yh,ar,bo,bgo,xlimo,ylimo,labels);

%Note that if you're label array is too small, you will recieve a warning
%that the labels will loop. If you're label array is too large, you will
%recieve a warning saying that your label array size and your number of bar
%groups do not match.

%Unfortunately, Matlab's bar function with style 'hist' does not support
%categorical arrays. The functionality of categorical arrays in the bar
%function with styles 'grouped' or 'stacked' adjusts the angle of the tick
%labels if they are too large. This does not in barmod as shown in the
%example below (the aspect ratio has been adjusted to illustrate overlap).

%% LABELS (2 - overlap error)
clf;

x = [1 2 3; 4 5 6]; yh = 400; ar = .75; bo = .1; bgo = .25; xlimo = 1/2; ylimo = 1; 
labels = ["abcdefghijklm123456789","nopqrstuvwxyz123456789"];
t = barmod(x,yh,ar,bo,bgo,xlimo,ylimo,labels);

%There is a nifty workaround, however, that can adjust in the same manner
%as categorical arrays--it is the xtickangle function, which takes angular
%inputs in degrees, as illustrated in the example below.

%% LABELS (3 - overlap error resolved)
clf;

x = [1 2 3; 4 5 6]; yh = 400; ar = .75; bo = .1; bgo = .25; xlimo = 1/2; ylimo = 1; 
labels = ["abcdefghijklm123456789","nopqrstuvwxyz123456789"];
t = barmod(x,yh,ar,bo,bgo,xlimo,ylimo,labels);

xtickangle(45)

%The above workaround allows you to adjust the angle any way you want.

%% All NEGATIVE INPUTS
%So far, our data has been all positive. The bottom plot limit for all 
%positive data is zero (ylim([0 #]). For all negative inputs, the top plot
%limit is zero (ylim([# 0]). I've never seen a bar chart like this, but
%maybe someone has data to that is all negative. If you have all negative
%data, and you'd like it portrated in the same manner as all positive data,
%unfortunately, you're out of luck--for ax.YTick, The following error is 
%given with attempted string or numerically descending inputs: 'Value must 
%be a vector of type single or double whose values increase'. Regardless,
%the case of all negative data is demonstrated below by flipping our data. 
%All inputs other than the data are cleared. 
clf;

x = [1 2 3; 4 5 6]*-1; yh = []; ar = []; bo = []; bgo = []; xlimo = []; ylimo = []; labels = [];
t = barmod(x,yh,ar,bo,bgo,xlimo,ylimo,labels);

%% POSITIVE AND NEGATIVE INPUTS (1)
%In the case of both positive and negative inputs, ylimo represents an
%equal offset at between the top and bottom of the chart data extents and
%the top and bottom of the extents of the plot respectively. This is
%demonstrated below by making some of the above data values negative and
%some positive.
clf;

x = [-1 -2 -3; 4 5 6]; yh = []; ar = []; bo = []; bgo = []; xlimo = []; ylimo = []; labels = [];
t = barmod(x,yh,ar,bo,bgo,xlimo,ylimo,labels);

%% POSITIVE AND NEGATIVE INPUTS (2 - y = 0 line)
%In the previous example, you may have noticed that the y = 0 line was
%missing. An easy way to fix that is shown below.
clf;

x = [-1 -2 -3; 4 5 6]; yh = []; ar = []; bo = []; bgo = []; xlimo = []; ylimo = []; labels = [];
t = barmod(x,yh,ar,bo,bgo,xlimo,ylimo,labels);

ax = gca;
xextents = xlim; %must declare first, pretty sure
plot([xextents(1) xextents(2)],[0 0],'Color',ax.XColor)

%% MODIFICATIONS - Y grid lines
%One useful hode is to add y grid lines. This is shown below. In the case
%of positive and negative data values, you may prefer to have just grid
%lines and no y = 0 line.
clf;

x = [-1 -2 -3; 4 5 6]; yh = []; ar = []; bo = []; bgo = []; xlimo = []; ylimo = []; labels = [];
t = barmod(x,yh,ar,bo,bgo,xlimo,ylimo,labels);

set(gca, 'YGrid', 'on', 'XGrid', 'off')

%% MODIFICATIONS - COLOR (1 - BARS INDEXED IN GROUP)
%The default color map for this function is the default for Matlab in
%general--that is, the parula map. You may not want the parula color map.
%The patch 't' is a NBG x n size matrix. Therefore, whatever color
%modifications you would like to do, you simply need to index accordingly.
%The handle to change the color of a patch face is .FaceColor. The
%following three examples are ways of modifying color. This first example
%is changing the colors of each data set.
clf;

x = [-1 -2 -3; 4 5 6]; yh = []; ar = []; bo = []; bgo = []; xlimo = []; ylimo = []; labels = [];
t = barmod(x,yh,ar,bo,bgo,xlimo,ylimo,labels);

szx = size(x);
NBG = szx(1);
n = szx(2);

%Color Declaration
clrs = cell(1);
for i = 1:n %indexed first to call rand's three times, not six
    clrs{i} = [rand rand rand];
    for j = 1:NBG
        t(j,i).FaceColor = clrs{i};
    end
end

%% MODIFICATIONS - COLOR (2 - BARS GROUPS)
%We now uniformly change the color in each group. Notice that all I have
%done is switched the indexing (now, i = 1:NBG ~= 1:n, and j = 1:n ~=
%1:NBG).
clf;

x = [-1 -2 -3; 4 5 6]; yh = []; ar = []; bo = []; bgo = []; xlimo = []; ylimo = []; labels = [];
t = barmod(x,yh,ar,bo,bgo,xlimo,ylimo,labels);

szx = size(x);
NBG = szx(1);
n = szx(2);

%Color Declaration
clrs = cell(1);
for i = 1:NBG %indexed first to call rand's three times, not six
    clrs{i} = [rand rand rand];
    for j = 1:n
        t(i,j).FaceColor = clrs{i};
    end
end

%% MODIFICATIONS - COLOR (3 - UNIFORM BAR COLOR EXCEPTING ONE)
%Now, we make all the color uniform except for one bar. We simply
%declare two different colors, declare all the face colors to be one of
%them, and then declare one arbitrary bar to be the other. I've randomized
%it to make it a little fun.
clf;

x = [-1 -2 -3; 4 5 6]; yh = []; ar = []; bo = []; bgo = []; xlimo = []; ylimo = []; labels = [];
t = barmod(x,yh,ar,bo,bgo,xlimo,ylimo,labels);

clr1 = [rand rand rand];
clr2 = [rand rand rand];

szx = size(x);
NBG = szx(1);
n = szx(2);

for i = 1:NBG %As far as I know, have to do this for loop, can't change en masse
    for j = 1:n
        t(i,j).FaceColor = clr1;
    end
end

rando_NBG = ceil(rand*NBG); %integer in range 1:NBG
rando_n = ceil(rand*n); %integer in range 1:n

t(rando_NBG,rando_n).FaceColor = clr2;

%% NOTES

%ERROR BAR CHARTS

%The inspiration for this function did not require an error bar
%chart--therefore, I have not created any special way of modifying
%error bar charts, unfortunately. It appears that Scott Clowe has done some
%great work on customizing error plots, so perhaps there's some way of
%marrying what I have done here with what he has done. For now, I leave
%that to the user. If nothing else, one can use an average of the XData of
%the patches from this function to create error plots that superimpose over
%the patches from this function. 

%HORIZONTAL BAR CHARTS

%I can't imagine it would be too difficult to flip the data and make the
%patches go vertically--I don't have a need at this time for a horizontal
%bar chart, so perhaps if and when I do, I will make an update to the
%function.

%% CONCLUSION

%So there you go! Hopefully this helps you meet your bar-chart needs. If
%you have feedback, or would like a certain feature, by all means, reach
%out--no guarantees, but I may consider it.

%Best,

%Hunter

