function [ e ] = plot_total_energy( list ,t_step)
%Author: Austin Sagan
%This program plots the total energy over time and returns it. It should be
%constant.
%
%Parameters:
%   list- output from main.m
%   t_step- time step used in main.m
%
%example:
%  plot_total_energy(list,1);
e=zeros(1,list(1).i);

for i=1:list(1).i
    for o=list
        e(i)=e(i)+o.mass*norm(o.v(:,i))^2;
    end
end
plot(e)
end