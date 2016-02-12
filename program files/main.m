function list_of_objects=main(t_step,t_end,file)
%Author: Austin Sagan
%This is the main program that itterates through all time positions and
%returns the final list of objects.
%
%Parametets:
%   t_step- time step in days
%   t_end- duration of simulation in days
%   file- .mat file containing a variable called "list_of_objects".  This
%   comes from make_solar_system.m,create_sling_shot1.m or create_sling_shot2.m 
%
%example call:
% list=main(1,365,'solar_system.mat');

t_step=t_step*60*60*24;
t_end=t_end*60*60*24;
load(file)



for i=1:length(list_of_objects)
    list_of_objects(i)=list_of_objects(i).init(t_step,t_end);
end

time_array=0:t_step:t_end;
for t=time_array
    if mod(t/t_step,100)==0
        fprintf('%f percent done.  t=%f \n',t/t_end*100,t/(60*60*24))
    end
    for i=1:length(list_of_objects)
        list_of_objects(i)=list_of_objects(i).update(list_of_objects,t_step,'runge kutta');
    end
end

end