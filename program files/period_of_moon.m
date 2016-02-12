function T=period_of_moon(list,t_step);
%Author: Austin Sagan
%This program finds the period of earth's moon.
%
%parameters:
%   list- output from main.m
%   t_step- time step from main simulation
%
%example:
%T=period_of_moon(list, 1);

earth=get_object(list,4);
moon=get_object(list,10);
x=moon.x(1,:)-earth.x(1,:);
pks=[];
for i=2:length(x)-1
    if(x(i-1)<x(i) && x(i+1)<x(i))
        pks=[pks,i];
    end
end
Tl=[]
for i=1:length(pks)-1
    Tl=[Tl,pks(i+1)-pks(i)];
end
T=mean(Tl)*t_step;